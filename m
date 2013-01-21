From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-ust] Introduce hash table
	for	lttng_create_event_if_missing()
Date: Mon, 21 Jan 2013 14:06:02 -0500
Message-ID: <20130121190602.GD7137__39515.6167717234$1358795209$gmane$org@Krystal>
References: <0AF7BA51953555439020FD85D854801F039A5D@eusaamb105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxMh1-0004yw-Oe
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 14:06:03 -0500
Content-Disposition: inline
In-Reply-To: <0AF7BA51953555439020FD85D854801F039A5D@eusaamb105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anik Mishra <anik.mishra@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Anik Mishra (anik.mishra@ericsson.com) wrote:
> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] 
> Sent: January-16-13 10:15 AM
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] [RFC PATCH lttng-ust] Introduce hash table for lttng_create_event_if_missing()
> 
> [...]
> @@ -329,17 +331,19 @@ int lttng_event_create(const struct lttng_event_desc *desc,  {
> [...]
> -	/*
> -	 * This is O(n^2) (for each event, the loop is called at event
> -	 * creation). Might require a hash if we have lots of events.
> -	 */
> -	cds_list_for_each_entry(event, &chan->session->events_head, node) {
> +	hash = jhash(event_name, name_len, 0);
> +	head = &chan->session->events_ht.table[hash & (LTTNG_UST_EVENT_HT_SIZE - 1)];
> +	cds_hlist_for_each_entry(event, node, head, hlist) {
>  [...]
> 
> From other code:
> #define LTTNG_UST_EVENT_HT_BITS            6
> #define LTTNG_UST_EVENT_HT_SIZE            (1U << LTTNG_UST_EVENT_HT_BITS)
> 
> The way I read this,  if there's a substantial number of events,
> you're just dividing the time required by a constant 64. The
> complexity remains the same. Are you sure this is really a long term
> solution?

If we have much more than 10k _different_ TRACEPOINT_EVENT in the code,
we'll probably have other issues to fix.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
