package controllers::ControllerAuthorization;

use strict;
use warnings;

use vars qw(@ISA %in);
use core::Controller;
use models::Users;
use views::ViewAuthorization;
use Data::Dumper;

use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);

@ISA = qw(core::Controller);

$|=1;
ReadParse();



sub actionIndex
{
    my ($self) = shift;
    $self->viewPage('auth');

}

sub actionLogin
{
    my($self) = shift;
    my %dataUser = (
        'login' => %in->{'login'},
        'pass'  => %in->{'pass'},
    );
    
    my $view = views::ViewAuthorization->new;
    my $model = models::Users->new;
    if($model->valdiateDataLogin(%dataUser) && length %dataUser->{'login'} > 3 && length %dataUser->{'pass'})
    {
        
        my $view = views::ViewAuthorization->new;
        my $hash = $model->generateString();
        my $login = %dataUser->{'login'};
        $model->updateHash($login,$hash);
        my $data = $model->getUserData(%dataUser->{'login'});
        $data = $data->[0];
        my $id = $data->{'id_user'};
        my $cookie = $model->setCookie($id,$hash);
        $view->redirect('Main',$cookie);
        
    }
    else
    {
        $self->viewPage('auth','Invalid password or login'); 
    }

    
}

sub viewPage
{
    my ($self) = shift;
    my ($templateFile) = shift;
    my ($data) = shift;
    my ($headers) = shift;
    my $view = views::ViewAuthorization->new;
    my $template = $view->getTemplate($templateFile);
    my $page = $view->generateTemplate($template,$data);
    $view->viewTemplate($page);
}

1;
