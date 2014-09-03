package Eixo::Proc::ProcessDescriptor;

use strict;
use parent qw(Eixo::Proc::Info);

sub tiene{

	descriptor=>undef,

	path=>undef,

	inode=>undef,
}

sub __parsear{

	$_[0]->{path} = readlink($_[0]->{descriptor});

	$_[0]->{inode} = (stat($_[0]->{path}))[1];
}

1;
