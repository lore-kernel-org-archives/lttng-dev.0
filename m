From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 2/4] Move add data stream to	the
	data thread
Date: Mon, 15 Oct 2012 13:31:01 -0400
Message-ID: <20121015173101.GA9142__19992.6927256913$1350322300$gmane$org@Krystal>
References: <1350052235-12198-1-git-send-email-dgoulet@efficios.com>
	<1350052235-12198-2-git-send-email-dgoulet@efficios.com>
	<20121013155313.GB29985@Krystal> <507C2E6F.9050107@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TNoVM-0003LQ-03
	for lttng-dev@lists.lttng.org; Mon, 15 Oct 2012 13:31:04 -0400
Content-Disposition: inline
In-Reply-To: <507C2E6F.9050107@efficios.com>
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
> >> As a second step of refactoring, upon receiving a data stream, we send
> >> it to the data thread that is now in charge of handling it.
> >>
> >> Furthermore, in order for this to behave correctly, we have to make the
> >> ustctl actions on the stream upon before passing it to the right thread
> >> (the kernel does not need special actions.). This way, once the sessiond
> >> thread reply back to the session daemon, the stream is sure to be open
> >> and ready for data to be recorded on the application side so we avoid a
> >> race between the application thinking the stream is ready and the stream
> >> thread still scheduled out.
> > 
> > Normally, as long as we have a reference on the SHM file descriptor, and
> > we have the wakeup FD, we should be good to fetch the data of buffers
> > belonging to an application that has already exited, even if it did so
> > before the ustctl calls are done.
> > 
> > So I'm wondering why you do the ustctl calls in the sessiond thread ? It
> > seems to complexify the implementation needlessly: we could still do the
> > ustctl calls and output file open at the same location, the
> > data/metadata threads.
> 
> Hmmm, it was my understanding that does

does -> those

> ustctl_* calls were needed
> before the trace could be recording thus making them quickly. Wrong?

Can you rephrase your question ? I don't understand.

Thanks,

Mathieu

