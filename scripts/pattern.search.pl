#!/usr/bin/perl -w
# Sanzhen Liu
# search for any sequencing pattern in fasta sequences
# version 0.2 (10/17/2018)
# v0.1 6/4/2014

use strict;
use warnings;
use Getopt::Std;

### options:
my %opts = (I=>"", P=>"", O=>"B", h=>0);	
getopts('I:P:O:Sh', \%opts);
die(qq/
Usage: pattern.search.pl [options]
Options:
	-I str	fasta file [$opts{I}]
	-P str  pattern [$opts{P}]; e.g., "(TTAGGG|CCCTAA){3,}" for searching Pyricularia oryzae telomeres 
	-O reverse & complement the sequence to be searched, "F", "R", "B"
	   representing forward, reverse, both, respectively.
	-S skip iterative search or not on pattern-identified sites, default is no skipping
	\n/) if ($opts{h} || $opts{I} eq "");

my $pattern_seq = $opts{P};

my $iteration = 1; ### iterative search as default
if ($opts{S}) {
	$iteration = 0;
}

if ($pattern_seq eq "") {
	die("ERROR: No site was input\n");
}

### import sequence data from the fasta file:
my ($name, $seq, %seqhash);
open(IN, $opts{I}) || die "Cannot open input file: $opts{I}\n";
while (<IN>) {
	chomp;
	if (/^>(.+)/) {
		if (defined $name) {
			$seqhash{$name} = $seq;
		}
		$name = $1;
		$seq = '';
	} else {
		$seq .= $_;
	}
}
$seqhash{$name} = $seq;
close IN;

### print header:
print "# input fasta file is $opts{I}\n";
print "# search pattern of $opts{P}\n";
print "Seq_name\tOrientation\tOrder\tStart\tEnd\tMatch_seq\n";
### search and output
for my $eachseq (sort {$a cmp $b} keys %seqhash) {
	my $current_seq = $seqhash{$eachseq};
	if ($opts{O} eq "F" or $opts{O} eq "B") { 
		&pattern_search($current_seq, $eachseq, $pattern_seq, "forward");
	}
	if ($opts{O} eq "R" or $opts{O} eq "B") {  ### reverse and complement seq
		my $revcom_current_seq = &revcom($current_seq);
		&pattern_search($revcom_current_seq, $eachseq, $pattern_seq, "minus");
	}
	if ($opts{O} ne "F" and $opts{O} ne "R" and $opts{O} ne "B") {
		die "Parameter O must be one of F, R, B, representing
			forward, reverse, both, respectively.\n";
	}
}

sub revcom {
	my $inseq = shift @_; 
	my $revcom = reverse($inseq);
	$revcom =~ tr/AGCTagct/TCGAtcga/;
	return $revcom;
}

sub pattern_search {
	my ($fasta, $fasta_name, $pattern, $ori) = @_;
	my $count = 0;
	my $nextpos = 0;
	### the following matchstart and matchend to be printed are 1-based
	if ($iteration) {
		while ($fasta =~ /(?=($pattern))/gi) { # ?= is to match overlapping matches
			my $match = $1;
			my $matchstart = index($fasta, $match, $nextpos);
			my $matchend = $matchstart + length($match);
			$matchstart += 1;  ### to adjust zero based
			$nextpos = $matchstart;
			$count++;
			printf("%s\t%s\t%d\t%d\t%d\t%s\n", $fasta_name, $ori, $count, $matchstart, $matchend, $match);
		}
	} else {
		while ($fasta =~ /($pattern)/gi) { # skip overlapping matches
			my $match = $1;
			my $matchstart = index($fasta, $match, $nextpos);
			my $matchend = $matchstart + length($match);
			$matchstart += 1;  ### to adjust zero based
			$nextpos = $matchend; ### nextpos is zero based
			$count++;
			printf("%s\t%s\t%d\t%d\t%d\t%s\n", $fasta_name, $ori, $count, $matchstart, $matchend, $match);
		}
	}
}

