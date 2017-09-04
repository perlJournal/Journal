package controllers::ControllerRegistration;

use strict;
use warnings;

use views::ViewRegistration;
use models::Users;
use vars qw(@ISA %in);
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);

use core::Controller;
use Data::Dumper;
@ISA = qw(core::Controller);

$|=1;
ReadParse();



sub actionIndex
{
my($self) = shift;
$self->viewPage();
}

sub actionRegister
{
my($self) = shift;
my $model = models::Users->new;
    my %dataUser = (
        'login' => %in->{'login'},
        'email' => %in->{'email'},
        'pass' => %in->{'pass'},
        'passConfirm' => %in->{'passConfirm'},
        'name' => %in->{'name'},
        'secName' => %in->{'secName'},
    ) ;
if($model->validateDataRegister(%dataUser))
{
    if(%dataUser->{'pass'} eq %dataUser->{'passConfirm'})
    {
        if($model->insertUserData(%dataUser))
        {
            $self->viewPage('registration succes');
        }
        else
        {
            $self->viewPage('This user exists already')
        }
    }
    else
    {
        $self->viewPage('confirmation must be same with pass');
    }

}
else
{

        $self->viewPage('required: Login, Email, Pass and pass confirm')
}
}

sub viewPage
{
my ($self) = shift;
my ($data) = shift;
my $view = views::ViewRegistration->new();
my $template = $view->getTemplate('regist');
my $page = $view->generateTemplate($template,$data);
$view->viewTemplate($page);
}

1;
