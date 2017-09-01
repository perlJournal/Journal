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
	my $id = %in->{'id_article'};
	my $Article = $modelObj->getArticleById($id);	
	my $view = views::ViewUserArticlesEdit->new();
	my $template = $view->getTemplate('articlesEdit');
	my $page = $view->generateTemplate($template, $Article);
	$view->viewTemplate($page);
}

sub actionEdit
{
	print "ActionEdit";
}

1;
