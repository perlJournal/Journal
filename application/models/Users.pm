package models::Users;


use strict;
use warnings;

use vars qw(@ISA);
use core::Model;
use CGI qw/:standard/;
use CGI::Cookie;
use utils::WorkDb;
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

sub getUserDataById
{
    my($self,$id)= @_;
    my $obj = utils::WorkDb->new();
    $obj->connectToDb();
    my $dataUser = $obj->exeSelect("Select * from journal_user where `id_user`='$id' ");
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


sub setCookie
{
    my($self, $id, $hash) = @_;
    my $cookie1 = CGI::Cookie->new(-name=>'id',-value=>$id);
    my $cookie2 = CGI::Cookie->new(-name=>'hash',-value=>$hash);
    return header(-cookie=>[$cookie1,$cookie2]);
}

sub getCookieData
{
my($self) = @_;
my %cookies = CGI::Cookie->fetch;
my $id = %cookies->{'id'}->{'value'}->[0];
my $hash = %cookies->{'hash'}->{'value'}->[0];
my %data = (
    'id' => $id,
    'hash' => $hash,
	);

return %data;
}

sub unsetCookie
{
 my($self, $id, $hash) = @_;

 my $cookie1 = CGI::Cookie->new(
        -name    =>  $id,
        -expires =>  '-1d',
        -value => ''
    );
my $cookie2 = CGI::Cookie->new(
        -name    =>  $hash,
        -expires =>  '-1d',
        -value => ''
    );
return header(-cookie=>[$cookie1,$cookie2]);
}

sub checkUser
{
my($self) = @_;
my %cookies = CGI::Cookie->fetch;
my $id = %cookies->{'id'}->{'value'}->[0];
my $hash = %cookies->{'hash'}->{'value'}->[0];
my $dataDB = $self->getUserDataById($id);
$dataDB = $dataDB->[0];
my $hashDb = $dataDB->{'hash'};
    if(defined $id)
    { 
        if($hashDb eq $hash)
        {
        return 1;
        }
        else
        {
        return 0;
        }
    }
    else
    {
        return 0;
    }

}

1;
