From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Force static_alloc setup to be written into
	memory
Date: Fri, 14 Feb 2014 14:08:12 +0000 (UTC)
Message-ID: <1889809951.24992.1392386892550.JavaMail.zimbra__17281.4441532411$1392386961$gmane$org@efficios.com>
References: <alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>
	<1392385505-13405-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WEJR9-0003Bt-Hi
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 09:08:20 -0500
In-Reply-To: <1392385505-13405-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: stefan seefeld <stefan_seefeld@mentor.com>, lttng-dev@lists.lttng.org, paulmck@linux.vnet.ibm.com
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Paul Woegerer" <paul_woegerer@mentor.com>
> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "stefan seefeld"
> <stefan_seefeld@mentor.com>
> Cc: paulmck@linux.vnet.ibm.com
> Sent: Friday, February 14, 2014 8:45:05 AM
> Subject: [PATCH] Force static_alloc setup to be written into memory
> 
> As explained by Alexander Monakov, dlsym() is defined to be pure, thus the
> compiler is allowed to assume that there is no need to write the changes
> performed by setup_static_allocator() into memory prior to calling dlsym().
> The added cmm_barrier() forces the compiler to write the changes into memory.
> 
> For more details refer to:
> http://lists.lttng.org/pipermail/lttng-dev/2014-February/022389.html
> 
> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> ---
>  liblttng-ust-libc-wrapper/lttng-ust-malloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> index 8296ae2..7dd647f 100644
> --- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> +++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> @@ -198,6 +198,9 @@ void lookup_all_symbols(void)
>  	 */
>  	setup_static_allocator();
>  
> +	/* Dlsym is defined pure -> force static alloc into memory */
> +	cmm_barrier();
> +
>  	/* Perform the actual lookups */
>  	af.calloc = dlsym(RTLD_NEXT, "calloc");
>  	af.malloc = dlsym(RTLD_NEXT, "malloc");
> @@ -207,7 +210,7 @@ void lookup_all_symbols(void)
>  	af.posix_memalign = dlsym(RTLD_NEXT, "posix_memalign");

Shouldn't we also add a cmm_barrier() between the last call to dlsym()
and the stores to cur_alloc then, to ensure that the allocator is swapped
only after all calls to dlsym ?

Thanks,

Mathieu

>  
>  	/* Populate the new allocator functions */
> -	memcpy(&cur_alloc, &af, sizeof(cur_alloc));
> +	cur_alloc = af;
>  }
>  
>  void *malloc(size_t size)
> --
> 1.8.5.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
