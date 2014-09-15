From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [PATCH lttng-tools] Fix: ignore error when loading
	optional kmod
Date: Mon, 15 Sep 2014 13:43:56 -0400
Message-ID: <1410803036-28529-1-git-send-email-eeppeliteloop__13614.3199088567$1410803109$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XTaJr-0004OV-RZ
 for lttng-dev@lists.lttng.org; Mon, 15 Sep 2014 13:44:13 -0400
Received: by mail-qa0-f43.google.com with SMTP id x12so4123233qac.16
 for <lttng-dev@lists.lttng.org>; Mon, 15 Sep 2014 10:43:56 -0700 (PDT)
Received: from archeepp.localdomain ([107.171.236.116])
 by mx.google.com with ESMTPSA id b33sm9973945qgb.9.2014.09.15.10.43.52
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Sep 2014 10:43:52 -0700 (PDT)
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
 src/bin/lttng-sessiond/modprobe.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 968b265..5c2bb05 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -205,8 +205,16 @@ static int modprobe_lttng(struct kern_modules_param *modules,
 
 		ret = kmod_module_probe_insert_module(mod, KMOD_PROBE_IGNORE_LOADED,
 				NULL, NULL, NULL, NULL);
-		if (required && ret < 0) {
-			ERR("Unable to load module %s", modules[i].name);
+		if (ret < 0) {
+			if (required) {
+				ERR("Unable to load required module %s",
+						modules[i].name);
+				goto error;
+			} else {
+				DBG("Unable to load optional module %s; continuing",
+						modules[i].name);
+				ret = 0;
+			}
 		} else {
 			DBG("Modprobe successfully %s", modules[i].name);
 		}
@@ -241,10 +249,25 @@ static int modprobe_lttng(struct kern_modules_param *modules,
 		modprobe[sizeof(modprobe) - 1] = '\0';
 		ret = system(modprobe);
 		if (ret == -1) {
-			ERR("Unable to launch modprobe for module %s",
-					modules[i].name);
-		} else if (required && WEXITSTATUS(ret) != 0) {
-			ERR("Unable to load module %s", modules[i].name);
+			if (required) {
+				ERR("Unable to launch modprobe for required module %s",
+						modules[i].name);
+				goto error;
+			} else {
+				DBG("Unable to launch modprobe for optional module %s; continuing",
+						modules[i].name);
+				ret = 0;
+			}
+		} else if (WEXITSTATUS(ret) != 0) {
+			if (required) {
+				ERR("Unable to load required module %s",
+						modules[i].name);
+				goto error;
+			} else {
+				DBG("Unable to load optional module %s; continuing",
+						modules[i].name);
+				ret = 0;
+			}
 		} else {
 			DBG("Modprobe successfully %s", modules[i].name);
 		}
-- 
2.1.0
