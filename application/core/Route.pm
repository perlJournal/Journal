package core::Route;

use strict;
use warnings;

use Data::Dumper;
use CGI;
sub new 
{
    my $class = ref($_[0])||$_[0];
    return bless {}, $class;
}

sub start
{
    my ($self) = @_[0];
    my  $controllerName = 'Main';
    my  $actionName = 'Index';

    my @route = split /\//, %ENV->{'REQUEST_URI'};

    if(@route[4])
    {
        $controllerName = @route[4]; 
    }

    if(@route[5])
    {
        $actionName = @route[5]; 
    }

    $controllerName = 'Controller' . $controllerName;
    my $controllerCreate = 'controllers::' . $controllerName;
    $actionName = 'action' . $actionName;

    my $controllerFile =  $controllerName . '.pm'; 
    my $controllerPath = 'application/controllers/' . $controllerFile;

    if(-e $controllerPath)
    {
        print "Content-type: text/html; charset=utf-8\n\n";
        require $controllerPath;
    }
    else
    {
        $controllerCreate = $self->_errorPage404;
    }  

    my $controller = $controllerCreate->new();

    if($controller->can($actionName))
    {
        $controller->$actionName();
    }

}




sub _errorPage404
{
    print "Content-type: text/html; charset=utf-8\n\n";
    my $controllerName = 'Controller404';
    my $controllerCreate = 'controllers::' . $controllerName;
    my $controllerFile = $controllerName . '.pm';
    my $controllerPath = 'application/controllers/' . $controllerFile;
    require $controllerPath;
    return $controllerCreate;
}

1;
