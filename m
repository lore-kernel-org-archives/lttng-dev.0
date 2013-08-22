From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [RFC] Add support for CTF trace files
Date: Thu, 22 Aug 2013 17:38:17 -0400
Message-ID: <1377207497-26822-2-git-send-email-eeppeliteloop__11906.3438884497$1377208202$gmane$org@gmail.com>
References: <1377207497-26822-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eeppeliteloop@gmail.com>) id 1VCcae-00083n-T6
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 17:38:50 -0400
Received: by mail-qc0-f169.google.com with SMTP id m15so1349232qcq.28
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 14:38:43 -0700 (PDT)
In-Reply-To: <1377207497-26822-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: file@mx.gw.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

---
 magic/Magdir/ctf  | 18 ++++++++++++++++++
 magic/Makefile.am |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 magic/Magdir/ctf

diff --git a/magic/Magdir/ctf b/magic/Magdir/ctf
new file mode 100644
index 0000000..1848422
--- /dev/null
+++ b/magic/Magdir/ctf
@@ -0,0 +1,18 @@
+
+#--------------------------------------------------------------
+# ctf:  file(1) magic for CTF (Common Trace Format) trace files
+#
+# Specs. available here: <http://www.efficios.com/ctf>
+#--------------------------------------------------------------
+
+# CTF trace data
+0	lelong	0xc1fc1fc1	Common Trace Format (CTF) trace data (LE)
+0	belong	0xc1fc1fc1	Common Trace Format (CTF) trace data (BE)
+
+# CTF metadata
+0	lelong	0x75d11d57	Common Trace Format (CTF) metadata (LE)
+>35	byte	x		\b, v%d
+>36	byte	x		\b.%d
+0	belong	0x75d11d57	Common Trace Format (CTF) metadata (BE)
+>35	byte	x		\b, v%d
+>36	byte	x		\b.%d
diff --git a/magic/Makefile.am b/magic/Makefile.am
index 31b8de2..b83b02b 100644
--- a/magic/Makefile.am
+++ b/magic/Makefile.am
@@ -54,6 +54,7 @@ $(MAGIC_FRAGMENT_DIR)/console \
 $(MAGIC_FRAGMENT_DIR)/convex \
 $(MAGIC_FRAGMENT_DIR)/cracklib \
 $(MAGIC_FRAGMENT_DIR)/ctags \
+$(MAGIC_FRAGMENT_DIR)/ctf \
 $(MAGIC_FRAGMENT_DIR)/cubemap \
 $(MAGIC_FRAGMENT_DIR)/cups \
 $(MAGIC_FRAGMENT_DIR)/dact \
-- 
1.8.3.4
