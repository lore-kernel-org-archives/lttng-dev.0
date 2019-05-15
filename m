From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH barectf 1/1] Fix: bitfield: shift
 undefined/implementation defined behaviors
Date: Wed, 15 May 2019 17:53:19 -0400 (EDT)
Message-ID: <1142915113.1625.1557957199369.JavaMail.zimbra__44178.3353265905$1557957221$gmane$org@efficios.com>
References: <20190514204215.27528-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4547bM6ZRlzyry
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 17:53:19 -0400 (EDT)
In-Reply-To: <20190514204215.27528-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <pproulx@efficios.com>, Jonathan Rajotte-Julien <joraj@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 14, 2019, at 4:42 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

[...]
> 
> #define _$prefix$bt_bitfield_write_be(_ptr, type, _start, _length, _vtype, _v)
> \\
> do {									\\
> -	_vtype __v = (_v);					\\
> +	_vtype __v = (_v);						\\
> 	type *__ptr = CAST_PTR(type *, _ptr);				\\
> 	unsigned long __start = (_start), __length = (_length);		\\
> 	type mask, cmask;						\\
> @@ -740,15 +859,15 @@ do {									\\
> 									\\
> 	/* Trim v high bits */						\\
> 	if (__length < sizeof(__v) * CHAR_BIT)				\\
> -		__v &= ~((~(_vtype) 0) << __length);			\\
> +		__v &= _$prefix$bt_make_mask(_vtype, __length);		\\
> 									\\
> 	/* We can now append v with a simple "or", shift it piece-wise */ \\
> 	this_unit = end_unit - 1;					\\
> 	if (start_unit == end_unit - 1) {				\\
> -		mask = ~((~(type) 0) << ((ts - (end % ts)) % ts));	\\
> +		mask = _$prefix$bt_make_mask(type, (ts - (end % ts)) % ts); \\
> 		if (__start % ts)					\\
> -			mask |= (~((type) 0)) << (ts - (__start % ts));	\\
> -		cmask = (type) __v << ((ts - (end % ts)) % ts);		\\
> +			mask |= _$prefix$bt_make_mask_complement(type, ts - (__start % ts)); \\
> +		cmask = _$prefix$bt_lshift(type, (type) (__v), (ts - (end % ts)) % ts); \\
> 		cmask &= ~mask;						\\
> 		__ptr[this_unit] &= mask;				\\
> 		__ptr[this_unit] |= cmask;				\\
> @@ -756,8 +875,8 @@ do {									\\
> 	}								\\
> 	if (end % ts) {							\\
> 		cshift = end % ts;					\\
> -		mask = ~((~(type) 0) << (ts - cshift));			\\
> -		cmask = (type) __v << (ts - cshift);			\\
> +		mask = _$prefix$bt_make_mask(type, ts - cshift);	\\
> +		cmask = _$prefix$bt_lshift(type, (type) (__v), ts - cshift); \\
> 		cmask &= ~mask;						\\
> 		__ptr[this_unit] &= mask;				\\
> 		__ptr[this_unit] |= cmask;				\\
> @@ -771,7 +890,7 @@ do {									\\
> 		end -= ts;						\\
> 	}								\\
> 	if (__start % ts) {						\\
> -		mask = (~(type) 0) << (ts - (__start % ts));		\\
> +		mask = _$prefix$bt_make_mask(type, ts - (__start % ts)); \\

Should be:

+               mask = _$prefix$bt_make_mask_complement(type, ts - (__start % ts)); \\

Will send an updated patch.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
