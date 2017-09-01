package views::ViewUserArticles;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
@ISA = qw(core::View);

my $wayEditArticle = 'UserArticlesEdit';

sub showUserArticles
{
	my ($self) = shift;
	my ($data) = shift;

	my $content = '';

	for my $n (values $data)
	{
		$content .= "<div class='alert alert-success' role='alert'> <strong> Author: $n->{'login'}</strong><br /> $n->{'content'}<br />Date: $n->{'date_insert'}<br /><a href='$wayEditArticle\?id_article=' class='btn btn-primary btn-lg active' role='button' aria-pressed='true'>Edit</a><br /></div>";
	}	
	
	return $content;
}


1;
