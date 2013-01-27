#!/usr/bin/perl
use strict;
use warnings;
use Sys::RunAlone;
use Parallel::ForkManager;
use Time::HiRes qw{sleep};
use List::NSect;
use DateTime;

printf "%s: Start\n", DateTime->now;

$|                = 1;
my $MAX_PROCESSES = shift || 5;
my $pm            = Parallel::ForkManager->new($MAX_PROCESSES);
my $tasks         = shift || 100;
my @tasks         = (1 .. $tasks);
my @sections      = nsect($MAX_PROCESSES => @tasks);

foreach my $section (@sections) {
  $pm->start and next;
  my $i=1;
  foreach my $task (@$section) {
    printf "%s: I'm child %s and I'm working on parent task %5d (child task %5d of %5d)\n", 
             DateTime->now, $$, $task, $i++, scalar(@$section);
    sleep rand 1;
  }
  $pm->finish; 
}

$pm->wait_all_children;

printf "%s: Finished\n", DateTime->now;

__END__
