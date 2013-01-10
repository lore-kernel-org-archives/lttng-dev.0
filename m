From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Atomically update relayd stream
 and session id
Date: Thu, 10 Jan 2013 13:17:58 -0500
Message-ID: <50EF05D6.6050903__15810.3842790753$1357841920$gmane$org@efficios.com>
References: <1357839948-25490-1-git-send-email-dgoulet@efficios.com>
	<20130110181233.GA10684@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TtMhW-0006lw-11
	for lttng-dev@lists.lttng.org; Thu, 10 Jan 2013 13:18:02 -0500
In-Reply-To: <20130110181233.GA10684@Krystal>
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

Wait wut?

Like every uatomic_inc/read() used else were in the code won't build or
just this specific add_return call?

Thanks!
David

Mathieu Desnoyers:
> * David Goulet (dgoulet@efficios.com) wrote:
>> Improve protection to the variables where the uatomic_add_return() call
>> does a volatile access and returns the value atomically incremented.
>>
>> Enclose that in two new functions, one for each id, which helps with the
>> code semantic and brings a single call site for the value update making
>> the code easier to scale and understand when adding contention to those
>> variables.
>>
>> Signed-off-by: David Goulet <dgoulet@efficios.com>
> 
> This won't build on 32-bit architectures, due to lack of 64-bit atomic
> ops.
> 
> Thanks,
> 
> Mathieu
> 
>> ---
>>  src/bin/lttng-relayd/lttng-relayd.h |   19 +++++++++++++++++++
>>  src/bin/lttng-relayd/main.c         |    9 +++++----
>>  2 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/bin/lttng-relayd/lttng-relayd.h b/src/bin/lttng-relayd/lttng-relayd.h
>> index edd32d6..b2566a1 100644
>> --- a/src/bin/lttng-relayd/lttng-relayd.h
>> +++ b/src/bin/lttng-relayd/lttng-relayd.h
>> @@ -23,6 +23,9 @@
>>  #include <urcu.h>
>>  #include <urcu/wfqueue.h>
>>  
>> +extern uint64_t relayd_last_stream_id;
>> +extern uint64_t relayd_last_session_id;
>> +
>>  /*
>>   * Queue used to enqueue relay requests
>>   */
>> @@ -81,4 +84,20 @@ struct relay_command {
>>  	unsigned int version_check_done:1;
>>  };
>>  
>> +/*
>> + * Atomically increment the id and return the next stream id.
>> + */
>> +static inline uint64_t relayd_get_next_stream_id(void)
>> +{
>> +	return (uint64_t) uatomic_add_return(&relayd_last_stream_id, 1);
>> +}
>> +
>> +/*
>> + * Atomically increment the id and return the next session id.
>> + */
>> +static inline uint64_t relayd_get_next_session_id(void)
>> +{
>> +	return (uint64_t) uatomic_add_return(&relayd_last_session_id, 1);
>> +}
>> +
>>  #endif /* LTTNG_RELAYD_H */
>> diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
>> index 6627310..a042ce6 100644
>> --- a/src/bin/lttng-relayd/main.c
>> +++ b/src/bin/lttng-relayd/main.c
>> @@ -82,8 +82,9 @@ static pthread_t listener_thread;
>>  static pthread_t dispatcher_thread;
>>  static pthread_t worker_thread;
>>  
>> -static uint64_t last_relay_stream_id;
>> -static uint64_t last_relay_session_id;
>> +/* Declared extern in lttng-relayd.h */
>> +uint64_t relayd_last_stream_id;
>> +uint64_t relayd_last_session_id;
>>  
>>  /*
>>   * Relay command queue.
>> @@ -968,7 +969,7 @@ int relay_create_session(struct lttcomm_relayd_hdr *recv_hdr,
>>  		goto error;
>>  	}
>>  
>> -	session->id = ++last_relay_session_id;
>> +	session->id = relayd_get_next_session_id();
>>  	session->sock = cmd->sock;
>>  	cmd->session = session;
>>  
>> @@ -1032,7 +1033,7 @@ int relay_add_stream(struct lttcomm_relayd_hdr *recv_hdr,
>>  	}
>>  
>>  	rcu_read_lock();
>> -	stream->stream_handle = ++last_relay_stream_id;
>> +	stream->stream_handle = relayd_get_next_stream_id();
>>  	stream->prev_seq = -1ULL;
>>  	stream->session = session;
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
