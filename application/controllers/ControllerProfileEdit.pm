package controllers::ControllerProfileEdit;

use strict;
use warnings;

use vars qw(@ISA);
use vars qw(%in);
use core::Controller;
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
	my $email = $var->param('email');
	my $name = $var->param('name');
	my $serName = $var->param('serName');
    my $getDataUserById = $model->getUserData('Alex');
    my $editUser =  $model->actionEdit('Alex',$email,$name,$serName);
	my $view = views::ViewProfileEdit->new();
	my $data = $view->getTemplate('profile'); 
    my $obj =  $view->generateTemplate($data,$getDataUserById);
	$view->viewTemplate($obj);

}

1;
