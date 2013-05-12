From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [PATCH] Fix linker library order
Date: Sat, 11 May 2013 20:25:33 -0400
Message-ID: <1368318333-31522-1-git-send-email-francis.giraldeau__25673.9945420579$1368318412$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UbK79-0005Ym-Qw
	for lttng-dev@lists.lttng.org; Sat, 11 May 2013 20:26:11 -0400
Received: by mail-qc0-f179.google.com with SMTP id d1so2865455qcz.10
	for <lttng-dev@lists.lttng.org>; Sat, 11 May 2013 17:26:06 -0700 (PDT)
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

Libraries must be specified after the binary target.

Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
---
 doc/examples/demo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
index 7ae6547..bbc8ccb 100644
--- a/doc/examples/demo/Makefile
+++ b/doc/examples/demo/Makefile
@@ -55,7 +55,7 @@ demo.o: demo.c
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
 
 demo: demo.o
-	$(CC) -o $@ $(LIBS) $^
+	$(CC) -o $@ $^ $(LIBS)
 
 .PHONY: clean
 clean:
-- 
1.8.1.2
