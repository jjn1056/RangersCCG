use strict;
use warnings;

package RangersCCG::Schema::Result::Side;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('side');
__PACKAGE__->add_columns(
  side_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  label => {
    data_type => 'varchar',
    size => '20',
  },
);

__PACKAGE__->set_primary_key('side_id');
__PACKAGE__->add_unique_constraint([ 'label' ]);

__PACKAGE__->has_many(
  character_rs => '::Character',
  { 'foreign.fk_side_id' => 'self.side_id' });

__PACKAGE__->has_many(
  game_player_side_rs => '::GamePlayerSide',
  { 'foreign.fk_side_id' => 'self.side_id' });

__PACKAGE__->many_to_many('game_rs' => 'game_player_side_rs', 'game');
__PACKAGE__->many_to_many('player_rs' => 'game_player_side_rs', 'player');

1;

=head1 TITLE

RangersCCG::Schema::Result::Side - The side of the game 

=head1 DESCRIPTION

A Side that a character card or player is associated with

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
