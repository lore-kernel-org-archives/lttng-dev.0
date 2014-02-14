From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH] Force static_alloc setup to be written into
	memory
Date: Fri, 14 Feb 2014 14:45:05 +0100
Message-ID: <1392385505-13405-1-git-send-email-paul_woegerer__18265.5415418141$1392385673$gmane$org@mentor.com>
References: <alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WEJ6U-0002zE-UT
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 08:47:00 -0500
In-Reply-To: <alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, stefan_seefeld@mentor.com
Cc: paulmck@linux.vnet.ibm.com
List-Id: lttng-dev@lists.lttng.org

As explained by Alexander Monakov, dlsym() is defined to be pure, thus the
compiler is allowed to assume that there is no need to write the changes
performed by setup_static_allocator() into memory prior to calling dlsym().
The added cmm_barrier() forces the compiler to write the changes into memory.

For more details refer to:
http://lists.lttng.org/pipermail/lttng-dev/2014-February/022389.html

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust-libc-wrapper/lttng-ust-malloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
index 8296ae2..7dd647f 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
@@ -198,6 +198,9 @@ void lookup_all_symbols(void)
 	 */
 	setup_static_allocator();
 
+	/* Dlsym is defined pure -> force static alloc into memory */
+	cmm_barrier();
+
 	/* Perform the actual lookups */
 	af.calloc = dlsym(RTLD_NEXT, "calloc");
 	af.malloc = dlsym(RTLD_NEXT, "malloc");
@@ -207,7 +210,7 @@ void lookup_all_symbols(void)
 	af.posix_memalign = dlsym(RTLD_NEXT, "posix_memalign");
 
 	/* Populate the new allocator functions */
-	memcpy(&cur_alloc, &af, sizeof(cur_alloc));
+	cur_alloc = af;
 }
 
 void *malloc(size_t size)
-- 
1.8.5.2
