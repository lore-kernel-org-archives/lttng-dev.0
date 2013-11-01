From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Re: Userspace RCU VS spin locks
Date: Fri, 1 Nov 2013 12:13:06 +0400
Message-ID: <CAO6Ho0eDS-RrOUN1jM3zYL9fvmrqf1uAkF4kpCaE+dYSX_Ufxg__43475.1618923203$1383293644$gmane$org@mail.gmail.com>
References: <CAO6Ho0ch2U2r5Ept2qFkOh1_Hxm6FcawsrzEmRQDEVi+KM5+tA@mail.gmail.com>
	<990689914.54025.1383219361284.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lolkaantimat@gmail.com>) id 1Vc9qy-0000Me-9t
	for lttng-dev@lists.lttng.org; Fri, 01 Nov 2013 04:13:14 -0400
Received: by mail-ie0-f180.google.com with SMTP id e14so6732789iej.39
	for <lttng-dev@lists.lttng.org>; Fri, 01 Nov 2013 01:13:06 -0700 (PDT)
In-Reply-To: <990689914.54025.1383219361284.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Thanks a lot, Mathieu!

On Thu, Oct 31, 2013 at 3:36 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
>> From: "Evgeniy Ivanov" <lolkaantimat@gmail.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Wednesday, October 30, 2013 9:11:47 AM
>> Subject: [lttng-dev] Userspace RCU VS spin locks
>>
>> Hi,
>>
>> I'm very interested in RCU performance, especially applied to hash
>> tables (rculfhash in particular). Did any body compare performance of
>> QSBR or signal RCU VS scalable and non-scalable spin locks?
>>
>
> Hi Evgeniy,
>
> You'll probably want to start by looking at my Linux Plumbers slides presenting rculfhash:
>
> https://www.efficios.com/lpc2011-urcu
>
> Also, Paul McKenney's slides of the Userspace RCU tutorial here present other numbers of a hash table example (including bucket-locks), AFAIK using his own statically sized hash table implementation (not rculfhash):
>
> https://events.linuxfoundation.org/sites/events/files/slides/userspace-rcu-tutorial-linuxcon-2013.pdf
>
> Thanks,
>
> Mathieu
>
>
>
>> --
>> Cheers,
>> Evgeniy
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- 
Cheers,
Evgeniy
