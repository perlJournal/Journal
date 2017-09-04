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
	my @articles = @{$modelObj->getArticleByUser($login)};
	my @sorted = sort {$b->{'id_article'} <=> $a->{'id_article'}} @articles; 
	my $list = \@sorted; 

	my $view = views::ViewUserArticles->new();
	my $template = $view->getTemplate('articlesUser');
	my $page = $view->generateTemplate($template, $list);
	$view->viewTemplate($page);
}

1;
