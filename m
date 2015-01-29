From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: [lttng-tools 2.5] [Backport]Missing include for out of
	tree build
Date: Thu, 29 Jan 2015 17:51:36 -0500
Message-ID: <54CAB978.5060407__13300.9377787404$1422571949$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1YGxw9-0007Ef-Cl
 for lttng-dev@lists.lttng.org; Thu, 29 Jan 2015 17:51:47 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hey,

While making sure we support out of tree build for lttng-tools 
master/stable-2.6/stable-2.5 I found that 2.5 was failing at oot build.  
After some digging, it looks like a patch submitted to fix this problem 
was not backported to 2.5.

The commit in question currently in master and 2.6 branch :

commit 4900d3cd9c4accc131a6a79986151cf3e6236031
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Jul 29 18:10:27 2014 -0400

     Fix: out of tree build by adding missing ini.c include

     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
     Signed-off-by: David Goulet <dgoulet@efficios.com>

diff --git a/src/common/config/ini.c b/src/common/config/ini.c
index 4369a32..7b2a4b6 100644
--- a/src/common/config/ini.c
+++ b/src/common/config/ini.c
@@ -31,9 +31,11 @@
   * http://code.google.com/p/inih/
   */

+#define _GNU_SOURCE
  #include <stdio.h>
  #include <ctype.h>
  #include <string.h>
+#include <common/common.h>

  #include "ini.h"

Cheers!

-- 
Jonathan R. Julien
Efficios
