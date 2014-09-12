From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [PATCH lttng-tools] Fix: ignore libkmod ret. value with
	optional kmod
Date: Fri, 12 Sep 2014 19:39:03 -0400
Message-ID: <1410565143-10236-1-git-send-email-eeppeliteloop__29886.0260671519$1410565188$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XSaQk-0000VV-L1
 for lttng-dev@lists.lttng.org; Fri, 12 Sep 2014 19:39:07 -0400
Received: by mail-yk0-f176.google.com with SMTP id 131so816260ykp.21
 for <lttng-dev@lists.lttng.org>; Fri, 12 Sep 2014 16:39:00 -0700 (PDT)
Received: from archeepp.internal.efficios.com ([96.127.217.202])
 by mx.google.com with ESMTPSA id 9sm2142165yho.6.2014.09.12.16.38.59
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Sep 2014 16:38:59 -0700 (PDT)
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

This commit also improves the accuracy of debug messages:
a module is not "successfully" loaded when it's optional
and actually not loaded.

Fixes: #837

Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 src/bin/lttng-sessiond/modprobe.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 968b265..adad7bf 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -205,8 +205,14 @@ static int modprobe_lttng(struct kern_modules_param *modules,
 
 		ret = kmod_module_probe_insert_module(mod, KMOD_PROBE_IGNORE_LOADED,
 				NULL, NULL, NULL, NULL);
-		if (required && ret < 0) {
-			ERR("Unable to load module %s", modules[i].name);
+		if (ret < 0) {
+			if (required) {
+				ERR("Unable to load required module %s", modules[i].name);
+				return ret;
+			} else {
+				DBG("Unable to load optional module %s; continuing", modules[i].name);
+				ret = 0;
+			}
 		} else {
 			DBG("Modprobe successfully %s", modules[i].name);
 		}
-- 
2.1.0
