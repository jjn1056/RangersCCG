use Test::DBIx::Class
  -schema_class => 'RangersCCG::Schema';

my $config = {
  'Model::Schema' => {
    connect_info => [ sub { Schema()->storage->dbh } ],
  },
};

return $config;
