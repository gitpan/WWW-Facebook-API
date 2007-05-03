#######################################################################
# $Date: 2007-05-03T11:42:54.177571Z $
# $Revision: 1413 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
#!perl -T

use Test::More;
eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage" if $@;
all_pod_coverage_ok();
