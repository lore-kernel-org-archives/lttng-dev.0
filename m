From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH v2 urcu] Add compilation support for the TileGX
	architecture
Date: Thu, 24 Jan 2013 13:42:02 -0500
Message-ID: <1359052922-24335-1-git-send-email-simon.marchi__2493.41788371584$1359052971$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TyRkU-0006u2-Mu
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 13:42:06 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

This patch adds compilation support for the TileGx architecture. Since
the tests were not ran on other architectures of the Tile family
(Tile64, TIlepro), errors are triggered during compilation if the
architecture is another Tile arch.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 configure.ac        |    1 +
 urcu/arch/tile.h    |   30 ++++++++++++++++++++++++++++++
 urcu/uatomic/tile.h |   28 ++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 urcu/arch/tile.h
 create mode 100644 urcu/uatomic/tile.h

diff --git a/configure.ac b/configure.ac
index 1d04062..d064a13 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,6 +77,7 @@ AS_CASE([$host_cpu],
 	[ia64], [ARCHTYPE="gcc"],
 	[arm*], [ARCHTYPE="arm"],
 	[mips*], [ARCHTYPE="mips"],
+	[tile*], [ARCHTYPE="tile"],
 	[ARCHTYPE="unknown"]
 )
 
diff --git a/urcu/arch/tile.h b/urcu/arch/tile.h
new file mode 100644
index 0000000..f1283af
--- /dev/null
+++ b/urcu/arch/tile.h
@@ -0,0 +1,30 @@
+#ifndef _URCU_ARCH_TILE_H
+#define _URCU_ARCH_TILE_H
+
+/*
+ * arch_tile.h: trivial definitions for the Tile architecture
+ *
+ * Copyright (c) 2013 Simon Marchi <simon.marchi@polymtl.ca>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifdef __tilegx__
+#include <urcu/arch/gcc.h>
+#else
+#error "URCU has only been tested on the TileGx architecture. For other Tile* architectures, please run the tests first and report the results to the maintainer so that proper support can be added."
+#endif
+
+#endif /* _URCU_ARCH_TILE_H */
diff --git a/urcu/uatomic/tile.h b/urcu/uatomic/tile.h
new file mode 100644
index 0000000..b15f885
--- /dev/null
+++ b/urcu/uatomic/tile.h
@@ -0,0 +1,28 @@
+#ifndef _URCU_ARCH_UATOMIC_TILE_H
+#define _URCU_ARCH_UATOMIC_TILE_H
+
+/*
+ * Copyright (c) 2013 Simon Marchi <simon.marchi@polymtl.ca>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifdef __tilegx__
+#include <urcu/uatomic/gcc.h>
+#else
+#error "URCU has only been tested on the TileGx architecture. For other Tile* architectures, please run the tests first and report the results to the maintainer so that proper support can be added."
+#endif
+
+#endif /* _URCU_ARCH_UATOMIC_TILE_H */
-- 
1.7.1
