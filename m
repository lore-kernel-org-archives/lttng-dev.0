From: Keir Fraser <keir@cohodata.com>
Subject: Re: [PATCH liburcu] Fix lifetime of rcu_barrier()'s
	completion structure
Date: Sun, 20 Apr 2014 06:35:46 +0100
Message-ID: <53535CB2.2030407__41783.1351551742$1397972211$gmane$org@cohodata.com>
References: <53518741.3060906@cohodata.com>
 <2068111068.4340.1397937819635.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f169.google.com ([74.125.82.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <keir@cohodata.com>) id 1WbkQ1-0005NO-CX
 for lttng-dev@lists.lttng.org; Sun, 20 Apr 2014 01:36:00 -0400
Received: by mail-we0-f169.google.com with SMTP id w62so2807466wes.28
 for <lttng-dev@lists.lttng.org>; Sat, 19 Apr 2014 22:35:51 -0700 (PDT)
In-Reply-To: <2068111068.4340.1397937819635.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org



Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Keir Fraser"<keir@cohodata.com>
>> To: lttng-dev@lists.lttng.org
>> Cc: "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>, "Paul E. McKenney"<paulmck@linux.vnet.ibm.com>
>> Sent: Friday, April 18, 2014 4:12:49 PM
>> Subject: [PATCH liburcu] Fix lifetime of rcu_barrier()'s completion structure
>>
>> [Another attachment, I must sort out to integrate with git send-mail]
>>
>> rcu_barrier() can return as soon as completion.barrier_count==0, which
>> frees the completion struct along with the rest of its stack frame. But
>> its call_rcu callbacks may yet try to read and write completion.futex
>> via the wake_up function.
>>
>> Fix this by calloc()ing the completion struct and implementing a
>> reference count to determine when it is eventually free()d.
>>
>> This also fixes bug #787, since calloc() initialises all fields of the
>> structure to zero.
>
> I slightly edited your patch to use urcu_ref() and uatomic_sub_return()
> (simple style fix). Please let me know if you are OK with the attached
> patch.

Yes that's better, in particular I don't know how I missed the existence 
of uatomic_sub_return(). Very happy with that, thanks.

  -- Keir

> Thanks!
>
> Mathieu
>
