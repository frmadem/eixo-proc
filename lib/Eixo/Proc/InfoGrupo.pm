package Eixo::Proc::InfoGrupo;

use strict;
use parent qw(Eixo::Proc::Info);

sub limite{
	my ($self, $limite) = @_;

	if(scalar(@{$self->{__contiene}}) <= $limite){

		return wantarray ? @{$self->{__contiene}} : $self;
	}	

	my @cortado = @{$self->{__contiene}}[0..$limite - 1];

	wantarray ?  @cortado : Eixo::Proc::InfoGrupo->new(__contiene=>\@cortado);
}

sub AUTOLOAD{
	my ($self, $valor) = @_;

	my ($metodo) = our $AUTOLOAD =~ /\:\:(\w+)$/;

	return $self->{__contiene}->[0]->$metodo($valor) if(scalar(@{$self->{__contiene}} > 0));
}

1;
