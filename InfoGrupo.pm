package dsys::InfoGrupo;

use strict;
use parent qw(dsys::Info);

sub limite{
	my ($self, $limite) = @_;

	if(scalar(@{$self->{__contiene}}) <= $limite){

		return wantarray ? @{$self->{__contiene}} : $self;
	}	

	my @cortado = @{$self->{__contiene}}[0..$limite - 1];

	wantarray ?  @cortado : dsys::InfoGrupo->new(__contiene=>\@cortado);
}

1;
