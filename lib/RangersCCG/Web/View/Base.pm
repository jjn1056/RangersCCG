use strict;
use warnings;

package RangersCCG::Web::View::Base;

use base 'Catalyst::View::Pure';

sub on_response {
  my ($self, $c, $data) = @_;
  $data->set('time', scalar(localtime));
}

__PACKAGE__->config(
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
      </body>
    </html>
  ],
  directives => [
    'title' => 'title',
    '^body h1' => 'body',
    '#time' => 'time',
  ],
);
