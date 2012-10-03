From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/3] Fix: Add missing call
	rcu	and read side lock
Date: Wed, 3 Oct 2012 12:28:41 -0400
Message-ID: <20121003162841.GA21776__5397.16803837127$1349281814$gmane$org@Krystal>
References: <1349279317-28056-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TJRoR-0006vS-2w
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 12:28:43 -0400
Content-Disposition: inline
In-Reply-To: <1349279317-28056-1-git-send-email-dgoulet@efficios.com>
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
>  src/common/consumer.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index f01eb5d..7c3762e 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -688,7 +688,9 @@ void consumer_del_channel(struct lttng_consumer_channel *channel)
>  		}
>  	}
>  
> +	rcu_read_lock();
>  	call_rcu(&channel->node.head, consumer_free_channel);
> +	rcu_read_unlock();

this rcu read lock is useless.

>  end:
>  	pthread_mutex_unlock(&consumer_data.lock);
>  }
> @@ -1535,7 +1537,7 @@ static void destroy_stream_ht(struct lttng_ht *ht)
>  		ret = lttng_ht_del(ht, &iter);
>  		assert(!ret);
>  
> -		free(stream);
> +		call_rcu(&stream->node.head, consumer_free_stream);

Good point. While you are there, please remove the bogus comment at the
top of destroy_stream_ht(). It does not take into account that
lttng_ht_del can trigger a concurrent resize (performed by call rcu
worker threads).


>  	}
>  	rcu_read_unlock();
>  
> @@ -1635,7 +1637,9 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
>  		consumer_del_channel(stream->chan);
>  	}
>  
> -	free(stream);
> +	rcu_read_lock();
> +	call_rcu(&stream->node.head, consumer_free_stream);
> +	rcu_read_unlock();

call_rcu makes sense here, but not rcu read lock.

Thanks,

Mathieu

>  }
>  
>  /*
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
