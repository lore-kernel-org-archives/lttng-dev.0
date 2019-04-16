From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: SIG33 message
Date: Tue, 16 Apr 2019 14:41:46 -0400 (EDT)
Message-ID: <928278419.2587.1555440106952.JavaMail.zimbra__16296.5107521572$1555440125$gmane$org@efficios.com>
References: <CAJyWpKFdOV6uiwWUicD5GNSSjWsD1TXjn=p45p_g6xu7F3HJbQ@mail.gmail.com>
 <03778ce1-f017-176a-3c5f-35fba359b5aa@gydle.com>
 <56684942.2314.1555438313423.JavaMail.zimbra@efficios.com>
 <91e63721-14c2-74f8-66ac-fec45ae8721f@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44kDjn0CG9z1Knq
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 14:41:48 -0400 (EDT)
In-Reply-To: <91e63721-14c2-74f8-66ac-fec45ae8721f@gydle.com>
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

----- On Apr 16, 2019, at 2:21 PM, Sebastien Boisvert sboisvert@gydle.com wrote:

> On 2019-04-16 2:12 p.m., Mathieu Desnoyers wrote:
> [snip]
>> 
>> Hi Sebastien,
>> 
>> This part of the ring buffer should only be used by the consumer daemon through
>> liblttng-ust-ctl.so, never from the traced applications.
>> 
>> So I keep suspecting that it's NPTL's use of SIG33 which is causing an old
>> version of gdb to trap, ref:
>> https://gdb.sourceware.narkive.com/SzqG56iA/program-received-signal-sig33-real-time-event-33
>> 
>> Thanks,
>> 
>> Mathieu
>> 
> 
> If it is the case that an old gdb is involved,
> then it is unrelated to this kill() call site in the LTTng-UST source code:
> 
>    libringbuffer/ring_buffer_frontend.c:767:	kill(getpid(),
>    LTTNG_UST_RB_SIG_TEARDOWN);
> 
> because LTTNG_UST_RB_SIG_TEARDOWN is SIGRTMIN + 2. According to the man page of
> signal(7) [1],
> SIGRTMIN is 34 (Native Posix Thread Library) or 35 (LinuxThreads, whatever that
> is).
> 
> 
> The equation
> 
>    33 = SIGRTMIN + 2
> 
> is not satisfied with either 34 or 35.
> 
> 
> So, is upgrading gdg the solution ?

Based on the gdb forum link I showed, either explicitly disable handling
SIG33 in older gdb:

handle SIG33 nostop noprint pass

or upgrade gdb.

Thanks,

Mathieu

> 
> 
> [1] http://man7.org/linux/man-pages/man7/signal.7.html
> 
> 
> [snip]

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
