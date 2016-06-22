package RangersCCG::Web::View::Base;

use Moo;

extends 'Catalyst::View::Template::Pure';

has [qw/init_time title body/] => (is=>'ro', required=>1);

sub render_time { scalar(localtime) }

__PACKAGE__->config(
  init_time => scalar(localtime),
  components => +{
    timestamp => sub {
      my ($pure, %params) = @_;
      use Devel::Dwarn;
      Dwarn \@_;
      die;
    },
  },
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
          <span id="time">Page Rendered On: <pure-timestamp /> </span><br/>
          <span id="init-time">Server Started On: </span>
        </div>
      </body>
    </html>
  ],
  directives => [
    'title' => 'title',
    '^body h1' => 'body',
    #   '#time+' => 'render_time',
    '#init-time+' => 'init_time',
  ],
);
