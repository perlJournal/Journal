package views::ViewUserArticlesAdd;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
use Data::Dumper;
@ISA = qw(core::View);

sub addArticle 
{
	my ($self) = shift;
	my ($data) = shift;

	my $content = "<input class='form-control' placeholder='Title' type='text' name='title'>
				<textarea placeholder='Article'  class='form-control' name='content' rows='8'></textarea>
				<button class='btn btn-success login-btn' type='submit'>Add</button>";

	return $content;
}

1;
