From: David Goulet <dgoulet@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: increment channel refcount
 on add_stream
Date: Thu, 23 May 2013 18:09:29 -0400
Message-ID: <519E9399.1040109__26594.113049987$1369347007$gmane$org@efficios.com>
References: <1369345431-15885-1-git-send-email-jdesfossez@efficios.com>
	<20130523220716.GB16552@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UfdhZ-0000Se-Gr
	for lttng-dev@lists.lttng.org; Thu, 23 May 2013 18:09:37 -0400
In-Reply-To: <20130523220716.GB16552@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

We can't merge that for UST. However, it needs to be done on the kernel
side! Removing it from the add_stream did impact the kernel. This is a
good fine but should not be done there.

See commit: b31398bb2b3fa91a53dea3b36fd693da4b50e0d3

David

Mathieu Desnoyers:
> * Julien Desfossez (jdesfossez@efficios.com) wrote:
>> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> 
> check the impact on the ust side ?
> 
>> ---
>>  src/common/consumer.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/src/common/consumer.c b/src/common/consumer.c
>> index c9e4bae..bfb809a 100644
>> --- a/src/common/consumer.c
>> +++ b/src/common/consumer.c
>> @@ -663,6 +663,9 @@ static int add_stream(struct lttng_consumer_stream *stream,
>>  		uatomic_inc(&relayd->refcount);
>>  	}
>>  
>> +	/* Update channel refcount once added without error(s). */
>> +	uatomic_inc(&stream->chan->refcount);
>> +
>>  	/*
>>  	 * When nb_init_stream_left reaches 0, we don't need to trigger any action
>>  	 * in terms of destroying the associated channel, because the action that
>> -- 
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
