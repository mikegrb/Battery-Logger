#!/usr/bin/perl

use 5.010;

use strict;
use warnings;

my $datafile_path = '/Users/mgreb/Documents/data/battery.log';

# We derrive Pcnt from CurrentCapacity & MaxCapacity, LifePcnt from MaxCapacity
# and design capacity, rest are properties for AppleSmartBattery from ioreg

my @logged = ( qw(
        CurrentCapacity MaxCapacity Pcnt CycleCount LifePcnt
        ExternalConnected IsCharging FullyCharged Temperature CellVoltage
) );

# get data
my %data;
open( my $fh, '-|', '/usr/sbin/ioreg', '-rc', 'AppleSmartBattery' )
    or die "Couldn't run ioreg: $!";
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
$data{LifePcnt}
    = sprintf( '%.2f', $data{MaxCapacity} / $data{DesignCapacity} * 100 );

# log it
open( $fh, '>>', $datafile_path ) or die "Couldn't open log file: $!";
say $fh join( "\t", time, @data{@logged} );
close($fh);
