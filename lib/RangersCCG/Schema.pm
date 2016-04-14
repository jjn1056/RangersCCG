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
    Set => [
      ['label'],
      ['light'],
      ['dark'],
    ]);

  $self->populate(
    Class => [
      ['label'],
      ['ranger'],
      ['shaman'],
      ['herald'],
      ['healer'],
    ]);

  $self->populate(
    CombatRole => [
      ['label'],
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
    ['Drustan Lorne', 2, 1, 1, 'ranger', 'human',  'archer'],
    ['Thane', 2, 1, 1, 'ranger', 'human', 'shield man'],
    ['Wolf ', 2, 1, 1, 'ranger','human','lieutenant'],
    ['Ivar', 1, 1, 1, 'ranger','human','archer'],
    ['Corser', 1, 1, 1, 'ranger','human','warrior'],
    ['Flynt Tanner', 2, 1, 1,'ranger','human','shield man'],
    ['Garrin', 2, 1, 1, 'ranger','human','falconer'],
    ['Sven', 2, 1, 1, 'ranger','human','berserker'],
    ['Kier', 1, 1, 1, 'ranger','human','warrior'],
    ['Soren Fell', 1, 1, 1, 'ranger','human','recruit'],
    ['Malde', 1, 1, 1, 'shaman','human','caster'],
    ['Amundsen', 1, 1, 1, 'herald','human','historian'],
    ['Kani', 0, 0, 0, 'healer','human','caster'],
  );

  my @characters = map {
    {
      set => {label=>'light'},
      name => $_->[0],
      attack => $_->[1],
      can_initiate_combat => $_->[2],
      operate_independently => $_->[3],
      class => {label=>$_->[4]},
      race => {label=>$_->[5]},
      combat_role => {label=>$_->[6]}
    }
  } @light;
      
  $self->populate(Character => \@characters);
}

1;

