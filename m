From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] pprint.m4: add missing copyright
 header
Date: Thu,  8 Aug 2019 10:49:23 -0400
Message-ID: <20190808144923.2417-1-mathieu.desnoyers__26078.4455853113$1565275782$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 464B934Cqjz1MY2
 for <lttng-dev@lists.lttng.org>; Thu,  8 Aug 2019 10:49:27 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Philippe Proulx <pproulx@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Add the missing copyright header to pprint.m4, clarifying that it is
GPLv2+ with the special exception applying to Autoconf Macros.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Philippe Proulx <pproulx@efficios.com>
---
 m4/pprint.m4 | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/m4/pprint.m4 b/m4/pprint.m4
index a7cfd94c..a18a2ac6 100644
--- a/m4/pprint.m4
+++ b/m4/pprint.m4
@@ -1,6 +1,36 @@
-# Pretty printing macros.
+# DESCRIPTION
 #
-# Author: Philippe Proulx <pproulx@efficios.com>
+#   Pretty printing macros.
+#
+# LICENSE
+#
+#   Copyright (c) 2016 Philippe Proulx <pproulx@efficios.com>
+#
+#   This program is free software; you can redistribute it and/or modify it
+#   under the terms of the GNU General Public License as published by the
+#   Free Software Foundation; either version 2 of the License, or (at your
+#   option) any later version.
+#
+#   This program is distributed in the hope that it will be useful, but
+#   WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+#   Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License along
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
+#
+#   As a special exception, the respective Autoconf Macro's copyright owner
+#   gives unlimited permission to copy, distribute and modify the configure
+#   scripts that are the output of Autoconf when processing the Macro. You
+#   need not follow the terms of the GNU General Public License when using
+#   or distributing such scripts, even though portions of the text of the
+#   Macro appear in them. The GNU General Public License (GPL) does govern
+#   all other use of the material that constitutes the Autoconf Macro.
+#
+#   This special exception to the GPL applies to versions of the Autoconf
+#   Macro released by the Autoconf Archive. When you make and distribute a
+#   modified version of the Autoconf Macro, you may extend this special
+#   exception to the GPL to apply to your modified version as well.
 
 #serial 1
 
-- 
2.11.0
