package models::Users;


#use strict;
use warnings;

use vars qw(@ISA);
use File::Basename qw(dirname);
use lib dirname(_FILE_).'/../utils/CGI/';
use core::Model;
use utils::WorkDb;
use utils::CGI::Session;
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

sub validateDataRegister
{
    my($self,%data) = @_;
    my $checker = 1;
    if(%data->{'login'} eq '')
    {
        $checker = 0;
    }
    elsif(%data->{'pass'}  eq'')
    {
        $checker = 0
    } 
    elsif(%data->{'email'}  eq'')
    {
        $checker = 0
    }   
    elsif(%data->{'passConfirm'}  eq'')
    {
        $checker = 0
    }
    return $checker;
}

sub valdiateDataLogin
{
    my($self,%data) = @_;
    my $db = utils::WorkDb->new;
    $db->connectToDb;
    my $checker = $self->getUserData(%data->{'login'});
    $checker = $checker->[0];
    if($checker->{'pass'} eq %data->{'pass'} && $checker->{'login'} eq %data->{'login'})
    {
        return 1; 
    }
    else
    {
        return 0;
    }
}

sub generateString
{
    my($self) = @_;
    my @chars = ("A".."Z", "a".."z");
    my $string;
    $string .= $chars[rand @chars] for 1..10;
    return $string;
}

sub updateHash
{
    my($self,$login, $hash) = @_;
    my $db = utils::WorkDb->new;
    $db->connectToDb;
    my $data = $db->upDelIns("UPDATE journal_user SET `hash` = '$hash' WHERE `login`= '$login' ");
}

sub checkHash
{
    my($self, $hash) = @_;
}

1;
