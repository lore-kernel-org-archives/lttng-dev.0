From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 08/18] Add serdes functions
 for lttng_channel
Date: Thu, 18 Apr 2019 15:32:30 -0400 (EDT)
Message-ID: <1210351240.1527.1555615950539.JavaMail.zimbra__11030.1044349157$1555615979$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-9-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lTlN5mYPz1KL6
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:32:32 -0400 (EDT)
In-Reply-To: <20190418161850.1536-9-ylamarre@efficios.com>
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

> Since those structs are only transfered across unix sockets, endianess

transfered -> transferred

[...]
> 
> +int init_serialized_extended_channel(struct lttng_domain *domain, struct
> +		lttng_channel_extended_serialized *extended)
> +{
> +	assert(domain && extended);
> +	switch (domain->type) {
> +	case LTTNG_DOMAIN_KERNEL:
> +		extended->monitor_timer_interval =
> +			DEFAULT_KERNEL_CHANNEL_MONITOR_TIMER;
> +		extended->blocking_timeout =
> +			DEFAULT_KERNEL_CHANNEL_BLOCKING_TIMEOUT;
> +		break;
> +	case LTTNG_DOMAIN_UST:
> +		switch (domain->buf_type) {
> +		case LTTNG_BUFFER_PER_UID:
> +			extended->monitor_timer_interval =
> +				DEFAULT_UST_UID_CHANNEL_MONITOR_TIMER;
> +			extended->blocking_timeout =
> +				DEFAULT_UST_UID_CHANNEL_BLOCKING_TIMEOUT;
> +			break;
> +		case LTTNG_BUFFER_PER_PID:
> +		default:
> +			extended->monitor_timer_interval =
> +				DEFAULT_UST_PID_CHANNEL_MONITOR_TIMER;
> +			extended->blocking_timeout =
> +				DEFAULT_UST_PID_CHANNEL_BLOCKING_TIMEOUT;
> +			break;
> +		}

missing break here.

> +	default:
> +		/* Default behavior: leave set to 0. */
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
[...]
> +LTTNG_HIDDEN
> +int lttng_channel_serialize(struct lttng_channel_serialized *dst,
> +		const struct lttng_channel *src)
> +{
> +	assert(src && dst);
> +	struct lttng_channel_attr_serialized *dst_attr = &dst->attr;
> +	const struct lttng_channel_attr *src_attr = &src->attr;

in our coding style, all code follows declarations. So here:

struct lttng_channel_attr_serialized *dst_attr;
const struct lttng_channel_attr *src_attr;

assert(src && dst);
dst_attr = &dst->attr;
src_attr = &src->attr;

(same applies elsewhere)

Thanks,

Mathieu
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
