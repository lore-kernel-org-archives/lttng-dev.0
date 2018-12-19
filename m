From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Cleanup: missing sign compare fixes
Date: Wed, 19 Dec 2018 11:55:06 -0500 (EST)
Message-ID: <241893685.6032.1545238506862.JavaMail.zimbra__15772.0515774146$1545238398$gmane$org@efficios.com>
References: <20181219164457.16915-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43Kgx84HZTz16MQ
 for <lttng-dev@lists.lttng.org>; Wed, 19 Dec 2018 11:55:08 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A09A1A76AF
 for <lttng-dev@lists.lttng.org>; Wed, 19 Dec 2018 11:55:07 -0500 (EST)
In-Reply-To: <20181219164457.16915-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged with modifications. test_perthreadlock compares the iterator against 0
with a decrementing iterator, so we need to work on long.

Thanks,

Mathieu

----- On Dec 19, 2018, at 11:44 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> tests/benchmark/test_perthreadlock.c | 2 +-
> tests/benchmark/test_urcu_gc.c       | 4 ++--
> tests/benchmark/test_urcu_qsbr_gc.c  | 4 ++--
> 3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/benchmark/test_perthreadlock.c
> b/tests/benchmark/test_perthreadlock.c
> index 512b1fc..13fc820 100644
> --- a/tests/benchmark/test_perthreadlock.c
> +++ b/tests/benchmark/test_perthreadlock.c
> @@ -207,7 +207,7 @@ void *thr_reader(void *data)
> void *thr_writer(void *data)
> {
> 	unsigned long wtidx = (unsigned long)data;
> -	long tidx;
> +	unsigned long tidx;
> 
> 	printf_verbose("thread_begin %s, tid %lu\n",
> 			"writer", urcu_get_thread_id());
> diff --git a/tests/benchmark/test_urcu_gc.c b/tests/benchmark/test_urcu_gc.c
> index 1e50e4c..34cf141 100644
> --- a/tests/benchmark/test_urcu_gc.c
> +++ b/tests/benchmark/test_urcu_gc.c
> @@ -55,7 +55,7 @@ static unsigned long wdelay;
> 
> static struct test_array *test_rcu_pointer;
> 
> -static unsigned int reclaim_batch = 1;
> +static long reclaim_batch = 1;
> 
> struct reclaim_queue {
> 	void **queue;	/* Beginning of queue */
> @@ -449,7 +449,7 @@ int main(int argc, char **argv)
> 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
> 		"nr_writers %3u "
> 		"wdelay %6lu nr_reads %12llu nr_writes %12llu nr_ops %12llu "
> -		"batch %u\n",
> +		"batch %ld\n",
> 		argv[0], duration, nr_readers, rduration, wduration,
> 		nr_writers, wdelay, tot_reads, tot_writes,
> 		tot_reads + tot_writes, reclaim_batch);
> diff --git a/tests/benchmark/test_urcu_qsbr_gc.c
> b/tests/benchmark/test_urcu_qsbr_gc.c
> index 11f0359..26bc352 100644
> --- a/tests/benchmark/test_urcu_qsbr_gc.c
> +++ b/tests/benchmark/test_urcu_qsbr_gc.c
> @@ -57,7 +57,7 @@ static unsigned long duration;
> 
> /* read-side C.S. duration, in loops */
> static unsigned long rduration;
> -static unsigned int reclaim_batch = 1;
> +static long reclaim_batch = 1;
> 
> struct reclaim_queue {
> 	void **queue;	/* Beginning of queue */
> @@ -450,7 +450,7 @@ int main(int argc, char **argv)
> 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
> 		"nr_writers %3u "
> 		"wdelay %6lu nr_reads %12llu nr_writes %12llu nr_ops %12llu "
> -		"batch %u\n",
> +		"batch %ld\n",
> 		argv[0], duration, nr_readers, rduration, wduration,
> 		nr_writers, wdelay, tot_reads, tot_writes,
> 		tot_reads + tot_writes, reclaim_batch);
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
