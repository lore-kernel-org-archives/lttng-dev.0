From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: SIG33 message
Date: Tue, 16 Apr 2019 14:11:53 -0400 (EDT)
Message-ID: <56684942.2314.1555438313423.JavaMail.zimbra__6364.88295146904$1555438331$gmane$org@efficios.com>
References: <CAJyWpKFdOV6uiwWUicD5GNSSjWsD1TXjn=p45p_g6xu7F3HJbQ@mail.gmail.com>
 <03778ce1-f017-176a-3c5f-35fba359b5aa@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44kD3H4tN5z1Kkh
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 14:11:54 -0400 (EDT)
In-Reply-To: <03778ce1-f017-176a-3c5f-35fba359b5aa@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Joe Sutker <jomasu22@gmail.com>
List-Id: lttng-dev@lists.lttng.org


----- On Apr 16, 2019, at 1:58 PM, Sebastien Boisvert sboisvert@gydle.com wrote:

> Hi Mosleh,
> 
> (I just saw Mathieu's answer arrive in my inbox while I was writing this.)
> 
> First, I don't know the exact solution.
> 
> 
> In Linux, signals are sent with the kill() function.
> 
> In the LTTng-UST source code, there are 3 signals that relate to 'Suspended:
> Signal: SIG33:Real-time event 33' (RT):
> 
> libringbuffer/ring_buffer_frontend.c:82:#define LTTNG_UST_RB_SIG_FLUSH		SIGRTMIN
> libringbuffer/ring_buffer_frontend.c:83:#define LTTNG_UST_RB_SIG_READ		SIGRTMIN
> + 1
> libringbuffer/ring_buffer_frontend.c:84:#define LTTNG_UST_RB_SIG_TEARDOWN
> 	SIGRTMIN + 2
> 
> =>
> http://git.lttng.org/?p=lttng-ust.git;a=blob;f=libringbuffer/ring_buffer_frontend.c;h=9721df1634585f028316d13f96b184af7e99cc08;hb=HEAD#l82
> 
> 
> On my system (Ubuntu 18.04.2 LTS with Linux 4.15.0-47-generic), SIGRTMIN = 34.
> 
> Check with 'kill -l SIGRTMIN' on your system to see if it it the same value.
> 
> 
> 
> In the LTTng-UST source code, there 1 this call to kill():
> 
> libringbuffer/ring_buffer_frontend.c:767:	kill(getpid(),
> LTTNG_UST_RB_SIG_TEARDOWN);
> 
> =>
> http://git.lttng.org/?p=lttng-ust.git;a=blob;f=libringbuffer/ring_buffer_frontend.c;h=9721df1634585f028316d13f96b184af7e99cc08;hb=HEAD#l767
> 
> 
> 
> 
> These custom signals seem to be handled here:
> 
> libringbuffer/ring_buffer_frontend.c:660
> 
> =>
> http://git.lttng.org/?p=lttng-ust.git;a=blob;f=libringbuffer/ring_buffer_frontend.c;h=9721df1634585f028316d13f96b184af7e99cc08;hb=HEAD#l660

Hi Sebastien,

This part of the ring buffer should only be used by the consumer daemon through
liblttng-ust-ctl.so, never from the traced applications.

So I keep suspecting that it's NPTL's use of SIG33 which is causing an old
version of gdb to trap, ref: https://gdb.sourceware.narkive.com/SzqG56iA/program-received-signal-sig33-real-time-event-33

Thanks,

Mathieu

> 
> 
> 
> 
> On 2019-04-04 3:26 p.m., Mosleh Uddin wrote:
>> Hello,
>> 
>> I am building an application which I am compiling with the 'lttng-ust' flag.
>> When I try to debug the application using gdb, I get a 'Suspended: Signal:
>> SIG33:Real-time event 33' message. This only happens when I compile with the
>> 'lttng-ust' flag, if I remove it I no longer have this issue. Any insight?
>> 
>> Regards,
>> Mosleh
>> 
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
