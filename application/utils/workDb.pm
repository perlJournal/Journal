 #!/usr/bin/perl

 use lib('lib');
 use DBI;
 package Utils::workDb;
 use strict;
 use Data::Dumper;
 sub new
 {
	my $self = 
		{
		'dbh'=>undef,
		'data'=>[],
		'inUpDelStatus'=>undef,
		'SelectStatus'=>undef
		};
	my $class = ref($_[0])|| $_[0];
	return bless $self, $class;
 }

 sub connectToDb
 {
	 my ($self) = @_;
	 my $dsn = 'dbi:mysql:user1';
	 my $user = 'user1';
	 my $password = 'tuser1';
	 $self->{'dbh'} = DBI->connect($dsn, $user, $password,{ RaiseError => 1, AutoCommit => 0 });
	 return !! $self->{'dbh'};

 }


sub exeSelect
{       
	my($self,$query)= @_;
	if($query eq '')
	{
		return undef;
	}

	$self->connectToDb() unless ($self->{'dbh'});
	return undef unless ($self->{'dbh'});

	
	my $hashArr = [];
	my $sth = $self->{'dbh'}->prepare($query);
	$sth->execute();

	while (my $hash = $sth->fetchrow_hashref) {
		push @{$hashArr}, $hash;
	}

	$self->{'data'}= $hashArr;
	#$self->{'dbh'}->disconnect(); #destroys upDelIns connection

	$self->{'SelectStatus'} = 1;
	return  $self->{'data'};
}

sub upDelIns
{
	my($self,$query)= @_;
	if($query eq '')
	{
		return undef;
	}

	$self->connectToDb() unless ($self->{'dbh'});
	return undef unless ($self->{'dbh'});


	my $sth = $self->{'dbh'}->do($query) or die "Invalid query";

	$self->{'dbh'}->disconnect();

	$self->{'InUpDelStatus'} = 1;
	return  1;
}

sub getData
{
	my($self) = @_;
	return  $self->{'data'};

}

1
