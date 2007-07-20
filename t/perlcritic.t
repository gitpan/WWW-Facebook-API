#######################################################################
# $Date: 2007-07-20 15:04:55 -0700 (Fri, 20 Jul 2007) $
# $Revision: 168 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More;
BEGIN {
    if (! $ENV{'AUTHOR_TESTS'} ) {
        plan( skip_all => 'Skipping author tests' );
        exit;
    }
    eval q{require Test::Perl::Critic};
    if ( $@ ) {
        plan( skip_all =>
            "Test::Perl::Critic required for testing PBP compliance" );
    }
}


use Test::Perl::Critic ( -severity => 1, -profile => 't/perlcriticrc' );
Test::Perl::Critic::all_critic_ok();
