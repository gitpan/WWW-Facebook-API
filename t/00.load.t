#######################################################################
# $Date: 2007-05-31T19:37:20.109163Z $
# $Revision: 1538 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More tests => 17;

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
