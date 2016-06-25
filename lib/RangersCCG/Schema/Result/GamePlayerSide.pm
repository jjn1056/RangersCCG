use strict;
use warnings;

package RangersCCG::Schema::Result::GamePlayerSide;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('game_players_sides');
__PACKAGE__->add_columns(
  fk_game_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
  fk_player_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
  fk_side_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
);

__PACKAGE__->set_primary_key(qw/fk_game_id fk_player_id fk_side_id/);

__PACKAGE__->belongs_to(
  game => '::Game',
  { 'foreign.game_id' => 'self.fk_game_id' });

__PACKAGE__->belongs_to(
  player => '::Player',
  { 'foreign.player_id' => 'self.fk_player_id' });

__PACKAGE__->belongs_to(
  side => '::Side',
  { 'foreign.side_id' => 'self.fk_side_id' });


1;

=head1 TITLE

RangersCCG::Schema::Result::GamePlayerSide - mapping table

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
