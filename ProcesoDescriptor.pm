package dsys::ProcesoDescriptor;

use strict;
use parent qw(dsys::Info);

sub tiene{

	descriptor=>undef,

	ruta=>undef,
}

sub __parsear{

	$_[0]->{ruta} = readlink($_[0]->{descriptor});
}

1;
