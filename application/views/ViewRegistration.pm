package views::ViewRegistration;

use strict;
use warnings;

use vars qw(@ISA);
use core::View;
@ISA = qw(core::View);

sub msgRegister
{
my ($self) = shift;
my ($login)= shift;
my ($data) = shift;

my $content .= '<div class="col-md-6 col-md-offset-3 errors ">';
$content .=     '<strong>'.$data.'</strong>';
$content .= '</div>';
return $content;
}



1;
