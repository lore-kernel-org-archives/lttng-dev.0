From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH v4] ABI with support for compat
	32/64 bits
Date: Mon, 1 Oct 2012 17:27:16 -0400
Message-ID: <20121001212716.GB22077__36888.5239972316$1349126879$gmane$org@Krystal>
References: <1349124140-3224-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TInWK-0001wg-0d
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 17:27:20 -0400
Content-Disposition: inline
In-Reply-To: <1349124140-3224-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
[...]
> +#define LTTNG_KERNEL_CHANNEL_PADDING1 LTTNG_SYMBOL_NAME_LEN + 32
> +struct lttng_kernel_channel {
> +	uint64_t subbuf_size;               /* bytes */
> +	uint64_t num_subbuf;                /* power of 2 */
> +	unsigned int switch_timer_interval; /* usec */
> +	unsigned int read_timer_interval;   /* usec */

->

> +	int overwrite;                      /* 1: overwrite, 0: discard */
> +	enum lttng_event_output output;     /* splice, mmap */

field order mismatch with lttng-modules. Please re-review all structures
between modules and tools headers.

Thanks,

Mathieu

> +
> +	char padding[LTTNG_KERNEL_CHANNEL_PADDING1];
> +}__attribute__((packed));
>  
>  #endif /* _LTTNG_KERNEL_H */
> -- 
> 1.7.9.5
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
