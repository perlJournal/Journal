package controllers::ControllerProfileEdit;

use strict;
use warnings;

use vars qw(@ISA);
use core::Controller;
@ISA = qw(core::Controller);



sub actionIndex
{
	my $model = models::Users->new();
    my $getDataUserById = $model->getUserData('test');
    my $editUser =  $model->actionEdit('test');
	my $view = views::ViewProfileEdit->new();
	my $data = $view->getTemplate('profile'); 
    my $obj =  $view->generateTemplate($data,$editUser);
	$view->viewTemplate($obj);

}

1;
