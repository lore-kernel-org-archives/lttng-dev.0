From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/2] Fix: bitfield: shift
 undefined/implementation defined behaviors
Date: Wed, 15 May 2019 17:51:43 -0400 (EDT)
Message-ID: <1744123491.1576.1557957103017.JavaMail.zimbra__42784.0762584069$1557957118$gmane$org@efficios.com>
References: <20190514203759.27112-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4547YW5h4yzyrD
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 17:51:43 -0400 (EDT)
In-Reply-To: <20190514203759.27112-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 14, 2019, at 4:37 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

[...]

> 
> #define _bt_bitfield_write_be(_ptr, type, _start, _length, _v)		\
> do {									\
> -	typeof(_v) __v = (_v);						\
> +	__typeof__(_v) __v = (_v);					\
> 	type *__ptr = (void *) (_ptr);					\
> 	unsigned long __start = (_start), __length = (_length);		\
> 	type mask, cmask;						\
> @@ -146,15 +249,15 @@ do {									\
> 									\
> 	/* Trim v high bits */						\
> 	if (__length < sizeof(__v) * CHAR_BIT)				\
> -		__v &= ~((~(typeof(__v)) 0) << __length);		\
> +		__v &= _bt_make_mask(__typeof__(__v), __length);	\
> 									\
> 	/* We can now append v with a simple "or", shift it piece-wise */ \
> 	this_unit = end_unit - 1;					\
> 	if (start_unit == end_unit - 1) {				\
> -		mask = ~((~(type) 0) << ((ts - (end % ts)) % ts));	\
> +		mask = _bt_make_mask(type, (ts - (end % ts)) % ts);	\
> 		if (__start % ts)					\
> -			mask |= (~((type) 0)) << (ts - (__start % ts));	\
> -		cmask = (type) __v << ((ts - (end % ts)) % ts);		\
> +			mask |= _bt_make_mask_complement(type, ts - (__start % ts)); \
> +		cmask = _bt_lshift((type) (__v), (ts - (end % ts)) % ts); \
> 		cmask &= ~mask;						\
> 		__ptr[this_unit] &= mask;				\
> 		__ptr[this_unit] |= cmask;				\
> @@ -162,22 +265,22 @@ do {									\
> 	}								\
> 	if (end % ts) {							\
> 		cshift = end % ts;					\
> -		mask = ~((~(type) 0) << (ts - cshift));			\
> -		cmask = (type) __v << (ts - cshift);			\
> +		mask = _bt_make_mask(type, ts - cshift);		\
> +		cmask = _bt_lshift((type) (__v), ts - cshift);		\
> 		cmask &= ~mask;						\
> 		__ptr[this_unit] &= mask;				\
> 		__ptr[this_unit] |= cmask;				\
> -		__v = _bt_piecewise_rshift(__v, cshift);		\
> +		_bt_piecewise_rshift(__v, cshift);			\
> 		end -= cshift;						\
> 		this_unit--;						\
> 	}								\
> 	for (; (long) this_unit >= (long) start_unit + 1; this_unit--) { \
> 		__ptr[this_unit] = (type) __v;				\
> -		__v = _bt_piecewise_rshift(__v, ts);			\
> +		_bt_piecewise_rshift(__v, ts);				\
> 		end -= ts;						\
> 	}								\
> 	if (__start % ts) {						\
> -		mask = (~(type) 0) << (ts - (__start % ts));		\
> +		mask = _bt_make_mask(type, ts - (__start % ts));	\

Should be:

+               mask = _bt_make_mask_complement(type, ts - (__start % ts)); \

Will fix before merging.

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
