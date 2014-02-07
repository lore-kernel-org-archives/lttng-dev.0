From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: RFC: Fix crash in dlerror()
Date: Fri, 7 Feb 2014 16:50:09 -0500
Message-ID: <52F55511.2080309__19369.1981643953$1391810174$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090302000301050605010003"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WBtJS-0002tF-P9
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 16:50:24 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1WBtJK-0001IJ-Dd from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 13:50:10 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--------------090302000301050605010003
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

I have been looking into an issue with the malloc wrapper, where an
unsuccessful call to dlopen(), followed by a call to dlerror(), would
result in a segmentation fault when the malloc wrapper is being used.

The problem is the following:

The functions dlopen() and dlsym() make use of a global (though
thread-local) "result" structure to hold the error state, to allow a
subsequent call to dlerror() to report it.

As it turns out, dlerror() itself may implicitly call realloc(), which,
if it hasn't been used before, triggers our wrapper to call dlsym(). So,
while dlerror() inspects said result structure, dlsym() re-initializes
it, causing the crash...

This is arguably a bug in the dlfcn functions. The attached patch
attempts to fix this by moving the initialization of the realloc()
wrapper (i.e., the loading of the symbol) into the constructor. This
fixes the crash that I'm observing, but since none of these dependencies
are specified or documented, this change may cause other issues elsewhere.

Are there any objections to this approach ? If not, I'll submit a formal
patch for this.

Thanks,
        Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/


--------------090302000301050605010003
Content-Type: text/plain; charset="UTF-8"; name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
index 33ed18b..3f391db 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
@@ -54,6 +54,14 @@ static void *static_calloc(size_t nmemb, size_t size)
 	return &static_calloc_buf[prev_offset];
 }
 
+static void *(*plibc_realloc)(void *ptr, size_t size);
+
+__attribute__((constructor))
+static void init()
+{
+	plibc_realloc = dlsym(RTLD_NEXT, "realloc");
+}
+
 void *malloc(size_t size)
 {
 	static void *(*plibc_malloc)(size_t size);
@@ -119,7 +127,6 @@ void *calloc(size_t nmemb, size_t size)
 
 void *realloc(void *ptr, size_t size)
 {
-	static void *(*plibc_realloc)(void *ptr, size_t size);
 	void *retval;
 
 	if (plibc_realloc == NULL) {

--------------090302000301050605010003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------090302000301050605010003--
