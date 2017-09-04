package views::ViewProfileEdit;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
@ISA = qw(core::View);


sub getEmail
{
	 my ($self) = shift;
	 my ($data) = shift;
	 my $content = '';
	 for my $n (values $data)
	 {
		$content .=  $n->{'email'};
	 }
	 return $content;
}

sub getName
{
	 my ($self) = shift;
     my ($data) = shift;
	 my $content = '';
	 for my $n (values $data)
	 {
		$content .=  $n->{'f_name'};
	 }
	 return $content;
}

sub getSerName
{
	my ($self) = shift;
	my ($data) = shift;
	my $content = '';
    for my $n (values $data)
	{
		$content .=  $n->{'l_name'};
	}
    return $content;

}


1;
