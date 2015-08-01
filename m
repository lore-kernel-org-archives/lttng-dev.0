From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [GIT PULL v2] Accounting packet lost and discarded
	events at runtime
Date: Sat, 01 Aug 2015 00:38:37 -0400
Message-ID: <55BC4D4D.9030202__11118.9576834024$1438403975$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZLOZI-0007qH-Cb
 for lttng-dev@lists.lttng.org; Sat, 01 Aug 2015 00:38:45 -0400
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

This patchset is composed of commits in lttng-tools, lttng-ust and
lttng-modules, it allows the sessiond, to report to the user the
discarded events (when a channel is in discard mode) or the lost packets
(when a channel is in overwrite mode).

Please pull from:
https://github.com/jdesfossez/lttng-tools-dev/tree/seqnum
* a67b58d Store the instance id and packet_seq_num in indexes
* 46799f7 kernctl commands to extract the stream instance id
* fa59a0d Account the lost packets in snapshot mode
* a9cc4fc Display discarded and lost events at destroy and stop
* 19cb87f Extract the lost packets and discarded events counters
* 542ea00 Metadata for instance_id and packet_seq_num
* 24f0684 Reference pointers from ust_app_chan to parent structs
* ea2bd65 Explicitely stop the session on lttng destroy
* ff43e00 Move lttng utils count_order function to common utils

https://github.com/jdesfossez/lttng-modules-dev/tree/seqnum
* df5eb63 Add stream instance id to the packet header
* 8a6e8ce Add a packet sequence number

https://github.com/jdesfossez/lttng-ust-dev/tree/seqnum
* 9953acc Export the stream instance ID.
* 0f61eb4 Generate and export the sequence number
* 3b2684f Add stream instance id to the packet header

Since we are in the last sprint of the 2.7 release, I will try to keep
these branches up-to-date by rebasing regularly until the maintainers
have some time to review and merge into master, so the commit IDs might
change, but the commit messages won't. I can resubmit as emails instead
of a pull request if it is easier for the review.

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
