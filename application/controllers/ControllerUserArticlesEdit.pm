package controllers::ControllerUserArticlesEdit;

use strict;
use warnings;

use core::Controller;
use models::Articles;
use views::ViewUserArticlesEdit;
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
	
	my $id = %in->{'id_article'};
	my $article = $modelObj->getArticleById($id);	
	my $view = views::ViewUserArticlesEdit->new();
	my $template = $view->getTemplate('articlesEdit');
	my $page = $view->generateTemplate($template, $article);
	$view->viewTemplate($page);
}

sub actionEdit
{
	my ($self) = @_;
	if (%in->{'action'} eq 'delete')
	{
		my $id_article = %in->{'id_article'};
		my $article = $modelObj->deleteArticle($id_article);
	}
	elsif (%in->{'action'} eq 'edit')
	{ 
		my $title = %in->{'title'};
		my $content = %in->{'content'};
		my $id_article = %in->{'id_article'};
		my $article = $modelObj->updateArticle($title, $content, $id_article);	
	}

	my $view = views::ViewUserArticlesEdit->new();
	$view->redirect('UserArticles');
	return 1;
}

1;
