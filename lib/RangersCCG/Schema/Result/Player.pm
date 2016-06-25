use strict;
use warnings;

package RangersCCG::Schema::Result::Player;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('player');
__PACKAGE__->add_columns(
  player_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  handle => {
    data_type => 'varchar',
    size => '64',
  },
);

__PACKAGE__->set_primary_key('player_id');
__PACKAGE__->add_unique_constraint([ 'handle' ]);

__PACKAGE__->has_many(
  game_player_side_rs => '::GamePlayerSide',
  { 'foreign.fk_player_id' => 'self.player_id' });

__PACKAGE__->many_to_many('game_rs' => 'game_player_side_rs', 'game');
__PACKAGE__->many_to_many('side_rs' => 'game_player_side_rs', 'side');

1;

=head1 TITLE

RangersCCG::Schema::Result::Player - Player of the Game

=head1 DESCRIPTION

This is a person that can play a game of RangersCCG

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
