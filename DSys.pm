package dsys::DSys;

use strict;
use parent qw(dsys::Info);

use dsys::Ps;
use Data::Dumper;

sub tiene{

	ps=>undef,
}

sub ps{
	$_[0]->{ps} if($_[0]->{ps});

	$_[0]->agregarInfo($_[0]->{ps} = dsys::Ps->new->parsear);
}

my $sys = __PACKAGE__->new;

$sys->ps;

foreach($sys->buscar(tipo=>'Proceso', usuario=>'mysql')->buscar(tipo=>'ProcesoDescriptor')){

	#print $_->{ruta} . "\n";

}

foreach($sys->buscar(tipo=>'Proceso', usuario=>'mysql')->buscar(tipo=>'ProcesoLocks')){

	print Dumper($_->{bloqueos});

}



__DATA__

foreach($sys->buscar(tipo=>'Proceso')->buscar(comando=>'apache2')){

#   if ($_->{usuario} ne "root"){
 
   print $_->{usuario} . "\n";
   print $_->{etime} . "\n";

#print Dumper $_;
#   }
}

#foreach($sys->buscar(tipo=>'Proceso')->buscar(usuario=>'root')->max('memoria_residente')->limite(30)){

#	print $_->{comando} . " ".  $_->{memoria_residente}. " "  .$_->{pico_memoria_residente}. "\n";

#}

#foreach($sys->buscar(tipo=>'Proceso', usuario=>'mysql')->buscar(tipo=>'ProcesoDescriptor')){
#
#	print $_->{ruta} . "\n";
#
#}

1;
