package RangersCCG::Web::Controller::Root;

use Moose;
use MooseX::MethodAttributes;
use Catalyst::ActionSignatures;

extends 'Catalyst::Controller';
with 'Catalyst::ControllerRole::At';

sub root :At($controller/...) { }

  sub base :Via(root) At() {
    $_->stash(body=>'bod');
    $_->view('Base', 
      title=>'fff')
      ->ok;
  }

__PACKAGE__->meta->make_immutable;
