From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Bulletproof RCU arena resize bug
Date: Mon, 30 Sep 2013 15:49:11 +0000 (UTC)
Message-ID: <1070351062.26103.1380556151276.JavaMail.zimbra__49693.0430680097$1380556227$gmane$org@efficios.com>
References: <CANP1eJFy4Ro4J-_pUtVPp3tm7a9ZoySZe+puJ1YotM=6QhLoOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VQfip-0003hc-5Q
	for lttng-dev@lists.lttng.org; Mon, 30 Sep 2013 11:49:24 -0400
In-Reply-To: <CANP1eJFy4Ro4J-_pUtVPp3tm7a9ZoySZe+puJ1YotM=6QhLoOw@mail.gmail.com>
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
> From: "Milosz Tanski" <milosz@adfin.com>
> To: lttng-dev@lists.lttng.org
> Sent: Monday, September 30, 2013 11:16:37 AM
> Subject: [lttng-dev] Bulletproof RCU arena resize bug
> 
> Hi,
> 
> While trying to use the BP flavor of RCU I ran into random crashes. I
> tracked it down to issues with resizing of the BP RCU memory pool.
> 
> The problem is in the urcu-bp.c file in the resize_arena() function.
> On successful allocation / remapping the len member of the
> registry_arena struct is never set anywhere function. On the second
> resize of the arena the code in resize_arena() still thinks the
> previous size is equal to the original mapping size. I've fixed this
> issue locally by just adding the following code at the bottom of
> resize_arena().
> 
> I hope this helps,

Good catch !!

However, I think your fix misses one case: if we happen to re-use the same region, we want to update the length right ? I propose:

diff --git a/urcu-bp.c b/urcu-bp.c
index a823659..34bd14e 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -316,6 +316,7 @@ static void resize_arena(struct registry_arena *arena, size_t len)
                new_arena = mremap_wrapper(arena->p, arena->len,
                                        len, MREMAP_MAYMOVE);
        assert(new_arena != MAP_FAILED);
+       arena->len = len;

        /*
         * re-used the same region ?

(sorry for bad patch formatting, I'm currently updating my mail client setup)

Thoughts ?

Thanks,

Mathieu



> - Milosz
> 
> diff --git a/urcu-bp.c b/urcu-bp.c
> index a823659..d26dcc7 100644
> --- a/urcu-bp.c
> +++ b/urcu-bp.c
> @@ -325,6 +329,7 @@ static void resize_arena(struct registry_arena
> *arena, size_t len)
> 
>         bzero(new_arena + arena->len, len - arena->len);
>         arena->p = new_arena;
> +       arena->len = len;
>  }
> 
>  /* Called with signals off and mutex locked */
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
