From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2] Test: prevent the spawning of a
	daemonized sessiond
Date: Tue,  8 Mar 2016 17:37:39 -0500
Message-ID: <1457476659-19530-1-git-send-email-jonathan.rajotte-julien__11215.7115866014$1457476740$gmane$org@efficios.com>
References: <495428957.19719.1457475555452.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1adQGN-0003Ux-TW
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 17:38:01 -0500
In-Reply-To: <495428957.19719.1457475555452.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Sets the default lttng-sessiond path to /bin/true to prevent the spawning
of a daemonized sessiond. This is necessary since 'lttng create' will spawn
its own sessiond if none is running. It also make sure that 'lttng create'
fails when no sessiond is running.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/utils/utils.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index da23f7a..0d5c33e 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -33,6 +33,12 @@ KERNEL_PATCHLEVEL_VERSION=27
 # systems. Specialized tests should test those corner-cases.
 export LTTNG_UST_REGISTER_TIMEOUT=-1
 
+# We set the default lttng-sessiond path to /bin/true to prevent the spawning
+# of a daemonized sessiond. This is necessary since 'lttng create' will spawn
+# its own sessiond if none is running. It also make sure that 'lttng create'
+# fails when no sessiond is running.
+export LTTNG_SESSIOND_PATH="/bin/true"
+
 source $TESTDIR/utils/tap/tap.sh
 
 function print_ok ()
-- 
2.7.0
