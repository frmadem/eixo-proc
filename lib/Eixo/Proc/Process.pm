package Eixo::Proc::Process;

use strict;
use parent qw(Eixo::Proc::InfoUnit);

use Eixo::Proc::ProcessStat;
use Eixo::Proc::ProcessLocks;
use Eixo::Proc::ProcessStatus;
use Eixo::Proc::ProcessHistory;
use Eixo::Proc::ProcessDescriptor;


sub tiene{

	pid=>undef,

	ppid=>undef,

	exe=>undef,

	name=>undef,

	state=>undef,

	user=>undef,

	effective_user=>undef,

	resident_memory=>undef,

	virtual_memory => undef,

	resident_memory_peak => undef,

	virtual_memory_peak => undef,

	etime => undef,
}

sub history{
	my ($self) = @_;

	Eixo::Proc::ProcessHistory->new(

		pid=>$_[0]->{pid}

	)->parsear($self);
} 

sub __parsear{
	
	$_[0]->{exe} = $_[0]->__cargarExe;

	$_[0]->__cargarStatus;

	$_[0]->__cargarDescriptores;

	$_[0]->__cargarLocks;
}

	sub __cargarExe{

		readlink('/proc/' . $_[0]->{pid} . '/exe');

	}

	sub __cargarStat{
		
		my $stat = Eixo::Proc::ProcessStat->new(pid=>$_[0]->{pid})->parsear;

		$_[0]->agregarInfo(

			$stat

		);
	}

	sub __cargarStatus{

		$_[0]->{etime} = (stat("/proc/" . $_[0]->{pid}))[10];

		my $status = Eixo::Proc::ProcessStatus->new(pid=>$_[0]->{pid})->parsear;

		$_[0]->agregarInfo($status);

		$_[0]->{ppid} = $status->{ppid};

		$_[0]->{name} = $status->{name};

		$_[0]->{state} = $status->{state};

		#
		# uids
		#
		my ($ruid, $euid, $suid, $filesytem) = split(/\s/, $status->{uid});

		$_[0]->{user} = getpwuid($ruid);
	
		$_[0]->{effective_user} = getpwuid($euid);

		#
		# Empleo de memoria
		# 
		($_[0]->{resident_memory}) = $status->{vmrss} =~ /(\d+)/;
		
		($_[0]->{virtual_memory}) = $status->{vmsize} =~ /(\d+)/;

		($_[0]->{resident_memory_peak}) = $status->{vmhwm} =~ /(\d+)/;

		($_[0]->{virtual_memory_peak}) = $status->{vmpeak} =~ /(\d+)/;
		
	}

	sub __cargarDescriptores{

		my $d;
		
		my $ruta = '/proc/' . $_[0]->{pid} . '/fd/';

		opendir($d, $ruta);

		my @descriptores = grep { $_ =~ /^\d+$/ } readdir($d);

		closedir $d;

		foreach(@descriptores){

			$_[0]->agregarInfo(

				Eixo::Proc::ProcessDescriptor->new(descriptor=> $ruta . $_)->parsear

			)

		}
	}

	sub __cargarLocks{

		$_[0]->agregarInfo(

			Eixo::Proc::ProcessLocks->new(

				pid=>$_[0]->{pid},
				
				process=>$_[0]

			)->parsear

		);
	}


1;
