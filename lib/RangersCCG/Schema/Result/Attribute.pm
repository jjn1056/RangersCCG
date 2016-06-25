use strict;
use warnings;

package RangersCCG::Schema::Result::Attribute;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('attribute');
__PACKAGE__->add_columns(
  attribute_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  label => {
    data_type => 'varchar',
    size => '40',
  },
);

__PACKAGE__->set_primary_key('attribute_id');
__PACKAGE__->add_unique_constraint([ 'label' ]);

__PACKAGE__->has_many(
  character_attribute_rs => '::CharacterAttribute',
  { 'foreign.fk_attribute_id' => 'self.attribute_id' });

__PACKAGE__->many_to_many('character_rs' => 'character_attribute_rs', 'character');

1;

=head1 TITLE

RangersCCG::Schema::Result::Attribute - A Ranger CCG Character Attribute

=head1 DESCRIPTION

Attributes tell us about the Character, such as if the know how to use
a bow or a shield, or if they hold some special status such as warlord.

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
