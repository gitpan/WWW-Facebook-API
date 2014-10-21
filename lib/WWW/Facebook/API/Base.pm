#######################################################################
# $Date: 2007-05-30T13:21:11.572530Z $ # $Revision: 1521 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
package WWW::Facebook::API::Base;

use warnings;
use strict;
use Carp;

use WWW::Mechanize;
use Time::HiRes qw(time);
use XML::Simple qw(xml_in);
use Digest::MD5;

use version; our $VERSION = qv('0.1.4');

use Moose;
use WWW::Facebook::API::Errors;

has 'format' => ( is => 'rw', isa => 'Str', required => 1, default => 'XML' );
has 'mech' => (is => 'rw', isa => 'WWW::Mechanize', required => 1,
    default => sub {
            WWW::Mechanize->new(
                agent => "Perl-WWW-Facebook-API/$VERSION"
            )
    },
);
has 'server_uri' => (
    is => 'rw', isa => 'Str', required => 1,
    default => 'http://api.facebook.com/restserver.php',
);
has 'secret' => (is => 'rw', isa => 'Str', required => 1,
    default => sub {
        print q{Shhhh...please enter a secret: };
        chomp(my $secret = <STDIN>);
        return $secret;
    },
);
has 'api_key' => (is => 'ro', isa => 'Str', required => 1,
    default => sub {
        print q{Please enter an API key: };
        chomp(my $key = <STDIN>);
        return $key;
    },
);
has 'api_version' => (is => 'ro', isa => 'Str', required => 1,
    default => '1.0',
);
has 'next' => (is => 'ro', isa => 'Int', required => 1,
    default => 0,
);
has 'popup' => (is => 'ro', isa => 'Int', required => 1,
    default => 0,
);
has 'skipcookie' => (is => 'ro', isa => 'Int', required => 1,
    default => 0,
);
has 'session_key'   => ( is => 'rw', isa => 'Str', default => q{} );
has 'session_expires'   => ( is => 'rw', isa => 'Str', default => q{} );
has 'session_uid'   => ( is => 'rw', isa => 'Str', default => q{} );
has 'desktop' => ( is => 'ro', isa => 'Bool', required => 1, default => 0 );
has 'errors' => (
    is => 'ro',
    isa => 'WWW::Facebook::API::Errors',
    required => 1,
    default => sub { WWW::Facebook::API::Errors->new( base => $_[0] ) },
);

