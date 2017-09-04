package core::View;

use strict;
use warnings;

sub new
{
    my $class = ref($_[0])||$_[0];
    return bless {}, $class;
}

sub getTemplate
{
my ($self) = shift;
my ($file) = shift;
my  @data = ();
$file = 'application/templates/' . $file . '.html';

open(my $fh, "< $file")or die "Could not open file '$file' $!"; 

while(<$fh>)
{
    push @data, $_;
}

close $fh;
unless(wantarray)
{
    return join ' ', @data; 
}
return  @data;
}

sub generateTemplate
{
 my($self) = shift;
 my($text) = shift;
 my($data) = shift;
$text =~ s/\%FUNC_(\w+)\%/$self->$1($data)/gse;
return $text;
}

sub viewTemplate
{
    my($self) = shift;
    my($temp) = shift;
    my($headers) = shift;
    $headers .= "Content-type: text/html; charset=utf-8\n\n"; 
    print $headers .  $temp;
}

sub cssInclude
{
    my ($self) = shift;
    my $rootPath = $self->getRoot;
       my $pathBootstrap = $rootPath . 'assets/css/bootstrap.css';
    my $pathCustom = $rootPath . 'assets/css/style.css';
    my $css = '<link rel="stylesheet" href="'. $pathBootstrap .'">';
    $css .= '<link rel="stylesheet" href="'. $pathCustom .'">';
    return $css;
}

sub jsInclude
{
    my ($self) = shift;
    my $rootPath = $self->getRoot;
    my $pathBootstrap = $rootPath . 'assets/js/bootstrap.min.js';
    my $pathCustom = $rootPath . 'assets/js/custom.js';
my    $js = '<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>';
    $js .= '<script src="'. $pathBootstrap .'"></script>';
    $js .= '<script src="'. $pathCustom .'"></script>';
    return $js;

}

sub getRoot
{
   my $path = %ENV->{'REQUEST_URI'};
   my @pathSplit = split('/',$path);
   my $rootPath = join('/',@pathSplit[0],@pathSplit[1],@pathSplit[2],@pathSplit[3],'');

return $rootPath;
}

sub redirect
{
	my ($self, $way,$headers) = @_;
	my $root = $self->getRoot();
	$root .= $way;
	print $headers . "<META HTTP-EQUIV=refresh CONTENT=\"1;URL=$root\">\n";
}

sub getHeader
{
my $content .=   '<nav class="navbar navbar-default">';
my $content .=          '<div class="container-fluid">';
my $content .=            '<!-- Brand and toggle get grouped for better mobile display -->';
my $content .=            '<div class="navbar-header">';
my $content .=              '<a class="navbar-brand" href="#">GeekJournal</a>';
my $content .=            '</div>';

my $content .=            '<!-- Collect the nav links, forms, and other content for toggling -->';
my $content .=            '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">';
my $content .=              '<ul class="nav navbar-nav navbar-right">';
my $content .=                '<li><a href="#">Log in</a></li>';
my $content .=                '<li><a href="#">Sign up</a></li>';
my $content .=              '</ul>';
my $content .=            '</div><!-- /.navbar-collapse -->';
my $content .=          '</div><!-- /.container-fluid -->';
my $content .=        '</nav>';

return $content;

}


1;
