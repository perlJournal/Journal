#!/usr/bin/perl -w

use strict;
use warnings;
use vars qw(%in);
use Data::Dumper;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);
use CGI::Cookie;

$|=1;
ReadParse();


require 'application/bootstrap.pl';
