use strict;
use warnings;

package RangersCCG::Schema::Result::Race;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('race');
__PACKAGE__->add_columns(
  race_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  label => {
    data_type => 'varchar',
    size => '20',
  },
);

__PACKAGE__->set_primary_key('race_id');
__PACKAGE__->add_unique_constraint([ 'label' ]);

__PACKAGE__->has_many(
  character_rs => '::Character',
  { 'foreign.fk_race_id' => 'self.race_id' });

1;

=head1 TITLE

RangersCCG::Schema::Result::Race - Character Race

=head1 DESCRIPTION

Only applies to Character cards...

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
