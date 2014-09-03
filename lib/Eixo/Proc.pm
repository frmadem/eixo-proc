package Eixo::Proc;

use 5.008;
use strict;
use warnings;
use Eixo::Proc::Ps;


our $VERSION = '0.020';

our $ps = undef;

sub ps {

	return $ps->actualizar if($ps);

	$ps = Eixo::Proc::Ps->new->parsear();

}

sub search{
	shift if(@_ % 2);

	
	Eixo::Proc->ps->search(@_);	

}


1;
