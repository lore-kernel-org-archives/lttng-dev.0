From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Mon, 5 Aug 2013 10:57:10 -0400
Message-ID: <51FFBD46.5030105__33067.1684038409$1375714697$gmane$org@mentor.com>
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
Content-Type: multipart/mixed; boundary="------------060501060307000603000109"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V6MDm-0003m5-IQ
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 10:57:24 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1V6MDf-0002RC-OG from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 07:57:11 -0700
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

--------------060501060307000603000109
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 08/02/2013 09:18 PM, Mathieu Desnoyers wrote:
> Please have a look at my implementation of quick and dirty malloc/free
> tracker here:
>
> https://github.com/efficios/memleak-finder
>
> file: memleak-finder.c
>
> Implementing a work-around for calloc vs dlsym was indeed tricky. The
> solution I got there works fine so far (static array used for this
> special-case). I think we might get the free() case to be more solid by
> checking if the address being freed is in the static buffer range.

I played a little with this code (e.g. by removing the "constructor"
attribute from the do_init() function, to increase the chances that I
could see static_calloc() being used in my own code).
I found one bug (where the static buffer size adjustment was wrong, so
the second time static_calloc was called a pointer pointing into the
previous buffer would be returned).
And I did observe a crash without the appropriate adjustment to free().

> If you could submit a patch that improves memleak-finder.c to get this
> right, it would be very much appreciated.

Please find attached a small patch for this. As you can see, if the
pointer falls into the range of the static buffer, free() does nothing.
("freeing" the buffer properly would require much more work,
and arguably falls outside the scope of what is needed here, since
static_calloc() is really only required during startup, and thus should
never run out of space.


> Then, I recommend porting the code from memleak-finder.c to UST
> liblttng-ust-libc-wrapper. The approach I used in memleak-finder.c seems
> to work quite well, and is clearly more complete that what we find in
> liblttng-ust-libc-wrapper currently.

Yes, with the adjusted free() implementation as per this patch, I think
this is a robust solution. Do you think we need any form of multi-thread
protection ? Or can we assume that library initialization will have
completed by the time multiple threads could possibly call calloc() ?

    Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/


--------------060501060307000603000109
Content-Type: text/x-patch; name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

From 858ae5805f3bea303edfcec8156494be2fa3580d Mon Sep 17 00:00:00 2001
From: Stefan Seefeld <stefan_seefeld@mentor.com>
Date: Mon, 5 Aug 2013 10:54:24 -0400
Subject: [PATCH] Fix typo and robustify free() implementation.

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 memleak-finder.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/memleak-finder.c b/memleak-finder.c
index 2f8b996..d3755ff 100644
--- a/memleak-finder.c
+++ b/memleak-finder.c
@@ -160,7 +160,7 @@ void *static_calloc(size_t nmemb, size_t size)
 	if (nmemb * size > sizeof(static_calloc_buf) - static_calloc_len)
 		return NULL;
 	prev_len = static_calloc_len;
-	static_calloc_len += nmemb + size;
+	static_calloc_len += nmemb * size;
 	return &static_calloc_buf[prev_len];
 }
 
@@ -341,6 +341,15 @@ free(void *ptr)
 {
 	const void *caller = __builtin_return_address(0);
 
+	/* Check whether the memory was allocated with
+	 * static_calloc, in which case there is nothing
+	 * to free.
+	 */
+	if ((char*)ptr >= static_calloc_buf &&
+	    (char*)ptr < static_calloc_buf + STATIC_CALLOC_LEN) {
+		return;
+	}
+
 	do_init();
 
 	if (thread_in_hook) {
-- 
1.8.3.1


--------------060501060307000603000109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------060501060307000603000109--
