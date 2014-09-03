use t::test_base;

use_ok(Eixo::Proc);

#foreach my $p (Eixo::Proc->search(type => "Process",pid => $$)){
#	print "usuario:".$p->{user}," ruta:".$p->{path}," exe:".$p->{exe}."\n";
#	$p->{__padre} = undef;
#	print Dumper($p);
#	print Dumper($p->history);
#}


my @TEST_ATRIBUTES = qw(pid state user effective_user exe);

my ($p) = Eixo::Proc->search(type => "Process", pid => $$);
ok(

	$p && ref($p) eq 'Eixo::Proc::Process',

	"Test process found and Process object created"
);

foreach my $a (@TEST_ATRIBUTES){
	ok(
		defined($p->{$a}),
		"Process Attribute '$a' catched"
	);

}

$p->{__padre} = undef;
print Dumper($p);

done_testing();
