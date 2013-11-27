From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH liburcu 1/5] configure.ac Android check
Date: Tue, 26 Nov 2013 21:08:18 -0800
Message-ID: <1385528902-4797-1-git-send-email-charlesbriere.flatzo__10588.9837177985$1385529062$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1VlXNa-0002Lk-EK
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 00:09:43 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so9082908pdj.40
	for <lttng-dev@lists.lttng.org>; Tue, 26 Nov 2013 21:09:32 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Set TARGET_IS_ANDROID to true if target
is Android

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index 0aae5fd..a2a0bcd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -82,6 +82,11 @@ AS_CASE([$host_cpu],
 	[ARCHTYPE="unknown"]
 )
 
+AS_CASE([$host],[*-*-linux-androideabi],
+	[AM_CONDITIONAL(TARGET_IS_ANDROID, true)],
+	[AM_CONDITIONAL(TARGET_IS_ANDROID, false)]
+)
+
 AC_SUBST(ARCHTYPE)
 AC_SUBST(SUBARCHTYPE)
 
-- 
1.8.4.2
