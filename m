From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace] Build: add version check on autoconf
Date: Thu,  2 Jul 2015 15:50:20 -0400
Message-ID: <1435866620-959-1-git-send-email-jonathan.rajotte-julien__40046.6183586561$1435866686$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZAkVG-0005nc-ST
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 15:50:39 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index f8d43d8..afd6db5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,6 +1,7 @@
 #                                               -*- Autoconf -*-
 # Process this file with autoconf to produce a configure script.
 
+AC_PREREQ([2.50])
 AC_INIT([babeltrace],[1.3.0-pre],[jeremie dot galarneau at efficios dot com])
 
 # Following the numbering scheme proposed by libtool for the library version
-- 
2.1.4
