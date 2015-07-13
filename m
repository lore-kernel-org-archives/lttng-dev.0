From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 0/9] Accounting packet lost and
	discarded events at runtime
Date: Mon, 13 Jul 2015 11:28:00 -0400
Message-ID: <1436801289-17554-1-git-send-email-jdesfossez__21220.8426943564$1436801451$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfec-0008PL-Mn
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:27 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This patchset is accompanied by commits in lttng-ust and lttng-modules, it
allows the sessiond, to report to the user the discarded events (when a channel
is in discard mode) or the lost packets (when a channel is in overwrite mode).
The reporting is detailled on a per-channel basis in the "lttng list" command
(and associated API calls) at runtime. On lttng stop/destroy, a warning is now
displayed to the user if events/packets were discarded/lost during the session.

The information about the packet lost is extracted from a packet sequence
number now written in each CTF packet and CTF index, allowing the relayd and
the viewers to know when parsing the trace/index that entire packets were lost
between two data packets.

Finally, a stream_instance_id is now written in each packet, this feature
allows a viewer to link multiple tracefiles belonging to the same channel and
stream. This is particularly useful when dealing with tracefile rotation
because the viewers will now be able to compute the accurate number of
discarded events.

Most of these patches rely on patches in the tracers, so they should be merged
at the same time when the review is over. The tests rely also on a Babeltrace
patch that hides the field packet_seq_num and packet_seq_num_padding from the
text output.

Julien Desfossez (9):
  Move lttng utils count_order function to common utils
  Explicitely stop the session on lttng destroy
  Reference pointers from ust_app_chan to parent structs
  Metadata for instance_id and packet_seq_num
  Extract the lost packets and discarded events counters
  Display discarded and lost events at destroy and stop
  Account the lost packets in snapshot mode
  kernctl commands to extract the stream instance id
  Store the instance id and packet_seq_num in indexes

 include/lttng/channel.h                      |   5 +-
 src/bin/lttng-relayd/main.c                  |  12 +-
 src/bin/lttng-sessiond/buffer-registry.c     |  39 +++++
 src/bin/lttng-sessiond/buffer-registry.h     |   5 +
 src/bin/lttng-sessiond/cmd.c                 |  94 +++++++++++-
 src/bin/lttng-sessiond/consumer.c            | 108 ++++++++++++++
 src/bin/lttng-sessiond/consumer.h            |   4 +
 src/bin/lttng-sessiond/trace-ust.h           |   2 +
 src/bin/lttng-sessiond/ust-app.c             | 130 ++++++++++++++++-
 src/bin/lttng-sessiond/ust-app.h             |  31 ++++
 src/bin/lttng-sessiond/ust-metadata.c        |  51 ++++---
 src/bin/lttng-sessiond/ust-registry.h        |   3 +-
 src/bin/lttng/commands/destroy.c             |   8 ++
 src/bin/lttng/commands/enable_channels.c     |   4 +-
 src/bin/lttng/commands/list.c                |   2 +
 src/bin/lttng/commands/stop.c                |   1 +
 src/bin/lttng/utils.c                        | 198 ++++++--------------------
 src/bin/lttng/utils.h                        |  19 +--
 src/common/config/config-session-abi.h       |   2 +
 src/common/config/config.c                   |   2 +
 src/common/config/session.xsd                |   2 +
 src/common/consumer.c                        |   1 +
 src/common/consumer.h                        |  13 ++
 src/common/index/ctf-index.h                 |   7 +-
 src/common/kernel-consumer/kernel-consumer.c | 151 +++++++++++++++++++-
 src/common/kernel-ctl/kernel-ctl.c           |  12 ++
 src/common/kernel-ctl/kernel-ctl.h           |   2 +
 src/common/kernel-ctl/kernel-ioctl.h         |   4 +
 src/common/mi-lttng.c                        |  16 +++
 src/common/mi_lttng.xsd                      |   2 +
 src/common/relayd/relayd.c                   |   5 +
 src/common/sessiond-comm/relayd.h            |   2 +
 src/common/sessiond-comm/sessiond-comm.h     |   8 ++
 src/common/ust-consumer/ust-consumer.c       | 204 ++++++++++++++++++++++++++-
 src/common/ust-consumer/ust-consumer.h       |   7 +
 src/common/utils.c                           |  89 ++++++++++++
 src/common/utils.h                           |   2 +
 37 files changed, 1044 insertions(+), 203 deletions(-)

-- 
1.9.1
