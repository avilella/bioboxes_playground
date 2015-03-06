#!/usr/bin/perl
use strict;
use warnings;
use IPC::Open3 'open3'; $SIG{CHLD} = 'IGNORE';
use Symbol 'gensym';
use Getopt::Long;

my $inputfile;
my $debug; my $verbose;
GetOptions(
	   'i|input|inputfile:s' => \$inputfile,
           'debug' => \$debug,
          'verbose' => \$verbose,
          );

print `$inputfile`;

1;
