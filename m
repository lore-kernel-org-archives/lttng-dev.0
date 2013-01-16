From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC PATCH lttng-ust] Introduce hash table
	for	lttng_create_event_if_missing()
Date: Wed, 16 Jan 2013 10:53:18 -0500
Message-ID: <50F6CCEE.4040903__24823.2694030323$1358351707$gmane$org@efficios.com>
References: <20130116151446.GA11082@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TvVIo-0005cK-0N
	for lttng-dev@lists.lttng.org; Wed, 16 Jan 2013 10:53:22 -0500
In-Reply-To: <20130116151446.GA11082@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Acked-by: David Goulet <dgoulet@efficios.com>

Mathieu Desnoyers:
> lttng_create_event_if_missing() takes a lot of CPU time with stress-test
> applications containing 1000 different TRACEPOINT_EVENT() and 1000
> individual tracepoint() call-site.
> 
> With tracing disabled:
> 
> time ./AppWith1000_lines_TP 0
> 
> real    0m2.487s
> user    0m2.424s
> sys     0m0.000s
> 
> 
> Introducing this hash table cuts the overhead very significantly when
> tracing is enabled:
> 
> Before patch:
> 
>  72.16%  AppWith1000_lin  liblttng-ust.so.0.0.0             [.] lttng_create_event_if_missing
>  25.64%  AppWith1000_lin  AppWith1000_lines_TP              [.] a(int)
> 
> time ./AppWith1000_lines_TP 0
> 
> real    0m7.946s
> user    0m7.864s
> sys     0m0.000s
> 
> 
> After patch:
> 
>  89.13%  AppWith1000_lin  AppWith1000_lines_TP              [.] a(int)
>   3.30%  AppWith1000_lin  liblttng-ust.so.0.0.0             [.] lttng_create_event_if_missing
> 
> time ./AppWith1000_lines_TP 0
> 
> real    0m2.762s
> user    0m2.692s
> sys     0m0.004s
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
> index 095fb1e..1db8e58 100644
> --- a/include/lttng/ust-events.h
> +++ b/include/lttng/ust-events.h
> @@ -362,6 +362,7 @@ struct lttng_event {
>  	int has_enablers_without_bytecode;
>  	/* Backward references: list of lttng_enabler_ref (ref to enablers) */
>  	struct cds_list_head enablers_ref_head;
> +	struct cds_hlist_node hlist;	/* session ht of events */
>  };
>  
>  struct channel;
> @@ -467,6 +468,7 @@ struct lttng_session {
>  	/* New UST 2.1 */
>  	/* List of enablers */
>  	struct cds_list_head enablers_head;
> +	struct lttng_ust_event_ht events_ht;	/* ht of events */
>  };
>  
>  struct lttng_transport {
> diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
> index 5e6c90c..f70c65f 100644
> --- a/liblttng-ust/lttng-events.c
> +++ b/liblttng-ust/lttng-events.c
> @@ -127,7 +127,7 @@ void synchronize_trace(void)
>  struct lttng_session *lttng_session_create(void)
>  {
>  	struct lttng_session *session;
> -	int ret;
> +	int ret, i;
>  
>  	session = zmalloc(sizeof(struct lttng_session));
>  	if (!session)
> @@ -135,6 +135,8 @@ struct lttng_session *lttng_session_create(void)
>  	CDS_INIT_LIST_HEAD(&session->chan_head);
>  	CDS_INIT_LIST_HEAD(&session->events_head);
>  	CDS_INIT_LIST_HEAD(&session->enablers_head);
> +	for (i = 0; i < LTTNG_UST_EVENT_HT_SIZE; i++)
> +		CDS_INIT_HLIST_HEAD(&session->events_ht.table[i]);
>  	ret = lttng_ust_uuid_generate(session->uuid);
>  	if (ret != 0) {
>  		session->uuid[0] = '\0';
> @@ -329,17 +331,19 @@ int lttng_event_create(const struct lttng_event_desc *desc,
>  {
>  	const char *event_name = desc->name;
>  	struct lttng_event *event;
> +	struct cds_hlist_head *head;
> +	struct cds_hlist_node *node;
>  	int ret = 0;
> +	size_t name_len = strlen(event_name);
> +	uint32_t hash;
>  
>  	if (chan->used_event_id == -1U) {
>  		ret = -ENOMEM;
>  		goto full;
>  	}
> -	/*
> -	 * This is O(n^2) (for each event, the loop is called at event
> -	 * creation). Might require a hash if we have lots of events.
> -	 */
> -	cds_list_for_each_entry(event, &chan->session->events_head, node) {
> +	hash = jhash(event_name, name_len, 0);
> +	head = &chan->session->events_ht.table[hash & (LTTNG_UST_EVENT_HT_SIZE - 1)];
> +	cds_hlist_for_each_entry(event, node, head, hlist) {
>  		assert(event->desc);
>  		if (!strncmp(event->desc->name,
>  				desc->name,
> @@ -380,6 +384,7 @@ int lttng_event_create(const struct lttng_event_desc *desc,
>  	if (ret)
>  		goto statedump_error;
>  	cds_list_add(&event->node, &chan->session->events_head);
> +	cds_hlist_add_head(&event->hlist, head);
>  	return 0;
>  
>  statedump_error:
> @@ -499,17 +504,24 @@ void lttng_create_event_if_missing(struct lttng_enabler *enabler)
>  	cds_list_for_each_entry(probe_desc, probe_list, head) {
>  		for (i = 0; i < probe_desc->nr_events; i++) {
>  			int found = 0, ret;
> +			struct cds_hlist_head *head;
> +			struct cds_hlist_node *node;
> +			const char *event_name;
> +			size_t name_len;
> +			uint32_t hash;
>  
>  			desc = probe_desc->event_desc[i];
>  			if (!lttng_desc_match_enabler(desc, enabler))
>  				continue;
> +			event_name = desc->name;
> +			name_len = strlen(event_name);
>  
>  			/*
> -			 * For each event in session event list,
> -			 * check if already created.
> +			 * Check if already created.
>  			 */
> -			cds_list_for_each_entry(event,
> -					&session->events_head, node) {
> +			hash = jhash(event_name, name_len, 0);
> +			head = &session->events_ht.table[hash & (LTTNG_UST_EVENT_HT_SIZE - 1)];
> +			cds_hlist_for_each_entry(event, node, head, hlist) {
>  				if (event->desc == desc)
>  					found = 1;
>  			}
> 
