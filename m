From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Make bitfield.h C++-friendly
Date: Mon, 19 Aug 2019 22:02:45 -0400 (EDT)
Message-ID: <1789263059.655.1566266565980.JavaMail.zimbra__12031.9168710679$1566266581$gmane$org@efficios.com>
References: <20190820015106.22331-1-simon.marchi@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46CDZv0lfKzsbf
 for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2019 22:02:46 -0400 (EDT)
In-Reply-To: <20190820015106.22331-1-simon.marchi@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simon.marchi@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged in lttng-ust master branch, thanks!

Mathieu

----- On Aug 19, 2019, at 6:51 PM, Simon Marchi simon.marchi@efficios.com wrote:

> This patch changes bitfield.h to be usable in C++11.
> 
> It will probably never be compiled as C++ in the context of
> lttng-ust, but this is just to keep things sync'ed across projects.
> 
> Signed-off-by: Simon Marchi <simon.marchi@efficios.com>
> ---
> include/lttng/bitfield.h | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/lttng/bitfield.h b/include/lttng/bitfield.h
> index 5ed629381ac6..9386fade1b76 100644
> --- a/include/lttng/bitfield.h
> +++ b/include/lttng/bitfield.h
> @@ -70,8 +70,12 @@
>  * Produce a build-time error if the condition `cond` is non-zero.
>  * Evaluates as a size_t expression.
>  */
> +#ifdef __cplusplus
> +#define _BT_BUILD_ASSERT(cond) ([]{static_assert((cond), "");}, 0)
> +#else
> #define _BT_BUILD_ASSERT(cond)					\
> 	sizeof(struct { int f:(2 * !!(cond) - 1); })
> +#endif
> 
> /*
>  * Cast value `v` to an unsigned integer of the same size as `v`.
> @@ -377,7 +381,7 @@ do {									\
> do {									\
> 	__typeof__(*(vptr)) *_vptr = (vptr);				\
> 	__typeof__(*_vptr) _v;						\
> -	type *_ptr = (void *) (ptr);					\
> +	type *_ptr = (type *) (ptr);					\
> 	unsigned long _start = (start), _length = (length);		\
> 	type _mask, _cmask;						\
> 	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\
> --
> 2.23.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
