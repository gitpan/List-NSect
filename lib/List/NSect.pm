package List::NSect;
use strict;
use warnings;
use base qw{Exporter};
use List::MoreUtils qw{part};

our $VERSION = '0.02';
our @EXPORT  = qw(nsect);

=head1 NAME

List::NSect - To cut or divide a list into N equal parts.

=head1 SYNOPSIS

  use List::NSect;
  my @sections=nsect(5, @list); #sections returns ([], [], [], [], []);
  my $sections=nsect(5, @list); #sections returns [[], [], [], [], []];

=head1 DESCRIPTION

List::NSect is an L<Exporter> that exports the function "nsect".

I had a hard time deciding on a function name that was distinct and succinct.  When I searched the Internet for "divide into equal parts", "bisect" was one of the top hits.  I then tried to find a synonym for "divide into N equal parts".  I soon realized that there is no single English word for the concept: thus "nsect".  

Other function names that I was contemplating are "chunk" (to cut, break, or form into chunks), "allot" (to divide or distribute by share or portion) and "apportion" (to distribute or allocate proportionally; divide and assign according to some rule of proportional distribution).  None of these names implies the need for exactly N sections instead of some other distribution.

I use this capability all of the time which is a specific implementation of List::MoreUtils::part.  You may ask `why not just use "part" directly from L<List::MoreUtils>?`  Well, there are many edge cases.  Take a look at the code yourself; This IS Perl!

=head1 USAGE

  use List::NSect;
  my @sections=nsect($n, @list); #sections returns ([], [], [], [], []);

=head1 FUNCTION

=head2 nsect

To cut or divide into N equal or nearly equal parts, from bisect to divide into two equal parts.

Returns an array of array references given a scalar number of sections and a list.

  my @sections=nsect(4, 1 .. 17); returns ([1,2,3,4,5],[6,7,8,9],[10,11,12,13],[14,15,16,17]);
  my $sections=nsect(4, 1 .. 17); returns [[1,2,3,4,5],[6,7,8,9],[10,11,12,13],[14,15,16,17]];

=cut

sub nsect {
  my $n=shift;
  my $count=scalar(@_);
  #undef, 0 or empty array returns nothing as requested
  if (defined($n) and $n > 0 and $count > 0) {
    $n=$count if $n > $count;
    my $i=0;
    my @sections=part {int($i++ * $n / $count)} @_; #Each partition created is a reference to an array.
    wantarray ? @sections : \@sections;
  } else {
    return wantarray ? () : [];
  }
}

=head1 BUGS

Please log on RT and send an email to the author.

=head1 SUPPORT

DavisNetworks.com supports all Perl applications including this package.

=head1 AUTHOR

  Michael R. Davis
  CPAN ID: MRDVT
  Satellite Tracking of People, LLC
  mdavis@stopllc.com
  http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

  The General Public License (GPL) Version 2, June 1991

The full text of the license can be found in the LICENSE file included with this module.

=head1 SEE ALSO

L<List::MoreUtils> part and natatime, L<http://www.perlmonks.org/?node_id=516499>, L<http://www.perlmonks.org/?node_id=861938>, L<Parallel::ForkManager>

=cut

1;