> 
> David
> 
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> >>
> >> This commit should speed up the add stream process for the session
> >> daemon. There is still some actions to move out of the session daemon
> >> poll thread to gain speed significantly, especially for network
> >> streaming.
> >>
> >> Signed-off-by: David Goulet <dgoulet@efficios.com>
> >> ---
> >>  src/common/consumer.c                        |  123 +++++++++++---------------
> >>  src/common/consumer.h                        |    1 +
> >>  src/common/kernel-consumer/kernel-consumer.c |   24 ++---
> >>  src/common/ust-consumer/ust-consumer.c       |   40 ++++-----
> >>  4 files changed, 78 insertions(+), 110 deletions(-)
> >>
> >> diff --git a/src/common/consumer.c b/src/common/consumer.c
> >> index 055de1b..1d2b1f7 100644
> >> --- a/src/common/consumer.c
> >> +++ b/src/common/consumer.c
> >> @@ -89,7 +89,7 @@ static struct lttng_consumer_stream *consumer_find_stream(int key,
> >>  	return stream;
> >>  }
> >>  
> >> -static void consumer_steal_stream_key(int key, struct lttng_ht *ht)
> >> +void consumer_steal_stream_key(int key, struct lttng_ht *ht)
> >>  {
> >>  	struct lttng_consumer_stream *stream;
> >>  
> >> @@ -409,6 +409,14 @@ struct lttng_consumer_stream *consumer_allocate_stream(
> >>  	lttng_ht_node_init_ulong(&stream->waitfd_node, stream->wait_fd);
> >>  	lttng_ht_node_init_ulong(&stream->node, stream->key);
> >>  
> >> +	/*
> >> +	 * The cpu number is needed before using any ustctl_* actions. Ignored for
> >> +	 * the kernel so the value does not matter.
> >> +	 */
> >> +	pthread_mutex_lock(&consumer_data.lock);
> >> +	stream->cpu = stream->chan->cpucount++;
> >> +	pthread_mutex_unlock(&consumer_data.lock);
> >> +
> >>  	DBG3("Allocated stream %s (key %d, shm_fd %d, wait_fd %d, mmap_len %llu,"
> >>  			" out_fd %d, net_seq_idx %d)", stream->path_name, stream->key,
> >>  			stream->shm_fd, stream->wait_fd,
> >> @@ -437,28 +445,6 @@ int consumer_add_stream(struct lttng_consumer_stream *stream)
> >>  	pthread_mutex_lock(&consumer_data.lock);
> >>  	rcu_read_lock();
> >>  
> >> -	switch (consumer_data.type) {
> >> -	case LTTNG_CONSUMER_KERNEL:
> >> -		break;
> >> -	case LTTNG_CONSUMER32_UST:
> >> -	case LTTNG_CONSUMER64_UST:
> >> -		stream->cpu = stream->chan->cpucount++;
> >> -		ret = lttng_ustconsumer_add_stream(stream);
> >> -		if (ret) {
> >> -			ret = -EINVAL;
> >> -			goto error;
> >> -		}
> >> -
> >> -		/* Steal stream identifier only for UST */
> >> -		consumer_steal_stream_key(stream->key, consumer_data.stream_ht);
> >> -		break;
> >> -	default:
> >> -		ERR("Unknown consumer_data type");
> >> -		assert(0);
> >> -		ret = -ENOSYS;
> >> -		goto error;
> >> -	}
> >> -
> >>  	lttng_ht_add_unique_ulong(consumer_data.stream_ht, &stream->node);
> >>  
> >>  	/* Check and cleanup relayd */
> >> @@ -485,7 +471,6 @@ int consumer_add_stream(struct lttng_consumer_stream *stream)
> >>  	consumer_data.stream_count++;
> >>  	consumer_data.need_update = 1;
> >>  
> >> -error:
> >>  	rcu_read_unlock();
> >>  	pthread_mutex_unlock(&consumer_data.lock);
> >>  
> >> @@ -1582,17 +1567,6 @@ void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
> >>  
> >>  	DBG3("Consumer delete metadata stream %d", stream->wait_fd);
> >>  
> >> -	if (ht == NULL) {
> >> -		/* Means the stream was allocated but not successfully added */
> >> -		goto free_stream;
> >> -	}
> >> -
> >> -	rcu_read_lock();
> >> -	iter.iter.node = &stream->waitfd_node.node;
> >> -	ret = lttng_ht_del(ht, &iter);
> >> -	assert(!ret);
> >> -	rcu_read_unlock();
> >> -
> >>  	pthread_mutex_lock(&consumer_data.lock);
> >>  	switch (consumer_data.type) {
> >>  	case LTTNG_CONSUMER_KERNEL:
> >> @@ -1613,6 +1587,18 @@ void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
> >>  		goto end;
> >>  	}
> >>  
> >> +	if (ht == NULL) {
> >> +		pthread_mutex_unlock(&consumer_data.lock);
> >> +		/* Means the stream was allocated but not successfully added */
> >> +		goto free_stream;
> >> +	}
> >> +
> >> +	rcu_read_lock();
> >> +	iter.iter.node = &stream->waitfd_node.node;
> >> +	ret = lttng_ht_del(ht, &iter);
> >> +	assert(!ret);
> >> +	rcu_read_unlock();
> >> +
> >>  	if (stream->out_fd >= 0) {
> >>  		ret = close(stream->out_fd);
> >>  		if (ret) {
> >> @@ -1699,27 +1685,6 @@ static int consumer_add_metadata_stream(struct lttng_consumer_stream *stream,
> >>  
> >>  	pthread_mutex_lock(&consumer_data.lock);
> >>  
> >> -	switch (consumer_data.type) {
> >> -	case LTTNG_CONSUMER_KERNEL:
> >> -		break;
> >> -	case LTTNG_CONSUMER32_UST:
> >> -	case LTTNG_CONSUMER64_UST:
> >> -		ret = lttng_ustconsumer_add_stream(stream);
> >> -		if (ret) {
> >> -			ret = -EINVAL;
> >> -			goto error;
> >> -		}
> >> -
> >> -		/* Steal stream identifier only for UST */
> >> -		consumer_steal_stream_key(stream->wait_fd, ht);
> >> -		break;
> >> -	default:
> >> -		ERR("Unknown consumer_data type");
> >> -		assert(0);
> >> -		ret = -ENOSYS;
> >> -		goto error;
> >> -	}
> >> -
> >>  	/*
> >>  	 * From here, refcounts are updated so be _careful_ when returning an error
> >>  	 * after this point.
> >> @@ -1749,7 +1714,6 @@ static int consumer_add_metadata_stream(struct lttng_consumer_stream *stream,
> >>  	lttng_ht_add_unique_ulong(ht, &stream->waitfd_node);
> >>  	rcu_read_unlock();
> >>  
> >> -error:
> >>  	pthread_mutex_unlock(&consumer_data.lock);
> >>  	return ret;
> >>  }
> >> @@ -1946,7 +1910,7 @@ void *consumer_thread_data_poll(void *data)
> >>  	int num_rdy, num_hup, high_prio, ret, i;
> >>  	struct pollfd *pollfd = NULL;
> >>  	/* local view of the streams */
> >> -	struct lttng_consumer_stream **local_stream = NULL;
> >> +	struct lttng_consumer_stream **local_stream = NULL, *new_stream = NULL;
> >>  	/* local view of consumer_data.fds_count */
> >>  	int nb_fd = 0;
> >>  	struct lttng_consumer_local_data *ctx = data;
> >> @@ -2034,13 +1998,35 @@ void *consumer_thread_data_poll(void *data)
> >>  		 */
> >>  		if (pollfd[nb_fd].revents & (POLLIN | POLLPRI)) {
> >>  			size_t pipe_readlen;
> >> -			char tmp;
> >>  
> >>  			DBG("consumer_poll_pipe wake up");
> >>  			/* Consume 1 byte of pipe data */
> >>  			do {
> >> -				pipe_readlen = read(ctx->consumer_poll_pipe[0], &tmp, 1);
> >> +				pipe_readlen = read(ctx->consumer_poll_pipe[0], &new_stream,
> >> +						sizeof(new_stream));
> >>  			} while (pipe_readlen == -1 && errno == EINTR);
> >> +
> >> +			/*
> >> +			 * If the stream is NULL, just ignore it. It's also possible that
> >> +			 * the sessiond poll thread changed the consumer_quit state and is
> >> +			 * waking us up to test it.
> >> +			 */
> >> +			if (new_stream == NULL) {
> >> +				continue;
> >> +			}
> >> +
> >> +			ret = consumer_add_stream(new_stream);
> >> +			if (ret) {
> >> +				ERR("Consumer add stream %d failed. Continuing",
> >> +						new_stream->key);
> >> +				/*
> >> +				 * At this point, if the add_stream fails, it is not in the
> >> +				 * hash table thus passing the NULL value here.
> >> +				 */
> >> +				consumer_del_stream(new_stream, NULL);
> >> +			}
> >> +
> >> +			/* Continue to update the local streams and handle prio ones */
> >>  			continue;
> >>  		}
> >>  
> >> @@ -2260,19 +2246,16 @@ end:
> >>  	consumer_poll_timeout = LTTNG_CONSUMER_POLL_TIMEOUT;
> >>  
> >>  	/*
> >> -	 * Wake-up the other end by writing a null byte in the pipe
> >> -	 * (non-blocking). Important note: Because writing into the
> >> -	 * pipe is non-blocking (and therefore we allow dropping wakeup
> >> -	 * data, as long as there is wakeup data present in the pipe
> >> -	 * buffer to wake up the other end), the other end should
> >> -	 * perform the following sequence for waiting:
> >> -	 * 1) empty the pipe (reads).
> >> -	 * 2) perform update operation.
> >> -	 * 3) wait on the pipe (poll).
> >> +	 * Notify the data poll thread to poll back again and test the
> >> +	 * consumer_quit state to quit gracefully.
> >>  	 */
> >>  	do {
> >> -		ret = write(ctx->consumer_poll_pipe[1], "", 1);
> >> +		struct lttng_consumer_stream *null_stream = NULL;
> >> +
> >> +		ret = write(ctx->consumer_poll_pipe[1], &null_stream,
> >> +				sizeof(null_stream));
> >>  	} while (ret < 0 && errno == EINTR);
> >> +
> >>  	rcu_unregister_thread();
> >>  	return NULL;
> >>  }
> >> diff --git a/src/common/consumer.h b/src/common/consumer.h
> >> index 4b225e4..8e5891a 100644
> >> --- a/src/common/consumer.h
> >> +++ b/src/common/consumer.h
> >> @@ -362,6 +362,7 @@ struct consumer_relayd_sock_pair *consumer_allocate_relayd_sock_pair(
> >>  struct consumer_relayd_sock_pair *consumer_find_relayd(int key);
> >>  int consumer_handle_stream_before_relayd(struct lttng_consumer_stream *stream,
> >>  		size_t data_size);
> >> +void consumer_steal_stream_key(int key, struct lttng_ht *ht);
> >>  
> >>  extern struct lttng_consumer_local_data *lttng_consumer_create(
> >>  		enum lttng_consumer_type type,
> >> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> >> index 13cbe21..444f5e0 100644
> >> --- a/src/common/kernel-consumer/kernel-consumer.c
> >> +++ b/src/common/kernel-consumer/kernel-consumer.c
> >> @@ -235,10 +235,12 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
> >>  				consumer_del_stream(new_stream, NULL);
> >>  			}
> >>  		} else {
> >> -			ret = consumer_add_stream(new_stream);
> >> -			if (ret) {
> >> -				ERR("Consumer add stream %d failed. Continuing",
> >> -						new_stream->key);
> >> +			do {
> >> +				ret = write(ctx->consumer_poll_pipe[1], &new_stream,
> >> +						sizeof(new_stream));
> >> +			} while (ret < 0 && errno == EINTR);
> >> +			if (ret < 0) {
> >> +				PERROR("write data pipe");
> >>  				consumer_del_stream(new_stream, NULL);
> >>  				goto end_nosignal;
> >>  			}
> >> @@ -284,20 +286,6 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
> >>  		goto end_nosignal;
> >>  	}
> >>  
> >> -	/*
> >> -	 * Wake-up the other end by writing a null byte in the pipe (non-blocking).
> >> -	 * Important note: Because writing into the pipe is non-blocking (and
> >> -	 * therefore we allow dropping wakeup data, as long as there is wakeup data
> >> -	 * present in the pipe buffer to wake up the other end), the other end
> >> -	 * should perform the following sequence for waiting:
> >> -	 *
> >> -	 * 1) empty the pipe (reads).
> >> -	 * 2) perform update operation.
> >> -	 * 3) wait on the pipe (poll).
> >> -	 */
> >> -	do {
> >> -		ret = write(ctx->consumer_poll_pipe[1], "", 1);
> >> -	} while (ret < 0 && errno == EINTR);
> >>  end_nosignal:
> >>  	rcu_read_unlock();
> >>  
> >> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
> >> index 1170687..4ca4b84 100644
> >> --- a/src/common/ust-consumer/ust-consumer.c
> >> +++ b/src/common/ust-consumer/ust-consumer.c
> >> @@ -224,6 +224,18 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
> >>  			goto end_nosignal;
> >>  		}
> >>  
> >> +		/*
> >> +		 * This needs to be done as soon as we can so we don't block the
> >> +		 * application too long.
> >> +		 */
> >> +		ret = lttng_ustconsumer_add_stream(new_stream);
> >> +		if (ret) {
> >> +			consumer_del_stream(new_stream, NULL);
> >> +			goto end_nosignal;
> >> +		}
> >> +		/* Steal stream identifier to avoid having streams with the same key */
> >> +		consumer_steal_stream_key(new_stream->key, consumer_data.stream_ht);
> >> +
> >>  		/* The stream is not metadata. Get relayd reference if exists. */
> >>  		relayd = consumer_find_relayd(msg.u.stream.net_index);
> >>  		if (relayd != NULL) {
> >> @@ -265,14 +277,12 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
> >>  				goto end_nosignal;
> >>  			}
> >>  		} else {
> >> -			ret = consumer_add_stream(new_stream);
> >> -			if (ret) {
> >> -				ERR("Consumer add stream %d failed. Continuing",
> >> -						new_stream->key);
> >> -				/*
> >> -				 * At this point, if the add_stream fails, it is not in the
> >> -				 * hash table thus passing the NULL value here.
> >> -				 */
> >> +			do {
> >> +				ret = write(ctx->consumer_poll_pipe[1], &new_stream,
> >> +						sizeof(new_stream));
> >> +			} while (ret < 0 && errno == EINTR);
> >> +			if (ret < 0) {
> >> +				PERROR("write data pipe");
> >>  				consumer_del_stream(new_stream, NULL);
> >>  				goto end_nosignal;
> >>  			}
> >> @@ -334,20 +344,6 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
> >>  		break;
> >>  	}
> >>  
> >> -	/*
> >> -	 * Wake-up the other end by writing a null byte in the pipe (non-blocking).
> >> -	 * Important note: Because writing into the pipe is non-blocking (and
> >> -	 * therefore we allow dropping wakeup data, as long as there is wakeup data
> >> -	 * present in the pipe buffer to wake up the other end), the other end
> >> -	 * should perform the following sequence for waiting:
> >> -	 *
> >> -	 * 1) empty the pipe (reads).
> >> -	 * 2) perform update operation.
> >> -	 * 3) wait on the pipe (poll).
> >> -	 */
> >> -	do {
> >> -		ret = write(ctx->consumer_poll_pipe[1], "", 1);
> >> -	} while (ret < 0 && errno == EINTR);
> >>  end_nosignal:
> >>  	rcu_read_unlock();
> >>  
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
