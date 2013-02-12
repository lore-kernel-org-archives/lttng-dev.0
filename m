From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH urcu] Fix configure checks for Tile
Date: Mon, 11 Feb 2013 19:04:11 -0500
Message-ID: <1360627451-11698-1-git-send-email-simon.marchi__13386.1087648713$1360627570$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1U53M6-0006Xy-9R
	for lttng-dev@lists.lttng.org; Mon, 11 Feb 2013 19:04:14 -0500
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

The previous method of checking whether the architecture is TileGx or
not was buggy. urcu/arch/tile.h included urcu/arch/gcc.h, which was not
installed on the system, causing a configure error. I am not sure why it
worked when I tested commit 1000f1f4204e5fbb337f4ea911f1e29f67df79aa,
maybe some previous partial install or something.

The check is now done earlier, during the configure step and should not
cause any trouble.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 configure.ac        |   17 ++++++++++++++++-
 urcu/arch/tile.h    |   30 ------------------------------
 urcu/uatomic/tile.h |   28 ----------------------------
 3 files changed, 16 insertions(+), 59 deletions(-)
 delete mode 100644 urcu/arch/tile.h
 delete mode 100644 urcu/uatomic/tile.h

diff --git a/configure.ac b/configure.ac
index d064a13..7a315e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,7 +77,7 @@ AS_CASE([$host_cpu],
 	[ia64], [ARCHTYPE="gcc"],
 	[arm*], [ARCHTYPE="arm"],
 	[mips*], [ARCHTYPE="mips"],
-	[tile*], [ARCHTYPE="tile"],
+	[tile*], [ARCHTYPE="gcc"],
 	[ARCHTYPE="unknown"]
 )
 
@@ -113,6 +113,21 @@ AS_IF([test "x$ARCHTYPE" = "xarm"],[
 	])
 ])
 
+# Tile-specific checks
+AS_IF([echo "$host_cpu" | grep "^tile"],[
+	AC_MSG_CHECKING([for Tile architecture type])
+	AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
+				#ifndef __tilegx__
+				#error
+				#endif
+		]])
+	],[
+		AC_MSG_RESULT([ok])
+	],[
+		AC_MSG_FAILURE([URCU has only been tested on the TileGx architecture. For other Tile* architectures, please run the tests first and report the results to the maintainer so that proper support can be added.])
+	])
+])
+
 # x86-specific checks
 AS_IF([test "x$ARCHTYPE" = "xx86"],[
 	AC_MSG_CHECKING([if architecture really supports the mfence instruction])
diff --git a/urcu/arch/tile.h b/urcu/arch/tile.h
deleted file mode 100644
index 8ef35da..0000000
--- a/urcu/arch/tile.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef _URCU_ARCH_TILE_H
-#define _URCU_ARCH_TILE_H
-
-/*
- * arch_tile.h: trivial definitions for the Tile architecture
- *
- * Copyright (c) 2013 Simon Marchi <simon.marchi@polymtl.ca>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#ifdef __tilegx__
-#include <urcu/arch/gcc.h>
-#else
-#error "URCU has only been tested on the TileGx architecture. For other Tile* architectures, please run the tests first and report the results to the maintainer so that proper support can be added."
-#endif
-
-#endif /* _URCU_ARCH_TILE_H */
diff --git a/urcu/uatomic/tile.h b/urcu/uatomic/tile.h
deleted file mode 100644
index 40eafd1..0000000
--- a/urcu/uatomic/tile.h
+++ /dev/null
@@ -1,28 +0,0 @@
-#ifndef _URCU_ARCH_UATOMIC_TILE_H
-#define _URCU_ARCH_UATOMIC_TILE_H
-
-/*
- * Copyright (c) 2013 Simon Marchi <simon.marchi@polymtl.ca>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#ifdef __tilegx__
-#include <urcu/uatomic/gcc.h>
-#else
-#error "URCU has only been tested on the TileGx architecture. For other Tile* architectures, please run the tests first and report the results to the maintainer so that proper support can be added."
-#endif
-
-#endif /* _URCU_ARCH_UATOMIC_TILE_H */
-- 
1.7.1
