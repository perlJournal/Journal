package views::ViewMain;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
@ISA = qw(core::View);

sub showAllArticles
{
	my ($self) = shift;
    my ($login) = shift;
	my ($data) = shift;

	my $content = '';

	for my $n (values $data)
	{
		$content .= "<div class='alert alert-success' role='alert'> Author: $n->{'login'}<br /><strong>$n->{'title'}</strong><br /> $n->{'content'}<br />Date: $n->{'date_insert'}<br /><br /></div>";
	}	
	
	return $content;
}

1;
