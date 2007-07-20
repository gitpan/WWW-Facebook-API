#######################################################################
# $Date: 2007-07-20 15:04:55 -0700 (Fri, 20 Jul 2007) $
# $Revision: 168 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################

use Test::More;
if (!$ENV{'AUTHOR_TESTS'}) {
    plan skip_all => "Skipping author tests";
    exit;
}

eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;
all_pod_coverage_ok();
