From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Tue, 30 Jul 2013 17:12:37 -0400
Message-ID: <51F82C45.6020502__28790.1807380424$1375218828$gmane$org@mentor.com>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080504050408090201050108"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V4HDp-0006jg-HA
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 17:12:51 -0400
In-Reply-To: <CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------080504050408090201050108
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id r6ULDCvq024453

Hi J=E9r=E9mie,

thanks for the quick review. I agree with the fragility of the calloc()
hack. However, we aren't the only ones hitting this circular dependency
(as google confirms).
Some more investigation reveals that dlsym() is in fact prepared for
calloc() to return NULL (in which case an internal static buffer is
used. And yes, it appears to check for that case during cleanup.)

Thus I have updated the patch, addressing all of the issues you raise,
and replaced the "dummy_malloc" business by a simple dummy_calloc()
returning NULL. This appears to be working fine.

Meanwhile, I'd like to understand your suggestion, so let me follow up
on that, too:

On 07/29/2013 07:19 PM, J=E9r=E9mie Galarneau wrote:

> I may be missing something, but since this structure is allocated only
> once per thread, subsequent calls from the same thread to dlsym()
> should not result in another call to calloc(). That should make it
> possible to call malloc() in dummy_calloc() without causing the
> recursion.

You are right. But the problem is that, if I call malloc() in
dummy_calloc(), I indirectly end up calling dlsym() from within dlsym()...

> Perhaps we could also forego this mechanism completely and initialize
> the symbols from a constructor since this library is meant to be
> LD_PRELOAD-ed?

I don't quite understand what you are suggesting. dlsym() still calls
calloc(), so our wrapper still needs to check whether initialization has
already been completed, and if not, use a fallback.

The code may be reorganized, but that doesn't seem to make it any simpler.

Regards,
	Stefan

--=20
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/

--------------080504050408090201050108
Content-Type: text/x-patch; name="patch"
Content-Disposition: attachment; filename="patch"
Content-Transfer-Encoding: 7bit

From fd9b458f0cee09cd17c0ff271ae0e2754aceb2fc Mon Sep 17 00:00:00 2001
From: Stefan Seefeld <stefan_seefeld@mentor.com>
Date: Sat, 27 Jul 2013 01:10:23 -0400
Subject: [PATCH] Add trace support for calloc and realloc.

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 liblttng-ust-libc-wrapper/lttng-ust-malloc.c | 51 +++++++++++++++++++++++++++-
 liblttng-ust-libc-wrapper/ust_libc.h         | 18 ++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
index 3212ff0..fd60e9d 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
@@ -45,7 +45,7 @@ void *malloc(size_t size)
 
 void free(void *ptr)
 {
-	static void *(*plibc_free)(void *ptr) = NULL;
+	static void (*plibc_free)(void *ptr) = NULL;
 
 	if (plibc_free == NULL) {
 		plibc_free = dlsym(RTLD_NEXT, "free");
@@ -57,3 +57,52 @@ void free(void *ptr)
 	tracepoint(ust_libc, free, ptr);
 	plibc_free(ptr);
 }
+
+static void *dummy_calloc(size_t nmemb, size_t size)
+{
+	/*
+	 * This function is once by dlsym (which calls
+	 * calloc internally). Fortunately it can handle
+	 * a NULL return value.
+	 */
+	return NULL;
+}
+
+void *calloc(size_t nmemb, size_t size)
+{
+	static void *(* volatile plibc_calloc)(size_t nmemb, size_t size) = NULL;
+	void *retval;
+
+	if (plibc_calloc == NULL) {
+		/*
+		 * Temporarily redirect to dummy_calloc,
+		 * until the dlsym lookup has completed.
+		 */
+		plibc_calloc = dummy_calloc;
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
+	static void *(*plibc_realloc)(void *ptr, size_t size) = NULL;
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


--------------080504050408090201050108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------080504050408090201050108--
