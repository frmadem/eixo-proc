package Eixo::Proc::ProcessDescriptor;

use strict;
use parent qw(Eixo::Proc::Info);

sub tiene{

	descriptor=>undef,

	ruta=>undef,

	inodo=>undef,
}

sub __parsear{

	$_[0]->{ruta} = readlink($_[0]->{descriptor});

	$_[0]->{inodo} = (stat($_[0]->{ruta}))[1];
}

1;
