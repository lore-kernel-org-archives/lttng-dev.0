From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/3] Build: look for python >= 3.0
	when building python bindings
Date: Thu,  6 Aug 2015 19:00:15 -0400
Message-ID: <1438902016-17511-2-git-send-email-jonathan.rajotte-julien__36617.2669957907$1438902094$gmane$org@efficios.com>
References: <1438902016-17511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZNU9N-0007iQ-VK
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 19:00:42 -0400
In-Reply-To: <1438902016-17511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 312b9f7..324b596 100644
--- a/configure.ac
+++ b/configure.ac
@@ -339,7 +339,7 @@ AM_CONDITIONAL([PYTHON_BINDING], [test "x${enable_python_binding:-yes}" = xyes])
 
 if test "x${enable_python_binding:-yes}" = xyes; then
   AX_PKG_SWIG($swig_version, [], [ AC_MSG_ERROR([SWIG $swig_version or newer is needed]) ])
-  AM_PATH_PYTHON
+  AM_PATH_PYTHON([3.0])
 
   AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing python-config])
   AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])
-- 
2.1.4
