From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH ust] Remove LIBFORMAT output in configure.
Date: Wed,  9 Jan 2013 15:28:14 -0500
Message-ID: <1357763294-24232-1-git-send-email-simon.marchi__26600.2582772218$1357763343$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1Tt2G3-0004bH-3L
	for lttng-dev@lists.lttng.org; Wed, 09 Jan 2013 15:28:19 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 configure.ac |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index c4377a5..a67e8f9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -309,7 +309,6 @@ AS_ECHO("$version_description")
 # Report on the configuration options
 AS_ECHO()
 AS_ECHO("LTTng-UST will be built with the following options:")
-AS_ECHO("Library format: $LIBFORMAT")
 
 AS_ECHO()
 AS_ECHO_N("Java support (JNI): ")
-- 
1.7.1
