package models::Users;


use strict;
use warnings;

use vars qw(@ISA);
use core::Model;
use utils::WorkDb;
use utils::SessionUtil;
@ISA = qw(core::Model);
use DBI;
use Data::Dumper;


sub actionEdit
{
	my($self,$login,$email,$name,$serName)= @_;
	my $obj = utils::WorkDb->new();
	$obj->connectToDb();
	my $data = $obj->upDelIns("UPDATE journal_user SET `email` = '$email', `f_name` = '$name', `l_name` = '$serName'  WHERE `login`= '$login' ");	

}

sub getUserData
{
	my($self,$login)= @_;
	my $obj = utils::WorkDb->new();
	$obj->connectToDb();
	my $dataUser = $obj->exeSelect("Select * from journal_user  where `login`='$login' ");
	return $dataUser;
}

sub emptyString
{
	my($self,$email,$name,$serName);

	 if ( $email =~ /^$/ && $name =~ /^$/ && $serName =~ /^$/  ) {
		              print 'Empty string';
	 } else 
	 {
		 return 1;
	 }
}

sub setSessionValues
{
	my($self) = shift;
	my($id) = shift;
	my($hash) = shift;


	my $session = utils::SessionUtil->new;
	
	$session->sessionStarter();
	$session->setSessionElement('id',$id);
	$session->setSessionElement('hash',$hash);
}

sub getSessionValues
{
	my($self) = shift;

	my $session = utils::SessionUtil->new;
	my $id = $session->getSessionElement('id');
	my $hash = $session->getSessionElement('hash');

	my %result = {
		'id' => $id,
		'hash' => $hash,
	};
	return %result;
}

sub unsetSession
{
	my ($self) = shift;
	my $session = utils::SessionUtil->new;
	$session->clearSessionElements(['id']);
	$session->clearSessionElements(['hash']);
}


1;
