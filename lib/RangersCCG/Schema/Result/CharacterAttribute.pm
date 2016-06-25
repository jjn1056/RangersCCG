use strict;
use warnings;

package RangersCCG::Schema::Result::CharacterAttribute;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('character_attribute');
__PACKAGE__->add_columns(
  fk_character_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
  fk_side_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
  fk_attribute_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },
);

__PACKAGE__->set_primary_key(qw/fk_character_id fk_side_id fk_attribute_id/);

__PACKAGE__->belongs_to(
  character => '::Character',
  { 'foreign.character_id' => 'self.fk_character_id',
    'foreign.fk_side_id' => 'self.fk_side_id',
  });

__PACKAGE__->belongs_to(
  attribute => '::Attribute',
  { 'foreign.attribute_id' => 'self.fk_attribute_id' });

1;

=head1 TITLE

RangersCCG::Schema::Result::CharacterAttribute - mapping table

=head1 DESCRIPTION

Relationship bridge between character cards and their attributes

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
