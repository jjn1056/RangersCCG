use strict;
use warnings;

package RangersCCG::Schema::Result::Card;

use base 'RangersCCG::Schema::Result';

__PACKAGE__->table('card');
__PACKAGE__->add_columns(
  card_id => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  fk_class_id => {
    data_type => 'integer',
    is_foreign_key => 1,
  },);

__PACKAGE__->set_primary_key('card_id');

1;

=head1 TITLE

RangersCCG::Schema::Result::Card - A Ranger CCG Card

=head1 DESCRIPTION

    TBD

=head1 RELATIONSHIPS

This class defines the following relationships

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
