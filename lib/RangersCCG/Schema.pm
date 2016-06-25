use strict;
use warnings;

package RangersCCG::Schema;

our $VERSION = 1;
use base 'DBIx::Class::Schema';

__PACKAGE__->load_components(qw/
  Helper::Schema::QuoteNames
  Helper::Schema::DidYouMean
  Helper::Schema::DateTime/);

__PACKAGE__->load_namespaces(
  default_resultset_class => "DefaultRS");

sub now {
  my $self = shift;
  my $dbh = $self->storage->dbh;
  my $now = $dbh->selectrow_arrayref(
    "select now() from users limit 1");

  return $now;
}

sub diagram {
  my $self = shift;
  my $number_tables = scalar $self->sources;
  my $dimension = int sqrt($number_tables * 13);
  my $trans = SQL::Translator->new(
    parser => 'SQL::Translator::Parser::DBIx::Class',
    parser_args => { dbic_schema => $self },
    producer => 'GraphViz',
    producer_args => {
      skip_tables => 'dbix_class_deploymenthandler_versions',
      width => $dimension,
      height => $dimension,
      show_constraints => 1,
      show_datatypes => 1,
      show_sizes => 1,
      out_file  => 'rangers_ccg.png' });
 
  $trans->translate
    or die $trans->error;
}

sub setup {
  my $self = shift;

  $self->populate(
    Race => [
      ['label'],
      ['human'],

    ]);

  $self->populate(
    Side => [
      ['label'],
      ['light'],
    ]);

  $self->populate(
    Attribute => [
      ['label'],
      ['ranger'],
      ['shaman'],
      ['herald'],
      ['healer'],
      ['archer'],
      ['warrior'],
      ['shieldman'],
      ['falconer'],
      ['recruit'],
      ['caster'],
      ['lieutenant'],
      ['berserker'],
    ]);

  my @light = (
    ['Drustan Lorne', 2, 1, 1, 0, 'human',  [qw/ranger archer/]],
    ['Thane', 2, 1, 1, 0, 'human', ['ranger','shield man']],
    ['Wolf ', 2, 1, 1, 0, 'human', ['ranger','lieutenant']],
    ['Ivar', 1, 1, 1, 0, 'human', ['ranger','archer']],
    ['Corser', 1, 1, 1, 1, 'human', ['ranger','warrior']],
    ['Flynt Tanner', 2, 1, 1, 0, 'human', ['ranger','shield man']],
    ['Garrin', 2, 1, 1, 0, 'human', ['ranger','falconer']],
    ['Sven', 2, 1, 1, 0, 'human', ['ranger','berserker']],
    ['Kier', 1, 1, 1, 0, 'human',['ranger', 'warrior']],
    ['Soren Fell', 1, 1, 1, 0, 'human',['ranger','recruit']],
    ['Malde', 1, 1, 1, 0, 'human',['shaman','caster']],
    ['Amundsen', 1, 1, 1, 0, 'human', ['herald','historian']],
    ['Kani', 0, 0, 0, 0, 'human',['healer','caster']],
  );

  my @light_side_characters = map {
    {
      side => {label=>'light'},
      name => $_->[0],
      attack => $_->[1],
      can_initiate_combat => $_->[2],
      operate_independently => $_->[3],
      has_leader_attack_bonus => $_->[4],
      race => {label=>$_->[5]},
      character_attribute_rs => [map { +{attribute => {label=>$_}} } @{$_->[6]}],
    }
  } @light;
      
  $self->populate(Character => \@light_side_characters);

  # Now the dark side!
  $self->populate(
    Side => [
      ['label'],
      ['dark'],
    ]);

  my @dark = (
    ['Ooklar', 1, 1, 1, 1, 'greenskin orc',  ['warrior']],
    ['Buga', 1, 1, 1, 0, 'greenskin orc',  ['warrior']],
    ['Zulgar', 1, 1, 1, 0, 'greenskin orc',  ['archer']],
    ['Thul\'ug', 2, 1, 1, 0, 'greenskin orc',  ['warrior']],
    ['Tral', 1, 1, 1, 0, 'greenskin orc',  ['shaman', 'caster']],
    ['Skrix', 0, 0, 0, 0, 'goblin',  ['war chanter', 'caster']],
    ['Lacker Pyne', 1, 1, 1, 0, 'human',  ['bounty hunter']],
    ['Turok', 1, 1, 1, 0, 'greenskin orc',  ['grunt']],
    ['Gurog', 2, 1, 1, 0, 'black orc',  ['beastmaster']],
    ['Durok', 1, 1, 1, 0, 'black orc',  ['Assasin']],
    ['Kulta', 2, 1, 1, 0, 'black orc',  ['warlord']],
    ['Grishurz', 1, 1, 1, 0, 'black orc',  ['warrior']],
    ['Garak', 2, 1, 1, 0, 'black orc',  ['warrior']],
  );

  my @dark_side_characters = map {
    {
      side => {label=>'dark'},
      name => $_->[0],
      attack => $_->[1],
      can_initiate_combat => $_->[2],
      operate_independently => $_->[3],
      has_leader_attack_bonus => $_->[4],
      race => {label=>$_->[5]},
      character_attribute_rs => [map { +{attribute => {label=>$_}} } @{$_->[6]}],
    }
  } @dark;
      
  $self->populate(Character => \@dark_side_characters);

}

1;

