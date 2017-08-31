package models::Users;


use strict;
use warnings;

use vars qw(@ISA);
use core::Model;
use utils::WorkDb;
@ISA = qw(core::Model);
use DBI;
use Data::Dumper;


sub actionEdit
{
	my($self,$id)= @_;
	my $obj = utils::WorkDb->new();
	$obj->connectToDb();
	my $data = $obj->upDelIns("UPDATE Data SET `key` = 'test' , `value` = 'cora' WHERE `key`= '$id' ");	

}

sub getUserData
{
	my($self,$login)= @_;
	my $obj = utils::WorkDb->new();
	$obj->connectToDb();
	my $dataUser = $obj->exeSelect("Select * from Data where `key`='$login' ");
	return $dataUser;
}

1;
