From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust v2] Multisession compatible fix for
	statedump with JUL tracing
Date: Fri, 29 Nov 2013 14:32:53 +0100
Message-ID: <1385731974-12135-1-git-send-email-paul_woegerer__28753.7768054337$1385732062$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VmOC8-00021r-PN
	for lttng-dev@lists.lttng.org; Fri, 29 Nov 2013 08:33:23 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Unfortunately, the first version of the deadlock fix broke the multi-session
usecase as a side effect.  This revised version works fine even for
multi-session scenarios.

I used the following bash-script for verification:

#!/bin/bash
function session_start {
	lttng create $1
	local SARG="-s $1"
	lttng enable-event -j -a $SARG
	lttng enable-channel -u test $SARG
	lttng enable-event -u -a -c test $SARG
	lttng start $1
}
function session_stop {
	lttng stop $1
}
function session_destroy {
	lttng destroy $1
}

session_start s1
session_start s2
session_start s3
(sleep 6 && session_start a1)&
(sleep 12 && session_start a2)&
(sleep 18 && session_start a3)&

./run

session_stop s1
session_stop s2
session_stop s3
session_stop a1
session_stop a2
session_stop a3

# start a new bash session to allow browsing the results (e.g. lttng view a1, ...)
# exit that session to do the cleanup.
PS1="(browse results) " bash -i

session_destroy s1
session_destroy s2
session_destroy s3
session_destroy a1
session_destroy a2
session_destroy a3
# script-end

Paul Woegerer (1):
  Fix: baddr_statedump deadlock with JUL tracing

 include/lttng/ust-events.h       |  6 ++++++
 liblttng-ust/lttng-events.c      | 19 ++++++++++++++++++-
 liblttng-ust/lttng-tracer-core.h |  3 +--
 liblttng-ust/lttng-ust-comm.c    | 30 +++++++++++++++++-------------
 4 files changed, 42 insertions(+), 16 deletions(-)

-- 
1.8.4
