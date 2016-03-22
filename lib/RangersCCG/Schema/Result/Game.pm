use strict;
use warnings;

package RangersCCG::Schema::Result::Game;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('game');
__PACKAGE__->add_columns(
  game_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
);

__PACKAGE__->set_primary_key('game_id');

1;

=head1 TITLE

RangersCCG::Schema::Result::Game - A game of Rangers

=head1 DESCRIPTION

    TBD

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
