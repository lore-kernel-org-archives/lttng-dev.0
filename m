From: Zifei Tong <soariez@gmail.com>
Subject: [PATCH lttng-tools] Add libuuid as dependency in README
Date: Mon, 25 Nov 2013 20:40:41 +0800
Message-ID: <1385383241-19484-1-git-send-email-soariez__16107.6164491989$1385383322$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VkvTb-0006sz-Qe
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 07:41:20 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so5577121pbc.25
	for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2013 04:41:13 -0800 (PST)
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

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 README | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/README b/README
index e38602d..3b5ae2e 100644
--- a/README
+++ b/README
@@ -31,6 +31,11 @@ REQUIREMENTS:
 
       * Debian/Ubuntu package: libpopt-dev
 
+    - libuuid
+      Universally unique id library
+
+      * Debian/Ubuntu package: uuid-dev
+
     - Perl (optional)
       Needed for make check and tests.
 
-- 
1.8.4.2
