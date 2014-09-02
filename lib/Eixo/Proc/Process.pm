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

	comando=>undef,

	estado=>undef,

	usuario=>undef,

	usuario_efectivo=>undef,

	memoria_residente=>undef,

	memoria_virtual => undef,

	pico_memoria_residente => undef,

	pico_memoria_virtual => undef,

	etime => undef,
}

sub historia{
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

		my $status = Eixo::Proc::ProcessStatus->new(pid=>$_[0]->{pid})->parsear;


		$_[0]->{etime} = (stat("/proc/" . $_[0]->{pid}))[10];
		$_[0]->agregarInfo($status);

		$_[0]->{ppid} = $status->{ppid};

		$_[0]->{comando} = $status->{name};

		#
		# uids
		#
		my ($ruid, $euid, $suid, $filesytem) = split(/\s/, $status->{uid});

		$_[0]->{usuario} = getpwuid($ruid);
	
		$_[0]->{usuario_efectivo} = getpwuid($euid);

		#
		# Empleo de memoria
		# 
		($_[0]->{memoria_residente}) = $status->{vmrss} =~ /(\d+)/;
		
		($_[0]->{memoria_virtual}) = $status->{vmsize} =~ /(\d+)/;

		($_[0]->{pico_memoria_residente}) = $status->{vmhwm} =~ /(\d+)/;

		($_[0]->{pico_memoria_virtual}) = $status->{vmpeak} =~ /(\d+)/;
		
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
				
				proceso=>$_[0]

			)->parsear

		);
	}


1;
