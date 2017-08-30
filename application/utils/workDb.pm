 #!/usr/bin/perl

 use lib('lib');
 use DBI;
 package utils::workDb;
 use strict;
 use Data::Dumper;
 sub new
 {
	my $self = 
		{
		'dbh'=>undef,
		'data'=>[],
		'iNUpDelStatus'=>undef,
		 'SelectStatus'=>undef
		};
	my $class = ref($_[0])|| $_[0];
	return bless $self, $class;
 }

 sub connectToDb
 {
	 my ($self) = @_;
	 my $dsn = 'dbi:mysql:user2';
	 my $user = 'user2';
	 my $password = 'tuser2';
	 $self->{'dbh'} = DBI->connect($dsn, $user, $password,{ RaiseError => 1, AutoCommit => 0 });
	 return !! $self->{'dbh'};

 }

sub exeSelect
{       
	my($self,$query)= @_;
	if($query eq "") return undef;

	$self->connectToDb() unless ($self->{'dbh'});
	return undef unless ($self->{'dbh'});

	
	my $hashArr = [];
	my $sth = $self->{'dbh'}->prepare($query);
	$sth->execute();

	while (my $hash = $sth->fetchrow_hashref) {
		push @{$hashArr}, $hash;
	}

	$self->{'data'}= $hashArr;
	 $self->{'dbh'}->disconnect();

	$self->{'SelectStatus'} = 1;
	return  $self->{'data'};
}

sub upDelIns
{
	
}

sub getData
{
	my($self) = @_;
	return  $self->{'data'};

}

1


