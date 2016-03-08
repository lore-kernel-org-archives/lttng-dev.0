From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Horrible hack to make C++ link to liburcu
Date: Tue, 8 Mar 2016 00:31:50 +0000 (UTC)
Message-ID: <1791412603.18710.1457397110216.JavaMail.zimbra__14313.3402955302$1457397193$gmane$org@efficios.com>
References: <20160304203254.GA2033@linux.vnet.ibm.com>
 <410832705.17244.1457190630579.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ad5ZE-0002qy-Jo
 for lttng-dev@lists.lttng.org; Mon, 07 Mar 2016 19:32:06 -0500
In-Reply-To: <410832705.17244.1457190630579.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----- On Mar 5, 2016, at 10:10 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Mar 4, 2016, at 3:32 PM, Paul E. McKenney paulmck@linux.vnet.ibm.com
> wrote:
> 
>> Hello!
>> 
>> Still working with the C++ standards committee to add RCU to C++, and
>> of course one step on that path is to make C++ programs build against
>> liburcu.  The following hack-patch makes this work by disabling C++ access
>> to wfcqueue and by making C++ see the rcu_head ->next field as a void *.
>> 
>> This supports prototyping, but what would be the real fix?

Hi Paul,

Of course you can remove the _LGPL_SOURCE define. It will work, but
without inlining. I have two fixes that should make inlining work
in C++, even when using wfcqueue.h. Those are currently in

https://github.com/compudj/userspace-rcu-dev/tree/urcu-cpp

(top 2 commits)

Feedback is welcome,

Thanks!

Mathieu

> 
> One fix would be:
> 
> diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
> index 83ec219..c0bb289 100644
> --- a/urcu/wfcqueue.h
> +++ b/urcu/wfcqueue.h
> @@ -43,7 +43,7 @@ extern "C" {
>  * McKenney.
>  */
> 
> -#define CDS_WFCQ_WOULDBLOCK    ((void *) -1UL)
> +#define CDS_WFCQ_WOULDBLOCK    ((struct cds_wfcq_node *) -1UL)
> 
> enum cds_wfcq_ret {
>        CDS_WFCQ_RET_WOULDBLOCK =       -1,
> 
> In addition, g++ does not support the __transparent_union__ gcc attribute
> (it just ignores it). So we might want to rethink our use of this attribute
> within wfcqueue.h. We current use it for
> 
> /*
> * Do not put head and tail on the same cache-line if concurrent
> * enqueue/dequeue are expected from many CPUs. This eliminates
> * false-sharing between enqueue and dequeue.
> */
> struct __cds_wfcq_head {
>        struct cds_wfcq_node node;
> };
> 
> struct cds_wfcq_head {
>        struct cds_wfcq_node node;
>        pthread_mutex_t lock;
> };
> 
> /*
> * The transparent union allows calling functions that work on both
> * struct cds_wfcq_head and struct __cds_wfcq_head on any of those two
> * types.
> */
> typedef union {
>        struct __cds_wfcq_head *_h;
>        struct cds_wfcq_head *h;
> } __attribute__((__transparent_union__)) cds_wfcq_head_ptr_t;
> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> 
>> 
>>							Thanx, Paul
>> 
>> ------------------------------------------------------------------------
>> 
>> diff --git a/urcu-call-rcu.h b/urcu-call-rcu.h
>> index 339ebacc3f7c..d37c49e9d958 100644
>> --- a/urcu-call-rcu.h
>> +++ b/urcu-call-rcu.h
>> @@ -32,7 +32,9 @@
>> #include <stdlib.h>
>> #include <pthread.h>
>> 
>> +#ifndef __cplusplus
>> #include <urcu/wfcqueue.h>
>> +#endif
>> 
>> #ifdef __cplusplus
>> extern "C" {
>> @@ -57,7 +59,11 @@ struct call_rcu_data;
>>  */
>> 
>> struct rcu_head {
>> +#ifdef __cplusplus
>> +	void *next;
>> +#else
>> 	struct cds_wfcq_node next;
>> +#endif
>> 	void (*func)(struct rcu_head *head);
>>  };
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
