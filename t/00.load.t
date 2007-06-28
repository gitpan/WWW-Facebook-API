#######################################################################
# $Date: 2007-06-28 13:05:21 -0700 (Thu, 28 Jun 2007) $
# $Revision: 120 $
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
