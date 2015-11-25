#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Data::Dumper;
use Time::HiRes qw( time );

# Local
use DOEKBase::DataAPI::taxonomy::taxon::ClientAPI;

sub test_client {
    my ($url,$token,$ref) = @_;
    my $api = DOEKBase::DataAPI::taxonomy::taxon::ClientAPI->new({url=>$url,token=>$token,ref=>$ref});

    warn "Getting data..";

    my @functions = qw(
get_info
get_history
get_provenance
get_id
get_name
get_version
get_genetic_code
get_aliases
get_domain
get_kingdon
get_taxonomic_id
get_scientific_lineage
get_genome_annotations
get_parent
get_children
);

    foreach my $function (@functions)
    {
        my $start_time=time();
        my $result = $api->$function();
        my $elapsed_time=time()-$start_time;
        warn Dumper($result);
        warn "Got and parsed data from $function in $elapsed_time seconds";
    }

}

my $url='http://localhost:9101';
my $token=$ENV{'KB_AUTH_TOKEN'};
my $ref='ReferenceTaxons/242159_taxon';

test_client($url,$token,$ref);

#    ap.add_argument('--ref', default='ReferenceTaxons/242159_taxon', help='Object reference ID, e.g. 1019/4/1')
#    ap.add_argument('--url', dest='url', default='http://localhost:9101',
#                    metavar='URL', help='Remote server url '
#                                         '(default=%(default)s)')
