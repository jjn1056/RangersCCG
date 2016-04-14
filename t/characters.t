use Test::Most;
use Test::DBIx::Class
  -traits=>'Testpostgresql',
  -schema_class => 'RangersCCG::Schema';

Schema->setup;

done_testing;
