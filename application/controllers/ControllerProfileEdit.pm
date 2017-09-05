package controllers::ControllerProfileEdit;

use strict;
use warnings;

use vars qw(@ISA);
use vars qw(%in);
use core::Controller;
use models::Users;
use views::ViewProfileEdit;
use Data::Dumper;
use CGI;
@ISA = qw(core::Controller);

my $model = models::Users->new();

my $var = new CGI->new();

sub actionIndex
{
    my $view = views::ViewProfileEdit->new();
    
    if($model->checkUser)
    {
	 my $auth = $model->checkUser(); 
     my %cookieData = $model->getCookieData;
     my $getDataUserById = $model->getUserDataById(%cookieData->{'id'});
	 my $data = $view->getTemplate('profile');
	 my $obj =  $view->generateTemplate($data, $auth, $getDataUserById );
	 $view->viewTemplate($obj);
    }
    else
    {
        $view->redirect('Authorization',"Content-type: text/html; charset=utf-8\n\n");
    }

}

sub actionEdit
{
	 my $auth = $model->checkUser(); 
	 my $email = $var->param('email');
	my $name = $var->param('name');
	my $serName = $var->param('serName');
    my %cookieData = $model->getCookieData;
    my $getDataUserById = $model->getUserDataById(%cookieData->{'id'});
     $getDataUserById = $getDataUserById->[0];
    my $login = $getDataUserById->{'login'}; 
     $model->emptyString($email,$name,$serName);
     my $editUser =  $model->actionEdit($login,$email,$name,$serName);
	 my $getDataUserById = $model->getUserData($login);
	 my $view = views::ViewProfileEdit->new();
	 my $data = $view->getTemplate('profile');
	 my $obj =  $view->generateTemplate($data, $auth, $getDataUserById );
	 $view->viewTemplate($obj);


}

1;
