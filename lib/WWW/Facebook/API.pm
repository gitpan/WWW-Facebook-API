#######################################################################
# $Date: 2007-05-03T11:47:22.910985Z $
# $Revision: 1416 $
# $Author: unobe $
# ex: set ts=8 sw=4 et
#########################################################################
package WWW::Facebook::API;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.0.6');

use Moose;
extends 'WWW::Facebook::API::Base';

has 'auth' => (is => 'ro',
    isa => 'WWW::Facebook::API::Auth',
    default => sub {
        use WWW::Facebook::API::Auth;
        return WWW::Facebook::API::Auth->new( base => $_[0] )
    },
);
has 'login' => (is => 'ro',
    isa => 'WWW::Facebook::API::Login',
    default => sub {
        use WWW::Facebook::API::Login;
        return WWW::Facebook::API::Login->new( base => $_[0] )
    },
);
has 'events' => (is => 'ro',
    isa => 'WWW::Facebook::API::Events',
    default => sub {
        use WWW::Facebook::API::Events;
        return WWW::Facebook::API::Events->new( base => $_[0] )
    },
);
has 'fql' => (is => 'ro',
    isa => 'WWW::Facebook::API::FQL',
    default => sub {
        use WWW::Facebook::API::FQL;
        return WWW::Facebook::API::FQL->new( base => $_[0] )
    },
);
has 'friends' => (is => 'ro',
    isa => 'WWW::Facebook::API::Friends',
    default => sub {
        use WWW::Facebook::API::Friends;
        return WWW::Facebook::API::Friends->new( base => $_[0] )
    },
);
has 'groups' => (is => 'ro',
    isa => 'WWW::Facebook::API::Groups',
    default => sub {
        use WWW::Facebook::API::Groups;
        return WWW::Facebook::API::Groups->new( base => $_[0] )
    },
);
has 'notifications' => (is => 'ro',
    isa => 'WWW::Facebook::API::Notifications',
    default => sub {
        use WWW::Facebook::API::Notifications;
        return WWW::Facebook::API::Notifications->new( base => $_[0] )
    },
);
has 'photos' => (is => 'ro',
    isa => 'WWW::Facebook::API::Photos',
    default => sub {
        use WWW::Facebook::API::Photos;
        return WWW::Facebook::API::Photos->new( base => $_[0] )
    },
);
has 'update' => (is => 'ro',
    isa => 'WWW::Facebook::API::Update',
    default => sub {
        use WWW::Facebook::API::Update;
        return WWW::Facebook::API::Update->new( base => $_[0] )
    },
);
has 'users' => (is => 'ro',
    isa => 'WWW::Facebook::API::Users',
    default => sub {
        use WWW::Facebook::API::Users;
        return WWW::Facebook::API::Users->new( base => $_[0] )
    },
);

has 'simple' => (is => 'rw',
    isa => 'Bool',
    required => 1,
    default => 0,
);

1;
__END__

=head1 NAME

WWW::Facebook::API - Facebook API implementation


=head1 VERSION

This document describes WWW::Facebook::API version 0.0.6


=head1 SYNOPSIS

    use WWW::Facebook::API;

    my $client = WWW::Facebook::API->new(
        throw_errors => 1,
        desktop => 1,
        api_key => '5ac7d432',
        secret => '459ade099c',
    );

    my $token = $client->auth->create_token
        ->{auth_createToken_response}->[0]->{content};
    $client->login->login( $token ); # prompts for login credentials from STDIN
    $client->auth->get_session( auth_token => $token );
    my @friends = @{$client->friends->get->{friends_get_response}->[0]->{uid}};
    use Data::Dumper;
    print Dumper $client->friends->are_friends(
        uids1 => [@friends[0,1,2,3]],
        uids2 => [@friends[4,5,6,7]],
    );
    print 'You have '
        . $client->notifications->get->{notifications_get_response}->[0]
            ->{pokes}->[0]->{unread}->[0]
        .' unread poke(s).';
    my @quotes = map { @{$_->{quotes}} }
        @{$client->users->get_info( uids => \@friends, fields => ['quotes'] )
            ->{users_getInfo_response}->[0]->{user}};
    print 'A lot of quotes: '.@quotes."\n";
    print "Random one:\t".$quotes[int rand @quotes]."\n";


=head1 DESCRIPTION

A Perl implementation of the Facebook API, working off of the Java and PHP
implementations initially proffered by the Facebook development team. The
results are returned as a hash parsed by L<XML::Simple> with ForceArray => 1
and KeepRoot => 1. So, as per the API description at
L<http://developers.facebook.com/documentation.php>, there's a result key,
with an array which has the result items (be they hashes or whatever) inside.
I thought this would give the most direct access to the actual data without
filtering any important data (or ordering of data) out.


=head1 SUBROUTINES/METHODS 

=over

=item auth

auth namespace of the API (See L<WWW::Facebook::API::Auth>).
All method names from the Facebook API are lower_cased instead of CamelCase,
e.g., auth.createToken is auth->create_token

=item login

Not defined in the API, but useful for testing with your own account. Asks for
username and password (not stored) to authenticate token. Called as
$client->login->login($token);

=item events

events namespace of the API (See L<WWW::Facebook::API::Events>).
All method names from the Facebook API are lower_cased instead of CamelCase,
e.g., events.getInWindow is events->get_in_window

=item fql

fql namespace of the API (See L<WWW::Facebook::API::FQL>).

=item friends

friends namespace of the API (See L<WWW::Facebook::API::Friends>).
All method names from the Facebook API are lower_cased instead of CamelCase,
e.g., friends.areFriends(list1, list2) is friends->are_friends(list1, list2)

=item groups

groups namespace of the API (See L<WWW::Facebook::API::Groups>).
All method names from the Facebook API are lower_cased instead of CamelCase,
e.g., groups.getMembers(gid) is groups->get_members(gid)

=item notifications

notifications namespace of the API (See L<WWW::Facebook::API::Notifications>).

=item photos

photos namespace of the API (See L<WWW::Facebook::API::Photos>).
All method names from the Facebook API are lower_cased instead of CamelCase,
e.g., photos.getOfUser is photos->get_of_user

=item update

update namespace of the API (See L<WWW::Facebook::API::Update>).
Call update.decodeIDs with update->decode_ids

=item users

users namespace of the API (See L<WWW::Facebook::API::Users>).
All method names from the Facebook API are lower_cased instead of CamelCase,
e.g., users.getInfo is users->get_info

=item simple

Defaults to false.  L<WWW::Facebook::API::Simple> defaults to true. Compare
this module's synopsis with L<WWW::Facebook::API::Simple> to see an example of
what difference it makes. If set to true, makes all methods return an
easier-to-manage value by dereferencing the top nodes of the XML hierarchy. If
there is no ambiguity about what the requested value is, it will return that
(e.g, auth.createToken will return the token, friends.get will return an array
ref of uids, etc. ).  If there is ambiguity (e.g., auth.getSession), then it
will only dereference to the point where it cannot do so without losing
crucial information.

=back 


=head1 DIAGNOSTICS

The errors that are thrown would most likely be from
L<WWW::Facebook::API::Base> or from L<DEPENDENCIES>, so look
there first.


=head1 CONFIGURATION AND ENVIRONMENT

WWW::Facebook::API requires no configuration files or environment variables.


=head1 DEPENDENCIES

L<Moose>
L<WWW::Mechanize>
L<XML::Simple>
L<Digest::MD5>
L<Time::HiRes>
L<URI::Escape>
L<Crypt::SSLeay>


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

Copyright (c) 2006, David Romano C<< <unobe@cpan.org> >>. All rights reserved.

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
