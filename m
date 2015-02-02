From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 4/4] configure: add type
	availability checking
Date: Mon,  2 Feb 2015 16:33:57 -0500
Message-ID: <1422912837-5003-5-git-send-email-jonathan.rajotte-julien__14322.5909131163$1422912951$gmane$org@efficios.com>
References: <1422912837-5003-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YIOdV-0001Uk-HL
 for lttng-dev@lists.lttng.org; Mon, 02 Feb 2015 16:34:26 -0500
In-Reply-To: <1422912837-5003-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Based on autoscan diagnostic

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/configure.ac b/configure.ac
index 8871889..5f54e48 100644
--- a/configure.ac
+++ b/configure.ac
@@ -420,6 +420,20 @@ AC_SYS_LARGEFILE
 AC_PROG_CC
 AC_C_INLINE
 
+# Type availability checking
+AC_TYPE_INT32_T
+AC_TYPE_INT64_T
+AC_TYPE_MODE_T
+AC_TYPE_OFF_T
+AC_TYPE_PID_T
+AC_TYPE_SIZE_T
+AC_TYPE_SSIZE_T
+AC_TYPE_UID_T
+AC_TYPE_UINT16_T
+AC_TYPE_UINT32_T
+AC_TYPE_UINT64_T
+AC_TYPE_UINT8_T
+
 LT_INIT
 AC_PROG_YACC
 AC_PROG_LEX
-- 
1.9.1
