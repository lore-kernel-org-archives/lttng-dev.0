From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc
	and	realloc.
Date: Tue, 6 Aug 2013 21:42:41 -0400
Message-ID: <20130807014241.GH19407__11429.1888000027$1375839823$gmane$org@Krystal>
References: <51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal> <51FFBD46.5030105@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6slu-0004ew-T2
	for lttng-dev@lists.lttng.org; Tue, 06 Aug 2013 21:42:47 -0400
Content-Disposition: inline
In-Reply-To: <51FFBD46.5030105@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
> On 08/02/2013 09:18 PM, Mathieu Desnoyers wrote:
> > Please have a look at my implementation of quick and dirty malloc/free
> > tracker here:
> >
> > https://github.com/efficios/memleak-finder
> >
> > file: memleak-finder.c
> >
> > Implementing a work-around for calloc vs dlsym was indeed tricky. The
> > solution I got there works fine so far (static array used for this
> > special-case). I think we might get the free() case to be more solid by
> > checking if the address being freed is in the static buffer range.
> 
> I played a little with this code (e.g. by removing the "constructor"
> attribute from the do_init() function, to increase the chances that I
> could see static_calloc() being used in my own code).
> I found one bug (where the static buffer size adjustment was wrong, so
> the second time static_calloc was called a pointer pointing into the
> previous buffer would be returned).

Good catch. I'm merging this part.

> And I did observe a crash without the appropriate adjustment to free().
> 
> > If you could submit a patch that improves memleak-finder.c to get this
> > right, it would be very much appreciated.
> 
> Please find attached a small patch for this. As you can see, if the
> pointer falls into the range of the static buffer, free() does nothing.
> ("freeing" the buffer properly would require much more work,
> and arguably falls outside the scope of what is needed here, since
> static_calloc() is really only required during startup, and thus should
> never run out of space.

Yep, agreed.

I already did a commit a few days ago before seeing your patch here.
It's:

commit 07b2e0cd6297e5c7349793f5bfc9cc28d6c83a6b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Aug 5 13:42:29 2013 -0400

    Handle realloc/free of static_calloc
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

It's not perfect, but if people are reallocating memory allocated that
early, they will get a NULL pointer exception and we'll deal with it.

> 
> 
> > Then, I recommend porting the code from memleak-finder.c to UST
> > liblttng-ust-libc-wrapper. The approach I used in memleak-finder.c seems
> > to work quite well, and is clearly more complete that what we find in
> > liblttng-ust-libc-wrapper currently.
> 
> Yes, with the adjusted free() implementation as per this patch, I think
> this is a robust solution. Do you think we need any form of multi-thread
> protection ? Or can we assume that library initialization will have
> completed by the time multiple threads could possibly call calloc() ?

Well, considering that lttng-ust spawns thread in its constructor, it
might indeed be a good thing to be thread-safe. Fixed by:

commit d9e6d9a57fda6d3ad73016b2b3137997aac9c7ba
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Aug 6 21:41:15 2013 -0400

    Fix: static_calloc should be thread-safe
    
    Reported-by: Stefan Seefeld <stefan_seefeld@mentor.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thoughts ?

Thanks,

Mathieu

> 
>     Stefan
> 
> -- 
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
> 

> From 858ae5805f3bea303edfcec8156494be2fa3580d Mon Sep 17 00:00:00 2001
> From: Stefan Seefeld <stefan_seefeld@mentor.com>
> Date: Mon, 5 Aug 2013 10:54:24 -0400
> Subject: [PATCH] Fix typo and robustify free() implementation.
> 
> Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
> ---
>  memleak-finder.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/memleak-finder.c b/memleak-finder.c
> index 2f8b996..d3755ff 100644
> --- a/memleak-finder.c
> +++ b/memleak-finder.c
> @@ -160,7 +160,7 @@ void *static_calloc(size_t nmemb, size_t size)
>  	if (nmemb * size > sizeof(static_calloc_buf) - static_calloc_len)
>  		return NULL;
>  	prev_len = static_calloc_len;
> -	static_calloc_len += nmemb + size;
> +	static_calloc_len += nmemb * size;
>  	return &static_calloc_buf[prev_len];
>  }
>  
> @@ -341,6 +341,15 @@ free(void *ptr)
>  {
>  	const void *caller = __builtin_return_address(0);
>  
> +	/* Check whether the memory was allocated with
> +	 * static_calloc, in which case there is nothing
> +	 * to free.
> +	 */
> +	if ((char*)ptr >= static_calloc_buf &&
> +	    (char*)ptr < static_calloc_buf + STATIC_CALLOC_LEN) {
> +		return;
> +	}
> +
>  	do_init();
>  
>  	if (thread_in_hook) {
> -- 
> 1.8.3.1
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
