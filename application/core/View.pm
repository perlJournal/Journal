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
    print $temp;
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
	my ($self, $way) = @_;
	my $root = $self->getRoot();
	$root .= $way;
	print "<META HTTP-EQUIV=refresh CONTENT=\"1;URL=$root\">\n";
}

1;
