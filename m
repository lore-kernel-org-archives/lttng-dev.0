From: jderehag@hotmail.com
Subject: [PATCH v2 lttng-ust] Fix: python invocation through env
Date: Thu, 27 Mar 2014 08:57:06 +0100
Message-ID: <1395907026-934-1-git-send-email-jderehag__39182.9575681642$1395907139$gmane$org@hotmail.com>
References: <1396845262.585.1395775224524.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f54.google.com ([209.85.215.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jderehag@gmail.com>) id 1WT5Ca-0000EM-VZ
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 03:58:18 -0400
Received: by mail-la0-f54.google.com with SMTP id mc6so2292166lab.41
	for <lttng-dev@lists.lttng.org>; Thu, 27 Mar 2014 00:58:10 -0700 (PDT)
In-Reply-To: <1396845262.585.1395775224524.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

From: Jesper Derehag <jderehag@hotmail.com>

This modification calls the interpreter through env instead of
directly, which should be more portable for those distros which do not install
python into /usr/bin/.
---
 tools/lttng-gen-tp |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
index c49e8a5..a3a01f2 100755
--- a/tools/lttng-gen-tp
+++ b/tools/lttng-gen-tp
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 #
 # Copyright (c)  2012 Yannick Brosseau <yannick.brosseau@gmail.com>
 #
-- 
1.7.9.5
