use Test::DBIx::Class
  -traits=>['Testpostgresql'],
  -schema_class => 'RangersCCG::Schema';

my $config = {
  'Model::Schema' => {
    connect_info => [ sub { Schema()->storage->dbh } ],
  },
};

return $config;
