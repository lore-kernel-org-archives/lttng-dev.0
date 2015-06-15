From: Martin Leisener <martin@leisener.de>
Subject: Re: [PATCH lttng-modules] Fix: Building the event list
 fails on fragmented memory
Date: Mon, 15 Jun 2015 20:27:07 +0200
Message-ID: <557F18FB.5020701__36739.1033367769$1434392931$gmane$org@leisener.de>
References: <55755E0D.7010902@leisener.de>
 <1905517223.241.1433920494952.JavaMail.zimbra@efficios.com>
 <557838F1.9020808@leisener.de>
 <1586680029.1815.1434223948187.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.kundenserver.de ([212.227.17.13])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martin@leisener.de>) id 1Z4Z6J-00089B-5n
 for lttng-dev@lists.lttng.org; Mon, 15 Jun 2015 14:27:25 -0400
In-Reply-To: <1586680029.1815.1434223948187.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 06/13/2015 09:32 PM, Mathieu Desnoyers wrote:
> ----- On Jun 10, 2015, at 9:17 AM, Martin Leisener martin@leisener.de wrote:
> 
>> Hi Mathieu,
>>
>> sorry for sending the broken patch, I fell for some "smart" formating of my
>> email client, I cannot utilize it myself the way I send it.
>> Hence I now send the patch again as it was original intended. Sent to myself, I
>> can apply it, so I hope it now works in general as well
>> I examined as recommended diff -urN, it seems the output can be utilized by
>> patch the same way as git diff.
>> Hope it is now received the way I intended.
> 
> Hi Martin,
> 
> I tried you patch on a x86-64 machine (my laptop), and although taking a
> single kernel trace worked fine, it appears to OOPS when I run
> 
> (in lttng-tools)
> cd tests
> ./run.sh root_regression
> 
> Not sure if it's a race within lttng-modules that gets triggered by using
> virtual mem rather than linear mapping, or if it's something else...
> 
> Thoughts ?
> 
Hi Mathieu,

thanks for testing my patch. I tried the root regression with patched and unpatched
lttng-modules, and found the following result (x86 Ubuntu 12.04 LTS):

martin@OEKAN42PVB:~/src/lttng-tools/tests$ ./run.sh root_regression
regression/kernel/test_all_events ....................... ok
regression/kernel/test_event_basic ...................... ok
regression/kernel/test_syscall .......................... ok
regression/tools/live/test_kernel ....................... No subtests run
regression/tools/live/test_lttng_kernel ................. ok
regression/tools/streaming/test_high_throughput_limits .. ok
regression/tools/streaming/test_kernel .................. ok
regression/tools/snapshots/test_kernel .................. ok
regression/tools/snapshots/test_kernel_streaming ........ ok
regression/tools/health/test_thread_ok .................. ok

Test Summary Report
-------------------
regression/tools/live/test_kernel                     (Wstat: 0 Tests: 0 Failed: 0)
  Parse errors: No plan found in TAP output
Files=10, Tests=2402, 32 wallclock secs ( 0.16 usr  0.02 sys +  0.23 cusr  0.42 csys =  0.83 CPU)
Result: FAIL

Everything runs the same, but for the test_thread_ok, which executes 1-17 with different speeds
sometimes 1/17 takes longer, sometimes 4/17, but I couldn't make it fail.
Same behaviour with patched and unpatched modules.

It always fails (patched and unpatched) when I execute with sudo:
regression/kernel/test_all_events ....................... Dubious, test returned 6 (wstat 1536, 0x600)
...

Since it is not appearing on my system, but in yours it would point more into the direction
of a race.
If it is a race it would be interesting if it can be also triggered via a long running test,
also with the unpatched version (and the patched version on my system)

I will not be able to look into this for the next 3 weeks, unfortunately,
but I plan to setup some long running tests, once I find time again.

Regard Martin

