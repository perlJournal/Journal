#!/usr/bin/perl -w

use strict;
use warnings;
use File::Basename qw(dirname);
use lib('application');
use lib ('application/utils');
use core::Route;

my $var = core::Route->new();
$var->start();



1;
