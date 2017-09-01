package views::ViewUserArticlesEdit;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
use Data::Dumper;
@ISA = qw(core::View);

sub editArticle 
{
	my ($self) = shift;
	my ($data) = shift;
	
	my $title =  $data->[0]->{'title'};
	my $text  =  $data->[0]->{'content'};

	my $content = "<input class='form-control' placeholder='Title' type='text' name='title' value='$title'>
				<textarea placeholder='Article'  class='form-control' name='article' rows='8'>$text</textarea>
				<button class='btn btn-success login-btn' type='submit'>Post</button>";

	return $content;
}

1;
