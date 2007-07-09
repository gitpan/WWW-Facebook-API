#######################################################################
# $Date: 2007-07-08 18:53:24 -0700 (Sun, 08 Jul 2007) $
# $Revision: 132 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More tests => 13;

BEGIN {
    use_ok('WWW::Facebook::API');

    for (@WWW::Facebook::API::namespaces) {
        use_ok("WWW::Facebook::API::$_");
    }
}

diag("Testing WWW::Facebook::API $WWW::Facebook::API::VERSION");
