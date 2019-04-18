From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 07/18] Add serialized
 versions of lttng_channel structs
Date: Thu, 18 Apr 2019 15:38:41 -0400 (EDT)
Message-ID: <1152533262.1544.1555616321837.JavaMail.zimbra__27895.7950462186$1555616338$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-8-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44lTtW0BpFz1KM3
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:38:42 -0400 (EDT)
In-Reply-To: <20190418161850.1536-8-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Apr 18, 2019, at 12:18 PM, Yannick Lamarre ylamarre@efficios.com wrote:

> Serialized versions of lttng_channel and lttng_channel_extended are
> packed structures to be used in communication protocols for consistent
> sizes across platforms. The serialized versions are stripped of pointers
> and padding.
> 
> Pointers are removed since their size can vary on platforms supporting
> variable sized registers (x86-64).

I don't understand this explanation. I think it's mostly that we have
situations where x86-32 processes interact with x86-64 processes, and
since this is within a communication protocol between processes over
unix socket, it breaks because of pointer size mismatch.

> Padding is also removed since it defeats the purpose of a packed struct.

Not necessarily. Padding was how we extend each command as the protocol evolves.
If we remove padding, how do we plan to extend those in the future ? This commit
documentat how we plan to extend those from now on.

Thanks,

Mathieu


> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> include/lttng/channel-internal.h | 30 ++++++++++++++++++++++++++++++
> 1 file changed, 30 insertions(+)
> 
> diff --git a/include/lttng/channel-internal.h b/include/lttng/channel-internal.h
> index 030b4701..c956c19d 100644
> --- a/include/lttng/channel-internal.h
> +++ b/include/lttng/channel-internal.h
> @@ -20,11 +20,41 @@
> 
> #include <common/macros.h>
> 
> +struct lttng_channel_attr_serialized {
> +	int overwrite;                      /* -1: session default, 1: overwrite, 0:
> discard */
> +	uint64_t subbuf_size;               /* bytes, power of 2 */
> +	uint64_t num_subbuf;                /* power of 2 */
> +	unsigned int switch_timer_interval; /* usec */
> +	unsigned int read_timer_interval;   /* usec */
> +	uint32_t output; /* enum lttng_event_output */
> +	/* LTTng 2.1 padding limit */
> +	uint64_t tracefile_size;            /* bytes */
> +	uint64_t tracefile_count;           /* number of tracefiles */
> +	/* LTTng 2.3 padding limit */
> +	unsigned int live_timer_interval;   /* usec */
> +	/* LTTng 2.7 padding limit */
> +
> +} LTTNG_PACKED;
> +
> +struct lttng_channel_serialized {
> +	char name[LTTNG_SYMBOL_NAME_LEN];
> +	uint32_t enabled;
> +	struct lttng_channel_attr_serialized attr;
> +
> +} LTTNG_PACKED;
> +
> struct lttng_channel_extended {
> 	uint64_t discarded_events;
> 	uint64_t lost_packets;
> 	uint64_t monitor_timer_interval;
> 	int64_t blocking_timeout;
> +};
> +
> +struct lttng_channel_extended_serialized {
> +	uint64_t discarded_events;
> +	uint64_t lost_packets;
> +	uint64_t monitor_timer_interval;
> +	int64_t blocking_timeout;
> } LTTNG_PACKED;
> 
> #endif /* LTTNG_CHANNEL_INTERNAL_H */
> --
> 2.11.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
