package views::ViewMain;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
@ISA = qw(core::View);

sub showData
{
my ($self) = shift;
my ($data) = shift;

return $data

}

sub showAllArticles
{
	my ($self) = shift;
	my ($data) = shift;

	my $content = '';

	for my $n (values $data)
	{
		$content .= "<div class='alert alert-success' role='alert'> <strong> Author: $n->{'login'}</strong><br /> $n->{'content'}<br />Date: $n->{'date_insert'}<br /><br /></div>";
	}	
	
	return $content;
}

1;
