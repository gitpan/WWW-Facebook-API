#######################################################################
# $Date: 2007-05-03T11:42:54.177571Z $
# $Revision: 1413 $
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
