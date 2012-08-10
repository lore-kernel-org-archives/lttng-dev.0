From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 0/2] relayd IPv6 fixes
Date: Fri, 10 Aug 2012 13:22:50 -0400
Message-ID: <1344619372-21976-1-git-send-email-christian.babeux__24992.1252871447$1344619433$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Szsvd-0006i0-JQ
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 13:23:17 -0400
Received: by ghbz10 with SMTP id z10so2138544ghb.35
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 10:23:12 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

Here are a few fixes to IPv6 support in relayd.

When trying to start the relayd using an IPv6 address, the relayd
simply segfaulted. The first patch fix this issue. 

The second patch fix a wrong domain value used in the socket()
call for the IPv6 socket causing a "Address family not supported 
by protocol" error when calling bind().

Thanks,

Christian

Christian Babeux (2):
  Fix: Off by one in lttcomm_sock_domain enum
  Fix: Wrong domain used when initializing IPv6 sockets

 src/common/sessiond-comm/inet6.c         | 2 +-
 src/common/sessiond-comm/sessiond-comm.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.11.4
