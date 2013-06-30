From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng-modules PATCH] The msg part of
	the	printk:console event was 1 character too long
Date: Sun, 30 Jun 2013 16:20:54 -0400
Message-ID: <20130630202054.GA16058__49858.9100818664$1372623695$gmane$org@Krystal>
References: <1372447954-4360-1-git-send-email-yannick.brosseau@gmail.com>
	<20130628194304.GB24942@Krystal> <51CDE9C5.7060406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UtO7F-0004mp-Vo
	for lttng-dev@lists.lttng.org; Sun, 30 Jun 2013 16:20:58 -0400
Content-Disposition: inline
In-Reply-To: <51CDE9C5.7060406@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> On 2013-06-28 15:43, Mathieu Desnoyers wrote:
> > * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> >> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> >> ---
> >>  instrumentation/events/lttng-module/printk.h |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
> >> index 4c744f9..f4b6028 100644
> >> --- a/instrumentation/events/lttng-module/printk.h
> >> +++ b/instrumentation/events/lttng-module/printk.h
> >> @@ -19,7 +19,7 @@ TRACE_EVENT_CONDITION(console,
> >>  
> >>  	TP_STRUCT__entry(
> >>  		__dynamic_array_text(char, msg,
> >> -			min_t(unsigned, end - start, MSG_TRACE_MAX_LEN) + 1)
> > this was taken from the Linux kernel mainline instrumentation, no ?
> >
> > Has this been fixed upstream ? If so, can you cite the commit in the
> > changelog ?
> >
> >
> It's not changed upstream. From what I see, ftrace does the right thing,
> but not LTTng. Will check perf and see if I can reproduce the problem
> directly with the upstream kernel.

in 3.9.8, I see:

        TP_STRUCT__entry(
                __dynamic_array(char, msg, end - start + 1)
        ),

(upstream)

which has the +1.

What effect of the off-by-one are you observing exactly ? Are you sure
your fix is the right fix ? I wonder if modifying the TP_fast_assign()
code would not be better. I'm not sure why #if (LINUX_VERSION_CODE >=
KERNEL_VERSION(3,5,0)) has a different code from mainline. CCing Andrew
Gabbasov who contributed this instrumentation.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
