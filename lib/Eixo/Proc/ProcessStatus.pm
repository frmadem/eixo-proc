package Eixo::Proc::ProcessStatus;

use strict;
use parent qw(Eixo::Proc::Info);

sub tiene{

	name=>undef,

	state=>undef,

	pid=>undef,

	ppid=>undef,

	tgid=>undef,

	tracer_pid=>undef,

	uid=>undef,

	gid=>undef,

	fdsize=>undef,

	groups=>undef,

	vmpeak=>undef,
}

sub __parsear{

	my $datos = $_[0]->__leerFormatoCV('/proc/' . $_[0]->{pid} . '/status');

	foreach(keys(%$datos)){

		$_[0]->{lc($_)} = $datos->{$_};

	}

}

#print __PACKAGE__->new(pid=>1)->parsear->aString;

1;
