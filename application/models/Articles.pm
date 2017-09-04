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

sub getArticleAll
{
	my ($self) = @_;
	$dbObj->connectToDb();
	$dbObj->exeSelect("Select * from journal_articles");	
	my $data = $dbObj->getData();
	return $data;
}

sub getArticleByUser
{
	my ($self, $login) = @_;
	my $dbObj = utils::WorkDb->new();
	$dbObj->connectToDb();
	$dbObj->exeSelect("Select * from journal_articles where login = '$login'");	
	my $data = $dbObj->getData();
	return $data;
}

sub getArticleById
{
	my ($self, $id_article) = @_;
	my $dbObj = utils::WorkDb->new();
	$dbObj->connectToDb();
	$dbObj->exeSelect("Select * from journal_articles where id_article = '$id_article'");	
	my $data = $dbObj->getData();
	return $data;
}

sub updateArticle
{
	my ($self, $title, $content, $id_article) = @_;
	my $dbObj = utils::WorkDb->new();
	$dbObj->connectToDb();
	$dbObj->upDelIns("Update journal_articles set title = '$title', content = '$content' where id_article = $id_article");	
	return 1;
}
