From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust] Make baddr tracing usable in
	stable-2.4
Date: Mon, 17 Mar 2014 10:22:00 +0100
Message-ID: <1395048121-20770-1-git-send-email-paul_woegerer__44735.438100952$1395048335$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WPTmV-0004QS-Tb
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 05:24:30 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

While this patch cannot entirely prevent the issue described by
http://bugs.lttng.org/issues/745 it greatly reduces the chance for it to
happen. Applying this patch to the stable-2.4 branch makes baddr statedump
tracing now usable in the context of fork/clone/daemon.

Paul Woegerer (1):
  Fix: Make deadlocks with baddr statedump unlikely

 liblttng-ust/lttng-ust-baddr.c | 95 ++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 21 deletions(-)

-- 
1.9.0
