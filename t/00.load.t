#######################################################################
# $Date: 2007-06-02 01:22:42 -0700 (Sat, 02 Jun 2007) $
# $Revision: 65 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More tests => 18;

BEGIN {
    use_ok( 'WWW::Facebook::API::Errors' );
    use_ok( 'WWW::Facebook::API::Base' );
    use_ok( 'WWW::Facebook::API' );
    use_ok( 'WWW::Facebook::API::Simple' );

    for (@WWW::Facebook::API::namespaces) {
        use_ok( "WWW::Facebook::API::$_" );
    }
}

diag( "Testing WWW::Facebook::API $WWW::Facebook::API::VERSION" );
