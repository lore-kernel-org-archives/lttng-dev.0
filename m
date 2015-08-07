From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [GIT PULL v4] Accounting packet lost and discarded
 events at runtime
Date: Thu, 06 Aug 2015 23:55:40 -0400
Message-ID: <55C42C3C.6060803__49558.0954397612$1438919797$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZNYl1-0000n7-DY
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 23:55:48 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeremie Galarneau <jgalar@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This patchset is composed of commits in lttng-tools, and lttng-ust, it
allows the sessiond, to report to the user the
discarded events (when a channel is in discard mode) or the lost packets
(when a channel is in overwrite mode).

Please pull from:
https://github.com/jdesfossez/lttng-tools-dev/tree/seqnum
a65a791 Store the instance id and packet_seq_num in indexes
8049650 kernctl commands to extract the stream instance id
f947d62 Account the lost packets in snapshot mode
978bee2 Display discarded and lost events at destroy and stop
77f57b2 Extract the lost packets and discarded events counters
133e6c4 Metadata for instance_id and packet_seq_num
3121370 Add a HT to lookup sessions by id
bda9cd8 Explicitly stop the session on lttng destroy

https://github.com/jdesfossez/lttng-ust-dev/tree/seqnum
e25f0ef Export the stream instance ID
f01b21f Generate and export the sequence number
593dff9 Add stream instance id to the packet header

Changes from v3:
- lttng-modules patches Acked-by and merged in master
- lttng-ust patches all Acked-by
- removed the back reference introduced to retrieve the
lttng_ust_session and channels from the ust_app_chan
- introduced a new hashtable to find easily ltt_session from their id.

Changes from v2:
- actually pushed the updates intended for v1 in UST and tools...
- fixed the comments from Mathieu on the v2

Change from v1:
- the packet sequence number is not dependant on the subbuf_size and now
always a uint64_t, so it got rid of the need of the
packet_seq_num_padding field

Original cover letter:
The reporting is detailled on a per-channel basis in the "lttng list"
command (and associated API calls) at runtime. On lttng stop/destroy, a
warning is now displayed to the user if events/packets were
discarded/lost during the session.

The information about the packet lost is extracted from a packet
sequence number now written in each CTF packet and CTF index, allowing
the relayd and the viewers to know when parsing the trace/index that
entire packets were lost between two data packets.

Finally, a stream_instance_id is now written in each packet, this
feature allows a viewer to link multiple tracefiles belonging to the
same channel and stream. This is particularly useful when dealing with
tracefile rotation because the viewers will now be able to compute the
accurate number of discarded events.

Julien

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
