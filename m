From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [Babeltrace PATCH] Remove extra -I for python bindings
Date: Fri, 21 Jun 2013 10:49:56 -0400
Message-ID: <1371826196-25578-1-git-send-email-yannick.brosseau__26622.8045140908$1371826249$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Uq2fD-0004dV-Br
	for lttng-dev@lists.lttng.org; Fri, 21 Jun 2013 10:50:11 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so19700202ied.14
	for <lttng-dev@lists.lttng.org>; Fri, 21 Jun 2013 07:50:05 -0700 (PDT)
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

Same fix as for lttng-tools commit f7cbc765ad2526667f1f20b3a89c596b3422ac34

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 bindings/python/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bindings/python/Makefile.am b/bindings/python/Makefile.am
index 536e07f..b25ce92 100644
--- a/bindings/python/Makefile.am
+++ b/bindings/python/Makefile.am
@@ -1,7 +1,7 @@
 babeltrace.i: babeltrace.i.in
 	sed "s/BABELTRACE_VERSION_STR/Babeltrace $(PACKAGE_VERSION)/g" <babeltrace.i.in >babeltrace.i
 
-AM_CFLAGS = -I$(PYTHON_INCLUDE) -I$(top_srcdir)/include/
+AM_CFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/
 
 EXTRA_DIST = babeltrace.i
 python_PYTHON = babeltrace.py
-- 
1.7.10.4
