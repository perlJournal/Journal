package core::Model;

use strict;
use warnings;

sub new
{
    my $class = ref($_[0])||$_[0];
    return bless {}, $class;
}

1;

