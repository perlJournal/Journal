package models::Articles;


use strict;
use warnings;

use core::Model;
use utils::WorkDb;
use Data::Dumper;

use vars qw(@ISA);
@ISA = qw(core::Model);

my $dbObj = utils::WorkDb->new();

sub new
{
	my $class = ref($_[0])||$_[0];
	return bless{}, $class;
} 

sub msg
{
	return 'Articles';
}

sub getArticleAll
{
	my ($self) = @_;
	$dbObj->connectToDb();
	$dbObj->exeSelect("Select * from journal_articles");	
	my $data = $dbObj->getData();
	return $data;
}

sub getArticleUser
{
	my ($self, $query) = @_;
	my $dbObj = utils::WorkDb->new();
	$dbObj->connectToDb();
	$dbObj->exeSelect("Select * from journal_articles where login = '$query'");	
	my $data = $dbObj->getData();
	return $data;
}
