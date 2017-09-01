package controllers::ControllerMain;

use strict;
use warnings;

use vars qw(@ISA);
use core::Controller;
use models::Articles;
use views::ViewMain;
use Data::Dumper;

@ISA = qw(core::Controller);

my $modelObj = models::Articles->new();

sub actionIndex
{
	my $allArticles =  $modelObj->getArticleAll();
	my $view = views::ViewMain->new();
	my $template = $view->getTemplate('mainTemplate');
	my $page = $view->generateTemplate($template, $allArticles);
	$view->viewTemplate($page);
}


