package controllers::Controller404;


use strict;
use warnings;

use vars qw(@ISA);
use core::Controller;
@ISA = qw(core::Controller);

sub actionIndex
{
print 404;
}

1;
