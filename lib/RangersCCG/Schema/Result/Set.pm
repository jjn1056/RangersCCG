use strict;
use warnings;

package RangersCCG::Schema::Result::Set;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('set');
__PACKAGE__->add_columns(
  set_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  label => {
    data_type => 'varchar',
    size => '20',
  },
);

__PACKAGE__->set_primary_key('set_id');
__PACKAGE__->add_unique_constraint([ 'label' ]);

__PACKAGE__->has_many(
  character_rs => '::Character',
  { 'foreign.fk_set_id' => 'self.set_id' });

1;

=head1 TITLE

RangersCCG::Schema::Result::Set - A Ranger CCG Set of cards

=head1 DESCRIPTION

In the the card game, we divide cards into sets, which are right now
the light and dark set.

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
