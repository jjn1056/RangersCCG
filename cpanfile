requires 'Catalyst', '5.90103';
requires 'Catalyst::ActionSignatures', '0.010';
requires 'Catalyst::Model::DBIC::Schema', '0.65';
requires 'Catalyst::Model::DataHash', '0.001';
requires 'Catalyst::Plugin::ConfigLoader', '0.34';
requires 'Catalyst::Plugin::CurrentComponents', '0.004';
requires 'Catalyst::Plugin::InjectionHelpers', '0.007';
requires 'Catalyst::Plugin::MapComponentDependencies', '0.009';
requires 'Catalyst::Plugin::RedirectTo', '0.001';
requires 'Catalyst::Plugin::ResponseFrom', '0.003';
requires 'Catalyst::Plugin::URI', '0.002';
requires 'Catalyst::TraitFor::Model::DBIC::Schema::Result', '0.005';
requires 'Catalyst::TraitFor::Request::ContentNegotiationHelpers', '0.006';
requires 'Catalyst::TraitFor::Request::QueryFromJSONY', '0.002';
requires 'Catalyst::View::JSON::PerRequest', '0.007';
requires 'Catalyst::View::Text::MicroTemplate::PerRequest', '0.004';
requires 'Catalyst::ControllerRole::At', '0.003';
requires 'DBIx::Class', '0.082820';
requires 'DBIx::Class::Helpers', '2.031000';
requires 'DBIx::Class::Schema::Loader', '0.07043';
requires 'DBD::Pg', '3.5.3';

requires 'Template::Pure', '0.011';
requires Data::Perl;
requires Scalar::Util;

requires 'JSON::MaybeXS', '1.003005';
requires 'Moose', '2.1603';
requires 'Moo', '2.000002';
requires 'Plack', '1.0037';
requires 'Type::Tiny', '1.000005';
requires 'Gazelle', '0.41';

on test => sub {
  requires 'Catalyst::Test';
  requires 'HTTP::Request::Common', '6.11';
  requires 'Test::DBIx::Class', '0.45';
  requires 'Test::Most', '0.34';
};

on develop => sub {
  requires 'App::Ack', '2.14';
  requires 'Devel::Confess', '0.008000';
  requires 'Devel::Dwarn';
};
