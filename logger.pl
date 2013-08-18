#!/usr/bin/env perl

use 5.010;

use strict;
use warnings;
use autodie;

my $datafile_path = '/Users/mgreb/Documents/data/battery.log';

# We derrive Pcnt from CurrentCapacity & MaxCapacity
my @logged = ( qw(
        CurrentCapacity MaxCapacity Pcnt CycleCount ExternalConnected IsCharging
        FullyCharged Temperature CellVoltage
) );

# get data;
my %data;
open( my $fh, '-|', '/usr/sbin/ioreg', '-rc', 'AppleSmartBattery' );
while ( my $line = <$fh> ) {
    if ( $line =~ m/"([^"]+)" = (.*)$/ ) {
        $data{$1} = $2;
    }
}
close($fh);

# data formatting
$data{Temperature} /= 100;
$_ = ( $_ eq 'Yes' ? 1 : 0 )
    for @data{ 'ExternalConnected', 'FullyCharged', 'IsCharging' };
$data{Pcnt}
    = sprintf( '%.2f', $data{CurrentCapacity} / $data{MaxCapacity} * 100 );

# log it
open ($fh, '>', $datafile_path);
say $fh join( "\t", time, @data{@logged} );
close ($fh);
