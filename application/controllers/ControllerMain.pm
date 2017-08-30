package controllers::ControllerMain;


sub new 
{
	my $class = ref($_[0])||$_[0];
	return bless {}, $class;
}

sub actionIndex
{

}

1;
