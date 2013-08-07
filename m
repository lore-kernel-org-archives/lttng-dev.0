From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation for
 some pthread functions.
Date: Wed, 7 Aug 2013 09:14:19 -0400
Message-ID: <5202482B.2010705__18161.9780291387$1375881327$gmane$org@mentor.com>
References: <51F97688.30704@mentor.com>
	<CA+jJMxsoH8Rz6fwZJOPnG-4xvB2w8GO5eqi0JDtHUy7iM-n2WA@mail.gmail.com>
	<51F9A917.9010509@seefeld.name> <20130803012831.GH9033@Krystal>
	<51FFAAD7.3000705@seefeld.name> <20130807013159.GG19407@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050502060003040802040001"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V73ZL-0006yJ-PR
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 09:14:31 -0400
In-Reply-To: <20130807013159.GG19407@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------050502060003040802040001
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Mathieu,

please find attached a revised patch.

On 08/06/2013 09:32 PM, Mathieu Desnoyers wrote:
>
> +#include <lttng/tracepoint.h>
> +
> +TRACEPOINT_EVENT(ust_pthread, pthread_mutex_lock_req,
> +	TP_ARGS(pthread_mutex_t *, mutex),
> +	TP_FIELDS(
> +		ctf_integer_hex(unsigned long, mutex, (unsigned long) mutex)
> I'm curious (and I honestly don't remember): does it work if we put
> "void *" as type rather than "unsigned long" here ?

It seems to work fine - I applied the suggested change (see the current
patch) and I see the same traces.

    Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/


--------------050502060003040802040001
Content-Type: text/x-patch; name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

From 6fb45b78dd60045631d3e8e6dab6dd838d9db869 Mon Sep 17 00:00:00 2001
From: Stefan Seefeld <stefan_seefeld@mentor.com>
Date: Wed, 31 Jul 2013 16:35:31 -0400
Subject: [PATCH] Add tracing instrumentation for pthread mutex lock functions.

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 liblttng-ust-libc-wrapper/Makefile.am         | 12 +++-
 liblttng-ust-libc-wrapper/lttng-ust-pthread.c | 97 +++++++++++++++++++++++++++
 liblttng-ust-libc-wrapper/ust_pthread.h       | 76 +++++++++++++++++++++
 3 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 liblttng-ust-libc-wrapper/lttng-ust-pthread.c
 create mode 100644 liblttng-ust-libc-wrapper/ust_pthread.h

diff --git a/liblttng-ust-libc-wrapper/Makefile.am b/liblttng-ust-libc-wrapper/Makefile.am
index 4fdcedb..d402d53 100644
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
+	lttng-ust-pthread.c \
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
diff --git a/liblttng-ust-libc-wrapper/lttng-ust-pthread.c b/liblttng-ust-libc-wrapper/lttng-ust-pthread.c
new file mode 100644
index 0000000..53230e1
--- /dev/null
+++ b/liblttng-ust-libc-wrapper/lttng-ust-pthread.c
@@ -0,0 +1,97 @@
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
+static __thread int thread_in_trace;
+
+int pthread_mutex_lock(pthread_mutex_t *mutex)
+{
+	static int (*mutex_lock)(pthread_mutex_t *);
+	int retval;
+
+	if (!mutex_lock) {
+		mutex_lock = dlsym(RTLD_NEXT, "pthread_mutex_lock");
+		if (!mutex_lock && !thread_in_trace) {
+			fprintf(stderr, "unable to initialize pthread wrapper library.\n");
+			return EINVAL;
+		}
+	}
+	if (thread_in_trace) {
+		return mutex_lock(mutex);
+	}
+
+	thread_in_trace = 1;
+	tracepoint(ust_pthread, pthread_mutex_lock_req, mutex);
+	retval = mutex_lock(mutex);
+	tracepoint(ust_pthread, pthread_mutex_lock_acq, mutex, retval);
+	thread_in_trace = 0;
+	return retval;
+}
+
+int pthread_mutex_trylock(pthread_mutex_t *mutex)
+{
+	static int (*mutex_trylock)(pthread_mutex_t *);
+	int retval;
+
+	if (!mutex_trylock) {
+		mutex_trylock = dlsym(RTLD_NEXT, "pthread_mutex_trylock");
+		if (!mutex_trylock && !thread_in_trace) {
+			fprintf(stderr, "unable to initialize pthread wrapper library.\n");
+			return EINVAL;
+		}
+	}
+	if (thread_in_trace) {
+		return mutex_trylock(mutex);
+	}
+
+	thread_in_trace = 1;
+	retval = mutex_trylock(mutex);
+	tracepoint(ust_pthread, pthread_mutex_trylock, mutex, retval);
+	thread_in_trace = 0;
+	return retval;
+}
+
+int pthread_mutex_unlock(pthread_mutex_t *mutex)
+{
+	static int (*mutex_unlock)(pthread_mutex_t *);
+	int retval;
+
+	if (!mutex_unlock) {
+		mutex_unlock = dlsym(RTLD_NEXT, "pthread_mutex_unlock");
+		if (!mutex_unlock && !thread_in_trace) {
+			fprintf(stderr, "unable to initialize pthread wrapper library.\n");
+			return EINVAL;
+		}
+	}
+	if (thread_in_trace) {
+		return mutex_unlock(mutex);
+	}
+
+	thread_in_trace = 1;
+	retval = mutex_unlock(mutex);
+	tracepoint(ust_pthread, pthread_mutex_unlock, mutex, retval);
+	thread_in_trace = 0;
+	return retval;
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


--------------050502060003040802040001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------050502060003040802040001--
