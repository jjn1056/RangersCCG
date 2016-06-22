package RangersCCG::Web::Controller::Light;

use Moose;
use MooseX::MethodAttributes;
use Catalyst::ActionSignatures;

extends 'Catalyst::Controller';
with 'Catalyst::ControllerRole::At';

sub root :Via($parent) At($controller/...) { }

  sub display_status :Via(root) At() {
    $_->view('DisplayStatus',
      game => {
        current_move => 0,
        winner => 'N/A',
      })->ok;
  }

__PACKAGE__->meta->make_immutable;

