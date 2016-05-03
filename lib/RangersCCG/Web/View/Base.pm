use strict;
use warnings;

package RangersCCG::Web::View::Base;

use base 'Catalyst::View::Pure';

__PACKAGE__->mk_accessors('init_time');

sub render_time { scalar(localtime) }

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
        <div>
          <span id="time">Page Rendered On: </span><br/>
          <span id="init-time">Server Started On: </span>
        </div>
      </body>
    </html>
  ],
  directives => [
    'title' => 'title',
    '^body h1' => 'body',
    '#time+' => 'view.render_time',
    '#init-time+' => 'view.init_time',
  ],
);
