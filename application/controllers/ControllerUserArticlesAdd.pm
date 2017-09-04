package controllers::ControllerUserArticlesAdd;

use strict;
use warnings;

use core::Controller;
use models::Articles;
use views::ViewUserArticlesAdd;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use Data::Dumper;

use vars qw(@ISA);
use vars qw(%in);
@ISA = qw(core::Controller);

my $modelObj = models::Articles->new();

$|=1;
ReadParse();

sub actionIndex
{
	my ($self) = @_;
	my $view = views::ViewUserArticlesAdd->new();
	my $template = $view->getTemplate('articlesAdd');
	my $page = $view->generateTemplate($template);
	$view->viewTemplate($page);
}

sub actionEdit
{
	my ($self) = @_;

	my $login = 'veritas';
	my $title = %in->{'title'};
	my $content = %in->{'content'};

	my $article = $modelObj->insertArticle($login, $title, $content);	
	my $view = views::ViewUserArticlesAdd->new();
	$view->redirect('UserArticles');
	return 1;
}

1;
