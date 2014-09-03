#!/usr/bin/env perl
package Eixo::Proc::Ps;

use strict;
use parent qw(Eixo::Proc::Info);

use Eixo::Proc::Process;

sub EROSION { 1 } 

sub tiene{


}


sub __actualizar{

	$_[0]->{__contiene} = [];

	$_[0]->parsear;
}

sub __parsear{

	opendir my $d, '/proc' || die("Error opening /proc: $!");

	my @lista_procesos = grep { $_ =~ /^\d+$/} readdir($d);

	$_[0]->agregarInfo(
	
		Eixo::Proc::Process->new(pid=>$_)->parsear

	) foreach(@lista_procesos);

	closedir $d;

}

1;
