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
    my($login) = shift;
    my($data) = shift;
    $text =~ s/\%FUNC_(\w+)\%/$self->$1($login,$data)/gse;
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
    my $redirect = "<META HTTP-EQUIV=refresh CONTENT=\"1;URL=$root\">\n";
    print   $headers . $redirect ;
}

sub getHeader
{
    my ($self, $login, $data) = @_;
	my $root = $self->getRoot();

	if($login == 1)
	{
	    my $content .=   '<nav class="navbar navbar-default">';
	    $content .=          '<div class="container-fluid">';
	    $content .=            '<!-- Brand and toggle get grouped for better mobile display -->';
		$content .=            '<div class="navbar-header">';
		$content .=              '<a class="navbar-brand" href="'.$root .'">GeekJournal</a>';
		$content .=            '</div>';

		$content .=            '<!-- Collect the nav links, forms, and other content for toggling -->';
		$content .=            '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">';
		$content .=              '<ul class="nav navbar-nav navbar-right">';
		$content .=                '<li><a href="'.$root.'Main/Logout">Log out</a></li>';
		$content .=              '</ul>';
		$content .=            '</div><!-- /.navbar-collapse -->';
		$content .=          '</div><!-- /.container-fluid -->';
		$content .=        '</nav>';
 
		return $content;
	}
	else
	{
	    my $content .=   '<nav class="navbar navbar-default">';
	    $content .=          '<div class="container-fluid">';
	    $content .=            '<!-- Brand and toggle get grouped for better mobile display -->';
		$content .=            '<div class="navbar-header">';
		$content .=              '<a class="navbar-brand" href="'.$root .'">GeekJournal</a>';
		$content .=            '</div>';

		$content .=            '<!-- Collect the nav links, forms, and other content for toggling -->';
		$content .=            '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">';
		$content .=              '<ul class="nav navbar-nav navbar-right">';
		$content .=                '<li><a href="'.$root.'Authorization">Log in</a></li>';
		$content .=                '<li><a href="'.$root.'Registration">Sign up</a></li>';
		$content .=              '</ul>';
		$content .=            '</div><!-- /.navbar-collapse -->';
		$content .=          '</div><!-- /.container-fluid -->';
		$content .=        '</nav>';
 
		return $content;
	}
 
}

sub getSidebar
{
    my ($self, $login , $data) = @_;
    my $root = $self->getRoot();
	
	if ($login == 1)
	{
		my $content .= '<div class="col-md-3 navbar-default" style="text-align: center;">';
		$content .= '<h1>Profile links</h1>';
		$content .= '<a href="'.$root .'UserArticles">My articles</a><br />';
		$content .= '<a href="'.$root.'UserArticlesAdd">Add post</a><br />';
		$content .= '<a href="'.$root.'ProfileEdit">Profile</a>';
		$content .= '</div>';
	
		return $content;
	}
}



1;
