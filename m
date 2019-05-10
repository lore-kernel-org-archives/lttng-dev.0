From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust v2] Fix: allocate ts_end in
 ringbuffer shared memory
Date: Fri, 10 May 2019 13:41:18 -0400 (EDT)
Message-ID: <954164369.552.1557510078100.JavaMail.zimbra__44739.7048397519$1557510209$gmane$org@efficios.com>
References: <20190510152632.8730-1-gabriel.pollo-guilbert@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 450yF03Ydmz1Jy1
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 13:41:24 -0400 (EDT)
In-Reply-To: <20190510152632.8730-1-gabriel.pollo-guilbert@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master, 2.11, thanks!

Mathieu

----- On May 10, 2019, at 11:26 AM, Gabriel-Andrew Pollo-Guilbert gabriel.pollo-guilbert@efficios.com wrote:

> This patch allocates the memory used by the ts_end field added by commit
> 6c737d05. When allocating lots of subbuffer for a channel (512 or more),
> zalloc_shm() will fail to allocate all the objects because the allocated memory
> map didn't take account the newly added field.
> 
> lttng-tools version: b14f53d4 (2.12.0-pre)
> 
> Steps to reproduce the bug:
> 
>	1. lttng-sessiond -vvv --verbose-consumer
>	2. start a traced application
>	3. lttng create "test-sesssion"
>	4. lttng enable-channel --userspace --num-subbuf 512 --subbuf-size 8k
>	--overwrite channel
>	5. lttng enable-event -u -a -c channel
>	6. lttng start
> 
> After these steps, the following error message show should be thrown:
> 
>	Error: ask_channel_creation consumer command failed
>	Error: Error creating UST channel "channel" on the consumer daemon
> 
> Signed-off-by: Gabriel-Andrew Pollo-Guilbert
> <gabriel.pollo-guilbert@efficios.com>
> ---
> libringbuffer/ring_buffer_backend.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/libringbuffer/ring_buffer_backend.c
> b/libringbuffer/ring_buffer_backend.c
> index a0ef7446..431b8eae 100644
> --- a/libringbuffer/ring_buffer_backend.c
> +++ b/libringbuffer/ring_buffer_backend.c
> @@ -341,6 +341,9 @@ int channel_backend_init(struct channel_backend *chanb,
> 	shmsize += sizeof(struct commit_counters_hot) * num_subbuf;
> 	shmsize += offset_align(shmsize, __alignof__(struct commit_counters_cold));
> 	shmsize += sizeof(struct commit_counters_cold) * num_subbuf;
> +	/* Sampled timestamp end */
> +	shmsize += offset_align(shmsize, __alignof__(uint64_t));
> +	shmsize += sizeof(uint64_t) * num_subbuf;
> 
> 	if (config->alloc == RING_BUFFER_ALLOC_PER_CPU) {
> 		struct lttng_ust_lib_ring_buffer *buf;
> --
> 2.21.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
