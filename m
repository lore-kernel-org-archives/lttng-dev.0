From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [Babeltrace] [GIT PULL][master] packet_seq_num and
 stream intersection
Date: Mon, 21 Sep 2015 16:46:44 -0400
Message-ID: <56006CB4.9010708__41316.5275044323$1442868494$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1Ze7z9-0002rr-GN
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 16:47:00 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

These commits were originally targeted for the stable1.2 branch. They
are now rebased on master with all the tests and ready for inclusion.

https://github.com/jdesfossez/babeltrace-dev/tree/merge_seqnum_intersect
991d86f Test the packet intersection feature
a23c294 Option to only show packets intersection
b28e2c6 Tests for packet_seq_num handling
490cf2b Output a warning if packets are lost
3fa502b Support ctf index version 1.1

Thanks,

Julien