sub call {
    my ( $self, $method, %args, $params, $secret, $response ) = @_;
    $self->errors->last_call_success( 1 );
    $self->errors->last_error( undef );

    $params = delete $args{'params'} || {};
    $params->{$_} = $args{$_} for keys %args;

    $secret = $args{'secret'} || $self->secret;
    $params->{'method'} ||= $method;
    $self->_update_params( $params );
    my $sig = _create_sig_for( $params, $secret );
    $response = $self->_post_request( $params, $secret );

    if ($self->errors->debug) {
        $params->{'sig'} = $sig;
        $params->{'secret'} = $secret;
        $self->errors->log_debug( $params, $response );
    }
    if ( $response =~ m!<error_code>(\d+)|^{"error_code"\D(\d+)!mx ) {
        confess "Error during REST $method call:\n$response";
        $self->errors->log_error( $1, $response );
    }

    return $response if $params->{'format'} eq 'JSON';

    return $self->_make_xml_for( $response );
}

sub _make_xml_for {
    my ( $self, $response, $xml ) = @_;
    $xml = xml_in( $response,
        ForceArray => 1,
        KeepRoot => !$self->simple,
    );

    if ( $self->simple ) {
        # remove meta-data
        for ( keys %$xml ) {
            delete $xml->{$_} if /^x(ml|si)|list/;
        }

        # keys is screwy: will give uninit warnings otherwise
        if ( keys %$xml ) {
            return $xml->{ [keys %$xml]->[0] } if keys %$xml == 1;
        }
        elsif ( exists $xml->{$_}->[0]->{content} ) {
            return $xml->{content};
        }
    }
    return $xml;
}

sub _update_params {
    my ( $self, $params ) = @_;
    if ( $params->{'method'} !~ m/^auth/mx ) {
        $params->{'session_key'} = $self->session_key;
    }
    $params->{ 'call_id' }  =   time if $self->desktop;
    $params->{ 'method'  }  =   "facebook.$params->{'method'}";
    $params->{ 'api_key' }  ||= $self->api_key;
    $params->{ 'format'  }  ||= $self->format;
    $params->{ 'v'       }  ||= $self->api_version;

    for (qw/popup next skipcookie/) {
        if ( $self->$_ ) { $params->{$_} = q{} }
    }
    return;
 }

sub _post_request {
    my ($self, $params, $secret, $sig, $post_params ) = @_;

    _reformat_params( $params );
    $sig = _create_sig_for( $params, $secret );
    $post_params = [ map { $_, $params->{$_} } sort keys %$params ];
    push @$post_params, 'sig', $sig;

    $self->mech->post( $self->server_uri, $post_params );
    
    return $self->mech->content;
}

sub _reformat_params {
    my $params = shift;

    # reformat arrays and add each param to digest
    for ( keys %$params ) {
        next unless ref $params->{$_} eq 'ARRAY';
        $params->{$_} = join q{,}, @{ $params->{$_} };
    }
}

sub _create_sig_for {
    my ($params, $secret ) = @_;

    my $md5 = Digest::MD5->new;
    $md5->add( map { "$_=$params->{$_}" } sort keys %$params );
    $md5->add( $secret );

    return $md5->hexdigest;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

WWW::Facebook::API::Base - Base class for Client


=head1 VERSION

This document describes WWW::Facebook::API::Base version 0.1.4


=head1 SYNOPSIS

    use WWW::Facebook::API::Base;


=head1 DESCRIPTION

Base methods and data for WWW::Facebook::API and friends.


=head1 SUBROUTINES/METHODS 

=over

=item format

The default format to use if none is supplied with an API method call.
Currently available options are XML and JSON. Defaults to XML.

=item call

The method which other submodules within WWW::Facebook::API use
to call the Facebook REST interface. It takes in a hash signifying the method
to be called (e.g., 'auth.getSession'), the parameters to pass through, and
(optionally) the secret to use.

=item mech

The L<WWW::Mechanize> agent used to communicate with the REST server.
Shouldn't be needed for anything. The agent_alias is set to
"Perl-WWW-Facebook-API-REST-Client/$VERSION".

=item server_uri

The server uri to access the Facebook REST server. See the Facebook API
documentation.

=item secret

For a desktop application, this is the secret that is used for calling
create_token and get_session. See the Facebook API documentation under
Authentication. If no secret is passed in to the C<new> method, it will prompt
for one to be entered from STDIN.

=item api_key

The developer's API key. See the Facebook API documentation. If no api_key is
passed in to the C<new> method, it will prompt for one to be entered from
STDIN.

=item session_key

The session key for the client's user. See the Facebook API documentation.

=item session_expires

The session expire timestamp for the client's user. See the Facebook API
documentation.

=item session_uid

The session's uid for the client's user. See the Facebook API documentation.

=item desktop

A boolean signifying if the client is being used for a desktop application.
See the Facebook API documentation.

=item errors

See L<WWW::Facebook::API::Errors>. Basically, a grouping of the
data that handles errors and debug information.

=item api_version

Which version to use (default is "1.0", which is the only one supported
currently. Corresponds to the argument C<v> that is passed in to methods as a
parameter.

=item next

See the Facebook API documentation.

=item popup

See the Facebook API documentation.

=item skipcookie

See the Facebook API documentation.

=back

=head1 INTERNAL METHODS AND FUNCTIONS

=over

=item _reformat_params

Reformat parameters according to Facebook API spec.

=item _update_params

Updates values for parameters that are passed in.

=item _post_request

Used by C<call> to post the request to the REST server and return the
response.

=item _create_sig_for

Creates signature (md5) for the post parameters, and returns a reference to
the post parameters with the sig as the last element in the list.

=back


=head1 DIAGNOSTICS

=over

=item C< Error during REST call: %s >

This means that there's most likely an error in the server you are using to
communicate to the Facebook REST server. Look at the traceback to determine
why an error was thrown. Double-check that C<server_uri> is set to the right
location.

=back

See L<WWW::Facebook::API::Errors>.


=head1 CONFIGURATION AND ENVIRONMENT

WWW::Facebook::API::Base requires no configuration files or
environment variables.


=head1 DEPENDENCIES

L<Moose>
L<WWW::Mechanize>
L<XML::Simple>
L<Digest::MD5>
L<Time::HiRes>
L<Crypt::SSLeay>


=head1 INCOMPATIBILITIES

None.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-www-facebook-api@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

David Romano  C<< <unobe@cpan.org> >>


=head1 LICENSE AND COPYRIGHT

Copyright (c) 2007, David Romano C<< <unobe@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENSE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
