package Eixo::Proc::DSys;

use strict;
use parent qw(Eixo::Proc::Info);

use Eixo::Proc::Ps;

sub tiene{

	ps=>undef,
}

sub ps{
	$_[0]->{ps} if($_[0]->{ps});

	$_[0]->agregarInfo($_[0]->{ps} = Eixo::Proc::Ps->new->parsear);
}

1;
#
#my $sys = __PACKAGE__->new;
#
#$sys->ps;
#
#my $h = $sys->buscar(tipo=>'Proceso', pid=>76)->historia;
#
#print Dumper($h);

#foreach($sys->buscar(tipo=>'Proceso', usuario=>'mysql')->buscar(tipo=>'ProcesoDescriptor')){
#
#	print $_->{ruta} . "\n";
#
#}
#
#foreach($sys->buscar(tipo=>'Proceso', usuario=>'mysql')->buscar(tipo=>'ProcesoLocks')){
#
#	print Dumper($_->{bloqueos});
#
#}



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
