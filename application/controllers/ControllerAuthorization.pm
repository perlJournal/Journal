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
    if($model->valdiateDataLogin(%dataUser))
    {
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
    my $view = views::ViewAuthorization->new;
    my $template = $view->getTemplate($templateFile);
    my $page = $view->generateTemplate($template,$data);
    $view->viewTemplate($page);
}

1;
