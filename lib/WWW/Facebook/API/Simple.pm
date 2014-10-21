#######################################################################
# $Date: 2007-05-31 17:58:27 -0700 (Thu, 31 May 2007) $
# $Revision: 34 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
package WWW::Facebook::API::Simple;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.1.6');

use Moose;
extends 'WWW::Facebook::API';

sub BUILD {
    my $self = shift;
    $self->simple(1);
    return;
}

1;
__END__

=head1 NAME

WWW::Facebook::API::Simple - Facebook API implementation


=head1 VERSION

This document describes WWW::Facebook::API::Simple version 0.1.6


=head1 SYNOPSIS

    use WWW::Facebook::API::Simple;

    my $client = WWW::Facebook::API::Simple->new(
        throw_errors => 1,
        desktop => 1,
        api_key => '5ac7d432',
        secret => '459ade099c',
    );

    my $token = $client->auth->create_token;
    $client->login->login( $token ); # prompts for login credentials from STDIN
    $client->auth->get_session( auth_token => $token );
    my @friends = @{ $client->friends->get };
    use Data::Dumper;
    print Dumper $client->friends->are_friends(
        uids1 => [@friends[0,1,2,3]],
        uids2 => [@friends[4,5,6,7]],
    );
    print 'You have '
        . $client->notifications->get->{pokes}->[0]->{unread}->[0]
        .' unread poke(s).';
    my @quotes = map { @{$_->{quotes}} }
        @{ $client->users->get_info( uids => \@friends, fields => ['quotes']) };
    print 'A lot of quotes: '.@quotes."\n";
    print "Random one:\t".$quotes[int rand @quotes]."\n";


=head1 DESCRIPTION

A simpler interface to fetch values with for the Facebook API. Basically, not
as much typing to get at the information returned by the server.

=head1 SUBROUTINES/METHODS 

See L<WWW::Facebook::API>.

=over

=item BUILD

L<Moose>

=item meta

L<Moose>

=back

=head1 DIAGNOSTICS

The errors that are thrown would most likely be from
L<WWW::Facebook::API::Base> or from L<DEPENDENCIES>, so look
there first.


=head1 CONFIGURATION AND ENVIRONMENT

WWW::Facebook::API::Simple requires no configuration files or environment
variables.


=head1 DEPENDENCIES

L<Moose>
L<WWW::Facebook::API>


=head1 INCOMPATIBILITIES

None.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-www-facebook-api-rest-client@rt.cpan.org>, or through the web interface at
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
