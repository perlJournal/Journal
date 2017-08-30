package core::View;

sub new
{
my $class = ref($_[0])||$_[0];
    return bless {}, $class;
}

1;
