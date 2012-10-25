From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Synchronization issue
	for	data available command
Date: Thu, 25 Oct 2012 17:04:18 -0400
Message-ID: <20121025210418.GA1014__7423.10096179626$1351199093$gmane$org@Krystal>
References: <1351194827-8604-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TRUbE-0006cG-KH
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 17:04:20 -0400
Content-Disposition: inline
In-Reply-To: <1351194827-8604-1-git-send-email-dgoulet@efficios.com>
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
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  src/common/consumer.c                        |   66 +++++++++++++++++++++++---
>  src/common/kernel-consumer/kernel-consumer.c |   19 ++------
>  src/common/ust-consumer/ust-consumer.c       |   19 ++------
>  3 files changed, 66 insertions(+), 38 deletions(-)
> 
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index e61a227..cf0e715 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -2657,6 +2657,33 @@ error:
>  }
>  
>  /*
> + * Try to lock the stream mutex.
> + *
> + * On success, 1 is returned else 0 indicating that the mutex is NOT lock.
> + */
> +static int stream_try_lock(struct lttng_consumer_stream *stream)
> +{
> +	int ret;
> +
> +	assert(stream);
> +
> +	/*
> +	 * Try to lock the stream mutex. On failure, we know that the stream is
> +	 * being used else where hence there is data still being extracted.
> +	 */
> +	ret = pthread_mutex_trylock(&stream->lock);
> +	if (ret == EBUSY) {
> +		ret = 0;
> +		goto end;
> +	}

what are we doing with the other errors ?

> +
> +	ret = 1;
> +
> +end:
> +	return ret;
> +}
> +
> +/*
>   * Check if for a given session id there is still data needed to be extract
>   * from the buffers.
>   *
> @@ -2696,17 +2723,43 @@ int consumer_data_available(uint64_t id)
>  			ht->hash_fct((void *)((unsigned long) id), 0x42UL),
>  			ht->match_fct, (void *)((unsigned long) id),
>  			&iter.iter, stream, node_session_id.node) {
> -		/* Check the stream for data. */
> -		ret = data_available(stream);
> -		if (ret == 0) {
> +		/* If this call fails, the stream is being used hence data pending. */
> +		ret = stream_try_lock(stream);
> +		if (!ret) {
>  			goto data_not_available;
>  		}
>  
> +		/*
> +		 * A removed node from the hash table indicates that the stream has
> +		 * been deleted thus having a guarantee that the buffers are closed
> +		 * on the consumer side. However, data can still be transmitted
> +		 * over the network so don't skip the relayd check.
> +		 */
> +		ret = cds_lfht_is_node_deleted(&stream->node.node);
> +		if (!ret) {
> +			/* Check the stream if there is data in the buffers. */
> +			ret = data_available(stream);
> +			if (ret == 0) {
> +				pthread_mutex_unlock(&stream->lock);
> +				goto data_not_available;
> +			}
> +		}
> +
> +		/* Relayd check */
>  		if (stream->net_seq_idx != -1) {
>  			relayd = consumer_find_relayd(stream->net_seq_idx);
> -			assert(relayd);
> +			if (!relayd) {
> +				/*
> +				 * At this point, if the relayd object is not available for the
> +				 * given stream, it is because the relayd is being cleanup so

cleanup -> cleaned up

> +				 * every stream associated with it (for a session id value) are
> +				 * or wil be marked for deletion hence not having data pending

hence not having -> hence do not have


wil -> will

> +				 * anymore.
> +				 */
> +				pthread_mutex_unlock(&stream->lock);
> +				goto data_not_available;
> +			}
>  
> -			pthread_mutex_lock(&stream->lock);
>  			pthread_mutex_lock(&relayd->ctrl_sock_mutex);
>  			if (stream->metadata_flag) {
>  				ret = relayd_quiescent_control(&relayd->control_sock);
> @@ -2715,11 +2768,12 @@ int consumer_data_available(uint64_t id)
>  						stream->relayd_stream_id, stream->next_net_seq_num);
>  			}
>  			pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
> -			pthread_mutex_unlock(&stream->lock);
>  			if (ret == 0) {
> +				pthread_mutex_unlock(&stream->lock);

dependency (lock nesting order) between 

                      pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
                      pthread_mutex_unlock(&stream->lock);

should be documented.

Thanks,

Mathieu


>  				goto data_not_available;
>  			}
>  		}
> +		pthread_mutex_unlock(&stream->lock);
>  	}
>  
>  	/*
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> index 249df8a..196deee 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -485,7 +485,8 @@ error:
>  
>  /*
>   * Check if data is still being extracted from the buffers for a specific
> - * stream. Consumer data lock MUST be acquired before calling this function.
> + * stream. Consumer data lock MUST be acquired before calling this function
> + * and the stream lock.
>   *
>   * Return 0 if the traced data are still getting read else 1 meaning that the
>   * data is available for trace viewer reading.
> @@ -496,31 +497,17 @@ int lttng_kconsumer_data_available(struct lttng_consumer_stream *stream)
>  
>  	assert(stream);
>  
> -	/*
> -	 * Try to lock the stream mutex. On failure, we know that the stream is
> -	 * being used else where hence there is data still being extracted.
> -	 */
> -	ret = pthread_mutex_trylock(&stream->lock);
> -	if (ret == EBUSY) {
> -		/* Data not available */
> -		ret = 0;
> -		goto end;
> -	}
> -	/* The stream is now locked so we can do our ustctl calls */
> -
>  	ret = kernctl_get_next_subbuf(stream->wait_fd);
>  	if (ret == 0) {
>  		/* There is still data so let's put back this subbuffer. */
>  		ret = kernctl_put_subbuf(stream->wait_fd);
>  		assert(ret == 0);
> -		goto end_unlock;
> +		goto end;
>  	}
>  
>  	/* Data is available to be read for this stream. */
>  	ret = 1;
>  
> -end_unlock:
> -	pthread_mutex_unlock(&stream->lock);
>  end:
>  	return ret;
>  }
> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
> index e8e3f93..4d3671a 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -526,7 +526,8 @@ error:
>  
>  /*
>   * Check if data is still being extracted from the buffers for a specific
> - * stream. Consumer data lock MUST be acquired before calling this function.
> + * stream. Consumer data lock MUST be acquired before calling this function
> + * and the stream lock.
>   *
>   * Return 0 if the traced data are still getting read else 1 meaning that the
>   * data is available for trace viewer reading.
> @@ -539,31 +540,17 @@ int lttng_ustconsumer_data_available(struct lttng_consumer_stream *stream)
>  
>  	DBG("UST consumer checking data availability");
>  
> -	/*
> -	 * Try to lock the stream mutex. On failure, we know that the stream is
> -	 * being used else where hence there is data still being extracted.
> -	 */
> -	ret = pthread_mutex_trylock(&stream->lock);
> -	if (ret == EBUSY) {
> -		/* Data not available */
> -		ret = 0;
> -		goto end;
> -	}
> -	/* The stream is now locked so we can do our ustctl calls */
> -
>  	ret = ustctl_get_next_subbuf(stream->chan->handle, stream->buf);
>  	if (ret == 0) {
>  		/* There is still data so let's put back this subbuffer. */
>  		ret = ustctl_put_subbuf(stream->chan->handle, stream->buf);
>  		assert(ret == 0);
> -		goto end_unlock;
> +		goto end;
>  	}
>  
>  	/* Data is available to be read for this stream. */
>  	ret = 1;
>  
> -end_unlock:
> -	pthread_mutex_unlock(&stream->lock);
>  end:
>  	return ret;
>  }
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
