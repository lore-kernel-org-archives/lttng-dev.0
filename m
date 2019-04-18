From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 13/18] Add serialized
 versions of lttng_event structs
Date: Thu, 18 Apr 2019 15:45:26 -0400 (EDT)
Message-ID: <1616121401.1570.1555616726710.JavaMail.zimbra__33170.5691687361$1555616796$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-14-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lV2H4Gwmz1KQY
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:45:27 -0400 (EDT)
In-Reply-To: <20190418161850.1536-14-ylamarre@efficios.com>
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

> Serialized versions of lttng_event, lttng_event_function_attr and
> lttng_event_probe_attr are packed structures to be used in communication
> protocols for consistent sizes across platforms. The serialized versions are
> stripped of pointers and padding.
> 
> Pointers are removed since their size can vary on platforms supporting
> variable sized registers (x86-64).

Same question about explanation as prior commits.

> Padding is also removed since it defeats the purpose of a packed struct.

Same question about documenting how the protocol is expected to be extended
as prior commits.

Thanks,

Mathieu

> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> include/lttng/event-internal.h | 38 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 38 insertions(+)
> 
> diff --git a/include/lttng/event-internal.h b/include/lttng/event-internal.h
> index 09b4d232..a43007de 100644
> --- a/include/lttng/event-internal.h
> +++ b/include/lttng/event-internal.h
> @@ -27,6 +27,44 @@
> 
> struct lttng_userspace_probe_location;
> 
> +struct lttng_event_probe_attr_serialized {
> +	uint64_t addr;
> +
> +	uint64_t offset;
> +	char symbol_name[LTTNG_SYMBOL_NAME_LEN];
> +} LTTNG_PACKED;
> +
> +struct lttng_event_function_attr_serialized {
> +	char symbol_name[LTTNG_SYMBOL_NAME_LEN];
> +} LTTNG_PACKED;
> +
> +struct lttng_event_serialized {
> +	uint32_t type; /* enum lttng_event_type */
> +
> +	char name[LTTNG_SYMBOL_NAME_LEN];
> +
> +	uint32_t loglevel_type; /* enum lttng_loglevel_type */
> +
> +	int loglevel;
> +
> +	int32_t enabled;	/* Does not apply: -1 */
> +
> +	pid_t pid;
> +
> +	unsigned char filter;	/* filter enabled ? */
> +
> +	unsigned char exclusion; /* exclusions added ? */
> +
> +	/* Event flag, from 2.6 and above. */
> +	uint32_t flags; /* enum lttng_event_flag */
> +
> +	/* Per event type configuration */
> +	union {
> +		struct lttng_event_probe_attr_serialized probe;
> +		struct lttng_event_function_attr_serialized ftrace;
> +	} attr;
> +} LTTNG_PACKED;
> +
> struct lttng_event_perf_counter_ctx_serialized {
> 	uint32_t type;
> 	uint64_t config;
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
