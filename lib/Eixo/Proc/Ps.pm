#!/usr/bin/env perl
package dsys::Ps;

use strict;
use parent qw(dsys::Info);

use dsys::Proceso;

sub EROSION { 1 } 

sub tiene{


}




sub __actualizar{

	$_[0]->{__contiene} = [];

	$_[0]->parsear;
}

sub __parsear{

	opendir D, '/proc';

	my @lista_procesos = grep { $_ =~ /^\d+$/} readdir(D);

	$_[0]->agregarInfo(
	
		dsys::Proceso->new(pid=>$_)->parsear

	) foreach(@lista_procesos);

	closedir D;

}

1;
