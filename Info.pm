package dsys::Info;

use strict;
use dsys::InfoGrupo;

sub EROSION  { 5 }

sub new{
	my ($clase, %args) = @_;

	if($clase->can('tiene')){

		my %claves = $clase->tiene;

		foreach(keys(%claves)){
			$args{$_} = $claves{$_} unless(exists $args{$_});
		}

	}

	$args{'__contiene'} = $args{__contiene} || [];
	$args{'__cargada'} = undef;

	return bless(\%args, $clase);
}

sub actualizar{
	
	if(my $t = $_[0]->{__cargada}){

		if(time > $t + $_[0]->EROSION){

			$_[0]->__actualizar;

		}
	}
	
	
	
}

sub agregarInfo{
	my ($self, $info) = @_;

	#
	# ARREGLAME!!! 
	#
	# no controlamos nada

	if($self == $info){
		die(ref($self) . '::agregarInfo: no se puede agregar una info a si misma');
	}

	push @{$_[0]->{__contiene}}, $info;

}

sub buscar{
	my ($self, %args) = @_;

	my @confrontaciones;

	if(my $tipo = $args{tipo}){

		push @confrontaciones, sub {

			$_[0]->isa('dsys::' . $tipo)

		};

		delete $args{tipo};
	}	

	foreach my $atributo (keys(%args)){

		my $valor = $args{$atributo};

		push @confrontaciones, sub {

			$_[0]->{$atributo} eq $valor;
		}

	}

	push @confrontaciones, $_ foreach(@{ $args{ad_hoc} || [] });


	my @ret = $self->mGrep(sub {

		foreach(@confrontaciones){

			return undef unless($_->($_[0]));

		}

		return 1;
	});

	wantarray ? @ret : dsys::InfoGrupo->new(__contiene=>\@ret);

}

sub max{
	my ($self, $criterio) = @_;

	my @ret = sort {

		$a->{$criterio} < $b->{$criterio}

	} @{$self->{__contiene}};

	wantarray ? @ret : dsys::InfoGrupo->new(__contiene=>\@ret);

}

sub min{
	my ($self, $criterio) = @_;

	my @ret = sort {

		$a->{$criterio} > $b->{$criterio}

	} @{$self->{__contiene}};

	wantarray ? @ret : dsys::InfoGrupo->new(__contiene=>\@ret);
}

sub mGrep {
	my ($self, $f, $no_incluir) = @_;

	my @ret = grep { $f->($_) } @{$self->{__contiene}};

	push @ret, $self if(!$no_incluir && $f->($self));

	@ret, map { $_->mGrep($f, 1) } @{$self->{__contiene}};

}

sub parsear{

	$_[0]->{__cargada} = time;

	$_[0]->__parsear;

	$_[0];
}
	sub __parsear{

		die(ref($_[0]). '::ABSTRACTO!!!');

	}

sub aString{

	use Data::Dumper;

	Dumper($_[0]);
}

sub __leerFormatoColumnas{

	map {

		[
			split(/\s+/, $_)
		]
		

	} grep {

		$_ !~ /^\s*$/


	} split(/\n/, $_[0]->__leer(@_[1..$#_]));

}

sub __leerFormatoCV{

	my  $reg = qr/^\s*([^:]+)\s*\:\s*(.+)$/;

	my $datos = $_[0]->__leer($_[1]);

	my %datos = map {
		
		$_ =~ /$reg/;

		$1 => $2
	

	} grep {

		$_ =~ /$reg/

	} split(/\n/, $datos);

	\%datos;
}

sub __leer{
	my ($self, $ruta) = @_;

	my $fichero;

	open ($fichero, $ruta);

	my $datos = join('', <$fichero>);

	close $fichero;

	$datos;
}


1;

