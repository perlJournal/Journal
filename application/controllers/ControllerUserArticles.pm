package controllers::ControllerUserArticles;

use strict;
use warnings;

use vars qw(@ISA);
use core::Controller;
use models::Articles;
use models::Users;
use views::ViewUserArticles;

use Data::Dumper;

@ISA = qw(core::Controller);

my $modelObj = models::Articles->new();
my $userObj = models::Users->new();
my $view = views::ViewUserArticles->new();

sub actionIndex
{
	my $auth = $userObj->checkUser();
	my $login = 'veritas';

	my @articles = @{$modelObj->getArticleByUser($login)};
	my @sorted = sort {$b->{'id_article'} <=> $a->{'id_article'}} @articles; 
	my $list = \@sorted; 

	my $template = $view->getTemplate('articlesUser');
	my $page = $view->generateTemplate($template, $list, $auth);
	$view->viewTemplate($page);
}

1;
