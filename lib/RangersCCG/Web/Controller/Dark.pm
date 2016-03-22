package RangersCCG::Web::Controller::Dark;

use Moose;
use MooseX::MethodAttributes;
use Catalyst::ActionSignatures;

extends 'Catalyst::Controller';
with 'Catalyst::ControllerRole::At';

sub root :Via($parent) At($controller) {
  pop->res->body("hi");  
}


__PACKAGE__->meta->make_immutable;
