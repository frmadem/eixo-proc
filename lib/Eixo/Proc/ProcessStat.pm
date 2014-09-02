package Eixo::Proc::ProcessStat;

use strict;
use parent qw(Eixo::Proc::Info);

my @CAMPOS = qw(

	pid
	comm
	state
	ppid
	pgrp
	session
	tty_nr
	tgpid
	flags
	minflt
	cminflt
	majflt
	cmajflt
	utime
	stime
	cutime
	cstime
	priority
	nice
	num_threads
	itrealvalue
	starttime
	vsize
	rss
	rsslim
	startcode
	endcode
	startstack
	kstkesp
	kstkeip
	signal
	blocked
	sigignore
	sigcatch
	wchan
	nswap
	cnswap
	exit_signal
	processor
	rt_priority
	policy
	delayacct_blkio_ticks
	guest_time
	cguest_time
	end_data
	start_brk
	arg_start
	arg_end
	env_start
	env_end
	exit_code
);

sub tiene{

	map { $_ => undef} @CAMPOS

}


sub __parsear{

	my $datos = $_[0]->__leerFormatoESV('/proc/' . $_[0]->{pid} . '/stat', \@CAMPOS);

	foreach(keys(%$datos)){

		$_[0]->{lc($_)} = $datos->{$_};

	}

}

#print __PACKAGE__->new(pid=>1)->parsear->aString;

1;
