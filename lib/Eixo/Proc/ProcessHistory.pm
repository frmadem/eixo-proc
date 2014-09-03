package Eixo::Proc::ProcessHistory;

use strict;
use parent qw(Eixo::Proc::Info);

sub tiene{
	pid =>undef,
	history =>[],
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

		push @{$self->{history}}, $pid;

		return if($pid == 1 || !$pid);

		$self->__cargarhistoria(
	
			$raiz->search(type=>'Process', pid=>$pid)->attr('ppid'),

			$raiz

		);

	}

	

1;
