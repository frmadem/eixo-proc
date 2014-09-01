package dsys::InfoUnit;

use strict;
use parent qw(dsys::Info);

sub attr{
	$_[0]->{$_[1]};
}

1;
