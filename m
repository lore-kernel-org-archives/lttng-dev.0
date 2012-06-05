From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] Makes write operation a parameter
	for	tp_memcpy macro
Date: Tue, 5 Jun 2012 11:14:59 -0400
Message-ID: <20120605151459.GB21009__36078.9973674857$1338909324$gmane$org@Krystal>
References: <1338888051-20879-1-git-send-email-francis.giraldeau@gmail.com>
	<1338888051-20879-2-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SbvTJ-0001Nf-5K
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 11:15:01 -0400
Content-Disposition: inline
In-Reply-To: <1338888051-20879-2-git-send-email-francis.giraldeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Memcpy source can be either user-space or kernel-space. To avoid code
> duplication, this patch makes the operation a parameter to the macros.
> Available macros are thus:
> 
> * tp_memcpy:               kernel-space array copy
> * tp_memcpy_from_user:     user-space array copy
> * tp_memcpy_dyn:           kernel-space sequence copy
> * tp_memcpy_dyn_from_user: user-space sequence copy
> 
> Those are TP_fast_assign macros that can be used with __dynamic_array
> macros in TP_STRUCT__entry in a TRACE_EVENT.

Merged, thanks !

Mathieu

> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> ---
>  probes/lttng-events.h |   37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/probes/lttng-events.h b/probes/lttng-events.h
> index 05e17b9..492423a 100644
> --- a/probes/lttng-events.h
> +++ b/probes/lttng-events.h
> @@ -523,17 +523,27 @@ __assign_##dest:							\
>  	}								\
>  	goto __end_field_##dest;
>  
> -#undef tp_memcpy
> -#define tp_memcpy(dest, src, len)					\
> +/* fixed length array memcpy */
> +#undef tp_memcpy_gen
> +#define tp_memcpy_gen(write_ops, dest, src, len)			\
>  __assign_##dest:							\
>  	if (0)								\
>  		(void) __typemap.dest;					\
>  	lib_ring_buffer_align_ctx(&__ctx, lttng_alignof(__typemap.dest));	\
> -	__chan->ops->event_write(&__ctx, src, len);			\
> +	__chan->ops->write_ops(&__ctx, src, len);			\
>  	goto __end_field_##dest;
>  
> -#undef tp_memcpy_dyn
> -#define tp_memcpy_dyn(dest, src)					\
> +#undef tp_memcpy
> +#define tp_memcpy(dest, src, len)					\
> +	tp_memcpy_gen(event_write, dest, src, len)
> +
> +#undef tp_memcpy_from_user
> +#define tp_memcpy_from_user(dest, src, len)				\
> +	tp_memcpy_gen(event_write_from_user, dest, src, len)
> +
> +/* variable length sequence memcpy */
> +#undef tp_memcpy_dyn_gen
> +#define tp_memcpy_dyn_gen(write_ops, dest, src)				\
>  __assign_##dest##_1:							\
>  	{								\
>  		u32 __tmpl = __dynamic_len[__dynamic_len_idx];		\
> @@ -543,18 +553,17 @@ __assign_##dest##_1:							\
>  	goto __end_field_##dest##_1;					\
>  __assign_##dest##_2:							\
>  	lib_ring_buffer_align_ctx(&__ctx, lttng_alignof(__typemap.dest));	\
> -	__chan->ops->event_write(&__ctx, src,				\
> +	__chan->ops->write_ops(&__ctx, src,				\
>  		sizeof(__typemap.dest) * __get_dynamic_array_len(dest));\
>  	goto __end_field_##dest##_2;
>  
> -#undef tp_memcpy_from_user
> -#define tp_memcpy_from_user(dest, src, len)				\
> -	__assign_##dest:						\
> -	if (0)								\
> -		(void) __typemap.dest;					\
> -	lib_ring_buffer_align_ctx(&__ctx, lttng_alignof(__typemap.dest));	\
> -	__chan->ops->event_write_from_user(&__ctx, src, len);		\
> -	goto __end_field_##dest;
> +#undef tp_memcpy_dyn
> +#define tp_memcpy_dyn(dest, src)					\
> +	tp_memcpy_dyn_gen(event_write, dest, src)
> +
> +#undef tp_memcpy_dyn_from_user
> +#define tp_memcpy_dyn_from_user(dest, src)				\
> +	tp_memcpy_dyn_gen(event_write_from_user, dest, src)
>  
>  /*
>   * The string length including the final \0.
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
