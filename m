From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 3/4] Make stream hash
	tables	global to the consumer
Date: Mon, 15 Oct 2012 13:57:54 -0400
Message-ID: <20121015175754.GB9423__27658.5113759667$1350323903$gmane$org@Krystal>
References: <1350052235-12198-1-git-send-email-dgoulet@efficios.com>
	<1350052235-12198-3-git-send-email-dgoulet@efficios.com>
	<20121013155615.GC29985@Krystal> <507C3013.2050405@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TNovM-0003d9-PY
	for lttng-dev@lists.lttng.org; Mon, 15 Oct 2012 13:57:56 -0400
Content-Disposition: inline
In-Reply-To: <507C3013.2050405@efficios.com>
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
> 
> 
> Mathieu Desnoyers:
> > * David Goulet (dgoulet@efficios.com) wrote:
> >> The data stream hash table is now global to the consumer and used in the
> >> data thread. The consumer_data stream_ht is no longer used to track the
> >> data streams but instead will be used (and possibly renamed) by the
> >> session daemon poll thread to keep track of streams on a per session id
> >> basis for the upcoming feature that check traced data availability.
> >>
> >> For now, in order to avoid mind bugging problems to access the streams,
> >> both hash table are now defined globally (metadata and data). However,
> >> stream update are still done in a single thread. Don't count on this to
> >> be guaranteed in the next commits.
> >>
> >> Signed-off-by: David Goulet <dgoulet@efficios.com>
> >> ---
> >>  src/common/consumer.c                  |   91 +++++++++++++++++++++++++-------
> >>  src/common/consumer.h                  |    9 ++--
> >>  src/common/ust-consumer/ust-consumer.c |    2 -
> >>  3 files changed, 75 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/src/common/consumer.c b/src/common/consumer.c
> >> index 1d2b1f7..1fb9960 100644
> >> --- a/src/common/consumer.c
> >> +++ b/src/common/consumer.c
> >> @@ -59,6 +59,17 @@ int consumer_poll_timeout = -1;
> >>  volatile int consumer_quit = 0;
> >>  
> >>  /*
> >> + * The following two hash tables are visible by all threads which are separated
> >> + * in different source files.
> >> + *
> >> + * Global hash table containing respectively metadata and data streams. The
> >> + * stream element in this ht should only be updated by the metadata poll thread
> >> + * for the metadata and the data poll thread for the data.
> >> + */
> >> +struct lttng_ht *metadata_ht = NULL;
> >> +struct lttng_ht *data_ht = NULL;
> >> +
> >> +/*
> >>   * Find a stream. The consumer_data.lock must be locked during this
> >>   * call.
> >>   */
> >> @@ -433,19 +444,24 @@ end:
> >>  /*
> >>   * Add a stream to the global list protected by a mutex.
> >>   */
> >> -int consumer_add_stream(struct lttng_consumer_stream *stream)
> >> +static int consumer_add_stream(struct lttng_consumer_stream *stream,
> >> +		struct lttng_ht *ht)
> >>  {
> >>  	int ret = 0;
> >>  	struct consumer_relayd_sock_pair *relayd;
> >>  
> >>  	assert(stream);
> >> +	assert(ht);
> >>  
> >>  	DBG3("Adding consumer stream %d", stream->key);
> >>  
> >>  	pthread_mutex_lock(&consumer_data.lock);
> >>  	rcu_read_lock();
> >>  
> >> -	lttng_ht_add_unique_ulong(consumer_data.stream_ht, &stream->node);
> >> +	/* Steal stream identifier to avoid having streams with the same key */
> >> +	consumer_steal_stream_key(stream->key, ht);
> > 
> > I don't understand why suddenly this change is needed. Considering what
> > this patch should be doing (just moving a ht from per-thread to global),
> > it should not have any behavior impact.
> 
> We move the steal stream key from the sessiond thread to the add_stream
> function call since we do not use the consumer_data hash table anymore
> (stream_ht) and uses per thread hashtable (global for now though).
> 
> If you look below, you'll see that the steal stream key call is removed
> (using the consumer data stream_ht).
> 
> This commit makes sure that both consumer_add_stream and
> add_metadata_stream steal the stream key if needed.

ok, makes sense.

Thanks!

Mathieu

> 
> Thanks
> David
> 
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> >> +
> >> +	lttng_ht_add_unique_ulong(ht, &stream->node);
> >>  
> >>  	/* Check and cleanup relayd */
> >>  	relayd = consumer_find_relayd(stream->net_seq_idx);
> >> @@ -783,9 +799,9 @@ end:
> >>   *
> >>   * Returns the number of fds in the structures.
> >>   */
> >> -int consumer_update_poll_array(
> >> +static int consumer_update_poll_array(
> >>  		struct lttng_consumer_local_data *ctx, struct pollfd **pollfd,
> >> -		struct lttng_consumer_stream **local_stream)
> >> +		struct lttng_consumer_stream **local_stream, struct lttng_ht *ht)
> >>  {
> >>  	int i = 0;
> >>  	struct lttng_ht_iter iter;
> >> @@ -793,8 +809,7 @@ int consumer_update_poll_array(
> >>  
> >>  	DBG("Updating poll fd array");
> >>  	rcu_read_lock();
> >> -	cds_lfht_for_each_entry(consumer_data.stream_ht->ht, &iter.iter, stream,
> >> -			node.node) {
> >> +	cds_lfht_for_each_entry(ht->ht, &iter.iter, stream, node.node) {
> >>  		if (stream->state != LTTNG_CONSUMER_ACTIVE_STREAM) {
> >>  			continue;
> >>  		}
> >> @@ -1523,6 +1538,33 @@ int lttng_consumer_recv_cmd(struct lttng_consumer_local_data *ctx,
> >>  /*
> >>   * Iterate over all streams of the hashtable and free them properly.
> >>   *
> >> + * WARNING: *MUST* be used with data stream only.
> >> + */
> >> +static void destroy_data_stream_ht(struct lttng_ht *ht)
> >> +{
> >> +	int ret;
> >> +	struct lttng_ht_iter iter;
> >> +	struct lttng_consumer_stream *stream;
> >> +
> >> +	if (ht == NULL) {
> >> +		return;
> >> +	}
> >> +
> >> +	rcu_read_lock();
> >> +	cds_lfht_for_each_entry(ht->ht, &iter.iter, stream, node.node) {
> >> +		ret = lttng_ht_del(ht, &iter);
> >> +		assert(!ret);
> >> +
> >> +		call_rcu(&stream->node.head, consumer_free_stream);
> >> +	}
> >> +	rcu_read_unlock();
> >> +
> >> +	lttng_ht_destroy(ht);
> >> +}
> >> +
> >> +/*
> >> + * Iterate over all streams of the hashtable and free them properly.
> >> + *
> >>   * XXX: Should not be only for metadata stream or else use an other name.
> >>   */
> >>  static void destroy_stream_ht(struct lttng_ht *ht)
> >> @@ -1711,6 +1753,9 @@ static int consumer_add_metadata_stream(struct lttng_consumer_stream *stream,
> >>  		uatomic_dec(&stream->chan->nb_init_streams);
> >>  	}
> >>  
> >> +	/* Steal stream identifier to avoid having streams with the same key */
> >> +	consumer_steal_stream_key(stream->key, ht);
> >> +
> >>  	lttng_ht_add_unique_ulong(ht, &stream->waitfd_node);
> >>  	rcu_read_unlock();
> >>  
> >> @@ -1729,7 +1774,6 @@ void *consumer_thread_metadata_poll(void *data)
> >>  	struct lttng_consumer_stream *stream = NULL;
> >>  	struct lttng_ht_iter iter;
> >>  	struct lttng_ht_node_ulong *node;
> >> -	struct lttng_ht *metadata_ht = NULL;
> >>  	struct lttng_poll_event events;
> >>  	struct lttng_consumer_local_data *ctx = data;
> >>  	ssize_t len;
> >> @@ -1738,11 +1782,6 @@ void *consumer_thread_metadata_poll(void *data)
> >>  
> >>  	DBG("Thread metadata poll started");
> >>  
> >> -	metadata_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> >> -	if (metadata_ht == NULL) {
> >> -		goto end;
> >> -	}
> >> -
> >>  	/* Size is set to 1 for the consumer_metadata pipe */
> >>  	ret = lttng_poll_create(&events, 2, LTTNG_CLOEXEC);
> >>  	if (ret < 0) {
> >> @@ -1918,6 +1957,11 @@ void *consumer_thread_data_poll(void *data)
> >>  
> >>  	rcu_register_thread();
> >>  
> >> +	data_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> >> +	if (data_ht == NULL) {
> >> +		goto end;
> >> +	}
> >> +
> >>  	local_stream = zmalloc(sizeof(struct lttng_consumer_stream));
> >>  
> >>  	while (1) {
> >> @@ -1955,7 +1999,8 @@ void *consumer_thread_data_poll(void *data)
> >>  				pthread_mutex_unlock(&consumer_data.lock);
> >>  				goto end;
> >>  			}
> >> -			ret = consumer_update_poll_array(ctx, &pollfd, local_stream);
> >> +			ret = consumer_update_poll_array(ctx, &pollfd, local_stream,
> >> +					data_ht);
> >>  			if (ret < 0) {
> >>  				ERR("Error in allocating pollfd or local_outfds");
> >>  				lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_POLL_ERROR);
> >> @@ -2015,7 +2060,7 @@ void *consumer_thread_data_poll(void *data)
> >>  				continue;
> >>  			}
> >>  
> >> -			ret = consumer_add_stream(new_stream);
> >> +			ret = consumer_add_stream(new_stream, data_ht);
> >>  			if (ret) {
> >>  				ERR("Consumer add stream %d failed. Continuing",
> >>  						new_stream->key);
> >> @@ -2088,22 +2133,19 @@ void *consumer_thread_data_poll(void *data)
> >>  			if ((pollfd[i].revents & POLLHUP)) {
> >>  				DBG("Polling fd %d tells it has hung up.", pollfd[i].fd);
> >>  				if (!local_stream[i]->data_read) {
> >> -					consumer_del_stream(local_stream[i],
> >> -							consumer_data.stream_ht);
> >> +					consumer_del_stream(local_stream[i], data_ht);
> >>  					num_hup++;
> >>  				}
> >>  			} else if (pollfd[i].revents & POLLERR) {
> >>  				ERR("Error returned in polling fd %d.", pollfd[i].fd);
> >>  				if (!local_stream[i]->data_read) {
> >> -					consumer_del_stream(local_stream[i],
> >> -							consumer_data.stream_ht);
> >> +					consumer_del_stream(local_stream[i], data_ht);
> >>  					num_hup++;
> >>  				}
> >>  			} else if (pollfd[i].revents & POLLNVAL) {
> >>  				ERR("Polling fd %d tells fd is not open.", pollfd[i].fd);
> >>  				if (!local_stream[i]->data_read) {
> >> -					consumer_del_stream(local_stream[i],
> >> -							consumer_data.stream_ht);
> >> +					consumer_del_stream(local_stream[i], data_ht);
> >>  					num_hup++;
> >>  				}
> >>  			}
> >> @@ -2131,6 +2173,10 @@ end:
> >>  	 */
> >>  	close(ctx->consumer_metadata_pipe[1]);
> >>  
> >> +	if (data_ht) {
> >> +		destroy_data_stream_ht(data_ht);
> >> +	}
> >> +
> >>  	rcu_unregister_thread();
> >>  	return NULL;
> >>  }
> >> @@ -2299,6 +2345,11 @@ void lttng_consumer_init(void)
> >>  	consumer_data.stream_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> >>  	consumer_data.channel_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> >>  	consumer_data.relayd_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> >> +
> >> +	metadata_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> >> +	assert(metadata_ht);
> >> +	data_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> >> +	assert(data_ht);
> >>  }
> >>  
> >>  /*
> >> diff --git a/src/common/consumer.h b/src/common/consumer.h
> >> index 8e5891a..6bce96d 100644
> >> --- a/src/common/consumer.h
> >> +++ b/src/common/consumer.h
> >> @@ -275,6 +275,10 @@ struct lttng_consumer_global_data {
> >>  	struct lttng_ht *relayd_ht;
> >>  };
> >>  
> >> +/* Defined in consumer.c and coupled with explanations */
> >> +extern struct lttng_ht *metadata_ht;
> >> +extern struct lttng_ht *data_ht;
> >> +
> >>  /*
> >>   * Init consumer data structures.
> >>   */
> >> @@ -324,10 +328,6 @@ extern void lttng_consumer_sync_trace_file(
> >>   */
> >>  extern int lttng_consumer_poll_socket(struct pollfd *kconsumer_sockpoll);
> >>  
> >> -extern int consumer_update_poll_array(
> >> -		struct lttng_consumer_local_data *ctx, struct pollfd **pollfd,
> >> -		struct lttng_consumer_stream **local_consumer_streams);
> >> -
> >>  extern struct lttng_consumer_stream *consumer_allocate_stream(
> >>  		int channel_key, int stream_key,
> >>  		int shm_fd, int wait_fd,
> >> @@ -340,7 +340,6 @@ extern struct lttng_consumer_stream *consumer_allocate_stream(
> >>  		int net_index,
> >>  		int metadata_flag,
> >>  		int *alloc_ret);
> >> -extern int consumer_add_stream(struct lttng_consumer_stream *stream);
> >>  extern void consumer_del_stream(struct lttng_consumer_stream *stream,
> >>  		struct lttng_ht *ht);
> >>  extern void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
> >> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
> >> index 4ca4b84..3b41e55 100644
> >> --- a/src/common/ust-consumer/ust-consumer.c
> >> +++ b/src/common/ust-consumer/ust-consumer.c
> >> @@ -233,8 +233,6 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
> >>  			consumer_del_stream(new_stream, NULL);
> >>  			goto end_nosignal;
> >>  		}
> >> -		/* Steal stream identifier to avoid having streams with the same key */
> >> -		consumer_steal_stream_key(new_stream->key, consumer_data.stream_ht);
> >>  
> >>  		/* The stream is not metadata. Get relayd reference if exists. */
> >>  		relayd = consumer_find_relayd(msg.u.stream.net_index);
> >> -- 
> >> 1.7.10.4
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
