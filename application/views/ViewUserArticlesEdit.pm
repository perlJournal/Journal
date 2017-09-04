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
	my $id_article = $data->[0]->{'id_article'};

	my $content = "<input class='form-control' placeholder='Title' type='text' name='title' value='$title'>
				<textarea placeholder='Article'  class='form-control' name='content' rows='8'>$text</textarea>
				<input type='hidden' name='id_article' value='$id_article'>
				<button class='btn btn-success login-btn' type='submit' name='action' value='edit'>Edit</button>
				<button class='btn btn-success login-btn' type='submit' name='action' value='delete'>Delete</button>";

	return $content;
}

1;
