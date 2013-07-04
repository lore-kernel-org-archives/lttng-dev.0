From: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Subject: Re: [LTTng-modules PATCH] The msg part of
	the	printk:console event was 1 character too long
Date: Thu, 4 Jul 2013 19:58:47 +0000
Message-ID: <6C5EA58090A5ED459815C4D04C2B466FD93341A6__15798.5080070377$1372967972$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <1372447954-4360-1-git-send-email-yannick.brosseau@gmail.com>
	<20130628194304.GB24942@Krystal>
	<51CDE9C5.7060406@gmail.com>,<20130630202054.GA16058@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1Uupg8-0004xo-Ki
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 15:58:56 -0400
In-Reply-To: <20130630202054.GA16058@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
> Sent: Monday, July 01, 2013 00:20
> To: Yannick Brosseau; Gabbasov, Andrew
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [LTTng-modules PATCH] The msg part of the      printk:console event was 1 character too long
> 
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> > On 2013-06-28 15:43, Mathieu Desnoyers wrote:
> > > * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> > >> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> > >> ---
> > >>  instrumentation/events/lttng-module/printk.h |    2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
> > >> index 4c744f9..f4b6028 100644
> > >> --- a/instrumentation/events/lttng-module/printk.h
> > >> +++ b/instrumentation/events/lttng-module/printk.h
> > >> @@ -19,7 +19,7 @@ TRACE_EVENT_CONDITION(console,
> > >>
> > >>    TP_STRUCT__entry(
> > >>            __dynamic_array_text(char, msg,
> > >> -                  min_t(unsigned, end - start, MSG_TRACE_MAX_LEN) + 1)
> > > this was taken from the Linux kernel mainline instrumentation, no ?
> > >
> > > Has this been fixed upstream ? If so, can you cite the commit in the
> > > changelog ?
> > >
> > >
> > It's not changed upstream. From what I see, ftrace does the right thing,
> > but not LTTng. Will check perf and see if I can reproduce the problem
> > directly with the upstream kernel.
> 
> in 3.9.8, I see:
> 
>         TP_STRUCT__entry(
>                 __dynamic_array(char, msg, end - start + 1)
>         ),
> 
> (upstream)
> 
> which has the +1.
> 
> What effect of the off-by-one are you observing exactly ? Are you sure
> your fix is the right fix ? I wonder if modifying the TP_fast_assign()
> code would not be better. I'm not sure why #if (LINUX_VERSION_CODE >=
> KERNEL_VERSION(3,5,0)) has a different code from mainline. CCing Andrew
> Gabbasov who contributed this instrumentation.
> 
> Thanks,
> 
> Mathieu

Hi Mathieu, Yannick,

Actually I also don't see why having +1 is wrong. Trailing zero byte needs
it in the message length. Removing it in entry and not changing
TP_fast_assign (that explicitly adds a zero byte) looks doubtful.
I join to the question what the exact problem is, since my testing
(at least on version 3.5) didn't show any problem.

As for the different implementation code: starting version 3.5
the kernel no longer use circular buffer for storing printk messages,
and handling the message in 2 pieces what it crosses the boundary
is no longer needed. Moreover, log_buf_len becomes not necessarily
the power of 2, and previous implementation (based on what was
in the kernel) just becomes incorrect. So, the newer and simpler
implementation was introduced for later version. It also looks like
this instrumentation needs to be further updated for version 3.10,
since the whole tracepoint (even the parameters set) was changed
there, becoming even more simple.

Thanks.

Best regards,
Andrew
