From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Add optional Perl dependency
	requirement to README
Date: Fri, 22 Mar 2013 15:49:19 -0400
Message-ID: <1363981759-4718-1-git-send-email-christian.babeux__42619.5252723575$1363981848$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UJ7yR-0001Lo-LY
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 15:49:59 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so3901733iaz.30
	for <lttng-dev@lists.lttng.org>; Fri, 22 Mar 2013 12:49:54 -0700 (PDT)
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


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 README | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README b/README
index 4ef88cb..cfbf1ac 100644
--- a/README
+++ b/README
@@ -28,6 +28,9 @@ REQUIREMENTS:
 
       * Debian/Ubuntu package: libpopt-dev
 
+    - Perl (optional)
+      Needed for make check and tests.
+
     - SWIG >= 2.0 (optional)
       Needed for Python bindings (--enable-python-bindings).
 
-- 
1.8.2
