use strict;
use warnings;

package Catalyst::View::Template::Pure;

use Scalar::Util qw/blessed refaddr/;
use Catalyst::Plugin::MapComponentDependencies::Utils;
use Catalyst::Utils;

use base 'Catalyst::View';

sub COMPONENT {
  my ($class, $app, $args) = @_;
  $args = $class->merge_config_hashes($class->config, $args);

  my $template;
  if(exists($args->{template})) {
    $template = delete ($args->{template});
  } elsif(exists($args->{template_src})) {
    $template = $app->config->{root}->file(delete $args->{template_src})->slurp;
  } else {
    die "Can't find a template for your View";
  }

  my $pure_class = exists($args->{pure_class}) ?
    delete($args->{pure_class}) :
    'Template::Pure';

  Catalyst::Utils::ensure_class_loaded($pure_class);
  
  my $directives = delete $args->{directives};
  my $pure = $pure_class->new(
    template=> $template, 
    directives=>$directives);

  return bless +{
    pure => $pure,
    %$args,
  }, $class;
}

sub ACCEPT_CONTEXT {
  my ($self, $c, %args) = @_;
  my $args = $c->Catalyst::Plugin::MapComponentDependencies::Utils::_expand_config(
    $self->catalyst_component_name,
      $self->merge_config_hashes($self->config, \%args));

  delete $args->{directives};
  delete $args->{template};
  delete $args->{template_src};

  my $key = blessed($self) ? refaddr($self) : $self;

  if(blessed $c) {
    return $c->stash->{"__Pure_${key}"} ||= do {
      $self->on_response($c) if $self->can('on_response');
      ref($self)->new(
        %{$args},
        %{$c->stash},
        ctx => $c,
        pure => $self->{pure},
      );
    } 
  } else {
    return ref($self)->new(
      %{$args},
      %{$c->stash},
      app => $c,
      pure => $self->{pure},
    );
  }
}

sub response {
  my ($self, $status, @proto) = @_;

  die "You need a context to build a response" unless $self->{ctx};

  my $res = $self->{ctx}->res;

  if(ref($proto[0]) eq 'ARRAY') {
    my @headers = @{shift @proto};
    $res->headers->push_header(@headers);
  }

  $res->status($status) unless $res->status != 200;
  $res->content_type('text/html') unless $res->content_type;
  $res->body($self->render($self));
}

sub render {
  my ($self, $data) = @_;
  return $self->{pure}->render($data)
}

sub TO_HTML {
  my ($self, $pure, $dom, $data) = @_;
  use Devel::Dwarn;
  Dwarn keys %$data;
  Dwarn $self->catalyst_component_name;
  return $self->{pure}->encoded_string(
    $self->render($self));
}

sub layout_view_name { shift->{layout_view_name} }

sub layout {
  my $self = shift;
  return sub {
    my ($pure, $dom, $data) = @_;
    $self->{ctx}->view($self->layout_view_name, %$data);
  };
}

# Send Helpers.
foreach my $helper( grep { $_=~/^http/i} @HTTP::Status::EXPORT_OK) {
  my $subname = lc $helper;
  $subname =~s/http_//i;  
  eval "sub $subname { return shift->response(HTTP::Status::$helper,\@_) }";
  eval qq[
    sub detach_$subname {
      my \$self=shift;
      \$self->response(HTTP::Status::$helper,\@_);
      \$self->{ctx}->detach;
    }];
}


1;
