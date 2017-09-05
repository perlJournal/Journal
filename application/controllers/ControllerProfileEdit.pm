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

     my %cookieData = $model->getCookieData;
     my $getDataUserById = $model->getUserDataById(%cookieData->{'id'});
	 my $data = $view->getTemplate('profile');
	 my $obj =  $view->generateTemplate($data,$getDataUserById );
	 $view->viewTemplate($obj);
    }
    else
    {
        $view->redirect('Authorization',"Content-type: text/html; charset=utf-8\n\n");
    }

}

sub actionEdit
{
    my $email = $var->param('email');
	my $name = $var->param('name');
	my $serName = $var->param('serName');
    $model->emptyString($email,$name,$serName);
     my $editUser =  $model->actionEdit('Alex',$email,$name,$serName);
	 my $getDataUserById = $model->getUserData('Alex');
	 my $view = views::ViewProfileEdit->new();
	 my $data = $view->getTemplate('profile');
	 my $obj =  $view->generateTemplate($data,$getDataUserById );
	 $view->viewTemplate($obj);


}

1;
