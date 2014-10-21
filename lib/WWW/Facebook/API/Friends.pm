#######################################################################
# $Date: 2007-06-03 02:17:24 -0700 (Sun, 03 Jun 2007) $
# $Revision: 79 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
package WWW::Facebook::API::Friends;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.3.0');

sub base { return shift->{'base'}; }

sub new {
    my ( $self, %args ) = @_;
    my $class = ref $self || $self;
    $self = bless \%args, $class;

    delete $self->{$_} for grep !/base/, keys %$self;
    $self->$_ for keys %$self;

    return $self;
}

sub get           { shift->base->call( 'friends.get',         @_ ) }
sub get_app_users { shift->base->call( 'friends.getAppUsers', @_ ) }
sub are_friends   { shift->base->call( 'friends.areFriends',  @_ ) }

1;    # Magic true value required at end of module
__END__

=head1 NAME

WWW::Facebook::API::Friends - Friend methods for Client


=head1 VERSION

This document describes WWW::Facebook::API::Friends version 0.3.0


=head1 SYNOPSIS

    use WWW::Facebook::API;


=head1 DESCRIPTION

Methods for accessing friends with L<WWW::Facebook::API>


=head1 SUBROUTINES/METHODS 

=over

=item new

Returns a new instance of this class.

=item base

The L<WWW::Facebook::API::Base> object to use to make calls to
the REST server.

=item get

The friends.get method of the Facebook API.

=item get_app_users

The friends.getAppUsers method of the Facebook API.

=item are_friends

The friends.areFriends method of the Facebook API. The two arguments are array
refs that make up an associative array. See the API for further details.

=back


=head1 DIAGNOSTICS

None.


=head1 CONFIGURATION AND ENVIRONMENT

WWW::Facebook::API::Friends requires no configuration files or
environment variables.


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
