package controllers::ControllerUserArticles;

use strict;
use warnings;

use vars qw(@ISA);
use core::Controller;
use models::Articles;
use views::ViewMain;
use Data::Dumper;

@ISA = qw(core::Controller);

my $modelObj = model::Articles->new();


sub actionIndex
{
	my $login = 'veritas';
	my $userArticles = $modelObj->getA
	print 'UserArticlesController';
}

1;
