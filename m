From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-tools PATCH] Add new thread in consumer
	for	metadata handling
Date: Tue, 11 Sep 2012 15:52:35 -0400
Message-ID: <20120911195235.GA11196__15436.6691517227$1347393195$gmane$org@Krystal>
References: <1347389351-19792-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TBWVi-000317-Uj
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 15:52:39 -0400
Content-Disposition: inline
In-Reply-To: <1347389351-19792-1-git-send-email-dgoulet@efficios.com>
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
> To prioritize the consumption of the metadata, this patch introduce a
> new thread in the consumer which exclusively handles metadata in order
> to separate them from the trace data.
> 
> The motivation behind this change is that once a start command is done
> on the tracer (kernel or UST), the start waits up to 10 seconds for the
> metadata to be written (LTTNG_METADATA_TIMEOUT_MSEC). However, there is
> a case where there is not enough space in the metadata buffers and the
> tracer waits so to not drop data. After the timeout, if the write(s) is
> unsuccessful, the start session command fails.
> 
> The previous problem can occur with network streaming with high
> throughput data such as enable-event -a -k and a poor bandwitdh

poor -> low

> connection.
> 
> The separation between metadata and trace data does the trick where
> consuming metadata does not depend anymore on the arbitrary time to
> stream trace data while metadata buffers needs to get consumed.
> 
> Of course, this fix is more _visible_ on multiprocessor/core machines
> but can also help on single processor to prioritize metadata
> consumption.

It helps on single-processor too because the scheduler will schedule
both the data and metadata threads. Even if the data thread need to send
many MB of data, if the metadata thread sends small enough metadata we
should be good with half of the CPU time.

I see that the metadata reaches easily 192k for kernel traces though. On
a 5KB/s connection, this sums up to 38s. However, thanks to the fact
that the 10s delay is allowed between each sub-buffer, we don't reach
the limit. This limits us to small trace packet sizes though, if we ever
have lots of metadata. E.g. on a 5KB/s connection, metadata buffers
configured as 2x64KB, with metadata size of e.g. 512KB, would trigger
the 10s delay error.

So we should be good for now, but removing this arbitrary 10s delay is
something to keep in mind as future improvement.

