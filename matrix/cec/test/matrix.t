#!/usr/bin/perl
use strict;
use warnings;

# Example matrices hardcoded; replace or extend to read input as needed
my @matrix1 = (
    [1, 2, 3],
    [4, 5, 6]
);

my @matrix2 = (
    [7, 8],
    [9, 10],
    [11, 12]
);

# Check dimensions
my $rows1 = scalar @matrix1;
my $cols1 = scalar @{$matrix1[0]};
my $rows2 = scalar @matrix2;
my $cols2 = scalar @{$matrix2[0]};

if ($cols1 != $rows2) {
    die "Error: Matrix multiplication not possible: columns of 1st != rows of 2nd\n";
}

# Initialize result matrix with zeros
my @result;
for my $i (0 .. $rows1 - 1) {
    for my $j (0 .. $cols2 - 1) {
        $result[$i][$j] = 0;
        for my $k (0 .. $cols1 - 1) {
            $result[$i][$j] += $matrix1[$i][$k] * $matrix2[$k][$j];
        }
    }
}

# Print result matrix
print "Result of multiplication:\n";
for my $i (0 .. $rows1 - 1) {
    for my $j (0 .. $cols2 - 1) {
        print $result[$i][$j], "\t";
    }
    print "\n";
}
