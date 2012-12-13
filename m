From: Hui Zhu <teawater@gmail.com>
Subject: Question about use libbabeltrace
Date: Thu, 13 Dec 2012 13:54:46 +0800
Message-ID: <CANFwon0LGfGbP=a+OBHQMSKWz=_DYPKoEN=-udAmX6LiTTfCng__27777.054362423$1355378174$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1Tj1ld-0000Ps-MM
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 00:55:33 -0500
Received: by mail-ee0-f48.google.com with SMTP id b57so1006558eek.35
	for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2012 21:55:28 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Hui Zhu <hui_zhu@mentor.com>
List-Id: lttng-dev@lists.lttng.org

Hi guys,

Maybe you had known that I am working on add CTF support to GDB that
use libbabeltrace from my prev mail.

I use libbabeltrace in this patch
http://sourceware.org/ml/gdb-patches/2012-11/msg00717.html

What I check if current machine have libbabeltrace in following way:
+    if test "x$enable_glibtest" = "xyes" ; then
+      ac_save_CFLAGS="$CFLAGS"
+      ac_save_LIBS="$LIBS"
+      CFLAGS="$CFLAGS $GLIB_CFLAGS"
+      LIBS="$LIBS -lbabeltrace -lbabeltrace-ctf"
+      rm -f conf.glibtest
+      if test "$cross_compiling" = yes; then :
+  $as_echo $ac_n "cross compiling; assumed OK... $ac_c"
+else
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+#include <babeltrace/babeltrace.h>
+#include <babeltrace/types.h>
+#include <babeltrace/ctf/events.h>
+#include <babeltrace/ctf/iterator.h>
+
+int
+main ()
+{
+  if (!bt_context_create())
+    return 1;
+  return 0;
+}
+
+_ACEOF
+if ac_fn_c_try_run "$LINENO"; then :
+
+else
+  no_glib=yes
+fi

Just try to build example with -lbabeltrace -lbabeltrace-ctf.

My question is does libbabeltrace have better way to handle it?  For
example: pkg-config

Thanks,
Hui
