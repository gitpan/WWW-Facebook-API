#######################################################################
# $Date: 2007-06-03 21:21:26 -0700 (Sun, 03 Jun 2007) $
# $Revision: 91 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More;
BEGIN {
    eval 'use Test::MockObject::Extends';
    if ($@) {
        plan skip_all => 'Tests require Test::MockObject::Extends';
    }
    plan tests => 6;
}

use WWW::Facebook::API;
use strict;
use warnings;

BEGIN { use_ok('WWW::Facebook::API::Auth'); }

my $api = Test::MockObject::Extends->new(
    WWW::Facebook::API->new(
        api_key => 1,
        secret  => 1,
        parse_response => 1,
        desktop => 1,
    ),
);

{
    local $/ = "\n\n";
    $api->set_series('_post_request', <DATA>);
}

my $auth = WWW::Facebook::API::Auth->new( base => $api );

my $token = $auth->create_token;
is $token, '3e4a22bb2f5ed75114b0fc9995ea85f1', 'token correct';

$auth->get_session( $token );
is $api->session_key, '5f34e11bfb97c762e439e6a5-8055', 'session key correct';
is $api->session_uid, '8055', 'uid correct';
is $api->session_expires, '1173309298', 'expires correct';
is $api->secret, '23489234289342389', 'secret correct';

__DATA__
"3e4a22bb2f5ed75114b0fc9995ea85f1"

{"session_key":"5f34e11bfb97c762e439e6a5-8055","uid":"8055","expires":1173309298,"secret":"23489234289342389"}
