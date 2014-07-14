From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 2/2] Revert "Turn base address dump
	into experimental feature"
Date: Mon, 14 Jul 2014 10:38:25 +0200
Message-ID: <1405327105-20507-3-git-send-email-paul_woegerer__40099.2501680323$1405327207$gmane$org@mentor.com>
References: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X6bml-0003Lz-9I
 for lttng-dev@lists.lttng.org; Mon, 14 Jul 2014 04:39:00 -0400
In-Reply-To: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

This reverts commit b11abb674e50c67e3410ab2bd5d0a263e88b73ba.

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 doc/man/lttng-ust.3            | 10 +++-------
 liblttng-ust/lttng-ust-baddr.c |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
index c72bd32..117fe98 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -397,13 +397,9 @@ Pthread identifier. Can be used on architectures where pthread_t maps
 nicely to an unsigned long type.
 .PP
 
-.SH "BASE ADDRESS STATEDUMP (Experimental feature)"
+.SH "BASE ADDRESS STATEDUMP"
 
 .PP
-Warning: This is an experimental feature known to cause deadlocks when the
-traced application uses fork, clone or daemon. Only use it for debugging and
-testing.  Do NOT use it in production.
-
 If an application that uses liblttng-ust.so becomes part of a session,
 information about its currently loaded shared objects will be traced to the
 session at session-enable time. To record this information, the following event
@@ -440,8 +436,8 @@ specified in milliseconds. The value 0 means "don't wait". The value
 recommended for applications with time constraints on the process
 startup time.
 .PP
-.IP "LTTNG_UST_WITH_EXPERIMENTAL_BADDR_STATEDUMP"
-Experimentally allow liblttng-ust to perform a base-address statedump on session-enable.
+.IP "LTTNG_UST_WITHOUT_BADDR_STATEDUMP"
+Prevent liblttng-ust to perform a base-address statedump on session-enable.
 .PP
 
 .SH "SEE ALSO"
diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
index dec7e82..922899b 100644
--- a/liblttng-ust/lttng-ust-baddr.c
+++ b/liblttng-ust/lttng-ust-baddr.c
@@ -176,7 +176,7 @@ int lttng_ust_baddr_statedump(void *owner)
 {
 	struct extract_data data;
 
-	if (!getenv("LTTNG_UST_WITH_EXPERIMENTAL_BADDR_STATEDUMP"))
+	if (getenv("LTTNG_UST_WITHOUT_BADDR_STATEDUMP"))
 		return 0;
 
 	data.owner = owner;
-- 
2.0.1
