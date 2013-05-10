From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: kprobe timestamp
Date: Fri, 10 May 2013 11:45:16 -0400
Message-ID: <20130510154516.GA22512__10006.1111305424$1368200750$gmane$org@Krystal>
References: <5176D588.5010307@gmail.com> <201304241357471345277@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UapVV-0007Jy-HW
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 11:45:17 -0400
Content-Disposition: inline
In-Reply-To: <201304241357471345277@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: OSDepend <osdepend@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* OSDepend (osdepend@gmail.com) wrote:
> 
> 
> > On 2013-04-23 12:50, OSDepend wrote:
> > > Hi guys,
> > > I just try to use kprobe, and get some thing like below:
> > >            
> > > java 15893 [015] 96380.588871: timer_cancel: timer=0xffff8804379d6698
> > >             java 15721 [010] 96380.588872: timer_cancel: timer=0xffff8800be3d6698
> > >             java 15893 [015] 96380.588875: timer_expire_entry: timer=0xffff8804379d6698 function=delayed_work_timer_fn now=4391194790
> > >             java 15721 [010] 96380.588876: timer_expire_entry: timer=0xffff8800be3d6698 function=delayed_work_timer_fn now=4391194790
> > > I want to know exactly about the time units of the events, such as
> > > 96380.588871, and 96380.588872.
> > > The number befor "." is second or millisecond? and  Is the number
> > > after "." nanoseconds or microseconds?
> > >
> > >What did you use to generate this output? I don't recognize it.
> 
> > >Yannick
> 
> /usr/src/linux-2.6.38.6/Documentation/trace/kprobetrace.txt
> I use kprobe to trace, you can get the documentation of kprobe in the text above.
> Does any one recognize the time format?

I guess you are using ftrace or perf rather than LTTng. You might want
to ask them instead.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
