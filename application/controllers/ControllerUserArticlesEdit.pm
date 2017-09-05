package controllers::ControllerUserArticlesEdit;

use strict;
use warnings;

use core::Controller;
use models::Articles;
use models::Users;
use views::ViewUserArticlesEdit;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use Data::Dumper;

use vars qw(@ISA);
use vars qw(%in);
@ISA = qw(core::Controller);

my $articleObj = models::Articles->new();
my $userObj = models::Users->new();
my $view = views::ViewUserArticlesEdit->new();

$|=1;
ReadParse();

sub actionIndex
{
    if(my $auth = $userObj->checkUser)
    {
		my $id = %in->{'id_article'};
		my $article = $articleObj->getArticleById($id);	
		my $template = $view->getTemplate('articlesEdit');
		my $page = $view->generateTemplate($template, $auth, $article);
		$view->viewTemplate($page);
    }
    else
    {
        $view->redirect('Authorization',"Content-type: text/html; charset=utf-8\n\n");

    }

}


sub actionEdit
{
	my ($self) = @_;
	if (%in->{'action'} eq 'delete')
	{
		my $id_article = %in->{'id_article'};
		my $article = $articleObj->deleteArticle($id_article);
	}
	elsif (%in->{'action'} eq 'edit')
	{ 
		my $title = %in->{'title'};
		my $content = %in->{'content'};
		my $id_article = %in->{'id_article'};
		my $article = $articleObj->updateArticle($title, $content, $id_article);	
	}

	$view->redirect('UserArticles');
	return 1;
}

1;
