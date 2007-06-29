#######################################################################
# $Date: 2007-06-29 11:10:50 -0700 (Fri, 29 Jun 2007) $
# $Revision: 124 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More tests => 14;

BEGIN {
    use_ok('WWW::Facebook::API');

    for (@WWW::Facebook::API::namespaces) {
        use_ok("WWW::Facebook::API::$_");
    }
}

diag("Testing WWW::Facebook::API $WWW::Facebook::API::VERSION");
