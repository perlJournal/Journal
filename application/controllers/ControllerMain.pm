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
my $view = views::ViewMain->new();

sub actionIndex
{
	my $auth = $userObj->checkUser();

	my @allArticles = @{$articleObj->getArticleAll()};
	my @sorted = sort {$b->{'id_article'} <=> $a->{'id_article'}} @allArticles;
	my $list = \@sorted;

	my $template = $view->getTemplate('mainTemplate');
	my $page = $view->generateTemplate($template, $list, $auth);
	$view->viewTemplate($page);
}

sub actionLogout
{
	my $headers = $userObj->unsetCookie('id','hash') ;
	$view->redirect('Main',$headers);
}
