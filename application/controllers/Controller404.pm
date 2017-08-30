package controllers::Controller404;


sub new 
{
	my $class = ref($_[0])||$_[0];
	return bless {}, $class;
}

sub actionIndex
{
print 404;
}

1;
