#######################################################################
# $Date: 2007-05-03 04:42:54 -0700 (Thu, 03 May 2007) $
# $Revision: 5 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More tests => 3;
use strict;
use warnings;

BEGIN { use_ok('WWW::Facebook::API::Simple'); }

my $api = WWW::Facebook::API::Simple->new( api_key => 1, secret => 1 );
isa_ok $api, 'WWW::Facebook::API';
is $api->simple, 1, 'simple attribute set correctly';
