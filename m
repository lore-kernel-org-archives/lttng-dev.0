From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-ust] Fix: Fix self-assign warning on
	struct ustfork_clone_info init
Date: Tue, 23 Oct 2012 15:37:20 -0400
Message-ID: <1351021040-18587-1-git-send-email-christian.babeux__31769.2722579979$1351021084$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TQkI9-0000UH-LM
	for lttng-dev@lists.lttng.org; Tue, 23 Oct 2012 15:37:33 -0400
Received: by mail-ie0-f176.google.com with SMTP id k11so6764727iea.35
	for <lttng-dev@lists.lttng.org>; Tue, 23 Oct 2012 12:37:28 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Use the proper field designator syntax (C99) to initialize the
ustfork_clone_info struct.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 liblttng-ust-fork/ustfork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 liblttng-ust-fork/ustfork.c

diff --git a/liblttng-ust-fork/ustfork.c b/liblttng-ust-fork/ustfork.c
old mode 100644
new mode 100755
index 13f77cf..34f674c
--- a/liblttng-ust-fork/ustfork.c
+++ b/liblttng-ust-fork/ustfork.c
@@ -139,7 +139,7 @@ int clone(int (*fn)(void *), void *child_stack, int flags, void *arg, ...)
 				tls, ctid);
 	} else {
 		/* Creating a real process, we need to intervene. */
-		struct ustfork_clone_info info = { fn = fn, arg = arg };
+		struct ustfork_clone_info info = { .fn = fn, .arg = arg };
 
 		ust_before_fork(&info.sigset);
 		retval = plibc_func(clone_fn, child_stack, flags, &info,
-- 
1.7.12.2
