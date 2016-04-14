use strict;
use warnings;

package RangersCCG::Schema::Result::Class;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('class');
__PACKAGE__->add_columns(
  class_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  label => {
    data_type => 'varchar',
    size => '20',
  },
);

__PACKAGE__->set_primary_key('class_id');
__PACKAGE__->add_unique_constraint([ 'label' ]);

__PACKAGE__->has_many(
  character_rs => '::Character',
  { 'foreign.fk_class_id' => 'self.class_id' });

1;

=head1 TITLE

RangersCCG::Schema::Result::Class - A Ranger CCG Character Class

=head1 DESCRIPTION

A Class defines some aspects of what a character card can do

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