> Thanks,
> 
> Mathieu
> 
>>
>> Regards Martin
>>
>>
>>
>> On a small arm imx6 solo with 256MB RAM it often happens that memory becomes
>> fragmented rather
>> quickly, so that kmalloc will not be able to get enough consecutive pages
>> (enocuntered for
>> example if you enable all kernel events: lttng enable-event -k syscall --all).
>>
>> This patch switches the allocation to vmalloc. Tested for x86 on Ubuntu 12.04
>> Lts
>> and on imx6 solo 256MB RAM
>>
>> If this patch is not applied, you can identify low and/or fragmented memory
>> failures by
>> looking at the kernel ring buffer (please ignore DMA, it is due to some memory
>> setup
>> misconfiguration, should read Normal):
>>
>> ...
>> [  321.993820] lttng-sessiond: page allocation failure: order:4, mode:0x1040d0
>> ...
>> [  321.994711] lowmem_reserve[]: 0 0 0
>> [  321.994727] DMA: 801*4kB (UEMC) 424*8kB (EMC) 355*16kB (UEMC) 344*32kB (MC)
>> 340*64kB (C) 8*128kB (C) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB
>> 0*16384kB 0*32768kB = 46068kB
>>
>> Signed-off-by: Martin Leisener <martin@leisener.de>
>>
>> diff -urN a/lttng-events.c lttng-modules/lttng-events.c
>> --- a/lttng-events.c	2015-06-10 14:36:51.143083012 +0200
>> +++ lttng-modules/lttng-events.c	2015-06-10 14:48:05.846662088 +0200
>> @@ -39,6 +39,7 @@
>> #include "wrapper/file.h"
>> #include <linux/jhash.h>
>> #include <linux/uaccess.h>
>> +#include <linux/vmalloc.h>
>>
>> #include "wrapper/uuid.h"
>> #include "wrapper/vmalloc.h"	/* for wrapper_vmalloc_sync_all() */
>> @@ -132,10 +133,10 @@
>> 			GFP_KERNEL);
>> 	if (!metadata_cache)
>> 		goto err_free_session;
>> -	metadata_cache->data = kzalloc(METADATA_CACHE_DEFAULT_SIZE,
>> -			GFP_KERNEL);
>> +	metadata_cache->data = vmalloc(METADATA_CACHE_DEFAULT_SIZE);
>> 	if (!metadata_cache->data)
>> 		goto err_free_cache;
>> +	memset(metadata_cache->data, 0, METADATA_CACHE_DEFAULT_SIZE);
>> 	metadata_cache->cache_alloc = METADATA_CACHE_DEFAULT_SIZE;
>> 	kref_init(&metadata_cache->refcount);
>> 	session->metadata_cache = metadata_cache;
>> @@ -162,7 +163,7 @@
>> {
>> 	struct lttng_metadata_cache *cache =
>> 		container_of(kref, struct lttng_metadata_cache, refcount);
>> -	kfree(cache->data);
>> +	vfree(cache->data);
>> 	kfree(cache);
>> }
>>
>> @@ -1523,10 +1524,15 @@
>> 		tmp_cache_alloc_size = max_t(unsigned int,
>> 				session->metadata_cache->cache_alloc + len,
>> 				session->metadata_cache->cache_alloc << 1);
>> -		tmp_cache_realloc = krealloc(session->metadata_cache->data,
>> -				tmp_cache_alloc_size, GFP_KERNEL);
>> +		tmp_cache_realloc = vmalloc(tmp_cache_alloc_size);
>> 		if (!tmp_cache_realloc)
>> 			goto err;
>> +		else if (session->metadata_cache->data) {
>> +			memset(tmp_cache_realloc, 0, tmp_cache_alloc_size);
>> +			memcpy(tmp_cache_realloc, session->metadata_cache->data,
>> session->metadata_cache->cache_alloc);
>> +			vfree(session->metadata_cache->data);
>> +		}
>> +
>> 		session->metadata_cache->cache_alloc = tmp_cache_alloc_size;
>> 		session->metadata_cache->data = tmp_cache_realloc;
>> 	}
>>
>>
>>
>>
>> On 06/10/2015 09:14 AM, Mathieu Desnoyers wrote:
>>> Hi Martin,
>>>
>>> Can you reformat your patch with diff -urN so I can apply it with patch ?
>>>
>>> Thanks!
>>>
>>> Mathieu
>>>
>>> ----- On Jun 8, 2015, at 11:19 AM, Martin Leisener martin@leisener.de wrote:
>>>
>>>> Hi Mathieu,
>>>>
>>>> thanks for merging my arm patch! I found one more issue during my lttng-modules
>>>> usages,
>>>> which can happen in low/fragmented memory situations. Please have a look, if you
>>>> find this
>>>> patch useful/mergable. Again it is tested on x86 Ubuntu 12.04 LTS as well as my
>>>> imx6 arm board.
>>>>
>>>> Regards Martin
>>>>
>>>>
>>>> On a small arm imx6 solo with 256MB RAM it often happens that memory becomes
>>>> fragmented rather
>>>> quickly, so that kmalloc will not be able to get enough consecutive pages
>>>> (enocuntered for
>>>> example if you enable all kernel events: lttng enable-event -k syscall --all).
>>>>
>>>> This patch switches the allocation to vmalloc. Tested for x86 on Ubuntu 12.04
>>>> Lts
>>>> and on imx6 solo 256MB RAM
>>>>
>>>> If this patch is not applied, you can identify low and/or fragmented memory
>>>> failures by
>>>> looking at the kernel ring buffer (please ignore DMA, it is due to some memory
>>>> setup
>>>> misconfiguration, should read Normal):
>>>>
>>>> ...
>>>> [  321.993820] lttng-sessiond: page allocation failure: order:4, mode:0x1040d0
>>>> ...
>>>> [  321.994711] lowmem_reserve[]: 0 0 0
>>>> [  321.994727] DMA: 801*4kB (UEMC) 424*8kB (EMC) 355*16kB (UEMC) 344*32kB (MC)
>>>> 340*64kB (C) 8*128kB (C) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB
>>>> 0*16384kB 0*32768kB = 46068kB
>>>>
>>>> Signed-off-by: Martin Leisener <martin@leisener.de>
>>>> ---
>>>> lttng-events.c |   16 +++++++++++-----
>>>> 1 file changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/lttng-events.c b/lttng-events.c
>>>> index 7eec04c..c861f71 100644
>>>> --- a/lttng-events.c
>>>> +++ b/lttng-events.c
>>>> @@ -39,6 +39,7 @@
>>>> #include "wrapper/file.h"
>>>> #include <linux/jhash.h>
>>>> #include <linux/uaccess.h>
>>>> +#include <linux/vmalloc.h>
>>>>  #include "wrapper/uuid.h"
>>>> #include "wrapper/vmalloc.h"	/* for wrapper_vmalloc_sync_all() */
>>>> @@ -132,10 +133,10 @@ struct lttng_session *lttng_session_create(void)
>>>> 			GFP_KERNEL);
>>>> 	if (!metadata_cache)
>>>> 		goto err_free_session;
>>>> -	metadata_cache->data = kzalloc(METADATA_CACHE_DEFAULT_SIZE,
>>>> -			GFP_KERNEL);
>>>> +	metadata_cache->data = vmalloc(METADATA_CACHE_DEFAULT_SIZE);
>>>> 	if (!metadata_cache->data)
>>>> 		goto err_free_cache;
>>>> +	memset(metadata_cache->data, 0, METADATA_CACHE_DEFAULT_SIZE);
>>>> 	metadata_cache->cache_alloc = METADATA_CACHE_DEFAULT_SIZE;
>>>> 	kref_init(&metadata_cache->refcount);
>>>> 	session->metadata_cache = metadata_cache;
>>>> @@ -162,7 +163,7 @@ void metadata_cache_destroy(struct kref *kref)
>>>> {
>>>> 	struct lttng_metadata_cache *cache =
>>>> 		container_of(kref, struct lttng_metadata_cache, refcount);
>>>> -	kfree(cache->data);
>>>> +	vfree(cache->data);
>>>> 	kfree(cache);
>>>> }
>>>> @@ -1523,10 +1524,15 @@ int lttng_metadata_printf(struct lttng_session *session,
>>>> 		tmp_cache_alloc_size = max_t(unsigned int,
>>>> 				session->metadata_cache->cache_alloc + len,
>>>> 				session->metadata_cache->cache_alloc << 1);
>>>> -		tmp_cache_realloc = krealloc(session->metadata_cache->data,
>>>> -				tmp_cache_alloc_size, GFP_KERNEL);
>>>> +		tmp_cache_realloc = vmalloc(tmp_cache_alloc_size);
>>>> 		if (!tmp_cache_realloc)
>>>> 			goto err;
>>>> +		else if (session->metadata_cache->data) {
>>>> +			memset(tmp_cache_realloc, 0, tmp_cache_alloc_size);
>>>> +			memcpy(tmp_cache_realloc, session->metadata_cache->data,
>>>> session->metadata_cache->cache_alloc);
>>>> +			vfree(session->metadata_cache->data);
>>>> +		}
>>>> +
>>>> 		session->metadata_cache->cache_alloc = tmp_cache_alloc_size;
>>>> 		session->metadata_cache->data = tmp_cache_realloc;
>>>> 	}
>>>> --
>>>> 1.7.9.5
>>>>
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