> 
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  src/bin/lttng-consumerd/lttng-consumerd.c    |    8 +-
>  src/common/compat/compat-epoll.c             |    2 +-
>  src/common/consumer.c                        |  455 ++++++++++++++++++++++----
>  src/common/consumer.h                        |    7 +-
>  src/common/kernel-consumer/kernel-consumer.c |   39 ++-
>  src/common/ust-consumer/ust-consumer.c       |   27 +-
>  6 files changed, 453 insertions(+), 85 deletions(-)
> 
> diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
> index d49c3eb..5952334 100644
> --- a/src/bin/lttng-consumerd/lttng-consumerd.c
> +++ b/src/bin/lttng-consumerd/lttng-consumerd.c
> @@ -44,14 +44,15 @@
>  #include <common/defaults.h>
>  #include <common/common.h>
>  #include <common/consumer.h>
> +#include <common/compat/poll.h>
>  #include <common/sessiond-comm/sessiond-comm.h>
>  
>  #include "lttng-consumerd.h"
>  
>  /* TODO : support UST (all direct kernel-ctl accesses). */
>  
> -/* the two threads (receive fd and poll) */
> -static pthread_t threads[2];
> +/* the two threads (receive fd, poll and metadata) */
> +static pthread_t threads[3];
>  
>  /* to count the number of times the user pressed ctrl+c */
>  static int sigintcount = 0;
> @@ -283,6 +284,9 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	/* Set up max poll set size */
> +	lttng_poll_set_max_size();
> +
>  	if (strlen(command_sock_path) == 0) {
>  		switch (opt_type) {
>  		case LTTNG_CONSUMER_KERNEL:
> diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
> index e584972..939aaac 100644
> --- a/src/common/compat/compat-epoll.c
> +++ b/src/common/compat/compat-epoll.c
> @@ -43,7 +43,7 @@ int compat_epoll_create(struct lttng_poll_event *events, int size, int flags)
>  	}
>  
>  	/* Don't bust the limit here */
> -	if (size > poll_max_size) {
> +	if (size > poll_max_size && poll_max_size != 0) {
>  		size = poll_max_size;
>  	}
>  
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 008bf8e..2ce33a6 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -30,6 +30,8 @@
>  #include <inttypes.h>
>  
>  #include <common/common.h>
> +#include <common/utils.h>
> +#include <common/compat/poll.h>
>  #include <common/kernel-ctl/kernel-ctl.h>
>  #include <common/sessiond-comm/relayd.h>
>  #include <common/sessiond-comm/sessiond-comm.h>
> @@ -440,20 +442,6 @@ int consumer_add_stream(struct lttng_consumer_stream *stream)
>  	consumer_data.stream_count++;
>  	consumer_data.need_update = 1;
>  
> -	switch (consumer_data.type) {
> -	case LTTNG_CONSUMER_KERNEL:
> -		break;
> -	case LTTNG_CONSUMER32_UST:
> -	case LTTNG_CONSUMER64_UST:
> -		/* Streams are in CPU number order (we rely on this) */
> -		stream->cpu = stream->chan->nr_streams++;
> -		break;
> -	default:
> -		ERR("Unknown consumer_data type");
> -		assert(0);
> -		goto end;
> -	}
> -
>  end:
>  	pthread_mutex_unlock(&consumer_data.lock);
>  
> @@ -698,7 +686,6 @@ struct lttng_consumer_channel *consumer_allocate_channel(
>  	channel->mmap_len = mmap_len;
>  	channel->max_sb_size = max_sb_size;
>  	channel->refcount = 0;
> -	channel->nr_streams = 0;
>  	lttng_ht_node_init_ulong(&channel->node, channel->key);
>  
>  	switch (consumer_data.type) {
> @@ -766,8 +753,7 @@ end:
>   */
>  int consumer_update_poll_array(
>  		struct lttng_consumer_local_data *ctx, struct pollfd **pollfd,
> -		struct lttng_consumer_stream **local_stream,
> -		struct lttng_ht *metadata_ht)
> +		struct lttng_consumer_stream **local_stream)
>  {
>  	int i = 0;
>  	struct lttng_ht_iter iter;
> @@ -783,10 +769,6 @@ int consumer_update_poll_array(
>  		DBG("Active FD %d", stream->wait_fd);
>  		(*pollfd)[i].fd = stream->wait_fd;
>  		(*pollfd)[i].events = POLLIN | POLLPRI;
> -		if (stream->metadata_flag && metadata_ht) {
> -			lttng_ht_add_unique_ulong(metadata_ht, &stream->waitfd_node);
> -			DBG("Active FD added to metadata hash table");
> -		}
>  		local_stream[i] = stream;
>  		i++;
>  	}
> @@ -1025,9 +1007,22 @@ struct lttng_consumer_local_data *lttng_consumer_create(
>  		goto error_thread_pipe;
>  	}
>  
> -	return ctx;
> +	ret = utils_create_pipe(ctx->consumer_metadata_pipe);
> +	if (ret < 0) {
> +		goto error_metadata_pipe;
> +	}
>  
> +	ret = utils_create_pipe(ctx->consumer_splice_metadata_pipe);
> +	if (ret < 0) {
> +		goto error_splice_pipe;
> +	}
> +
> +	return ctx;
>  
> +error_splice_pipe:
> +	utils_close_pipe(ctx->consumer_metadata_pipe);
> +error_metadata_pipe:
> +	utils_close_pipe(ctx->consumer_thread_pipe);
>  error_thread_pipe:
>  	for (i = 0; i < 2; i++) {
>  		int err;
> @@ -1088,6 +1083,8 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
>  	if (ret) {
>  		PERROR("close");
>  	}
> +	utils_close_pipe(ctx->consumer_splice_metadata_pipe);

hrm, utils_close_pipe(ctx->consumer_thread_pipe); too ?

> +
>  	unlink(ctx->consumer_command_sock_path);
>  	free(ctx);
>  }
> @@ -1258,6 +1255,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  	/* Default is on the disk */
>  	int outfd = stream->out_fd;
>  	struct consumer_relayd_sock_pair *relayd = NULL;
> +	int *splice_pipe;
>  
>  	switch (consumer_data.type) {
>  	case LTTNG_CONSUMER_KERNEL:
> @@ -1282,6 +1280,17 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  		}
>  	}
>  
> +	/*
> +	 * Choose right pipe for splice. Metadata and trace data are handled by
> +	 * different threads hence the use of two pipes in order not to race or
> +	 * corrupt the written data.
> +	 */
> +	if (stream->metadata_flag) {
> +		splice_pipe = ctx->consumer_splice_metadata_pipe;
> +	} else {
> +		splice_pipe = ctx->consumer_thread_pipe;
> +	}
> +
>  	/* Write metadata stream id before payload */
>  	if (stream->metadata_flag && relayd) {
>  		/*
> @@ -1290,8 +1299,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  		 */
>  		pthread_mutex_lock(&relayd->ctrl_sock_mutex);
>  
> -		ret = write_relayd_metadata_id(ctx->consumer_thread_pipe[1],
> -				stream, relayd);
> +		ret = write_relayd_metadata_id(splice_pipe[1], stream, relayd);
>  		if (ret < 0) {
>  			written = ret;
>  			goto end;
> @@ -1301,7 +1309,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  	while (len > 0) {
>  		DBG("splice chan to pipe offset %lu of len %lu (fd : %d)",
>  				(unsigned long)offset, len, fd);
> -		ret_splice = splice(fd, &offset, ctx->consumer_thread_pipe[1], NULL, len,
> +		ret_splice = splice(fd, &offset, splice_pipe[1], NULL, len,
>  				SPLICE_F_MOVE | SPLICE_F_MORE);
>  		DBG("splice chan to pipe, ret %zd", ret_splice);
>  		if (ret_splice < 0) {
> @@ -1337,7 +1345,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  		}
>  
>  		/* Splice data out */
> -		ret_splice = splice(ctx->consumer_thread_pipe[0], NULL, outfd, NULL,
> +		ret_splice = splice(splice_pipe[0], NULL, outfd, NULL,
>  				ret_splice, SPLICE_F_MOVE | SPLICE_F_MORE);
>  		DBG("Kernel consumer splice pipe to file, ret %zd", ret_splice);
>  		if (ret_splice < 0) {
> @@ -1460,6 +1468,331 @@ int lttng_consumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  }
>  
>  /*
> + * Iterate over all stream element of the hashtable and free them. This is race
> + * free since the hashtable pass MUST be in a race free synchronization state.

pass -> received

> + * It's the caller responsability to make sure of that.
> + */

static

> +void destroy_stream_ht(struct lttng_ht *ht)
> +{
> +	int ret;
> +	struct lttng_ht_iter iter;
> +	struct lttng_consumer_stream *stream;
> +
> +	if (ht == NULL) {
> +		return;
> +	}
> +
> +	cds_lfht_for_each_entry(ht->ht, &iter.iter, stream, node.node) {
> +		ret = lttng_ht_del(ht, &iter);
> +		assert(ret);

hrm, weird ? shouldn't it be assert(!ret); ? Why doesn't it fail then ?

> +
> +		free(stream);
> +	}
> +
> +	lttng_ht_destroy(ht);
> +}
> +
> +/*
> + * Clean up a metadata stream and free it's memory.

it's -> its

> + */

static

> +void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
> +{
> +	int ret;
> +	struct lttng_consumer_channel *free_chan = NULL;
> +	struct consumer_relayd_sock_pair *relayd;
> +
> +	assert(stream);
> +	/*
> +	 * This call should NEVER receive regular stream. It must always be
> +	 * metadata stream and this is crucial for data structure synchronization.
> +	 */
> +	assert(stream->metadata_flag);
> +
> +	pthread_mutex_lock(&consumer_data.lock);
> +	switch (consumer_data.type) {
> +	case LTTNG_CONSUMER_KERNEL:
> +		if (stream->mmap_base != NULL) {
> +			ret = munmap(stream->mmap_base, stream->mmap_len);
> +			if (ret != 0) {
> +				PERROR("munmap metadata stream");
> +			}
> +		}
> +		break;
> +	case LTTNG_CONSUMER32_UST:
> +	case LTTNG_CONSUMER64_UST:
> +		lttng_ustconsumer_del_stream(stream);
> +		break;
> +	default:
> +		ERR("Unknown consumer_data type");
> +		assert(0);
> +	}
> +	pthread_mutex_unlock(&consumer_data.lock);
> +
> +	if (stream->out_fd >= 0) {
> +		ret = close(stream->out_fd);
> +		if (ret) {
> +			PERROR("close");
> +		}
> +	}
> +
> +	if (stream->wait_fd >= 0 && !stream->wait_fd_is_copy) {
> +		ret = close(stream->wait_fd);
> +		if (ret) {
> +			PERROR("close");
> +		}
> +	}
> +
> +	if (stream->shm_fd >= 0 && stream->wait_fd != stream->shm_fd) {
> +		ret = close(stream->shm_fd);
> +		if (ret) {
> +			PERROR("close");
> +		}
> +	}
> +
> +	/* Check and cleanup relayd */
> +	rcu_read_lock();
> +	relayd = consumer_find_relayd(stream->net_seq_idx);
> +	if (relayd != NULL) {
> +		uatomic_dec(&relayd->refcount);
> +		assert(uatomic_read(&relayd->refcount) >= 0);
> +
> +		/* Closing streams requires to lock the control socket. */
> +		pthread_mutex_lock(&relayd->ctrl_sock_mutex);
> +		ret = relayd_send_close_stream(&relayd->control_sock,
> +				stream->relayd_stream_id, stream->next_net_seq_num - 1);
> +		pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
> +		if (ret < 0) {
> +			DBG("Unable to close stream on the relayd. Continuing");
> +			/*
> +			 * Continue here. There is nothing we can do for the relayd.
> +			 * Chances are that the relayd has closed the socket so we just
> +			 * continue cleaning up.
> +			 */
> +		}
> +
> +		/* Both conditions are met, we destroy the relayd. */
> +		if (uatomic_read(&relayd->refcount) == 0 &&
> +				uatomic_read(&relayd->destroy_flag)) {
> +			consumer_destroy_relayd(relayd);
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	/* Atomically decrement channel refcount since other threads can use it. */
> +	uatomic_dec(&stream->chan->refcount);
> +	if (!uatomic_read(&stream->chan->refcount)) {
> +		free_chan = stream->chan;
> +	}
> +
> +	if (free_chan) {
> +		consumer_del_channel(free_chan);
> +	}
> +
> +	free(stream);
> +}
> +
> +/*
> + * Action done with the metadata stream when adding it to the consumer internal
> + * data structures to handle it.
> + */

static

> +void consumer_add_metadata_stream(struct lttng_consumer_stream *stream)
> +{
> +	struct consumer_relayd_sock_pair *relayd;
> +
> +	/* Find relayd and, if one, increment refcount. */

if one -> if one is found

> +	rcu_read_lock();
> +	relayd = consumer_find_relayd(stream->net_seq_idx);
> +	if (relayd != NULL) {
> +		uatomic_inc(&relayd->refcount);
> +	}
> +	rcu_read_unlock();
> +}
> +
> +/*
> + * Thread polls on metadata file descriptor and write them on disk or on the
> + * network.
> + */
> +void *lttng_consumer_thread_poll_metadata(void *data)
> +{
> +	int ret, i, pollfd;
> +	uint32_t revents, nb_fd;
> +	struct lttng_consumer_stream *stream;
> +	struct lttng_ht_iter iter;
> +	struct lttng_ht_node_ulong *node;
> +	struct lttng_ht *metadata_ht = NULL;
> +	struct lttng_poll_event events;
> +	struct lttng_consumer_local_data *ctx = data;
> +	ssize_t len;
> +
> +	rcu_register_thread();
> +
> +	DBG("Thread metadata poll started");
> +
> +	metadata_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> +	if (metadata_ht == NULL) {
> +		goto end;
> +	}
> +
> +	/* Size is set to 1 for the consumer_metadata pipe */
> +	ret = lttng_poll_create(&events, 2, LTTNG_CLOEXEC);
> +	if (ret < 0) {
> +		ERR("Poll set creation failed");
> +		goto end;
> +	}
> +
> +	ret = lttng_poll_add(&events, ctx->consumer_metadata_pipe[0], LPOLLIN);
> +	if (ret < 0) {
> +		goto end;
> +	}
> +
> +	/* Main loop */
> +	DBG("Metadata main loop started");
> +
> +	while (1) {
> +		lttng_poll_reset(&events);
> +
> +		nb_fd = LTTNG_POLL_GETNB(&events);
> +
> +		/* Only the metadata pipe is set */
> +		if (nb_fd == 0 && consumer_quit == 1) {
> +			goto end;
> +		}
> +
> +restart:
> +		DBG("Metadata poll wait with %d fd(s)", nb_fd);
> +		ret = lttng_poll_wait(&events, -1);
> +		DBG("Metadata event catched in thread");
> +		if (ret < 0) {
> +			if (errno == EINTR) {
> +				goto restart;
> +			}
> +			goto error;
> +		}
> +
> +		for (i = 0; i < nb_fd; i++) {
> +			revents = LTTNG_POLL_GETEV(&events, i);
> +			pollfd = LTTNG_POLL_GETFD(&events, i);
> +
> +			/* Check the metadata pipe for incoming metadata. */
> +			if (pollfd == ctx->consumer_metadata_pipe[0]) {
> +				if (revents & (LPOLLERR | LPOLLHUP | LPOLLNVAL)) {
> +					DBG("Metadata thread pipe hung up");
> +					/*
> +					 * Remove the pipe from the poll set and continue the loop
> +					 * since their might be data to consume.
> +					 */
> +					lttng_poll_del(&events, ctx->consumer_metadata_pipe[0]);
> +					close(ctx->consumer_metadata_pipe[0]);
> +					continue;
> +				} else if (revents & LPOLLIN) {
> +					stream = zmalloc(sizeof(struct lttng_consumer_stream));
> +					if (stream == NULL) {
> +						PERROR("zmalloc metadata consumer stream");
> +						goto error;
> +					}
> +
> +					do {
> +						/* Get the stream and add it to the local hash table */
> +						ret = read(pollfd, stream,
> +								sizeof(struct lttng_consumer_stream));
> +					} while (ret < 0 && errno == EINTR);
> +					if (ret < 0 || ret < sizeof(struct lttng_consumer_stream)) {
> +						PERROR("read metadata stream");
> +						free(stream);
> +						/*
> +						 * Let's continue here and hope we can still work
> +						 * without stopping the consumer. XXX: Should we?
> +						 */
> +						continue;
> +					}
> +
> +					DBG("Adding metadata stream %d to poll set",
> +							stream->wait_fd);
> +
> +					/* The node should be init at this point */
> +					lttng_ht_add_unique_ulong(metadata_ht,
> +							&stream->waitfd_node);
> +
> +					/* Add metadata stream to the global poll events list */
> +					lttng_poll_add(&events, stream->wait_fd,
> +							LPOLLIN | LPOLLPRI);
> +
> +					consumer_add_metadata_stream(stream);
> +				}
> +
> +				/* Metadata pipe handled. Continue handling the others */
> +				continue;
> +			}
> +
> +			/* From here, the event is a metadata wait fd */
> +
> +			lttng_ht_lookup(metadata_ht, (void *)((unsigned long) pollfd),
> +					&iter);
> +			node = lttng_ht_iter_get_node_ulong(&iter);
> +			if (node == NULL) {
> +				/* FD not found, continue loop */
> +				continue;
> +			}
> +
> +			stream = caa_container_of(node, struct lttng_consumer_stream,
> +					waitfd_node);
> +
> +			/* Get the data out of the metadata file descriptor */
> +			if (revents & (LPOLLIN | LPOLLPRI)) {
> +				DBG("Metadata available on fd %d", pollfd);
> +				assert(stream->wait_fd == pollfd);
> +
> +				len = ctx->on_buffer_ready(stream, ctx);
> +				/* It's ok to have an unavailable sub-buffer */
> +				if (len < 0 && len != -EAGAIN) {
> +					goto end;
> +				} else if (len > 0) {
> +					stream->data_read = 1;
> +				}
> +			}
> +
> +			/*
> +			 * Remove the stream from the hash table since there is no data
> +			 * left on the fd because we previously did a read on the buffer.
> +			 */
> +			if (revents & (LPOLLERR | LPOLLHUP | LPOLLNVAL)) {
> +				DBG("Metadata fd %d is hup|err|nval.", pollfd);
> +				if (!stream->hangup_flush_done
> +						&& (consumer_data.type == LTTNG_CONSUMER32_UST
> +							|| consumer_data.type == LTTNG_CONSUMER64_UST)) {
> +					DBG("Attempting to flush and consume the UST buffers");
> +					lttng_ustconsumer_on_stream_hangup(stream);
> +
> +					/* We just flushed the stream now read it. */
> +					len = ctx->on_buffer_ready(stream, ctx);
> +					/* It's ok to have an unavailable sub-buffer */
> +					if (len < 0 && len != -EAGAIN) {
> +						goto end;
> +					}
> +				}
> +
> +				/* Removing it from hash table, poll set and free memory */
> +				lttng_ht_del(metadata_ht, &iter);
> +				lttng_poll_del(&events, stream->wait_fd);
> +				consumer_del_metadata_stream(stream);
> +			}
> +		}
> +	}
> +
> +error:
> +end:
> +	DBG("Metadata poll thread exiting");
> +	lttng_poll_clean(&events);
> +
> +	if (metadata_ht) {
> +		destroy_stream_ht(metadata_ht);
> +	}
> +
> +	rcu_unregister_thread();
> +	return NULL;
> +}
> +
> +/*
>   * This thread polls the fds in the set to consume the data and write
>   * it to tracefile if necessary.
>   */
> @@ -1472,16 +1805,20 @@ void *lttng_consumer_thread_poll_fds(void *data)
>  	/* local view of consumer_data.fds_count */
>  	int nb_fd = 0;
>  	struct lttng_consumer_local_data *ctx = data;
> -	struct lttng_ht *metadata_ht;
> -	struct lttng_ht_iter iter;
> -	struct lttng_ht_node_ulong *node;
> -	struct lttng_consumer_stream *metadata_stream;
>  	ssize_t len;
> -
> -	metadata_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
> +	pthread_t metadata_thread;
> +	void *status;
>  
>  	rcu_register_thread();
>  
> +	/* Start metadata polling thread */
> +	ret = pthread_create(&metadata_thread, NULL,
> +			lttng_consumer_thread_poll_metadata, (void *) ctx);
> +	if (ret < 0) {
> +		PERROR("pthread_create metadata thread");
> +		goto end;
> +	}
> +
>  	local_stream = zmalloc(sizeof(struct lttng_consumer_stream));
>  
>  	while (1) {
> @@ -1519,8 +1856,7 @@ void *lttng_consumer_thread_poll_fds(void *data)
>  				pthread_mutex_unlock(&consumer_data.lock);
>  				goto end;
>  			}
> -			ret = consumer_update_poll_array(ctx, &pollfd, local_stream,
> -					metadata_ht);
> +			ret = consumer_update_poll_array(ctx, &pollfd, local_stream);
>  			if (ret < 0) {
>  				ERR("Error in allocating pollfd or local_outfds");
>  				lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_POLL_ERROR);
> @@ -1575,24 +1911,7 @@ void *lttng_consumer_thread_poll_fds(void *data)
>  
>  		/* Take care of high priority channels first. */
>  		for (i = 0; i < nb_fd; i++) {
> -			/* Lookup for metadata which is the highest priority */
> -			lttng_ht_lookup(metadata_ht,
> -					(void *)((unsigned long) pollfd[i].fd), &iter);
> -			node = lttng_ht_iter_get_node_ulong(&iter);
> -			if (node != NULL &&
> -					(pollfd[i].revents & (POLLIN | POLLPRI))) {
> -				DBG("Urgent metadata read on fd %d", pollfd[i].fd);
> -				metadata_stream = caa_container_of(node,
> -						struct lttng_consumer_stream, waitfd_node);
> -				high_prio = 1;
> -				len = ctx->on_buffer_ready(metadata_stream, ctx);
> -				/* it's ok to have an unavailable sub-buffer */
> -				if (len < 0 && len != -EAGAIN) {
> -					goto end;
> -				} else if (len > 0) {
> -					metadata_stream->data_read = 1;
> -				}
> -			} else if (pollfd[i].revents & POLLPRI) {
> +			if (pollfd[i].revents & POLLPRI) {
>  				DBG("Urgent read on fd %d", pollfd[i].fd);
>  				high_prio = 1;
>  				len = ctx->on_buffer_ready(local_stream[i], ctx);
> @@ -1648,33 +1967,18 @@ void *lttng_consumer_thread_poll_fds(void *data)
>  			if ((pollfd[i].revents & POLLHUP)) {
>  				DBG("Polling fd %d tells it has hung up.", pollfd[i].fd);
>  				if (!local_stream[i]->data_read) {
> -					if (local_stream[i]->metadata_flag) {
> -						iter.iter.node = &local_stream[i]->waitfd_node.node;
> -						ret = lttng_ht_del(metadata_ht, &iter);
> -						assert(!ret);
> -					}
>  					consumer_del_stream(local_stream[i]);
>  					num_hup++;
>  				}
>  			} else if (pollfd[i].revents & POLLERR) {
>  				ERR("Error returned in polling fd %d.", pollfd[i].fd);
>  				if (!local_stream[i]->data_read) {
> -					if (local_stream[i]->metadata_flag) {
> -						iter.iter.node = &local_stream[i]->waitfd_node.node;
> -						ret = lttng_ht_del(metadata_ht, &iter);
> -						assert(!ret);
> -					}
>  					consumer_del_stream(local_stream[i]);
>  					num_hup++;
>  				}
>  			} else if (pollfd[i].revents & POLLNVAL) {
>  				ERR("Polling fd %d tells fd is not open.", pollfd[i].fd);
>  				if (!local_stream[i]->data_read) {
> -					if (local_stream[i]->metadata_flag) {
> -						iter.iter.node = &local_stream[i]->waitfd_node.node;
> -						ret = lttng_ht_del(metadata_ht, &iter);
> -						assert(!ret);
> -					}
>  					consumer_del_stream(local_stream[i]);
>  					num_hup++;
>  				}
> @@ -1692,6 +1996,23 @@ end:
>  		free(local_stream);
>  		local_stream = NULL;
>  	}
> +
> +	/*
> +	 * Close the write side of the pipe so epoll_wait() in
> +	 * lttng_consumer_thread_poll_metadata can catch it. The thread is
> +	 * monitoring the read side of the pipe. If we close them both, epoll_wait
> +	 * strangely does not return and could create a endless wait period if the
> +	 * pipe is the only tracked fd in the poll set. The thread will take care
> +	 * of closing the read side.
> +	 */
> +	close(ctx->consumer_metadata_pipe[1]);
> +	if (ret) {
> +		ret = pthread_join(metadata_thread, &status);
> +		if (ret < 0) {
> +			PERROR("pthread_join metadata thread");
> +		}
> +	}
> +
>  	rcu_unregister_thread();
>  	return NULL;
>  }
> diff --git a/src/common/consumer.h b/src/common/consumer.h
> index fc5d5ef..e307b18 100644
> --- a/src/common/consumer.h
> +++ b/src/common/consumer.h
> @@ -83,7 +83,6 @@ struct lttng_consumer_channel {
>  	void *mmap_base;
>  	size_t mmap_len;
>  	struct lttng_ust_shm_handle *handle;
> -	int nr_streams;
>  	int wait_fd_is_copy;
>  	int cpucount;
>  };
> @@ -224,10 +223,13 @@ struct lttng_consumer_local_data {
>  	char *consumer_command_sock_path;
>  	/* communication with splice */
>  	int consumer_thread_pipe[2];
> +	int consumer_splice_metadata_pipe[2];
>  	/* pipe to wake the poll thread when necessary */
>  	int consumer_poll_pipe[2];
>  	/* to let the signal handler wake up the fd receiver thread */
>  	int consumer_should_quit[2];
> +	/* Metadata poll thread pipe. Transfer metadata stream to it */
> +	int consumer_metadata_pipe[2];
>  };
>  
>  /*
> @@ -318,8 +320,7 @@ extern int lttng_consumer_poll_socket(struct pollfd *kconsumer_sockpoll);
>  
>  extern int consumer_update_poll_array(
>  		struct lttng_consumer_local_data *ctx, struct pollfd **pollfd,
> -		struct lttng_consumer_stream **local_consumer_streams,
> -		struct lttng_ht *metadata_ht);
> +		struct lttng_consumer_stream **local_consumer_streams);
>  
>  extern struct lttng_consumer_stream *consumer_allocate_stream(
>  		int channel_key, int stream_key,
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> index 86e4051..ca82f96 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -171,6 +171,18 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  			goto end_nosignal;
>  		}
>  
> +		/*
> +		 * XXX: Kernel workaround. The buffer flush is done on the session
> +		 * daemon side for the kernel so no need for the stream
> +		 * "hangup_flush_done" variable to be tracked. So, we just set it to be
> +		 * always true meaning that the flush was done on the stream at
> +		 * anytime.
> +		 *
> +		 * We should think of doing the kernel flush on the consumer side in
> +		 * order to standardize our operations on streams whatever the domain.
> +		 */
> +		new_stream->hangup_flush_done = 1;

As discussed privately, this should be left to 0 for kernel.

Thanks,

Mathieu

> +
>  		/* The stream is not metadata. Get relayd reference if exists. */
>  		relayd = consumer_find_relayd(msg.u.stream.net_index);
>  		if (relayd != NULL) {
> @@ -190,14 +202,29 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  			goto end_nosignal;
>  		}
>  
> -		if (ctx->on_recv_stream != NULL) {
> -			ret = ctx->on_recv_stream(new_stream);
> -			if (ret == 0) {
> -				consumer_add_stream(new_stream);
> -			} else if (ret < 0) {
> -				goto end_nosignal;
> +		/* Send stream to the metadata thread */
> +		if (new_stream->metadata_flag) {
> +			if (ctx->on_recv_stream) {
> +				ret = ctx->on_recv_stream(new_stream);
> +				if (ret < 0) {
> +					goto end_nosignal;
> +				}
> +			}
> +
> +			do {
> +				ret = write(ctx->consumer_metadata_pipe[1], new_stream,
> +						sizeof(struct lttng_consumer_stream));
> +			} while (ret < 0 && errno == EINTR);
> +			if (ret < 0) {
> +				PERROR("write metadata pipe");
>  			}
>  		} else {
> +			if (ctx->on_recv_stream) {
> +				ret = ctx->on_recv_stream(new_stream);
> +				if (ret < 0) {
> +					goto end_nosignal;
> +				}
> +			}
>  			consumer_add_stream(new_stream);
>  		}
>  
> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
> index 855d071..c984e33 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -223,14 +223,29 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  			goto end_nosignal;
>  		}
>  
> -		if (ctx->on_recv_stream != NULL) {
> -			ret = ctx->on_recv_stream(new_stream);
> -			if (ret == 0) {
> -				consumer_add_stream(new_stream);
> -			} else if (ret < 0) {
> -				goto end_nosignal;
> +		/* Send stream to the metadata thread */
> +		if (new_stream->metadata_flag) {
> +			if (ctx->on_recv_stream) {
> +				ret = ctx->on_recv_stream(new_stream);
> +				if (ret < 0) {
> +					goto end_nosignal;
> +				}
> +			}
> +
> +			do {
> +				ret = write(ctx->consumer_metadata_pipe[1], new_stream,
> +						sizeof(struct lttng_consumer_stream));
> +			} while (ret < 0 && errno == EINTR);
> +			if (ret < 0) {
> +				PERROR("write metadata pipe");
>  			}
>  		} else {
> +			if (ctx->on_recv_stream) {
> +				ret = ctx->on_recv_stream(new_stream);
> +				if (ret < 0) {
> +					goto end_nosignal;
> +				}
> +			}
>  			consumer_add_stream(new_stream);
>  		}
>  
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
