From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 2/3] Add hash table argument
	to	helper functions
Date: Wed, 3 Oct 2012 12:29:47 -0400
Message-ID: <20121003162947.GB21776__47635.0568388172$1349281858$gmane$org@Krystal>
References: <1349279317-28056-1-git-send-email-dgoulet@efficios.com>
	<1349279317-28056-2-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TJRpV-0006wo-1e
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 12:29:49 -0400
Content-Disposition: inline
In-Reply-To: <1349279317-28056-2-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> This allows these helper functions to be used more broadly across the
> code base and not for a specific hash table.
> 
> Signed-off-by: David Goulet <dgoulet@efficios.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

> ---
>  src/common/consumer.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 7c3762e..6ee366f 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -62,12 +62,15 @@ volatile int consumer_quit = 0;
>   * Find a stream. The consumer_data.lock must be locked during this
>   * call.
>   */
> -static struct lttng_consumer_stream *consumer_find_stream(int key)
> +static struct lttng_consumer_stream *consumer_find_stream(int key,
> +		struct lttng_ht *ht)
>  {
>  	struct lttng_ht_iter iter;
>  	struct lttng_ht_node_ulong *node;
>  	struct lttng_consumer_stream *stream = NULL;
>  
> +	assert(ht);
> +
>  	/* Negative keys are lookup failures */
>  	if (key < 0) {
>  		return NULL;
> @@ -75,8 +78,7 @@ static struct lttng_consumer_stream *consumer_find_stream(int key)
>  
>  	rcu_read_lock();
>  
> -	lttng_ht_lookup(consumer_data.stream_ht, (void *)((unsigned long) key),
> -			&iter);
> +	lttng_ht_lookup(ht, (void *)((unsigned long) key), &iter);
>  	node = lttng_ht_iter_get_node_ulong(&iter);
>  	if (node != NULL) {
>  		stream = caa_container_of(node, struct lttng_consumer_stream, node);
> @@ -87,12 +89,12 @@ static struct lttng_consumer_stream *consumer_find_stream(int key)
>  	return stream;
>  }
>  
> -static void consumer_steal_stream_key(int key)
> +static void consumer_steal_stream_key(int key, struct lttng_ht *ht)
>  {
>  	struct lttng_consumer_stream *stream;
>  
>  	rcu_read_lock();
> -	stream = consumer_find_stream(key);
> +	stream = consumer_find_stream(key, ht);
>  	if (stream) {
>  		stream->key = -1;
>  		/*
> @@ -443,7 +445,7 @@ int consumer_add_stream(struct lttng_consumer_stream *stream)
>  
>  	pthread_mutex_lock(&consumer_data.lock);
>  	/* Steal stream identifier, for UST */
> -	consumer_steal_stream_key(stream->key);
> +	consumer_steal_stream_key(stream->key, consumer_data.stream_ht);
>  
>  	rcu_read_lock();
>  	lttng_ht_lookup(consumer_data.stream_ht,
> @@ -620,7 +622,7 @@ void consumer_change_stream_state(int stream_key,
>  	struct lttng_consumer_stream *stream;
>  
>  	pthread_mutex_lock(&consumer_data.lock);
> -	stream = consumer_find_stream(stream_key);
> +	stream = consumer_find_stream(stream_key, consumer_data.stream_ht);
>  	if (stream) {
>  		stream->state = state;
>  	}
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
