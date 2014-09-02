package Eixo::Proc::ProcessHistory;

use strict;
use parent qw(Eixo::Proc::Info);

sub tiene{
	pid=>undef,
	historia=>[],
}

sub __parsear{
	my ($self, $proceso) = @_;

	#
	# Cargamos la historia
	#
	my $raiz = $proceso->raiz;

	$_[0]->__cargarhistoria($_[0]->{pid}, $raiz);
}

	sub __cargarhistoria{
		my ($self, $pid, $raiz) = @_;

		push @{$self->{historia}}, $pid;

		return if($pid == 1 || !$pid);

		$self->__cargarhistoria(
	
			$raiz->buscar(tipo=>'Process', pid=>$pid)->attr('ppid'),

			$raiz

		);

	}

	

1;
