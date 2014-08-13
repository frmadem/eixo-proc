package dsys::DSys;

use strict;
use parent qw(dsys::Info);

use dsys::Ps;

sub tiene{

	ps=>undef,
}

sub ps{
	$_[0]->{ps} if($_[0]->{ps});

	$_[0]->agregarInfo($_[0]->{ps} = dsys::Ps->new->parsear);
}

my $sys = __PACKAGE__->new;

$sys->ps;

#foreach($sys->buscar(tipo=>'Proceso')->buscar(usuario=>'root')->max('memoria_residente')->limite(30)){
#
#	print $_->{comando} . " ".  $_->{memoria_residente}. " "  .$_->{pico_memoria_residente}. "\n";
#
#}

foreach($sys->buscar(tipo=>'Proceso', usuario=>'mysql')->buscar(tipo=>'ProcesoDescriptor')){

	print $_->{ruta} . "\n";

}

1;
