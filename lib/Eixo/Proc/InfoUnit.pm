package Eixo::Proc::InfoUnit;

use strict;
use parent qw(Eixo::Proc::Info);

sub attr{
	$_[0]->{$_[1]};
}

1;
