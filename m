From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 13/24] Add : Compatibility layer for
	un.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-14-git-send-email-c.briere__24779.051091946$1414443527$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEX-0007nm-Mn
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:46 -0400
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4003LMF6KW130@usmailout3.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:32 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 src/common/compat/un.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 src/common/compat/un.h

diff --git a/src/common/compat/un.h b/src/common/compat/un.h
new file mode 100644
index 0000000..6c5479d
--- /dev/null
+++ b/src/common/compat/un.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2014 - Charles Briere <c.briere@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _COMPAT_UN_H
+#define _COMPAT_UN_H
+
+# ifdef __ANDROID__
+
+#include <sys/_types.h>
+
+#define UNIX_PATH_MAX 108
+
+struct sockaddr_un {
+	__sa_family_t sun_family;
+	char sun_path[UNIX_PATH_MAX];
+};
+# else /* __ANDROID__ */
+
+#include <sys/un.h>
+
+# endif
+
+#endif /* _COMPAT_UN_H */
-- 
2.1.2
