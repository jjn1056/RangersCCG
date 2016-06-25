use strict;
use warnings;

package RangersCCG::Schema::Result::Character;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('character');
__PACKAGE__->add_columns(
  character_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  fk_side_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
  name => {
    data_type => 'varchar',
    size => '40',
  },
  attack => {
    data_type => 'integer',
  },
  has_leader_attack_bonus => {
    data_type => 'integer',
  },
  can_initiate_combat => {
    data_type => 'boolean',
  },
  operate_independently => {
    data_type => 'boolean',
  },
  fk_race_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
);

__PACKAGE__->set_primary_key('character_id', 'fk_side_id');
__PACKAGE__->add_unique_constraint([ 'name' ]);

__PACKAGE__->belongs_to(
  side => '::Side',
  { 'foreign.side_id' => 'self.fk_side_id' });

__PACKAGE__->belongs_to(
  race => '::Race',
  { 'foreign.race_id' => 'self.fk_race_id' });

__PACKAGE__->has_many(
  character_attribute_rs => '::CharacterAttribute',
  { 'foreign.fk_character_id' => 'self.character_id',
    'foreign.fk_side_id' => 'self.fk_side_id',
  });

__PACKAGE__->many_to_many('attribute_rs' => 'character_attribute_rs', 'attribute');

1;

=head1 TITLE

RangersCCG::Schema::Result::Character - A Ranger CCG Character Card

=head1 DESCRIPTION

Character cards are send to the battlefield in a game between the
forces of light and dark.

=head1 FIELDS

This table defines the following fields

=head2 character_id

unique ID for the character

=head2 fk_set_id

The cardset this character belongs to (light, dark, etc.)

=head2 name

Character fullname

=head2 attack

Normal attack strength of the card

=head2 fk_class_id

Character class

=head2 fk_role_id

The role this character plays in combat

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
