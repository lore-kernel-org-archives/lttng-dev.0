From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-ust] duplicated struct
 ustctl_consumer_channel_attr
Date: Fri, 10 May 2019 16:39:29 -0400 (EDT)
Message-ID: <525034328.877.1557520769219.JavaMail.zimbra__45830.1241089188$1557520789$gmane$org@efficios.com>
References: <46193ce3-1320-a982-2cb2-7f5d11596195@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4512BV4JKrz1KPd
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 16:39:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id EA3DE1E3641
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 16:39:29 -0400 (EDT)
In-Reply-To: <46193ce3-1320-a982-2cb2-7f5d11596195@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 10, 2019, at 3:35 PM, Sebastien Boisvert sboisvert@gydle.com wrote:

> Hello,
> 
> As suggested by Jonathan [1], I should start a new email thread.
> 
> Why are there 2 identical declarations of struct ustctl_consumer_channel_attr
> (one in lttng-ust, one in lttng-tools) instead of just one ?
> 
> It just seems redundant to me.

Answering this very relevant question requires recalling a bit of lttng 2.x
history.

Back when we introduced lttng-ust support into the lttng-tools project:

commit 3bd1e0819b577ffcb44acd7c2f8e02ff09654b7b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sat Oct 22 21:06:11 2011 -0400

    UST 2.0 support

lttng-tools required lttng-ust as a dependency. Also, in retrospect,
this initial implementation did not properly encapsulate the parts that
were interacting with lttng-ust.

However, some users wanted to build lttng-tools only for kernel tracing,
without lttng-ust at all, so we eventually had to introduce the configure
option "--disable-lttng-ust" (now "--without-lttng-ust"):

commit 74d0b6427faafd5f5d59b7e9d5f78ac52924a7a2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Nov 4 07:32:26 2011 -0400

    LTTng-UST support: --disable-lttng-ust build option

That was needed prior to the 2.0 release. The fastest way to make it
happen was to replicate the UST abi header within the tools tree,
otherwise a rather large refactoring of the code base would have
been required, and time constraints did not allow it. The
lttng-ust-abi.h "stub" header was introduced by:

commit 2bdd86d4c47902237c691d3c5409f32f205df81e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 27 14:33:28 2011 +0200

    UST support: add UST control commands

So yes, ideally we would ensure that we properly split all functions that
depend on the lttng-ust ABI into separate objects, and not build them if
lttng-ust is disabled. We would also need to refactor some internal structures
of the session daemon so they do not depend on lttng-ust ABIs structures.

Unfortunately, we never found time to tackle this refactoring since then, so
we still live with this 8 years old band-aid. :-/

Thanks,

Mathieu

> 
> 
> [sboisvert@GT480:lttng-ust]$ grep "struct ustctl_consumer_channel_attr {" -A 11
> include/lttng/ust-ctl.h
> struct ustctl_consumer_channel_attr {
>	enum lttng_ust_chan_type type;
>	uint64_t subbuf_size;			/* bytes */
>	uint64_t num_subbuf;			/* power of 2 */
>	int overwrite;				/* 1: overwrite, 0: discard */
>	unsigned int switch_timer_interval;	/* usec */
>	unsigned int read_timer_interval;	/* usec */
>	enum lttng_ust_output output;		/* splice, mmap */
>	uint32_t chan_id;			/* channel ID */
>	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
>	int64_t blocking_timeout;			/* Blocking timeout (usec) */
> } LTTNG_PACKED;
> 
> 
> [sboisvert@GT480:lttng-tools]$ grep "struct ustctl_consumer_channel_attr {" -A
> 11 src/bin/lttng-sessiond/lttng-ust-ctl.h
> struct ustctl_consumer_channel_attr {
>	enum lttng_ust_chan_type type;
>	uint64_t subbuf_size;			/* bytes */
>	uint64_t num_subbuf;			/* power of 2 */
>	int overwrite;				/* 1: overwrite, 0: discard */
>	unsigned int switch_timer_interval;	/* usec */
>	unsigned int read_timer_interval;	/* usec */
>	enum lttng_ust_output output;		/* splice, mmap */
>	uint32_t chan_id;			/* channel ID */
>	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
>	int64_t blocking_timeout;			/* Blocking timeout (usec) */
> } LTTNG_PACKED;
> 
> 
> ----
> [1] https://lists.lttng.org/pipermail/lttng-dev/2019-May/028894.html
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
