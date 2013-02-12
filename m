From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [RFC] on-disk multiple tracefiles circular buffer
Date: Tue, 12 Feb 2013 15:35:59 -0500
Message-ID: <511AA7AF.60102__46287.6268932179$1360701417$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U5MaG-0007z2-EQ
	for lttng-dev@lists.lttng.org; Tue, 12 Feb 2013 15:36:08 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This RFC discusses at high level the modification to be made to limit
the maximum size of tracefiles and the number of tracefiles to keep on disk.
The intent is to create an "on-disk circular buffer" with multiple
tracefiles, thus limiting the maximum disk usage of traces.

The semantic is similar to the -C and -W flags of tcpdump. In tcpdump,
-C limits the maximum file size and -W the amount of such files to keep
on disk. The -W flag is not mandatory with the -C, so it is possible to
have an "infinite" number of data files of a specific size which is
useful for analysis afterwards.

In LTTng, we have one stream (tracefile) per-channel per-CPU, so the
restrictions will apply for all the streams of a channel. For example,
if in a channel we want 5 tracefiles of 100MB each and we have 4 CPUs,
we will have a maximum of 20 tracefiles of 100MB (and a single metadata
file).

Each tracefile will be readable independently or with the others (and
correctly sorted) as long as the metadata file is available.

This functionnality will be enabled by channel in LTTng, so the proposed
approach is to add parameters to the channel creation calls (UI and API)
and make the streams inherit these parameters so that the consumer and
the relay will be able to handle the tracefiles accordingly.

The proposed options names are :
--tracefile_size
--tracefile_count

Or maybe add "max_" in there : max_tracefile_size, max_tracefile_count ?

The tracefile_count is ignored if the tracefile_size is not specified.
The tracefile will be splitted in a "infinite" number of files if
tracefile_size is specified and tracefile_count is omitted.

At the end of the tracefile name, we will add the number of tracefile,
for example the 5th tracefile on CPU 2 of channel "channel0" will be
named "channel0_2.5".

When a tracefile must be reused (after we reach the tracefile_count),
its content is truncated on open so the old data is no longer available
even if we don't overwrite it completely.

So this is the high-level breakdown of this new feature, if you have any
comments, please send them asap.

Thanks,

Julien
