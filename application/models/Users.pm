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
	my $dataUser = $obj->exeSelect("Select * from journal_user where `login`='$login' ");
	return $dataUser;
}

sub insertUserData
{
    my($self,%data) = @_;
    my $db = utils::WorkDb->new;
    $db->connectToDb;
    my $checker = $self->getUserData(%data->{'login'});
    $checker = $checker->[0];
    unless($checker->{'login'} eq %data->{'login'})
    {
        $db->upDelIns("INSERT INTO journal_user(login,
                                             f_name,
                                             l_name,
                                             email,
                                             pass)
                                             VALUES (
                                             '". %data->{'login'}."','"
                                             . %data->{'name'} ."','"
                                             . %data->{'secName'}."','"
                                             . %data->{'email'} ."','"
                                             . %data->{'pass'}. "')"
                                             );
    }
    else
    {
       return 0; 
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

sub validateDataRegister
{
    my($self,%data) = @_;
    my $cheker = 1;
    if(%data->{'login'} eq '')
    {
        $cheker = 0;
    }
    elsif(%data->{'pass'}  eq'')
    {
        $cheker = 0
    } 
    elsif(%data->{'email'}  eq'')
    {
        $cheker = 0
    }   
    elsif(%data->{'passConfirm'}  eq'')
    {
        $cheker = 0
    }
    return $cheker;
}

1;
