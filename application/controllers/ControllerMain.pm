package controllers::ControllerMain;

use strict;
use warnings;

use vars qw(@ISA);
use core::Controller;
use models::Articles;
use models::Users;
use views::ViewMain;
use Data::Dumper;

@ISA = qw(core::Controller);

my $articleObj = models::Articles->new();
my $userObj = models::Users->new();

sub actionIndex
{
	my $check = $userObj->checkUser();

	my @allArticles = @{$articleObj->getArticleAll()};
	my @sorted = sort {$b->{'id_article'} <=> $a->{'id_article'}} @allArticles;
	my $list = \@sorted;

	my $view = views::ViewMain->new();
	my $template = $view->getTemplate('mainTemplate');
	my $page = $view->generateTemplate($template, $list, $check);
	$view->viewTemplate($page);
}


