use strict;
use warnings;

package Catalyst::View::Template::Pure;

use Scalar::Util qw/blessed refaddr/;
use Catalyst::Utils;

use base 'Catalyst::View';

sub COMPONENT {
  my ($class, $app, $args) = @_;
  $args = $class->merge_config_hashes($class->config, $args);
  $class->on_init($app, $args) if $class->can('on_init');
  return bless $args, $class;
}

sub ACCEPT_CONTEXT {
  my ($self, $c, %args) = @_;
  my $args = $self->merge_config_hashes($self->config, \%args);

  my $template;
  if(exists($args->{template})) {
    $template = delete ($args->{template});
  } elsif(exists($args->{template_src})) {
    $template = $c->config->{root}->file(delete $args->{template_src})->slurp;
  } else {
    die "Can't find a template for your View";
  }

  my $directives = delete $args->{directives};
  my $pure_class = exists($args->{pure_class}) ?
    delete($args->{pure_class}) :
    'Template::Pure';

  Catalyst::Utils::ensure_class_loaded($pure_class);

  my $key = blessed($self) ? refaddr($self) : $self;

  if(blessed $c) {
    return $c->stash->{"__Pure_${key}"} ||= do {
      $self->before_build($c, %$args) if $self->can('before_build');
      my $pure = $pure_class->new(
        template => $template,
        directives => $directives,
        components => +{
          map {
            my $v = $_;
            lc($v) => sub {
            my ($pure, %params) = @_;
            return $c->view($v, %params);
          } } ($c->views)
        },
        %$args,
      );
      
      my $new = ref($self)->new(
        %{$args},
        %{$c->stash},
        ctx => $c,
        pure => $pure,
      );
      $new->after_build($c) if $new->can('after_build');
      return $new;
    } 
  } else {
    die "Can't make this class without a context";
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

  $self->on_response($self->{ctx},$res) if $self->can('on_response');

  $res->status($status) unless $res->status != 200;
  $res->content_type('text/html') unless $res->content_type;
  $res->body($self->render);
}

sub render {
  my ($self, $data) = @_;
  $self->before_render($self->{ctx}) if $self->can('before_render');
  # quite possible I should do something with $data...
  return $self->{pure}->render($self)
}

sub TO_HTML {
  my ($self, $pure, $dom, $data) = @_;
  return $self->{pure}->encoded_string(
    $self->render($self));
}

sub Views {
  my $self = shift;
  my %view_dispatch = (
    map {
      my $v = $_;
      $v => sub {
        my ($pure, $dom, $data) = @_;
        $self->{ctx}->view($v, %$data);
      }
    } ($self->{ctx}->views)
  );
  return \%view_dispatch;
}

# Proxy these here for now.  I assume eventually will nee
# a subclass just for components
sub style_fragment { shift->{pure}->style_fragment }
sub script_fragment { shift->{pure}->script_fragment }

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
