package views::ViewAuthorization;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
@ISA = qw(core::View);


sub msg
{
   my ($self) = shift;
   my ($login) = shift; 
   my ($data) = shift;
    return my $content = $data;
}


1;
