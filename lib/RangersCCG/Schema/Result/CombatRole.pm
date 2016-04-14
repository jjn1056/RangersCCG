use strict;
use warnings;

package RangersCCG::Schema::Result::CombatRole;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('combat_role');
__PACKAGE__->add_columns(
  combat_role_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  label => {
    data_type => 'varchar',
    size => '20',
  },
);

__PACKAGE__->set_primary_key('combat_role_id');
__PACKAGE__->add_unique_constraint([ 'label' ]);

__PACKAGE__->has_many(
  character_rs => '::Character',
  { 'foreign.fk_combat_role_id' => 'self.combat_role_id' });

1;

=head1 TITLE

RangersCCG::Schema::Result::CombatRole - What a character does in a fight

=head1 DESCRIPTION

Defines some aspects of what a character can do in a fight

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
