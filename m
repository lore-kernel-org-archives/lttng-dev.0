From: jderehag@hotmail.com
Subject: [PATCH lttng-ust] Fix: Corrected python version
	assumptions in lttng-gen-tp
Date: Mon, 24 Mar 2014 15:29:44 +0100
Message-ID: <1395671384-24750-1-git-send-email-jderehag__40186.5250700668$1395681073$gmane$org@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jderehag@gmail.com>) id 1WS5tP-00034q-7R
	for lttng-dev@lists.lttng.org; Mon, 24 Mar 2014 10:30:29 -0400
Received: by mail-lb0-f195.google.com with SMTP id w7so1064199lbi.10
	for <lttng-dev@lists.lttng.org>; Mon, 24 Mar 2014 07:30:14 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Jesper Derehag <jderehag@hotmail.com>
List-Id: lttng-dev@lists.lttng.org

From: Jesper Derehag <jderehag@hotmail.com>

This modification calls the interpreter through env instead of
directly, which should be more portable for those distros which do not install
python into /usr/bin/.

Also, since lttng-gen-tp is not python2 compatible, I changed it to strictly
call python3 which is the recommended way.
See PEP 394.
http://legacy.python.org/dev/peps/pep-0394/
---
 tools/lttng-gen-tp |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
index c49e8a5..c7bf295 100755
--- a/tools/lttng-gen-tp
+++ b/tools/lttng-gen-tp
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Copyright (c)  2012 Yannick Brosseau <yannick.brosseau@gmail.com>
 #
-- 
1.7.9.5
