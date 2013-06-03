package Test::MockObject::Chain::Builder;
use 5.010000;
use strict;
use warnings;

sub new { bless shift, {} }

sub AUTOLOAD {
  my $self = shift;
  ( my $method = $AUTOLOAD ) =~ s{.*::}{};

  return $self->_handle_method_call(
    { method => $method, parameters => \@_, wants => wantarray ? '@' : '$', call_type => '->'  },
    { 'OBJECT' => want('OBJECT'),  }
  );

}

sub _handle_method_call {
  my $self = shift;
  my $args = shift;
  my $wants = shift;

  $self->_add_to_chain($args);

  unless ($wants->{'OBJECT'} ) {
    #Lets end the chain
    #return $self->_client->execute_chain($self->_chain());
  }

  return $self; #They wanted an object, so lets just chain (we can't make it the right type because we don't know what it is yet
}

1;