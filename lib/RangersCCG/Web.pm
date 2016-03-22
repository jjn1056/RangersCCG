package RangersCCG::Web;

use Catalyst::Plugin::MapComponentDependencies::Utils ':ALL';
use Catalyst qw/
  ConfigLoader
  ResponseFrom
  RedirectTo
  CurrentComponents
  InjectionHelpers
  MapComponentDependencies
  URI
/;

__PACKAGE__->inject_components(
  'Model::Schema' => { from_component => 'Catalyst::Model::DBIC::Schema'});

__PACKAGE__->request_class_traits([
  'ContentNegotiationHelpers',
  'QueryFromJSONY']);


__PACKAGE__->config(
  'default_view' => 'HTML',
  'default_model' => 'Schema',
  'Controller::Root' => { namespace => '' },
  'Model::Schema' => {
    traits => ['Result', 'SchemaProxy'],
    schema_class => 'RangersCCG::Schema',
  },
  'Plugin::CurrentComponents' => {
    model_instance_from_return => 1,
  },
);

__PACKAGE__->setup;

=head1 NAME

RangersCCG::Web - Prototype service to query the Adama DB 

=head1 SYNOPSIS

    TBD

=head1 DESCRIPTION

    TBD

=head1 METHODS

This class defines the following methods

=head1 AUTHORS & COPYRIGHT

See L<RangersCCG>

=head1 LICENSE

See L<RangersCCG>

=cut

