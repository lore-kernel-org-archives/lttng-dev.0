From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH urcu 2/4] Fix: pthread_rwlock initialization
 on Cygwin
Date: Fri, 23 Nov 2018 15:54:53 -0500
Message-ID: <35e75d5a-bf20-4fc4-4ca7-ed63e3dc0931__48578.7811143838$1543006380$gmane$org@efficios.com>
References: <20181123202707.19851-1-mjeanson@efficios.com>
 <20181123202707.19851-2-mjeanson@efficios.com>
 <173534666.11983.1543005974050.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 431pTp74x5zyJL
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:54:54 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 484329A8C8
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:54:54 -0500 (EST)
In-Reply-To: <173534666.11983.1543005974050.JavaMail.zimbra@efficios.com>
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

On 2018-11-23 3:46 p.m., Mathieu Desnoyers wrote:
> ----- On Nov 23, 2018, at 3:27 PM, Michael Jeanson mjeanson@efficios.com wrote:
> 
>> On Cygwin the PTHREAD_RWLOCK_INITIALIZER macro is not
>> sufficient to get a properly initialized pthread_rwlock_t
>> struct. Use the pthread_rwlock_init function instead which
>> should work on all platforms.
>>
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> ---
>> tests/benchmark/test_rwlock.c        | 34 +++++++++++++++++++++++-----
>> tests/benchmark/test_rwlock_timing.c | 33 +++++++++++++++++++++------
>> 2 files changed, 54 insertions(+), 13 deletions(-)
>>
>> diff --git a/tests/benchmark/test_rwlock.c b/tests/benchmark/test_rwlock.c
>> index 4448597..c23e782 100644
>> --- a/tests/benchmark/test_rwlock.c
>> +++ b/tests/benchmark/test_rwlock.c
>> @@ -48,7 +48,7 @@ struct test_array {
>> 	int a;
>> };
>>
>> -pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;
>> +pthread_rwlock_t lock;
>>
>> static volatile int test_go, test_stop;
>>
>> @@ -173,14 +173,21 @@ void *thr_reader(void *_count)
>> 	}
>>
>> 	for (;;) {
>> -		int a;
>> +		int a, ret;
>> +
>> +		ret = pthread_rwlock_rdlock(&lock);
>> +		if (ret)
>> +			fprintf(stderr, "reader pthread_rwlock_rdlock: %s\n", strerror(ret));
> 
> In each of those cases, shouldn't we also "abort()" ?

Yes, that would make sense.

> 
>>
>> -		pthread_rwlock_rdlock(&lock);
>> 		a = test_array.a;
>> 		assert(a == 8);
>> 		if (caa_unlikely(rduration))
>> 			loop_sleep(rduration);
>> -		pthread_rwlock_unlock(&lock);
>> +
>> +		ret = pthread_rwlock_unlock(&lock);
>> +		if (ret)
>> +			fprintf(stderr, "reader pthread_rwlock_unlock: %s\n", strerror(ret));
>> +
>> 		URCU_TLS(nr_reads)++;
>> 		if (caa_unlikely(!test_duration_read()))
>> 			break;
>> @@ -208,12 +215,21 @@ void *thr_writer(void *_count)
>> 	cmm_smp_mb();
>>
>> 	for (;;) {
>> -		pthread_rwlock_wrlock(&lock);
>> +		int ret;
>> +
>> +		ret = pthread_rwlock_wrlock(&lock);
>> +		if (ret)
>> +			fprintf(stderr, "writer pthread_rwlock_wrlock: %s\n", strerror(ret));
>> +
>> 		test_array.a = 0;
>> 		test_array.a = 8;
>> 		if (caa_unlikely(wduration))
>> 			loop_sleep(wduration);
>> -		pthread_rwlock_unlock(&lock);
>> +
>> +		ret = pthread_rwlock_unlock(&lock);
>> +		if (ret)
>> +			fprintf(stderr, "writer pthread_rwlock_unlock: %s\n", strerror(ret));
>> +
>> 		URCU_TLS(nr_writes)++;
>> 		if (caa_unlikely(!test_duration_write()))
>> 			break;
>> @@ -321,6 +337,12 @@ int main(int argc, char **argv)
>> 	printf_verbose("thread %-6s, tid %lu\n",
>> 			"main", urcu_get_thread_id());
>>
>> +	err = pthread_rwlock_init(&lock, NULL);
>> +	if (err != 0) {
>> +		fprintf(stderr, "pthread_rwlock_init: (%d) %s\n", err, strerror(err));
>> +		exit(1);
>> +	}
>> +
>> 	tid_reader = calloc(nr_readers, sizeof(*tid_reader));
>> 	tid_writer = calloc(nr_writers, sizeof(*tid_writer));
>> 	count_reader = calloc(nr_readers, sizeof(*count_reader));
>> diff --git a/tests/benchmark/test_rwlock_timing.c
>> b/tests/benchmark/test_rwlock_timing.c
>> index a52da38..1e7863a 100644
>> --- a/tests/benchmark/test_rwlock_timing.c
>> +++ b/tests/benchmark/test_rwlock_timing.c
>> @@ -42,7 +42,7 @@ struct test_array {
>> 	int a;
>> };
>>
>> -pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;
>> +pthread_rwlock_t lock;
>>
>> static struct test_array test_array = { 8 };
>>
>> @@ -65,7 +65,7 @@ static caa_cycles_t
>> __attribute__((aligned(CAA_CACHE_LINE_SIZE))) *writer_time;
>>
>> void *thr_reader(void *arg)
>> {
>> -	int i, j;
>> +	int i, j, ret;
>> 	caa_cycles_t time1, time2;
>>
>> 	printf("thread_begin %s, tid %lu\n",
>> @@ -75,9 +75,15 @@ void *thr_reader(void *arg)
>> 	time1 = caa_get_cycles();
>> 	for (i = 0; i < OUTER_READ_LOOP; i++) {
>> 		for (j = 0; j < INNER_READ_LOOP; j++) {
>> -			pthread_rwlock_rdlock(&lock);
>> +			ret = pthread_rwlock_rdlock(&lock);
>> +			if (ret)
>> +				fprintf(stderr, "reader pthread_rwlock_rdlock: %s\n", strerror(ret));
>> +
>> 			assert(test_array.a == 8);
>> -			pthread_rwlock_unlock(&lock);
>> +
>> +			ret = pthread_rwlock_unlock(&lock);
>> +			if (ret)
>> +				fprintf(stderr, "reader pthread_rwlock_unlock: %s\n", strerror(ret));
>> 		}
>> 	}
>> 	time2 = caa_get_cycles();
>> @@ -93,7 +99,7 @@ void *thr_reader(void *arg)
>>
>> void *thr_writer(void *arg)
>> {
>> -	int i, j;
>> +	int i, j, ret;
>> 	caa_cycles_t time1, time2;
>>
>> 	printf("thread_begin %s, tid %lu\n",
>> @@ -103,9 +109,16 @@ void *thr_writer(void *arg)
>> 	for (i = 0; i < OUTER_WRITE_LOOP; i++) {
>> 		for (j = 0; j < INNER_WRITE_LOOP; j++) {
>> 			time1 = caa_get_cycles();
>> -			pthread_rwlock_wrlock(&lock);
>> +			ret = pthread_rwlock_wrlock(&lock);
>> +			if (ret)
>> +				fprintf(stderr, "writer pthread_rwlock_wrlock: %s\n", strerror(ret));
>> +
>> 			test_array.a = 8;
>> -			pthread_rwlock_unlock(&lock);
>> +
>> +			ret = pthread_rwlock_unlock(&lock);
>> +			if (ret)
>> +				fprintf(stderr, "writer pthread_rwlock_unlock: %s\n", strerror(ret));
>> +
>> 			time2 = caa_get_cycles();
>> 			writer_time[(unsigned long)arg] += time2 - time1;
>> 			usleep(1);
>> @@ -133,6 +146,12 @@ int main(int argc, char **argv)
>> 	num_read = atoi(argv[1]);
>> 	num_write = atoi(argv[2]);
>>
>> +	err = pthread_rwlock_init(&lock, NULL);
>> +	if (err != 0) {
>> +		fprintf(stderr, "pthread_rwlock_init: (%d) %s\n", err, strerror(err));
>> +		exit(1);
> 
> I typically use "abort()" instead.

exit() is used everywhere in this file to abort, I went with the "local"
style.

> 
> Thanks,
> 
> Mathieu
> 
> 
>> +	}
>> +
>> 	reader_time = calloc(num_read, sizeof(*reader_time));
>> 	writer_time = calloc(num_write, sizeof(*writer_time));
>> 	tid_reader = calloc(num_read, sizeof(*tid_reader));
>> --
>> 2.17.1
> 
