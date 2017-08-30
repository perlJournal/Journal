package core::Route;

use strict;
use warnings;

sub new 
{
	my $class = ref($_[0])||$_[0];
	return bless {}, $class;
}

sub hello
{
	my $self = @_[0];
	print 'abc';
}

sub hello1
{
	my $self = @_[0];
	$self->hello();
}

1;