From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: [PATCH lttng-ust] Add trace instrumentation for some
	pthread functions.
Date: Wed, 31 Jul 2013 16:41:44 -0400
Message-ID: <51F97688.30704__34137.9000143663$1375303375$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080303060403070107020401"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V4dDU-0006c8-GI
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 16:41:58 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1V4dDO-0002re-2n from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 13:41:46 -0700
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------080303060403070107020401
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

The attached patch introduces a pthread wrapper library with initial
instrumentation for pthread_mutex_lock, pthread_mutex_trylock, and
pthread_mutex_unlock.
New tracepoints are introduced for each of those. For the lock function,
two distinct tracepoints are emitted: one before the lock is requested,
another after it has been acquired.

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/

--------------080303060403070107020401
Content-Type: text/x-patch; name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

From 38021db8d2b466856050ed5cdcedb997b0e6aff2 Mon Sep 17 00:00:00 2001
From: Stefan Seefeld <stefan_seefeld@mentor.com>
Date: Wed, 31 Jul 2013 16:35:31 -0400
Subject: [PATCH] Add tracing instrumentation for pthread mutex lock functions.

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 liblttng-ust-libc-wrapper/Makefile.am   |  12 +++-
 liblttng-ust-libc-wrapper/pthread.c     | 106 ++++++++++++++++++++++++++++++++
 liblttng-ust-libc-wrapper/ust_pthread.h |  76 +++++++++++++++++++++++
 3 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 liblttng-ust-libc-wrapper/pthread.c
 create mode 100644 liblttng-ust-libc-wrapper/ust_pthread.h

diff --git a/liblttng-ust-libc-wrapper/Makefile.am b/liblttng-ust-libc-wrapper/Makefile.am
index 4fdcedb..78977fe 100644
--- a/liblttng-ust-libc-wrapper/Makefile.am
+++ b/liblttng-ust-libc-wrapper/Makefile.am
@@ -1,7 +1,8 @@
 AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
 AM_CFLAGS = -fno-strict-aliasing
 
-lib_LTLIBRARIES = liblttng-ust-libc-wrapper.la
+lib_LTLIBRARIES = liblttng-ust-libc-wrapper.la \
+  liblttng-ust-pthread-wrapper.la
 liblttng_ust_libc_wrapper_la_SOURCES = \
 	lttng-ust-malloc.c \
 	ust_libc.h
@@ -9,11 +10,20 @@ liblttng_ust_libc_wrapper_la_LIBADD = \
 	-L$(top_builddir)/liblttng-ust/.libs \
 	-llttng-ust
 
+liblttng_ust_pthread_wrapper_la_SOURCES = \
+	pthread.c \
+	ust_pthread.h
+liblttng_ust_pthread_wrapper_la_LIBADD = \
+	-L$(top_builddir)/liblttng-ust/.libs \
+	-llttng-ust
+
 if LTTNG_UST_BUILD_WITH_LIBDL
 liblttng_ust_libc_wrapper_la_LIBADD += -ldl
+liblttng_ust_pthread_wrapper_la_LIBADD += -ldl
 endif
 if LTTNG_UST_BUILD_WITH_LIBC_DL
 liblttng_ust_libc_wrapper_la_LIBADD += -lc
+liblttng_ust_pthread_wrapper_la_LIBADD += -lc
 endif
 
 noinst_SCRIPTS = run
