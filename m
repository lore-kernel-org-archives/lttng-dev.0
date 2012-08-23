From: Hui Zhu <teawater@gmail.com>
Subject: [PATCH] Fix trace-collection.h: No such file or
 directory that build code with libbabeltrace
Date: Thu, 23 Aug 2012 14:11:54 +0800
Message-ID: <CANFwon3m1K3KRobkOk-4FSAaoFk8u1ixqVmtB284k-hVRGUXtQ__44586.4780144349$1345702386$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1T4Qen-0006kC-0Q
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 02:12:41 -0400
Received: by vcbfl11 with SMTP id fl11so546523vcb.35
	for <lttng-dev@lists.lttng.org>; Wed, 22 Aug 2012 23:12:35 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

After I install the babeltrace and try to build a code, I got this:
gcc -Wall  -g 1.c -lbabeltrace -lbabeltrace-ctf
In file included from 1.c:11:0:
/usr/local/include/babeltrace/babeltrace.h:23:41: fatal error:
babeltrace/trace-collection.h: No such file or directory
compilation terminated.

I check the code,looks most of function of trace-collection.h is
covered by context.h.

So I post a patch for it.  Wish you like it.

Thanks,
Hui

--- a/include/babeltrace/babeltrace.h
+++ b/include/babeltrace/babeltrace.h
@@ -20,7 +20,6 @@
 #include <babeltrace/context.h>
 #include <babeltrace/format.h>
 #include <babeltrace/iterator.h>
-#include <babeltrace/trace-collection.h>
 #include <babeltrace/trace-handle.h>

 #endif /* _BABELTRACE_H */
