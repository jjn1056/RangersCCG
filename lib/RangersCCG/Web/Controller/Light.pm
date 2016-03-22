package RangersCCG::Web::Controller::Light;

use Moose;
use MooseX::MethodAttributes;
use Catalyst::ActionSignatures;

extends 'Catalyst::Controller';
with 'Catalyst::ControllerRole::At';

sub root :Via($parent) At($controller/...) { }

  sub display_status(View::DisplayStatus $v) :Via(root) At() {
    $v->ok({
      game => {
        current_move => 0,
      },
    });
  }


__PACKAGE__->meta->make_immutable;

