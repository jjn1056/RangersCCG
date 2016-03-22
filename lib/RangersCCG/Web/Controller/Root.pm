package RangersCCG::Web::Controller::Root;

use Moose;
use MooseX::MethodAttributes;
use Catalyst::ActionSignatures;

extends 'Catalyst::Controller';
with 'Catalyst::ControllerRole::At';

sub root :At(/...) { }

__PACKAGE__->meta->make_immutable;
