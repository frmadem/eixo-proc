package Eixo::Proc::ProcessLocks;

use strict;
use parent qw(Eixo::Proc::Info);

sub tiene{

	pid=>undef,

	bloqueos=>{},	

	proceso=>undef,

}

sub __parsear{
	
	#
	# Vemos si nuestro proceso tiene locks
	#

	my @locks  = grep { $_->[4] eq $_[0]->{pid}} $_[0]->__flocks;

	my @descriptores = $_[0]->{proceso}->buscar(tipo=>'ProcessDescriptor');

	foreach my $l (@locks){

		my ($major, $minor, $inodo) = split(/\:/, $l->[5]);
		
		my $ruta;

		foreach(@descriptores){

			if($_->{inodo} eq $inodo){
	
				$ruta = $_->{ruta};

				last;
			}

		}

		$_[0]->{bloqueos}->{$ruta} = {

			familia=>$l->[1],
			tipo=>$l->[2]

		};

	}
}

	sub __flocks{

		$_[0]->__leerFormatoColumnas('/proc/locks')

	}



1;
