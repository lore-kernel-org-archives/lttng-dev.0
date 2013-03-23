From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace] Replace AM_PROG_MKDIR obsolete macro
	with AC_PROG_MKDIR_P
Date: Sat, 23 Mar 2013 14:47:55 -0400
Message-ID: <1364064475-24015-1-git-send-email-christian.babeux__6982.98184802315$1364064557$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UJTUM-0003io-8j
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 14:48:22 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so1682296ieb.22
	for <lttng-dev@lists.lttng.org>; Sat, 23 Mar 2013 11:48:16 -0700 (PDT)
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

The bootstrap script is complaining with a deprecation warning [1] for
the AM_PROG_MKDIR_P Automake macro.

Relevant bootstrap output:

configure.ac:13: warning: The 'AM_PROG_MKDIR_P' macro is deprecated,
		 and will soon be removed.
configure.ac:13: You should use the Autoconf-provided 'AC_PROG_MKDIR_P'
		 macro instead,
configure.ac:13: and use '$(MKDIR_P)' instead of '$(mkdir_p)'in your
		 Makefile.am files.

Fix this by updating configure.ac with the proposed AC_PROG_MKDIR_P macro.

[1] - https://www.gnu.org/software/automake/manual/html_node/Obsolete-Macros.html

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b96e09f..cc23f5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -10,7 +10,7 @@ m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
 AC_CONFIG_MACRO_DIR([m4])
 
-AM_PROG_MKDIR_P
+AC_PROG_MKDIR_P
 
 AC_CONFIG_HEADERS([config.h])
 
-- 
1.8.2
