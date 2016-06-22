package RangersCCG::Web::View::Timestamp;

use Moo;
use DateTime;

extends 'Catalyst::View::Template::Pure';

has 'tz' => (is=>'ro', predicate=>'has_tz');

sub time {
  my ($self) = @_;
  my $now = DateTime->now;
  $now->set_time_zone($self->tz)
    if $self->has_tz;
  return $now;
}

__PACKAGE__->config(
  pure_class => 'Template::Pure::Component',
  template => q[
    <span class='timestamp'>time</span>
  ],
  directives => [
    '.timestamp' => 'time',
  ],
);