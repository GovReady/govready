#!/usr/bin/env perl

#
# Perl script to decode JSON from aws ec2 describe-security-groups.
# Should work with older JSON package if you have that and not JSON:XS.
#

use JSON::XS qw( decode_json );

my $json = do { local $/; <STDIN> };

my $decoded = decode_json($json);

my @secgrp = @{ $decoded->{'SecurityGroups'} };
foreach my $f ( @secgrp ) {
    $desc=$f->{"Description"};
    $group=$f->{"GroupName"};

    print "\nGroup Name : $group\n";
    print "Description: $desc\n\n";

    my @ipperm = @{ $f->{'IpPermissions'} };

    foreach my $g ( @ipperm ) {
	$toport=$g->{'ToPort'};
	$fromport=$g->{'FromPort'};
	$proto=$g->{'IpProtocol'};

	my @cidr = @{ $g->{'IpRanges'} };
	foreach my $h ( @cidr ) {
	    $cidr=$h->{'CidrIp'};

	    if ($proto == -1) {
		print "any IP traffic, from source $cidr\n";
	    } else {
		if ($fromport ne $toport) {
		    print "ports $fromport:$toport/$proto, from source $cidr\n";
		} else {
		    $service = getService("${fromport}/${proto}");
		    print "port $fromport/$proto, from source $cidr\t $service\n";
		}
	    }
	}
    }
}

sub getService {
    my $service = shift;
    open my $fh, '<:encoding(UTF-8)', '/etc/services' or die;
    while (my $line = <$fh>) {
        if ($line =~ /^(\w+)\s+$service$/) {
            return $1;
        }
    }
}
