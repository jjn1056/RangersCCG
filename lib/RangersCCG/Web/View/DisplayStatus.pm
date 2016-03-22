use strict;
use warnings;

package RangersCCG::Web::View::DisplayStatus;

use base 'Catalyst::View::Pure';

__PACKAGE__->config(
  template => qq[
    <html>
      <head>
        <title>Rangers CCG - Forces of Light Status</title>
      </head>
      <body>
        <section id="game-info">
        <h1>Game Information</h1>
          <dl>
            <dt>Game Move</dt><dd id="game-move">??</dd>
            <dt>Who's Turn?</dt><dd id="whos-turn">??</dd>
            <dt>Has Winner?</dt><dd id="winner">??</dd>
          </dl>
        </section>
        <section id="forces-of-darkness">
        <h1>Forces of Darkness</h1>
          <dl>
            <dt>Attack Total</dt><dd id="darkness-attack-total">??</dd>
          </dl>
          <h2>Battlefield</h2>
            <ol id="darkness-battlefield">
              <li>??</li>
            </ol>
        </section>
        <section id="forces-of-light">
        <h1>Forces of Light</h1>
          <dl>
            <dt>Attack Total</dt><dd id="light-attack-total">??</dd>
            <dt>Cards Remaining in Deck</dt><dd id="light-cards-in-deck">??</dd>
          </dl>
          <h2>Battlefield</h2>
            <ol id="light-battlefield">
              <li>??</li>
            </ol>
          <h2>Cards In Hand</h2>
            <ol id="light-cards-in-hand">
              <li>??</li>
            </ol>
          <h2>Discard Pile</h2>
            <ol id="light-discard-pile">
              <li>??</li>
            </ol>
          <h2>Removed From Play</h2>
            <ol id="light-removed-from-play">
              <li>??</li>
            </ol>
        </section>
      </body>
    </html>
  ],
  directives => sub {
    my ($pure, $ctx) = @_;
    '^html' => [
      {
        'title' => \'title',
        'body' => \'body',
      }, 
      '.' => $ctx->view('Base'),
    ],
    '#game-move' => 'game.current_move',
  },
);
