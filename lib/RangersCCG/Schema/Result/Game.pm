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

__PACKAGE__->has_many(
  game_player_side_rs => '::GamePlayerSide',
  { 'foreign.fk_game_id' => 'self.game_id' });

__PACKAGE__->many_to_many('player_rs' => 'game_player_side_rs', 'player');
__PACKAGE__->many_to_many('side_rs' => 'game_player_side_rs', 'side');

1;

=head1 TITLE

RangersCCG::Schema::Result::Game - Shall we play a Game?

=head1 DESCRIPTION

A Game of RangersCCG

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
