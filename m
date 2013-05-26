From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Getting started with UST
Date: Sun, 26 May 2013 09:55:32 -0400
Message-ID: <20130526135531.GA17287__34778.5916216255$1369576571$gmane$org@Krystal>
References: <CAE5ibEneMm2D1=3Zy8hbtV42Y22TwW2rRAqimyMSfMPvtiYCiA@mail.gmail.com>
	<51A209D6.6010802@gmail.com>
	<CAE5ibEkiyYRJyC0HYDHH6OuLUeebfLkCvXt0+O-AunT6bsTgXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UgbQ7-0003Yd-P1
	for lttng-dev@lists.lttng.org; Sun, 26 May 2013 09:55:35 -0400
Content-Disposition: inline
In-Reply-To: <CAE5ibEkiyYRJyC0HYDHH6OuLUeebfLkCvXt0+O-AunT6bsTgXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aryeh Weinreb <weinrea@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Aryeh Weinreb (weinrea@gmail.com) wrote:
> On Sun, May 26, 2013 at 4:10 PM, Yannick Brosseau
> <yannick.brosseau@gmail.com> wrote:
> > Hi,
> >
> > Did you forgot to enable some event, for example:
> > lttng enable-event -u -a
> > (For all userspace events)
> >
> 
> I did now, but I still can't get anything.

upgrade lttng-tools to 2.1.x. It's required along with lttng-ust 2.1.x.

Thanks,

Mathieu

> 
> # lttng list my_session
> Tracing session my_session: [active]
>     Trace path: /root/lttng-traces/my_session-20130526-074913
> 
> === Domain: UST global ===
> 
> Channels:
> -------------
> - channel0: [enabled]
> 
>     Attributes:
>       overwrite mode: 0
>       subbufers size: 4096
>       number of subbufers: 4
>       switch timer interval: 0
>       read timer interval: 200
>       output: mmap()
> 
>     Events:
>       * (type: tracepoint) [enabled]
> 
> 
> # ./sample
> 
> # lttng view
> Trace directory: /root/lttng-traces/my_session-20130526-074913
> 
> [error] Cannot open any trace for reading.
> 
> [error] opening trace "/root/lttng-traces/my_session-20130526-074913"
> for reading.
> 
> [error] none of the specified trace paths could be opened.
> 
> 
> # ls -l /root/lttng-traces/my_session-20130526-074913
> total 4
> drwxrwx--- 2 root root 4096 May 26 07:49 ust
> 
> # ls -l /root/lttng-traces/my_session-20130526-074913/ust/
> total 0
> 
> # lttng list -u
> UST events:
> -------------
> None
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
