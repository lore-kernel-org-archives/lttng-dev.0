From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/3] Tests: Move the babelstats
 utility to tests/utils
Date: Wed, 15 May 2013 11:52:48 -0400
Message-ID: <5193AF50.6030508__45454.0066807114$1368633232$gmane$org@efficios.com>
References: <1368568427-8289-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Uce0h-0006Ma-9M
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 11:52:59 -0400
In-Reply-To: <1368568427-8289-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

All 3 patches merged!

Thanks
David

Christian Babeux:
> This utility will prove useful in trace validation for other tests,
> so put it in a common location accessible by the tests.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/regression/tools/filtering/Makefile.am       |   4 +-
>  tests/regression/tools/filtering/babelstats.pl     | 174 ---------------------
>  tests/regression/tools/filtering/test_valid_filter |   4 +-
>  tests/utils/babelstats.pl                          | 174 +++++++++++++++++++++
>  4 files changed, 178 insertions(+), 178 deletions(-)
>  delete mode 100755 tests/regression/tools/filtering/babelstats.pl
>  create mode 100755 tests/utils/babelstats.pl
> 
> diff --git a/tests/regression/tools/filtering/Makefile.am b/tests/regression/tools/filtering/Makefile.am
> index 5629da2..ca60dbf 100644
> --- a/tests/regression/tools/filtering/Makefile.am
> +++ b/tests/regression/tools/filtering/Makefile.am
> @@ -14,5 +14,5 @@ gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
>  gen_ust_events_LDADD = -llttng-ust
>  endif
>  
> -noinst_SCRIPTS = test_unsupported_op test_invalid_filter test_valid_filter babelstats.pl
> -EXTRA_DIST = test_unsupported_op test_invalid_filter test_valid_filter babelstats.pl
> +noinst_SCRIPTS = test_unsupported_op test_invalid_filter test_valid_filter
> +EXTRA_DIST = test_unsupported_op test_invalid_filter test_valid_filter
> diff --git a/tests/regression/tools/filtering/babelstats.pl b/tests/regression/tools/filtering/babelstats.pl
> deleted file mode 100755
> index d8d4dd0..0000000
> --- a/tests/regression/tools/filtering/babelstats.pl
> +++ /dev/null
> @@ -1,174 +0,0 @@
> -#!/usr/bin/perl
> -
> -# Copyright (C) - 2012 Christian Babeux <christian.babeux@efficios.com>
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of the GNU General Public License, version 2 only, as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> -# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> -# more details.
> -#
> -# You should have received a copy of the GNU General Public License along with
> -# this program; if not, write to the Free Software Foundation, Inc., 51
> -# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -
> -use strict;
> -use warnings;
> -
> -use Getopt::Long;
> -
> -my $opt_tracepoint;
> -
> -GetOptions('tracepoint=s' => \$opt_tracepoint)
> -	or die("Invalid command-line option\n");
> -
> -defined($opt_tracepoint)
> -	or die("Missing tracepoint, use --tracepoint <name>");
> -
> -# Parse an array string.
> -# The format is as follow: [ [index] = value, ... ]
> -sub parse_array
> -{
> -	my ($arr_str) = @_;
> -	my @array = ();
> -
> -	# Strip leading and ending brackets, remove whitespace
> -	$arr_str =~ s/^\[//;
> -	$arr_str =~ s/\]$//;
> -	$arr_str =~ s/\s//g;
> -
> -	my @entries = split(',', $arr_str);
> -
> -	foreach my $entry (@entries) {
> -		if ($entry =~ /^\[(\d+)\]=(\d+)$/) {
> -			my $index = $1;
> -			my $value = $2;
> -			splice @array, $index, 0, $value;
> -		}
> -	}
> -
> -	return \@array;
> -}
> -
> -# Parse fields values.
> -# Format can either be a name = array or a name = value pair.
> -sub parse_fields
> -{
> -	my ($fields_str) = @_;
> -	my %fields_hash;
> -
> -	my $field_name = '[\w\d_]+';
> -	my $field_value = '[\w\d_\\\*"]+';
> -	my $array = '\[(?:\s\[\d+\]\s=\s\d+,)*\s\[\d+\]\s=\s\d+\s\]';
> -
> -	# Split the various fields
> -	my @fields = ($fields_str =~ /$field_name\s=\s(?:$array|$field_value)/g);
> -
> -	foreach my $field (@fields) {
> -		if ($field =~ /($field_name)\s=\s($array)/) {
> -			my $name  = $1;
> -			my $value = parse_array($2);
> -			$fields_hash{$name} = $value;
> -		}
> -
> -		if ($field =~ /($field_name)\s=\s($field_value)/) {
> -			my $name  = $1;
> -			my $value = $2;
> -			$fields_hash{$name} = $value;
> -		}
> -	}
> -
> -	return \%fields_hash;
> -}
> -
> -# Using an event array, merge all the fields
> -# of a particular tracepoint.
> -sub merge_fields
> -{
> -	my ($events_ref) = @_;
> -	my %merged;
> -
> -	foreach my $event (@{$events_ref}) {
> -		my $tp_provider = $event->{'tp_provider'};
> -		my $tp_name     = $event->{'tp_name'};
> -		my $tracepoint  = "$tp_provider:$tp_name";
> -
> -		foreach my $key (keys %{$event->{'fields'}}) {
> -			my $val = $event->{'fields'}->{$key};
> -
> -			# TODO: Merge of array is not implemented.
> -			next if (ref($val) eq 'ARRAY');
> -			$merged{$tracepoint}{$key}{$val} = undef;
> -		}
> -	}
> -
> -	return \%merged;
> -}
> -
> -# Print the minimum and maximum of each fields
> -# for a particular tracepoint.
> -sub print_fields_stats
> -{
> -	my ($merged_ref, $tracepoint) = @_;
> -
> -	return unless ($tracepoint && exists $merged_ref->{$tracepoint});
> -
> -	foreach my $field (keys %{$merged_ref->{$tracepoint}}) {
> -		my @sorted;
> -		my @val = keys ($merged_ref->{$tracepoint}->{$field});
> -
> -		if ($val[0] =~ /^\d+$/) {
> -			# Sort numerically
> -			@sorted = sort { $a <=> $b } @val;
> -		} elsif ($val[0] =~ /^0x[\da-f]+$/i) {
> -			# Convert the hex values and sort numerically
> -			@sorted = sort { hex($a) <=> hex($b) } @val;
> -		} else {
> -			# Fallback, alphabetical sort
> -			@sorted = sort { lc($a) cmp lc($b) } @val;
> -		}
> -
> -		my $min = $sorted[0];
> -		my $max = $sorted[-1];
> -
> -		print "$field $min $max\n";
> -	}
> -}
> -
> -my @events;
> -
> -while (<>)
> -{
> -	my $timestamp   = '\[(.*)\]';
> -	my $elapsed     = '\((.*)\)';
> -	my $hostname    = '.*';
> -	my $pname       = '.*';
> -	my $pid         = '\d+';
> -	my $tp_provider = '.*';
> -	my $tp_name     = '.*';
> -	my $cpu_info    = '{\scpu_id\s=\s(\d+)\s\}';
> -	my $fields      = '{(.*)}';
> -
> -	# Parse babeltrace text output format
> -	if (/$timestamp\s$elapsed\s($hostname):($pname):($pid)\s($tp_provider):($tp_name):\s$cpu_info,\s$fields/) {
> -		my %event_hash;
> -
> -		$event_hash{'timestamp'}   = $1;
> -		$event_hash{'elapsed'}     = $2;
> -		$event_hash{'hostname'}    = $3;
> -		$event_hash{'pname'}       = $4;
> -		$event_hash{'pid'}         = $5;
> -		$event_hash{'tp_provider'} = $6;
> -		$event_hash{'tp_name'}     = $7;
> -		$event_hash{'cpu_id'}      = $8;
> -		$event_hash{'fields'}      = parse_fields($9);
> -
> -		push @events, \%event_hash;
> -	}
> -}
> -
> -my %merged_fields = %{merge_fields(\@{events})};
> -print_fields_stats(\%merged_fields, $opt_tracepoint);
> diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
> index 7170eb5..a62cc1e 100755
> --- a/tests/regression/tools/filtering/test_valid_filter
> +++ b/tests/regression/tools/filtering/test_valid_filter
> @@ -21,7 +21,7 @@ CURDIR=$(dirname $0)/
>  TESTDIR=$CURDIR/../../..
>  LTTNG_BIN="lttng"
>  BIN_NAME="gen-ust-events"
> -STATS_BIN="babelstats.pl"
> +STATS_BIN="$TESTDIR/utils/babelstats.pl"
>  SESSION_NAME="valid_filter"
>  EVENT_NAME="tp:tptest"
>  NR_ITER=100
> @@ -81,7 +81,7 @@ function test_valid_filter
>  	# Destroy session
>  	destroy_lttng_session $SESSION_NAME
>  
> -	stats=`babeltrace $trace_path | $CURDIR/$STATS_BIN --tracepoint $EVENT_NAME`
> +	stats=`babeltrace $trace_path | $STATS_BIN --tracepoint $EVENT_NAME`
>  
>  	rm -rf $trace_path
>  
> diff --git a/tests/utils/babelstats.pl b/tests/utils/babelstats.pl
> new file mode 100755
> index 0000000..d8d4dd0
> --- /dev/null
> +++ b/tests/utils/babelstats.pl
> @@ -0,0 +1,174 @@
> +#!/usr/bin/perl
> +
> +# Copyright (C) - 2012 Christian Babeux <christian.babeux@efficios.com>
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms of the GNU General Public License, version 2 only, as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +# more details.
> +#
> +# You should have received a copy of the GNU General Public License along with
> +# this program; if not, write to the Free Software Foundation, Inc., 51
> +# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +use strict;
> +use warnings;
> +
> +use Getopt::Long;
> +
> +my $opt_tracepoint;
> +
> +GetOptions('tracepoint=s' => \$opt_tracepoint)
> +	or die("Invalid command-line option\n");
> +
> +defined($opt_tracepoint)
> +	or die("Missing tracepoint, use --tracepoint <name>");
> +
> +# Parse an array string.
> +# The format is as follow: [ [index] = value, ... ]
> +sub parse_array
> +{
> +	my ($arr_str) = @_;
> +	my @array = ();
> +
> +	# Strip leading and ending brackets, remove whitespace
> +	$arr_str =~ s/^\[//;
> +	$arr_str =~ s/\]$//;
> +	$arr_str =~ s/\s//g;
> +
> +	my @entries = split(',', $arr_str);
> +
> +	foreach my $entry (@entries) {
> +		if ($entry =~ /^\[(\d+)\]=(\d+)$/) {
> +			my $index = $1;
> +			my $value = $2;
> +			splice @array, $index, 0, $value;
> +		}
> +	}
> +
> +	return \@array;
> +}
> +
> +# Parse fields values.
> +# Format can either be a name = array or a name = value pair.
> +sub parse_fields
> +{
> +	my ($fields_str) = @_;
> +	my %fields_hash;
> +
> +	my $field_name = '[\w\d_]+';
> +	my $field_value = '[\w\d_\\\*"]+';
> +	my $array = '\[(?:\s\[\d+\]\s=\s\d+,)*\s\[\d+\]\s=\s\d+\s\]';
> +
> +	# Split the various fields
> +	my @fields = ($fields_str =~ /$field_name\s=\s(?:$array|$field_value)/g);
> +
> +	foreach my $field (@fields) {
> +		if ($field =~ /($field_name)\s=\s($array)/) {
> +			my $name  = $1;
> +			my $value = parse_array($2);
> +			$fields_hash{$name} = $value;
> +		}
> +
> +		if ($field =~ /($field_name)\s=\s($field_value)/) {
> +			my $name  = $1;
> +			my $value = $2;
> +			$fields_hash{$name} = $value;
> +		}
> +	}
> +
> +	return \%fields_hash;
> +}
> +
> +# Using an event array, merge all the fields
> +# of a particular tracepoint.
> +sub merge_fields
> +{
> +	my ($events_ref) = @_;
> +	my %merged;
> +
> +	foreach my $event (@{$events_ref}) {
> +		my $tp_provider = $event->{'tp_provider'};
> +		my $tp_name     = $event->{'tp_name'};
> +		my $tracepoint  = "$tp_provider:$tp_name";
> +
> +		foreach my $key (keys %{$event->{'fields'}}) {
> +			my $val = $event->{'fields'}->{$key};
> +
> +			# TODO: Merge of array is not implemented.
> +			next if (ref($val) eq 'ARRAY');
> +			$merged{$tracepoint}{$key}{$val} = undef;
> +		}
> +	}
> +
> +	return \%merged;
> +}
> +
> +# Print the minimum and maximum of each fields
> +# for a particular tracepoint.
> +sub print_fields_stats
> +{
> +	my ($merged_ref, $tracepoint) = @_;
> +
> +	return unless ($tracepoint && exists $merged_ref->{$tracepoint});
> +
> +	foreach my $field (keys %{$merged_ref->{$tracepoint}}) {
> +		my @sorted;
> +		my @val = keys ($merged_ref->{$tracepoint}->{$field});
> +
> +		if ($val[0] =~ /^\d+$/) {
> +			# Sort numerically
> +			@sorted = sort { $a <=> $b } @val;
> +		} elsif ($val[0] =~ /^0x[\da-f]+$/i) {
> +			# Convert the hex values and sort numerically
> +			@sorted = sort { hex($a) <=> hex($b) } @val;
> +		} else {
> +			# Fallback, alphabetical sort
> +			@sorted = sort { lc($a) cmp lc($b) } @val;
> +		}
> +
> +		my $min = $sorted[0];
> +		my $max = $sorted[-1];
> +
> +		print "$field $min $max\n";
> +	}
> +}
> +
> +my @events;
> +
> +while (<>)
> +{
> +	my $timestamp   = '\[(.*)\]';
> +	my $elapsed     = '\((.*)\)';
> +	my $hostname    = '.*';
> +	my $pname       = '.*';
> +	my $pid         = '\d+';
> +	my $tp_provider = '.*';
> +	my $tp_name     = '.*';
> +	my $cpu_info    = '{\scpu_id\s=\s(\d+)\s\}';
> +	my $fields      = '{(.*)}';
> +
> +	# Parse babeltrace text output format
> +	if (/$timestamp\s$elapsed\s($hostname):($pname):($pid)\s($tp_provider):($tp_name):\s$cpu_info,\s$fields/) {
> +		my %event_hash;
> +
> +		$event_hash{'timestamp'}   = $1;
> +		$event_hash{'elapsed'}     = $2;
> +		$event_hash{'hostname'}    = $3;
> +		$event_hash{'pname'}       = $4;
> +		$event_hash{'pid'}         = $5;
> +		$event_hash{'tp_provider'} = $6;
> +		$event_hash{'tp_name'}     = $7;
> +		$event_hash{'cpu_id'}      = $8;
> +		$event_hash{'fields'}      = parse_fields($9);
> +
> +		push @events, \%event_hash;
> +	}
> +}
> +
> +my %merged_fields = %{merge_fields(\@{events})};
> +print_fields_stats(\%merged_fields, $opt_tracepoint);
