#######################################################################
# $Date: 2007-05-28T14:18:18.679359Z $
# $Revision: 1508 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
package WWW::Facebook::API::Photos;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.0.9');

use Moose;
extends 'Moose::Object';

has 'base' => ( is => 'ro', isa => 'WWW::Facebook::API::Base' );

sub add_tag {
    my $self = shift;
    my $value = $self->base->call(
        method => 'photos.addTag',
        params => { @_ },
    );
    return $self->base->simple
        ? $value->{photos_addTag_response}->[0]->{content}
        : $value;
}

sub create_album {
    my $self = shift;
    my $value = $self->base->call(
        method => 'photos.createAlbum',
        params => { @_ },
    );
    return $self->base->simple
        ? $value->{photos_createAlbum_response}->[0]
        : $value;
}

sub get {
    my $self = shift;
    my $value = $self->base->call(
        method => 'photos.get',
        params => { @_ },
    );
    return $self->base->simple
        ? $value->{photos_get_response}->[0]->{photo}
        : $value;
}

sub get_albums {
    my $self = shift;
    my $value = $self->base->call(
        method => 'photos.getAlbums',
        params => { @_ },
    );
    return $self->base->simple
        ? $value->{photos_getAlbums_response}->[0]->{album}
        : $value;
}

sub get_tags {
    my $self = shift;
    my $value = $self->base->call(
        method => 'photos.getTags',
        params => { @_ },
    );
    return $self->base->simple
        ? $value->{photos_getTags_response}->[0]->{photo_tag}
        : $value;
}

sub upload {
    my $self = shift;
    my $value = $self->base->call(
        method => 'photos.upload',
        params => { @_ },
    );
    return $self->base->simple
        ? $value->{photos_upload_response}->[0]
        : $value;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

WWW::Facebook::API::Photos - Photos methods for Client


=head1 VERSION

This document describes WWW::Facebook::API::Photos version 0.0.9


=head1 SYNOPSIS

    use WWW::Facebook::API;

=head1 DESCRIPTION

Methods for accessing photos with L<WWW::Facebook::API>

=head1 SUBROUTINES/METHODS 

=over

=item base

The L<WWW::Facebook::API::Base> object to use to make calls to
the REST server.

=item add_tag

The photos.addTag method of the Facebook API.

=item create_album

The photos.createAlbum method of the Facebook API.

=item get

The photos.get method of the Facebook API.

=item get_albums

The photos.getAlbums method of the Facebook API.

=item get_tags

The photos.getTags method of the Facebook API.

=item upload

The photos.upload method of the Facebook API.

=back


=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

WWW::Facebook::API::Photos requires no configuration files or
environment variables.


=head1 DEPENDENCIES

L<Moose>
L<WWW::Facebook::API::Base>


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
