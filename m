From: OSDepend <osdepend@gmail.com>
Subject: Re: kprobe timestamp
Date: Wed, 24 Apr 2013 13:57:49 +0800
Message-ID: <201304241357471345277__1951.63920657269$1366783109$gmane$org@gmail.com>
References: <201304240050144491467@gmail.com>,
 <5176D588.5010307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-da0-f48.google.com ([209.85.210.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <osdepend@gmail.com>) id 1UUsiM-0001Ns-Cq
	for lttng-dev@lists.lttng.org; Wed, 24 Apr 2013 01:57:58 -0400
Received: by mail-da0-f48.google.com with SMTP id f10so709998dak.21
	for <lttng-dev@lists.lttng.org>; Tue, 23 Apr 2013 22:57:52 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



> On 2013-04-23 12:50, OSDepend wrote:
> > Hi guys,
> > I just try to use kprobe, and get some thing like below:
> >            
> > java 15893 [015] 96380.588871: timer_cancel: timer=0xffff8804379d6698
> >             java 15721 [010] 96380.588872: timer_cancel: timer=0xffff8800be3d6698
> >             java 15893 [015] 96380.588875: timer_expire_entry: timer=0xffff8804379d6698 function=delayed_work_timer_fn now=4391194790
> >             java 15721 [010] 96380.588876: timer_expire_entry: timer=0xffff8800be3d6698 function=delayed_work_timer_fn now=4391194790
> > I want to know exactly about the time units of the events, such as
> > 96380.588871, and 96380.588872.
> > The number befor "." is second or millisecond? and  Is the number
> > after "." nanoseconds or microseconds?
> >
> >What did you use to generate this output? I don't recognize it.

> >Yannick

/usr/src/linux-2.6.38.6/Documentation/trace/kprobetrace.txt
I use kprobe to trace, you can get the documentation of kprobe in the text above.
Does any one recognize the time format?

Best,
Chen
