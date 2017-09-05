package controllers::ControllerUserArticlesAdd;

use strict;
use warnings;

use core::Controller;
use models::Articles;
use models::Users;
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
    my $view = views::ViewUserArticlesAdd->new();
    my $model = models::Users->new();

    if(my $auth = $model->checkUser)
    {
	    my $template = $view->getTemplate('articlesAdd');
	    my $page = $view->generateTemplate($template, $auth);
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
    my $model = models::Users->new();
    my %getCookie = $model->getCookieData();
    my $id = %getCookie->{'id'};
    my $userData = $model->getUserDataById($id);
    my $userData = $userData->[0];
    my $login = $userData->{'login'};

	my $title = %in->{'title'};
	my $content = %in->{'content'};

	my $article = $modelObj->insertArticle($login, $title, $content);	
	my $view = views::ViewUserArticlesAdd->new();
	$view->redirect('UserArticles');
	return 1;
}

1;
