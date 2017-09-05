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
my $view = views::ViewUserArticles->new();

sub actionIndex
{

	my $model = models::Users->new();
  my $view = views::ViewUserArticles->new();
  my $auth = $model->checkUser();

    if($model->checkUser)
    {
      my %getCookie = $model->getCookieData();
      my $id = %getCookie->{'id'};
      my $userData = $model->getUserDataById($id);
      my $userData = $userData->[0];
      my $login = $userData->{'login'};

      my @articles = @{$modelObj->getArticleByUser($login)};
      my @sorted = sort {$b->{'id_article'} <=> $a->{'id_article'}} @articles; 
      my $list = \@sorted; 


      my $template = $view->getTemplate('articlesUser');
      my $page = $view->generateTemplate($template, $auth, $list);
      $view->viewTemplate($page);
    }
    else
    {
        $view->redirect('Authorization',"Content-type: text/html; charset=utf-8\n\n");
    }
}

1;
