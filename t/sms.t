#######################################################################
# $Date: 2007-06-28 13:05:21 -0700 (Thu, 28 Jun 2007) $
# $Revision: 120 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More tests => 2;
use WWW::Facebook::API;
use strict;
use warnings;

my $api = WWW::Facebook::API->new( app_path => 'test' );

{
    no warnings 'redefine';
    *WWW::Facebook::API::call = sub { shift; return [@_] };
}
is_deeply $api->sms->can_send( uid => 1234 ),
    [ 'sms.canSend', uid => 1234 ],
    'can_send calls correctly';

is_deeply $api->sms->send( uid => 1234 ),
    [ 'sms.send', uid => 1234 ],
    'send calls correctly';

