use strict;
use warnings;

package Catalyst::View::Pure;

use Template::Pure;
use Data::Perl qw/hash/;
use Scalar::Util qw/blessed refaddr/;

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

  my @directives;
  if(ref($args->{directives}) eq 'ARRAY') {
    @directives = @{delete $args->{directives}};
  } 

  return bless +{
    pure => Template::Pure->new(
      template=> $template, 
        directives=>\@directives),
    args => $args,
  }, $class;
}

sub ACCEPT_CONTEXT {
  my ($self, $c, %args) = @_;
  my $key = blessed($self) ? refaddr($self) : $self;
  my $data = hash();

  if(blessed $c) {
    return $c->stash->{"__Pure_${key}"} ||= do {
      $self->on_response($c, $data) if $self->can('on_response');
      bless +{
        ctx => $c,
        pure => $self->{pure},
        args => +{ %{$self->{args}}, %args },
        data => $data,
      }, ref($self);
    } 
  } else {
    return bless +{
        app => $c,
        pure => $self->{pure},
        args => +{ %{$self->{args}}, %args },
        data => $data,
    }, ref($self);
  }
}

sub data { shift->{data} }

sub response {
  my ($self, $status, @proto) = @_;

  die "You need a context to build a response" unless $self->{ctx};

  my $res = $self->{ctx}->res;

  if(ref($proto[0]) eq 'ARRAY') {
    my @headers = @{shift @proto};
    $res->headers->push_header(@headers);
  }

  my %data = ($self->{data}->all,
    %{$self->{args}});
  
  if(ref($proto[0]) eq 'HASH') {
    %data = (%data, %{$proto[0]});
  }

  $res->status($status) unless $res->status != 200;
  $res->content_type('text/html') unless $res->content_type;
  $res->body( $self->render_with_extra_directives(\%data) );
}

sub render_with_extra_directives {
  my ($self, $data) = @_;
  my @extra_directives;
  if($self->{args}{directives}) {
    @extra_directives = $self->{args}{directives}->(
      $self->{pure}, $self->{ctx});
  }
  return $self->{pure}->render($data, \@extra_directives)
}

sub TO_HTML {
  my ($self, $pure, $dom, $data) = @_;

  # This only works for now since we expect $data to be a hashref,
  # but it will eventually break when we all real data objects.
  # At that point maybe need Template::Pure::DataProxy???

  my %data = ($self->{data}->all,
    %{$data||+{}});

  return $self->{pure}->encoded_string(
    $self->render_with_extra_directives(\%data));
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