diff --git a/liblttng-ust-libc-wrapper/pthread.c b/liblttng-ust-libc-wrapper/pthread.c
new file mode 100644
index 0000000..a08aa86
--- /dev/null
+++ b/liblttng-ust-libc-wrapper/pthread.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2013  Mentor Graphics
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
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#define _GNU_SOURCE
+#include <dlfcn.h>
+#include <pthread.h>
+
+#define TRACEPOINT_DEFINE
+#define TRACEPOINT_CREATE_PROBES
+#include "ust_pthread.h"
+
+static __thread int thread_in_trace = 0;
+
+int pthread_mutex_lock(pthread_mutex_t *mutex)
+{
+	static int (*mutex_lock)(pthread_mutex_t *);
+	if (!mutex_lock)
+	{
+		mutex_lock = dlsym(RTLD_NEXT, "pthread_mutex_lock");
+		if (!mutex_lock)
+		{
+			fprintf(stderr, "unable to initialize pthread wrapper library.\n");
+			return EINVAL;
+		}
+	}
+	if(!thread_in_trace)
+	{
+		thread_in_trace = 1;
+		tracepoint(ust_pthread, pthread_mutex_lock_req, mutex);
+		int retval = mutex_lock(mutex);
+		tracepoint(ust_pthread, pthread_mutex_lock_acq, mutex, retval);
+		thread_in_trace = 0;
+		return retval;
+	}
+	else
+	{
+		return mutex_lock(mutex);
+	}
+}
+
+int pthread_mutex_trylock(pthread_mutex_t *mutex)
+{
+	static int (*mutex_trylock)(pthread_mutex_t *);
+	if (!mutex_trylock)
+	{
+		mutex_trylock = dlsym(RTLD_NEXT, "pthread_mutex_trylock");
+		if (!mutex_trylock)
+		{
+			fprintf(stderr, "unable to initialize pthread wrapper library.\n");
+			return EINVAL;
+		}
+	}
+	if(!thread_in_trace)
+	{
+		thread_in_trace = 1;
+		int retval = mutex_trylock(mutex);
+		tracepoint(ust_pthread, pthread_mutex_trylock, mutex, retval);
+		thread_in_trace = 0;
+		return retval;
+	}
+	else
+	{
+		return mutex_trylock(mutex);
+	}
+}
+
+int pthread_mutex_unlock(pthread_mutex_t *mutex)
+{
+	static int (*mutex_unlock)(pthread_mutex_t *);
+	if (!mutex_unlock)
+	{
+		mutex_unlock = dlsym(RTLD_NEXT, "pthread_mutex_unlock");
+		if (!mutex_unlock)
+		{
+			fprintf(stderr, "unable to initialize pthread wrapper library.\n");
+			return EINVAL;
+		}
+	}
+	if(!thread_in_trace)
+	{
+		thread_in_trace = 1;
+		int retval = mutex_unlock(mutex);
+		tracepoint(ust_pthread, pthread_mutex_unlock, mutex, retval);
+		thread_in_trace = 0;
+		return retval;
+	}
+	else
+	{
+		return mutex_unlock(mutex);
+	}
+}
diff --git a/liblttng-ust-libc-wrapper/ust_pthread.h b/liblttng-ust-libc-wrapper/ust_pthread.h
new file mode 100644
index 0000000..86275b7
--- /dev/null
+++ b/liblttng-ust-libc-wrapper/ust_pthread.h
@@ -0,0 +1,76 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER ust_pthread
+
+#if !defined(_TRACEPOINT_UST_PTHREAD_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_UST_PTHREAD_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Copyright (C) 2013  Mentor Graphics
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(ust_pthread, pthread_mutex_lock_req,
+	TP_ARGS(pthread_mutex_t *, mutex),
+	TP_FIELDS(
+		ctf_integer_hex(unsigned long, mutex, (unsigned long) mutex)
+	)
+)
+
+TRACEPOINT_EVENT(ust_pthread, pthread_mutex_lock_acq,
+	TP_ARGS(pthread_mutex_t *, mutex, int, status),
+	TP_FIELDS(
+		ctf_integer_hex(unsigned long, mutex, (unsigned long) mutex)
+		ctf_integer(int, status, status)
+	)
+)
+
+TRACEPOINT_EVENT(ust_pthread, pthread_mutex_trylock,
+	TP_ARGS(pthread_mutex_t *, mutex, int, status),
+	TP_FIELDS(
+		ctf_integer_hex(unsigned long, mutex, (unsigned long) mutex)
+		ctf_integer(int, status, status)
+	)
+)
+
+TRACEPOINT_EVENT(ust_pthread, pthread_mutex_unlock,
+	TP_ARGS(pthread_mutex_t *, mutex, int, status),
+	TP_FIELDS(
+		ctf_integer_hex(unsigned long, mutex, (unsigned long) mutex)
+		ctf_integer(int, status, status)
+	)
+)
+
+#endif /* _TRACEPOINT_UST_PTHREAD_H */
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./ust_pthread.h"
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
-- 
1.8.3.1


--------------080303060403070107020401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------080303060403070107020401--
