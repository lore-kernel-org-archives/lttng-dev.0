From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] Fix printk instrumentation
Date: Thu, 4 Jul 2013 14:22:28 -0400
Message-ID: <20130704182228.GA332__42517.9910184399$1372962193$gmane$org@Krystal>
References: <20130704165855.GB31483@Krystal> <51D5B319.6060700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UuoAq-0004A0-99
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 14:22:32 -0400
Content-Disposition: inline
In-Reply-To: <51D5B319.6060700@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> On 2013-07-04 12:58, Mathieu Desnoyers wrote:
> > This patch fixes the printk instrumentation.
> >
> > - It does not require a 2kB buffer on the stack anymore,
> > - It introduces __dynamic_array_enc_ext_2() and tp_memcpy_dyn_2(), which
> >   allow copying into a single variable-length buffer from two sources,
> >   useful for kernel < 3.5.
> > - It adds support for 3.10 kernel printk instrumentation.
> >
> > Yannick, can you try this out on 3.4, 3.5, 3.9 and 3.10 kernels ? When
> > you confirm that it works, I'll split it into two patches (one for
> > lttng-events.h and the other for printk.h), merge, and backport this.
> So far:
> 3.10: Works and compile when small typo fixed (see bellow)

ok, fixed.

> 3.9: Works
> 3.2: Fail to enable with this error msg (will try to get more detailled
> info or fix)
> root@debian-wheezy:/home/scientist# lttng enable-event -k console
> PERROR [6648/6745]: create event ioctl: Invalid argument (in
> kernel_create_event() at kernel.c:205)
> Error: Event console: Enable kernel event failed (channel channel0,
> session auto-20130630-135404)
> Warning: Some command(s) went wrong

Hrm, make sure the "condition" trace event actually exist in 3.2 ?

> 
> 
> > Only built-tested on 3.5 kernel so far.
> >
> > Thanks,
> >
> > Mathieu
> >
> > ---
> > diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
> > index 4c744f9..e22a2cc 100644
> > --- a/instrumentation/events/lttng-module/printk.h
> > +++ b/instrumentation/events/lttng-module/printk.h
> > @@ -7,7 +7,25 @@
> >  #include <linux/tracepoint.h>
> >  #include <linux/version.h>
> >  
> > -#define MSG_TRACE_MAX_LEN	2048
> > +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0))
> > +
> > +TRACE_EVENT(console,
> > +	TP_PROTO(const char *text, size_t len),
> > +
> > +	TP_ARGS(text, len),
> > +
> > +	TP_STRUCT__entry(
> > +		__dynamic_array_text(char, msg, len)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		tp_memcpy_dyn(msg, msg)
> >
> second "msg" should be "text"

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
