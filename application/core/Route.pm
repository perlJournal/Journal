package core::Route;

use strict;
use warnings;
use Data::Dumper;
use vars qw( %in);
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);

use vars qw(%in);

$|=1;
ReadParse();

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
        my @query = $self->queryGet(@route[4]);
        if(@query[0])
        {
            $controllerName = @query[0];
        }
        $self->dataGet(@query[1]); 
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
    my $controllerName = 'Controller404';
    my $controllerCreate = 'controllers::' . $controllerName;
    my $controllerFile = $controllerName . '.pm';
    my $controllerPath = 'application/controllers/' . $controllerFile;
    require $controllerPath;
    return $controllerCreate;
}

sub queryGet
{
my($self,$string) = @_;
my @data =  split(/\?/,$string);
return @data; 
}

sub dataGet
{
my($self,$string) = @_;
my @getString = split(/=/, $string);
return %in->{@getString[0]} = @getString[1];
}




1;
