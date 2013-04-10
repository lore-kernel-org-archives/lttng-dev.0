From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Error using add-context for perf counters
Date: Wed, 10 Apr 2013 10:21:08 -0400
Message-ID: <20130410142108.GA5362__46649.7290450663$1365603701$gmane$org@Krystal>
References: <5148B66A.6080007@ericsson.com> <515C6F92.5060803@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UPvtg-0004kg-5P
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 10:21:12 -0400
Content-Disposition: inline
In-Reply-To: <515C6F92.5060803@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

please open a bug report on the bug tracker for this issue if you still
see it. Please let us know if you see it in 2.2-rc1 too.

* Matthew Khouzam (matthew.khouzam@ericsson.com) wrote:
> Hi, I can confirm this bug, Has anyone else tried it?
> 
> On 13-03-19 03:03 PM, Bernd Hufmann wrote:
> > Hello
> >
> > I cannot add contexts for perf counters using lttng-tools v2.1.1 and I
> > get an error (see below). When using lttng-tools 2.0.5 (on a different
> > computer) it works. Could somebody from lttng development team look
> > into that?
> >
> > Thanks
> > Bernd
> >
> > ----------------------------------------------------------------------
> > > lttng create mySession
> > Session mySession created.
> > Traces will be written in
> > /home/bernd/lttng-traces/mySession-20130319-145021
> >
> > > lttng enable-event -a -k
> > All kernel events are enabled in channel channel0
> >
> > > lttng add-context -k -t perf:branch-misses -t perf:cache-misses
> > PERROR: add context ioctl: Invalid argument [in
> > kernel_add_channel_context() at kernel.c:47]
> > Error: perf:cache-misses: Add kernel context failed
> > PERROR: add context ioctl: Invalid argument [in
> > kernel_add_channel_context() at kernel.c:47]
> > Error: perf:branch-misses: Add kernel context failed
> > Warning: Some command(s) went wrong
> >
> > -----------------------------------------------------------------------
> > My setup is:
> > Ubuntu 12.04 with kernel 3.2.0-38
> > lttng-modules v2.1.1
> > lttng-tools v2.1.1
> >
> >
> >
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
