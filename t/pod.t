#######################################################################
# $Date: 2007-06-29 11:10:50 -0700 (Fri, 29 Jun 2007) $
# $Revision: 124 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################

use Test::More;
eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
all_pod_files_ok();
