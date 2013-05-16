From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH 3/3 lttng-tools] Fix: use lttng pipe to send
 new stream to thread
Date: Thu, 16 May 2013 09:57:57 -0400
Message-ID: <5194E5E5.20702__14461.3166260116$1368712720$gmane$org@efficios.com>
References: <1368553935-17162-1-git-send-email-dgoulet@efficios.com>
	<1368553935-17162-3-git-send-email-dgoulet@efficios.com>
	<20130515192038.GC12581@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Ucyh2-0000JF-GE
	for lttng-dev@lists.lttng.org; Thu, 16 May 2013 09:58:04 -0400
In-Reply-To: <20130515192038.GC12581@Krystal>
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

The read() calls are in the thread that were changed by the previous
patches. This patch is to completely remove traditional pipe from the
sessiond thread for data and metadata streams.

David

Mathieu Desnoyers:
> same question about not using lttng_pipe_read() here.
> 
> Thanks,
> 
> Mathieu
> 
> * David Goulet (dgoulet@efficios.com) wrote:
>> Signed-off-by: David Goulet <dgoulet@efficios.com>
>> ---
>>  src/common/kernel-consumer/kernel-consumer.c |   15 +++++++--------
>>  src/common/ust-consumer/ust-consumer.c       |   16 ++++++++--------
>>  2 files changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
>> index f23fc9c..d985014 100644
>> --- a/src/common/kernel-consumer/kernel-consumer.c
>> +++ b/src/common/kernel-consumer/kernel-consumer.c
>> @@ -168,7 +168,8 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>>  	}
>>  	case LTTNG_CONSUMER_ADD_STREAM:
>>  	{
>> -		int fd, stream_pipe;
>> +		int fd;
>> +		struct lttng_pipe *stream_pipe;
>>  		struct consumer_relayd_sock_pair *relayd = NULL;
>>  		struct lttng_consumer_stream *new_stream;
>>  		struct lttng_consumer_channel *channel;
>> @@ -288,18 +289,16 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>>  
>>  		/* Get the right pipe where the stream will be sent. */
>>  		if (new_stream->metadata_flag) {
>> -			stream_pipe = lttng_pipe_get_writefd(ctx->consumer_metadata_pipe);
>> +			stream_pipe = ctx->consumer_metadata_pipe;
>>  		} else {
>> -			stream_pipe = lttng_pipe_get_writefd(ctx->consumer_data_pipe);
>> +			stream_pipe = ctx->consumer_data_pipe;
>>  		}
>>  
>> -		do {
>> -			ret = write(stream_pipe, &new_stream, sizeof(new_stream));
>> -		} while (ret < 0 && errno == EINTR);
>> +		ret = lttng_pipe_write(stream_pipe, &new_stream, sizeof(new_stream));
>>  		if (ret < 0) {
>> -			PERROR("Consumer write %s stream to pipe %d",
>> +			ERR("Consumer write %s stream to pipe %d",
>>  					new_stream->metadata_flag ? "metadata" : "data",
>> -					stream_pipe);
>> +					lttng_pipe_get_writefd(stream_pipe));
>>  			consumer_del_stream(new_stream, NULL);
>>  			goto end_nosignal;
>>  		}
>> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
>> index a81e9d4..fa46634 100644
>> --- a/src/common/ust-consumer/ust-consumer.c
>> +++ b/src/common/ust-consumer/ust-consumer.c
>> @@ -185,21 +185,21 @@ error:
>>  static int send_stream_to_thread(struct lttng_consumer_stream *stream,
>>  		struct lttng_consumer_local_data *ctx)
>>  {
>> -	int ret, stream_pipe;
>> +	int ret;
>> +	struct lttng_pipe *stream_pipe;
>>  
>>  	/* Get the right pipe where the stream will be sent. */
>>  	if (stream->metadata_flag) {
>> -		stream_pipe = lttng_pipe_get_writefd(ctx->consumer_metadata_pipe);
>> +		stream_pipe = ctx->consumer_metadata_pipe;
>>  	} else {
>> -		stream_pipe = lttng_pipe_get_writefd(ctx->consumer_data_pipe);
>> +		stream_pipe = ctx->consumer_data_pipe;
>>  	}
>>  
>> -	do {
>> -		ret = write(stream_pipe, &stream, sizeof(stream));
>> -	} while (ret < 0 && errno == EINTR);
>> +	ret = lttng_pipe_write(stream_pipe, &stream, sizeof(stream));
>>  	if (ret < 0) {
>> -		PERROR("Consumer write %s stream to pipe %d",
>> -				stream->metadata_flag ? "metadata" : "data", stream_pipe);
>> +		ERR("Consumer write %s stream to pipe %d",
>> +				stream->metadata_flag ? "metadata" : "data",
>> +				lttng_pipe_get_writefd(stream_pipe));
>>  	}
>>  
>>  	return ret;
>> -- 
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
