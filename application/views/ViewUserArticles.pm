package views::ViewUserArticles;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
use Data::Dumper;
@ISA = qw(core::View);

my $wayEditArticle = 'UserArticlesEdit';

sub showUserArticles
{
	my ($self) = shift;
	my ($data) = shift;

	my $content = '';

	for my $n (values $data)
	{
		$content .= "<div class='alert alert-success' role='alert'> <strong> Author: $n->{'login'}</strong><br /> $n->{'content'}<br />Date: $n->{'date_insert'}<br /><a href='$wayEditArticle\?id_article=$n->{'id_article'}' role='button' aria-pressed='true'>Edit</a><br /></div>";
	}	
	
	return $content;
}

sub getLogin 
{
	return 'veritas';
}
1;
