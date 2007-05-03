#######################################################################
# $Date: 2007-05-03T11:42:54.177571Z $
# $Revision: 1413 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
#!perl -T

use Test::More;
eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
all_pod_files_ok();
