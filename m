From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Wed, 7 Aug 2013 13:07:50 -0400
Message-ID: <52027EE6.60704__11038.0145641559$1375895475$gmane$org@mentor.com>
References: <CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal> <51FFC4DB.7080905@mentor.com>
	<52025E03.7090201@mentor.com> <20130807155057.GB1035@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030901080303030103080006"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V77DK-0003JP-IQ
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 13:08:04 -0400
In-Reply-To: <20130807155057.GB1035@Krystal>
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

--------------030901080303030103080006
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 08/07/2013 11:50 AM, Mathieu Desnoyers wrote:

> I notice that memalign and posix_memalign are missing. Do you have plans
> to add them ?

Here is a patch adding those two.

	Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/

--------------030901080303030103080006
Content-Type: text/x-patch; name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

From 10b4f91ea710b484a7e31fca68f55a2b58d026cd Mon Sep 17 00:00:00 2001
From: Stefan Seefeld <stefan_seefeld@mentor.com>
Date: Wed, 7 Aug 2013 13:05:34 -0400
Subject: [PATCH] Add trace support for memalign and posix_memalign.

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 liblttng-ust-libc-wrapper/lttng-ust-malloc.c | 34 ++++++++++++++++++++++++++++
 liblttng-ust-libc-wrapper/ust_libc.h         | 19 ++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
index 4fe8fa9..33ed18b 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
@@ -133,3 +133,37 @@ void *realloc(void *ptr, size_t size)
 	tracepoint(ust_libc, realloc, ptr, size, retval);
 	return retval;
 }
+
+void *memalign(size_t alignment, size_t size)
+{
+	static void *(*plibc_memalign)(size_t alignment, size_t size);
+	void *retval;
+
+	if (plibc_memalign == NULL) {
+		plibc_memalign = dlsym(RTLD_NEXT, "memalign");
+		if (plibc_memalign == NULL) {
+			fprintf(stderr, "memalignwrap: unable to find memalign\n");
+			return NULL;
+		}
+	}
+	retval = plibc_memalign(alignment, size);
+	tracepoint(ust_libc, memalign, alignment, size, retval);
+	return retval;
+}
+
+int posix_memalign(void **memptr, size_t alignment, size_t size)
+{
+	static int(*plibc_posix_memalign)(void **memptr, size_t alignment, size_t size);
+	int retval;
+
+	if (plibc_posix_memalign == NULL) {
+		plibc_posix_memalign = dlsym(RTLD_NEXT, "posix_memalign");
+		if (plibc_posix_memalign == NULL) {
+			fprintf(stderr, "posix_memalignwrap: unable to find posix_memalign\n");
+			return ENOMEM;
+		}
+	}
+	retval = plibc_posix_memalign(memptr, alignment, size);
+	tracepoint(ust_libc, posix_memalign, *memptr, alignment, size, retval);
+	return retval;
+}
diff --git a/liblttng-ust-libc-wrapper/ust_libc.h b/liblttng-ust-libc-wrapper/ust_libc.h
index d2096a3..a8ff9c6 100644
--- a/liblttng-ust-libc-wrapper/ust_libc.h
+++ b/liblttng-ust-libc-wrapper/ust_libc.h
@@ -65,6 +65,25 @@ TRACEPOINT_EVENT(ust_libc, realloc,
 	)
 )
 
+TRACEPOINT_EVENT(ust_libc, memalign,
+	TP_ARGS(size_t, alignment, size_t, size, void *, ptr),
+	TP_FIELDS(
+		ctf_integer(size_t, alignment, alignment)
+		ctf_integer(size_t, size, size)
+		ctf_integer_hex(void *, ptr, ptr)
+	)
+)
+
+TRACEPOINT_EVENT(ust_libc, posix_memalign,
+	TP_ARGS(void *, out_ptr, size_t, alignment, size_t, size, int, result),
+	TP_FIELDS(
+		ctf_integer_hex(void *, out_ptr, out_ptr)
+		ctf_integer(size_t, alignment, alignment)
+		ctf_integer(size_t, size, size)
+		ctf_integer(int, result, result)
+	)
+)
+
 #endif /* _TRACEPOINT_UST_LIBC_H */
 
 #undef TRACEPOINT_INCLUDE
-- 
1.8.3.1


--------------030901080303030103080006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------030901080303030103080006--
