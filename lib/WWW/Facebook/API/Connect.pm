#######################################################################
# ex: set ts=8 sw=4 et
#########################################################################
package WWW::Facebook::API::Connect;

use warnings;
use strict;
use Carp;

sub get_unconnected_friends_count {
    return shift->base->call( 'connect.getUnconnectedFriendsCount',        @_ ) }
sub register_users         { return shift->base->call( 'connect.registerUsers',        @_ ) }
sub unregister_users         { return shift->base->call(
        'connect.unregisterUsers',        @_ ) }

1;    # Magic true value required at end of module
__END__

=head1 NAME

WWW::Facebook::API::Connect - Facebook Connect

=head1 SYNOPSIS

    use WWW::Facebook::API;


=head1 DESCRIPTION

Methods for accessing connect with L<WWW::Facebook::API>

=head1 SUBROUTINES/METHODS 

=over

=item base

Returns the L<WWW::Facebook::API> base object.

=item new

Constructor.

=item add( %params )

The connect.getUnconnectedFriendsCount method of the Facebook API:

    $response = $client->connect->get_unconnected_friends_count(
        format => $json,
    );

=item register_users( %params )

The connect.registerUsers method of the Facebook API:

    $response = $client->connect->register_users(
        accounts => [ { email_hash => $email_hash } ]
    );

=item unregister_users( %params )

The connect.unregisterUsers method of the Facebook API:

    $response = $client->connect->unregister_users(
        email_hashes => [@email_hashes]
    );

=back

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

WWW::Facebook::API::Connect requires no configuration files or environment
variables.

=head1 DEPENDENCIES

See L<WWW::Facebook::API>

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-www-facebook-api@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

David Romano  C<< <unobe@cpan.org> >>


=head1 LICENSE AND COPYRIGHT

Copyright (c) 2009, David Romano C<< <unobe@cpan.org> >>. All rights reserved.

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