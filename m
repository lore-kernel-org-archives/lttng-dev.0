From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Mon, 5 Aug 2013 11:29:31 -0400
Message-ID: <51FFC4DB.7080905__5180.69621543891$1375716715$gmane$org@mentor.com>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050500040206040405000206"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V6Mj4-0004sx-Gm
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 11:29:44 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1V6Miy-0005WW-TN from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 08:29:32 -0700
In-Reply-To: <20130803011841.GE9033@Krystal>
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

--------------050500040206040405000206
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 08/02/2013 09:18 PM, Mathieu Desnoyers wrote:

[...]

> Then, I recommend porting the code from memleak-finder.c to UST
> liblttng-ust-libc-wrapper. The approach I used in memleak-finder.c seems
> to work quite well, and is clearly more complete that what we find in
> liblttng-ust-libc-wrapper currently.

...and here is a revised patch to add calloc and realloc
instrumentation, using the same technique as memleak-finder.

I've ran the patch through the checkpatch.pl script, and made some minor
adjustments to other code to fix coding style errors.

Regards,
    Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/


--------------050500040206040405000206
Content-Type: text/x-patch; name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

From 93da5d2be5ec3a3680449e186780ff7a08cec6d9 Mon Sep 17 00:00:00 2001
From: Stefan Seefeld <stefan_seefeld@mentor.com>
Date: Sat, 27 Jul 2013 01:10:23 -0400
Subject: [PATCH] Add trace support for calloc and realloc.

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 liblttng-ust-libc-wrapper/lttng-ust-malloc.c | 68 +++++++++++++++++++++++++++-
 liblttng-ust-libc-wrapper/ust_libc.h         | 18 ++++++++
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
index 3212ff0..81beb78 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
@@ -26,9 +26,25 @@
 #define TRACEPOINT_CREATE_PROBES
 #include "ust_libc.h"
 
+#define STATIC_CALLOC_LEN 4096
+static char static_calloc_buf[STATIC_CALLOC_LEN];
+static size_t static_calloc_buf_offset;
+
+static void *static_calloc(size_t nmemb, size_t size)
+{
+	size_t prev_offset;
+
+	if (nmemb * size > sizeof(static_calloc_buf) - static_calloc_buf_offset) {
+		return NULL;
+	}
+	prev_offset = static_calloc_buf_offset;
+	static_calloc_buf_offset += nmemb * size;
+	return &static_calloc_buf[prev_offset];
+}
+
 void *malloc(size_t size)
 {
-	static void *(*plibc_malloc)(size_t size) = NULL;
+	static void *(*plibc_malloc)(size_t size);
 	void *retval;
 
 	if (plibc_malloc == NULL) {
@@ -45,7 +61,16 @@ void *malloc(size_t size)
 
 void free(void *ptr)
 {
-	static void *(*plibc_free)(void *ptr) = NULL;
+	static void (*plibc_free)(void *ptr);
+
+	/* Check whether the memory was allocated with
+	 * static_calloc, in which case there is nothing
+	 * to free.
+	 */
+	if ((char *)ptr >= static_calloc_buf &&
+	    (char *)ptr < static_calloc_buf + STATIC_CALLOC_LEN) {
+		return;
+	}
 
 	if (plibc_free == NULL) {
 		plibc_free = dlsym(RTLD_NEXT, "free");
@@ -57,3 +82,42 @@ void free(void *ptr)
 	tracepoint(ust_libc, free, ptr);
 	plibc_free(ptr);
 }
+
+void *calloc(size_t nmemb, size_t size)
+{
+	static void *(*volatile plibc_calloc)(size_t nmemb, size_t size);
+	void *retval;
+
+	if (plibc_calloc == NULL) {
+		/*
+		 * Temporarily redirect to static_calloc,
+		 * until the dlsym lookup has completed.
+		 */
+		plibc_calloc = static_calloc;
+		plibc_calloc = dlsym(RTLD_NEXT, "calloc");
+		if (plibc_calloc == NULL) {
+			fprintf(stderr, "callocwrap: unable to find calloc\n");
+			return NULL;
+		}
+	}
+	retval = plibc_calloc(nmemb, size);
+	tracepoint(ust_libc, calloc, nmemb, size, retval);
+	return retval;
+}
+
+void *realloc(void *ptr, size_t size)
+{
+	static void *(*plibc_realloc)(void *ptr, size_t size);
+	void *retval;
+
+	if (plibc_realloc == NULL) {
+		plibc_realloc = dlsym(RTLD_NEXT, "realloc");
+		if (plibc_realloc == NULL) {
+			fprintf(stderr, "reallocwrap: unable to find realloc\n");
+			return NULL;
+		}
+	}
+	retval = plibc_realloc(ptr, size);
+	tracepoint(ust_libc, realloc, ptr, size, retval);
+	return retval;
+}
diff --git a/liblttng-ust-libc-wrapper/ust_libc.h b/liblttng-ust-libc-wrapper/ust_libc.h
index af705aa..6b03a4d 100644
--- a/liblttng-ust-libc-wrapper/ust_libc.h
+++ b/liblttng-ust-libc-wrapper/ust_libc.h
@@ -47,6 +47,24 @@ TRACEPOINT_EVENT(ust_libc, free,
 	)
 )
 
+TRACEPOINT_EVENT(ust_libc, calloc,
+	TP_ARGS(size_t, nmemb, size_t, size, void *, ptr),
+	TP_FIELDS(
+		ctf_integer(size_t, nmemb, nmemb)
+		ctf_integer(size_t, size, size)
+		ctf_integer_hex(unsigned long, ptr, (unsigned long) ptr)
+	)
+)
+
+TRACEPOINT_EVENT(ust_libc, realloc,
+	TP_ARGS(void *, in_ptr, size_t, size, void *, ptr),
+	TP_FIELDS(
+		ctf_integer_hex(unsigned long, in_ptr, (unsigned long) in_ptr)
+		ctf_integer(size_t, size, size)
+		ctf_integer_hex(unsigned long, ptr, (unsigned long) ptr)
+	)
+)
+
 #endif /* _TRACEPOINT_UST_LIBC_H */
 
 #undef TRACEPOINT_INCLUDE
-- 
1.8.3.1


--------------050500040206040405000206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------050500040206040405000206--
