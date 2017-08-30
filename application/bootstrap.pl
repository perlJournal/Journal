#!/usr/bin/perl -w

use strict;
use warnings;
use lib('application');
use core::Route;

my $var = core::Route->new();
$var->start();



1;
