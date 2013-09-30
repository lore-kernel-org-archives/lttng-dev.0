From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Bulletproof RCU arena resize bug
Date: Mon, 30 Sep 2013 16:09:59 +0000 (UTC)
Message-ID: <1994626768.26110.1380557399580.JavaMail.zimbra__15166.4526122206$1380557469$gmane$org@efficios.com>
References: <CANP1eJFy4Ro4J-_pUtVPp3tm7a9ZoySZe+puJ1YotM=6QhLoOw@mail.gmail.com>
	<1070351062.26103.1380556151276.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VQg2w-00042k-Ev
	for lttng-dev@lists.lttng.org; Mon, 30 Sep 2013 12:10:12 -0400
In-Reply-To: <1070351062.26103.1380556151276.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Milosz Tanski <milosz@adfin.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org



----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Milosz Tanski" <milosz@adfin.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, September 30, 2013 11:49:11 AM
> Subject: Re: [lttng-dev] Bulletproof RCU arena resize bug
> 
> ----- Original Message -----
> > From: "Milosz Tanski" <milosz@adfin.com>
> > To: lttng-dev@lists.lttng.org
> > Sent: Monday, September 30, 2013 11:16:37 AM
> > Subject: [lttng-dev] Bulletproof RCU arena resize bug
> > 
> > Hi,
> > 
> > While trying to use the BP flavor of RCU I ran into random crashes. I
> > tracked it down to issues with resizing of the BP RCU memory pool.
> > 
> > The problem is in the urcu-bp.c file in the resize_arena() function.
> > On successful allocation / remapping the len member of the
> > registry_arena struct is never set anywhere function. On the second
> > resize of the arena the code in resize_arena() still thinks the
> > previous size is equal to the original mapping size. I've fixed this
> > issue locally by just adding the following code at the bottom of
> > resize_arena().
> > 
> > I hope this helps,
> 
> Good catch !!
> 
> However, I think your fix misses one case: if we happen to re-use the same
> region, we want to update the length right ? I propose:

Sorry, my previous patch was wrong: I updated arena->len before it was used (expecting old value).

Here is an updated fix. It includes a bit of cleanup so we can make some sense of the variables there.

diff --git a/urcu-bp.c b/urcu-bp.c
index 34bd14e..93d781f 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -305,27 +305,37 @@ int rcu_read_ongoing(void)
  */
 static void resize_arena(struct registry_arena *arena, size_t len)
 {
-       void *new_arena;
+       void *new_p;
+       size_t old_len;
+
+       old_len = arena->len;

        if (!arena->p)
-               new_arena = mmap(arena->p, len,
-                                PROT_READ | PROT_WRITE,
-                                MAP_ANONYMOUS | MAP_PRIVATE,
-                                -1, 0);
+               new_p = mmap(arena->p, len,
+                       PROT_READ | PROT_WRITE,
+                       MAP_ANONYMOUS | MAP_PRIVATE,
+                       -1, 0);
        else
-               new_arena = mremap_wrapper(arena->p, arena->len,
-                                       len, MREMAP_MAYMOVE);
-       assert(new_arena != MAP_FAILED);
-       arena->len = len;
+               new_p = mremap_wrapper(arena->p, old_len,
+                       len, MREMAP_MAYMOVE);
+       assert(new_p != MAP_FAILED);
+
+       /*
+        * Zero the newly allocated memory. Since mmap() does not
+        * clearly specify if memory is zeroed or not (although it is
+        * very likely that it is), be extra careful by not expecting
+        * the new range to be zeroed by mremap.
+        */
+       bzero(new_p + old_len, len - old_len);

        /*
-        * re-used the same region ?
+        * If we did not re-use the same region, we need to update the
+        * arena pointer.
         */
-       if (new_arena == arena->p)
-               return;
+       if (new_p != arena->p)
+               arena->p = new_p;

-       bzero(new_arena + arena->len, len - arena->len);
-       arena->p = new_arena;
+       arena->len = len;
 }

 /* Called with signals off and mutex locked */

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
