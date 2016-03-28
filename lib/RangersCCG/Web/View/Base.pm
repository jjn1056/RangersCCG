use strict;
use warnings;

package RangersCCG::Web::View::Base;

use base 'Catalyst::View::Pure';

__PACKAGE__->mk_accessors('init_time');

sub time { scalar(localtime) }

__PACKAGE__->config(
  init_time => scalar(localtime),
  template => qq[
    <!doctype html>
    <html lang="en">
      <head>
        <title>Title Goes Here</title>
        <meta charset="utf-8" />
          <meta name="description" content="Rangers CCG API Proto">
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      </head>
      <body>
        <h1>Content goes here!</h1>
        <span id="time">current time</span>
        ...<span id="init-time">start time</span>...
      </body>
    </html>
  ],
  directives => [
    'title' => 'title',
    '^body h1' => 'body',
    '#time' => 'self.time',
    '#init-time' => 'self.init_time',
  ],
);
