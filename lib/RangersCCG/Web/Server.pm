use warnings;
use strict;

package RangersCCG::Web::Server;

use RangersCCG::Web;
use Plack::Runner;

sub run {
  Plack::Runner->run(@_, RangersCCG::Web->to_app);
}

return caller(1) ? 1 : run(@ARGV);

=head1 TITLE

RangersCCG::Web::Server - Start the application under a web server

=head1 DESCRIPTION

Start the web application.  Example:

    perl -Ilib  lib/RangersCCG/Web/Server.pm --server Gazelle

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>.

=head1 LICENSE

See L<RangersCCG>.

=cut
