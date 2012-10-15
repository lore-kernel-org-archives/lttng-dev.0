From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/4] Rename consumer threads	and
 spawn them in daemon
Date: Mon, 15 Oct 2012 11:39:18 -0400
Message-ID: <507C2E26.1030401__2516.76745615459$1350315601$gmane$org@efficios.com>
References: <1350052235-12198-1-git-send-email-dgoulet@efficios.com>
	<20121013154113.GA29985@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TNmlH-0002RK-4S
	for lttng-dev@lists.lttng.org; Mon, 15 Oct 2012 11:39:23 -0400
In-Reply-To: <20121013154113.GA29985@Krystal>
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



Mathieu Desnoyers:
> * David Goulet (dgoulet@efficios.com) wrote:
>> The metadata thread is now created in the lttng-consumerd daemon so all
>> thread could be controlled inside the daemon.
>>
>> This is the first step of a consumer thread refactoring which aims at
>> moving data and metadata stream operations inside a dedicated thread so
>> the session daemon thread does not block and is more efficient at adding
>> streams.
>>
>> The most important concept is that a stream file descriptor MUST be
>> opened as quickly as we can than passed to the right thread (for UST
> 
> than -> then
> 
>> since they are already opened by the session daemon for the kernel).
>>
>> Signed-off-by: David Goulet <dgoulet@efficios.com>
>> ---
>>  src/bin/lttng-consumerd/lttng-consumerd.c |   18 ++++++++++-----
>>  src/common/consumer.c                     |   34 +++++++++--------------------
>>  src/common/consumer.h                     |    5 +++--
>>  3 files changed, 26 insertions(+), 31 deletions(-)
>>
>> diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
>> index 5952334..946fb02 100644
>> --- a/src/bin/lttng-consumerd/lttng-consumerd.c
>> +++ b/src/bin/lttng-consumerd/lttng-consumerd.c
>> @@ -356,23 +356,31 @@ int main(int argc, char **argv)
>>  	}
>>  	lttng_consumer_set_error_sock(ctx, ret);
>>  
>> -	/* Create the thread to manage the receive of fd */
>> -	ret = pthread_create(&threads[0], NULL, lttng_consumer_thread_receive_fds,
>> +	/* Create thread to manage the polling/writing of trace metadata */
>> +	ret = pthread_create(&threads[0], NULL, consumer_thread_metadata_poll,
>> +			(void *) ctx);
>> +	if (ret != 0) {
>> +		perror("pthread_create");
>> +		goto error;
>> +	}
>> +
>> +	/* Create thread to manage the polling/writing of trace data */
>> +	ret = pthread_create(&threads[1], NULL, consumer_thread_data_poll,
>>  			(void *) ctx);
>>  	if (ret != 0) {
>>  		perror("pthread_create");
>>  		goto error;
>>  	}
>>  
>> -	/* Create thread to manage the polling/writing of traces */
>> -	ret = pthread_create(&threads[1], NULL, lttng_consumer_thread_poll_fds,
>> +	/* Create the thread to manage the receive of fd */
>> +	ret = pthread_create(&threads[2], NULL, consumer_thread_sessiond_poll,
>>  			(void *) ctx);
>>  	if (ret != 0) {
>>  		perror("pthread_create");
>>  		goto error;
>>  	}
>>  
>> -	for (i = 0; i < 2; i++) {
>> +	for (i = 0; i < 3; i++) {
>>  		ret = pthread_join(threads[i], &status);
>>  		if (ret != 0) {
>>  			perror("pthread_join");
>> diff --git a/src/common/consumer.c b/src/common/consumer.c
>> index 242b05b..055de1b 100644
>> --- a/src/common/consumer.c
>> +++ b/src/common/consumer.c
>> @@ -1131,6 +1131,8 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
>>  		PERROR("close");
>>  	}
>>  	utils_close_pipe(ctx->consumer_splice_metadata_pipe);
>> +	/* This should trigger the metadata thread to exit */
>> +	close(ctx->consumer_metadata_pipe[1]);
> 
> this is adding a close, but did not remove any other remove that might
> previously be in place elsewhere.

So we got two possible error path which is either the poll thread fails
or the consumer could be destroy by hand even though the threads are
working well.

Actually, this close should check if the value is valid and close it. To
be honest, this is just a shortcut since close(-1) does not fail and
ignoring the close error here since we are in the cleanup path anyway so
we don't necessarily care about the perror message.

Anyhow, we have to handle both error path. An if plus set -1 after close
can be done so not to confuse.

David

> 
> moreover, the close() return value is not tested.
>>  
>>  	unlink(ctx->consumer_command_sock_path);
>>  	free(ctx);
>> @@ -1756,7 +1758,7 @@ error:
>>   * Thread polls on metadata file descriptor and write them on disk or on the
>>   * network.
>>   */
>> -void *lttng_consumer_thread_poll_metadata(void *data)
>> +void *consumer_thread_metadata_poll(void *data)
>>  {
>>  	int ret, i, pollfd;
>>  	uint32_t revents, nb_fd;
>> @@ -1939,7 +1941,7 @@ end:
>>   * This thread polls the fds in the set to consume the data and write
>>   * it to tracefile if necessary.
>>   */
>> -void *lttng_consumer_thread_poll_fds(void *data)
>> +void *consumer_thread_data_poll(void *data)
>>  {
>>  	int num_rdy, num_hup, high_prio, ret, i;
>>  	struct pollfd *pollfd = NULL;
>> @@ -1949,19 +1951,9 @@ void *lttng_consumer_thread_poll_fds(void *data)
>>  	int nb_fd = 0;
>>  	struct lttng_consumer_local_data *ctx = data;
>>  	ssize_t len;
>> -	pthread_t metadata_thread;
>> -	void *status;
>>  
>>  	rcu_register_thread();
>>  
>> -	/* Start metadata polling thread */
>> -	ret = pthread_create(&metadata_thread, NULL,
>> -			lttng_consumer_thread_poll_metadata, (void *) ctx);
>> -	if (ret < 0) {
>> -		PERROR("pthread_create metadata thread");
>> -		goto end;
>> -	}
>> -
>>  	local_stream = zmalloc(sizeof(struct lttng_consumer_stream));
>>  
>>  	while (1) {
>> @@ -2145,19 +2137,13 @@ end:
>>  
>>  	/*
>>  	 * Close the write side of the pipe so epoll_wait() in
>> -	 * lttng_consumer_thread_poll_metadata can catch it. The thread is
>> -	 * monitoring the read side of the pipe. If we close them both, epoll_wait
>> -	 * strangely does not return and could create a endless wait period if the
>> -	 * pipe is the only tracked fd in the poll set. The thread will take care
>> -	 * of closing the read side.
>> +	 * consumer_thread_metadata_poll can catch it. The thread is monitoring the
>> +	 * read side of the pipe. If we close them both, epoll_wait strangely does
>> +	 * not return and could create a endless wait period if the pipe is the
>> +	 * only tracked fd in the poll set. The thread will take care of closing
>> +	 * the read side.
>>  	 */
>>  	close(ctx->consumer_metadata_pipe[1]);
> 
> this is the second close on the same FD I'm talking about.
> 
> thanks,
> 
> Mathieu
> 
>> -	if (ret) {
>> -		ret = pthread_join(metadata_thread, &status);
>> -		if (ret < 0) {
>> -			PERROR("pthread_join metadata thread");
>> -		}
>> -	}
>>  
>>  	rcu_unregister_thread();
>>  	return NULL;
>> @@ -2167,7 +2153,7 @@ end:
>>   * This thread listens on the consumerd socket and receives the file
>>   * descriptors from the session daemon.
>>   */
>> -void *lttng_consumer_thread_receive_fds(void *data)
>> +void *consumer_thread_sessiond_poll(void *data)
>>  {
>>  	int sock, client_socket, ret;
>>  	/*
>> diff --git a/src/common/consumer.h b/src/common/consumer.h
>> index d0cd8fd..4b225e4 100644
>> --- a/src/common/consumer.h
>> +++ b/src/common/consumer.h
>> @@ -385,8 +385,9 @@ extern int lttng_consumer_get_produced_snapshot(
>>  		struct lttng_consumer_local_data *ctx,
>>  		struct lttng_consumer_stream *stream,
>>  		unsigned long *pos);
>> -extern void *lttng_consumer_thread_poll_fds(void *data);
>> -extern void *lttng_consumer_thread_receive_fds(void *data);
>> +extern void *consumer_thread_metadata_poll(void *data);
>> +extern void *consumer_thread_data_poll(void *data);
>> +extern void *consumer_thread_sessiond_poll(void *data);
>>  extern int lttng_consumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>>  		int sock, struct pollfd *consumer_sockpoll);
>>  
>> -- 
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
