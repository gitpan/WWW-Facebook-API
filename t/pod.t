#######################################################################
# $Date: 2007-05-03 04:42:54 -0700 (Thu, 03 May 2007) $
# $Revision: 5 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
#!perl -T

use Test::More;
eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
all_pod_files_ok();
