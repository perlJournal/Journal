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
$text =~ s/\%FUNC_(\w+)\%$/$self->$1()/gse;
return $text;
}

sub viewTemplate
{
    my($self) = shift;
    my($temp) = shift;
    print $temp;
}


1;
