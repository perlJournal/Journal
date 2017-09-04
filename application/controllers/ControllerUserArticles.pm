package controllers::ControllerUserArticles;

use strict;
use warnings;

use vars qw(@ISA);
use core::Controller;
use models::Articles;
use views::ViewUserArticles;

use Data::Dumper;

@ISA = qw(core::Controller);

my $modelObj = models::Articles->new();

sub actionIndex
{
	my $login = 'veritas';
	my $userArticles = $modelObj->getArticleByUser($login);

	#my %articles
	#my $new sort {$articles{$a}->{date_insert} cmp $articles{$b}->{date_insert}} keys %articles;
	#print Dumper $userArticles->[0];
	
	print "@$userArticles\n";
	
	my $view = views::ViewUserArticles->new();
	my $template = $view->getTemplate('articlesUser');
	my $page = $view->generateTemplate($template, $userArticles);
	$view->viewTemplate($page);
}

1;
