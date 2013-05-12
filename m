From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [PATCH] Fix (another) linker library order
Date: Sat, 11 May 2013 20:44:39 -0400
Message-ID: <1368319479-7433-1-git-send-email-francis.giraldeau__35676.3362804942$1368319549$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UbKPf-0005im-7N
	for lttng-dev@lists.lttng.org; Sat, 11 May 2013 20:45:19 -0400
Received: by mail-qa0-f41.google.com with SMTP id bv4so888724qab.7
	for <lttng-dev@lists.lttng.org>; Sat, 11 May 2013 17:45:13 -0700 (PDT)
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
 doc/examples/hello-static-lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/examples/hello-static-lib/Makefile b/doc/examples/hello-static-lib/Makefile
index a5bf2df..dd246f7 100644
--- a/doc/examples/hello-static-lib/Makefile
+++ b/doc/examples/hello-static-lib/Makefile
@@ -46,7 +46,7 @@ hello.o: hello.c
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
 
 hello: hello.o lttng-ust-provider-hello.a
-	$(CC) -o $@ $(LDFLAGS) $(LIBS) $^
+	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
 
 .PHONY: clean
 clean:
-- 
1.8.1.2
