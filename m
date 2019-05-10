From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [PATCH lttng-ust v2] Fix: allocate ts_end in
 ringbuffer shared memory
Date: Fri, 10 May 2019 15:16:01 -0400
Message-ID: <84225c7a-c13e-ff39-9891-5ddab703e8b9__48430.3855848097$1557515779$gmane$org@gydle.com>
References: <20190510152632.8730-1-gabriel.pollo-guilbert@efficios.com>
 <c9f0e5ee-14ed-a2e7-1113-49a77bc7312a@gydle.com>
 <1897690228.618.1557511236306.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 4510LC11Bkz1KCk
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 15:16:02 -0400 (EDT)
In-Reply-To: <1897690228.618.1557511236306.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



On 2019-05-10 2:00 p.m., Mathieu Desnoyers wrote:
> ----- On May 10, 2019, at 12:33 PM, Sebastien Boisvert sboisvert@gydle.com wrote:
> 
>> On 2019-05-10 11:26 a.m., Gabriel-Andrew Pollo-Guilbert wrote:
>>
>> Hello Gabriel-Andrew,
>>
>>> This patch allocates the memory used by the ts_end field added by commit
>>> 6c737d05. When allocating lots of subbuffer for a channel (512 or more),
>>> zalloc_shm() will fail to allocate all the objects because the allocated memory
>>> map didn't take account the newly added field.
>>>
>>> lttng-tools version: b14f53d4 (2.12.0-pre)
>>>
>>> Steps to reproduce the bug:
>>>
>>> 	1. lttng-sessiond -vvv --verbose-consumer
>>
>> I need to killall existing lttng-sessiond daemon, right ?
>>
>>> 	2. start a traced application
>>
>> I used lttng-ust/doc/examples/demo/.
>>
>>> 	3. lttng create "test-sesssion"
>>                                ^^^
>> There are too many s in session.
> 
> oops, already merged.
> 
>>
>>
>>> 	4. lttng enable-channel --userspace --num-subbuf 512 --subbuf-size 8k
>>> 	--overwrite channel
>>> 	5. lttng enable-event -u -a -c channel
>>> 	6. lttng start
>>>
>>> After these steps, the following error message show should be thrown:
>>>
>>> 	Error: ask_channel_creation consumer command failed
>>> 	Error: Error creating UST channel "channel" on the consumer daemon
>>
>> When I build lttng-tools b14f53d4
>>
>> I get this error:
>>
>> make[3]: Entering directory
>> '/home/sboisvert/open-source/lttng.org/Source/lttng-tools/src/common/ust-consumer'
>>  CC       ust-consumer.lo
>> ust-consumer.c: In function 'lttng_ustconsumer_recv_cmd':
>> ust-consumer.c:1459:7: error: 'struct ustctl_consumer_channel_attr' has no
>> member named 'blocking_timeout'
>>   attr.blocking_timeout= msg.u.ask_channel.blocking_timeout;
>>       ^
>> ust-consumer.c: In function 'lttng_ustconsumer_sample_snapshot_positions':
>> ust-consumer.c:2225:9: warning: implicit declaration of function
>> 'ustctl_snapshot_sample_positions'; did you mean
>> 'ustctl_snapshot_get_produced'? [-Wimplicit-function-declaration]
>>  return ustctl_snapshot_sample_positions(stream->ustream);
>>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>         ustctl_snapshot_get_produced
>> Makefile:548: recipe for target 'ust-consumer.lo' failed
>>
>>
>> There seems to be 2 declarations of struct ustctl_consumer_channel_attr.
>>
>> In file lttng-tools/src/bin/lttng-sessiond/lttng-ust-ctl.h,
>> struct ustctl_consumer_channel_attr has the attribute blocking_timeout.
>>
>> In file lttng-ust/include/lttng/ust-ctl.h, struct ustctl_consumer_channel_attr
>> does not have the attribute.
>>
>>
>> They are exactly the same, except the missing blocking_timeout attribute.
>>
>>
>> [sboisvert@GT480:Source]$ grep -A 10 "struct ustctl_consumer_channel_attr {"
>> lttng-ust/include/lttng/ust-ctl.h
>> struct ustctl_consumer_channel_attr {
>> 	enum lttng_ust_chan_type type;
>> 	uint64_t subbuf_size;			/* bytes */
>> 	uint64_t num_subbuf;			/* power of 2 */
>> 	int overwrite;				/* 1: overwrite, 0: discard */
>> 	unsigned int switch_timer_interval;	/* usec */
>> 	unsigned int read_timer_interval;	/* usec */
>> 	enum lttng_ust_output output;		/* splice, mmap */
>> 	uint32_t chan_id;			/* channel ID */
>> 	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
>> } LTTNG_PACKED;
>>
>> [sboisvert@GT480:Source]$ grep -A 11 "struct ustctl_consumer_channel_attr {"
>> lttng-tools/src/bin/lttng-sessiond/lttng-ust-ctl.h
>> struct ustctl_consumer_channel_attr {
>> 	enum lttng_ust_chan_type type;
>> 	uint64_t subbuf_size;			/* bytes */
>> 	uint64_t num_subbuf;			/* power of 2 */
>> 	int overwrite;				/* 1: overwrite, 0: discard */
>> 	unsigned int switch_timer_interval;	/* usec */
>> 	unsigned int read_timer_interval;	/* usec */
>> 	enum lttng_ust_output output;		/* splice, mmap */
>> 	uint32_t chan_id;			/* channel ID */
>> 	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
>> 	int64_t blocking_timeout;			/* Blocking timeout (usec) */
>> } LTTNG_PACKED;
>>
>> [sboisvert@GT480:Source]$ diff -u <(grep -A 11 "struct
>> ustctl_consumer_channel_attr {"
>> lttng-tools/src/bin/lttng-sessiond/lttng-ust-ctl.h) <(grep -A 10 "struct
>> ustctl_consumer_channel_attr {" lttng-ust/include/lttng/ust-ctl.h)
>> --- /dev/fd/63	2019-05-10 12:32:23.562246820 -0400
>> +++ /dev/fd/62	2019-05-10 12:32:23.562246820 -0400
>> @@ -8,5 +8,4 @@
>> 	enum lttng_ust_output output;		/* splice, mmap */
>> 	uint32_t chan_id;			/* channel ID */
>> 	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
>> -	int64_t blocking_timeout;			/* Blocking timeout (usec) */
>> } LTTNG_PACKED;
>>
>>
>> My configure commands (followed by "make install"):
>>
>> [sboisvert@GT480:userspace-rcu]$ ./configure
>> --prefix=/home/sboisvert/open-source/lttng.org/Build/userspace-rcu/v0.11.0
>>
>> [sboisvert@GT480:lttng-ust]$ ./configure
>> --prefix=/home/sboisvert/open-source/lttng.org/Build/lttng-ust/v2.9.4
>> LDFLAGS=-L/home/sboisvert/open-source/lttng.org/Build/userspace-rcu/v0.11.0/lib
> 
> I think you need a lttng-ust which is more recent than 2.9.4.

Got it.

I used the most recent git tag for lttng-ust: v2.9.4

> 
> Thanks,
> 
> Mathieu
> 
>>
>> [sboisvert@GT480:lttng-tools]$ ./configure
>> --prefix=/home/sboisvert/open-source/lttng.org/Build/lttng-tools/b14f53d4
>> LDFLAGS=-L/home/sboisvert/open-source/lttng.org/Build/lttng-ust/v2.9.4/lib
>> CPPFLAGS=-I/home/sboisvert/open-source/lttng.org/Build/lttng-ust/v2.9.4/include
>>
>>
>> Thanks
>>
>>>
>>> Signed-off-by: Gabriel-Andrew Pollo-Guilbert
>>> <gabriel.pollo-guilbert@efficios.com>
>>> ---
>>>  libringbuffer/ring_buffer_backend.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/libringbuffer/ring_buffer_backend.c
>>> b/libringbuffer/ring_buffer_backend.c
>>> index a0ef7446..431b8eae 100644
>>> --- a/libringbuffer/ring_buffer_backend.c
>>> +++ b/libringbuffer/ring_buffer_backend.c
>>> @@ -341,6 +341,9 @@ int channel_backend_init(struct channel_backend *chanb,
>>>  	shmsize += sizeof(struct commit_counters_hot) * num_subbuf;
>>>  	shmsize += offset_align(shmsize, __alignof__(struct commit_counters_cold));
>>>  	shmsize += sizeof(struct commit_counters_cold) * num_subbuf;
>>> +	/* Sampled timestamp end */
>>> +	shmsize += offset_align(shmsize, __alignof__(uint64_t));
>>> +	shmsize += sizeof(uint64_t) * num_subbuf;
>>>  
>>>  	if (config->alloc == RING_BUFFER_ALLOC_PER_CPU) {
>>>  		struct lttng_ust_lib_ring_buffer *buf;
>>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
