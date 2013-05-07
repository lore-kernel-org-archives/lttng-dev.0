From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Issue faced in logging the traces
Date: Mon, 6 May 2013 23:18:18 -0400
Message-ID: <20130507031817.GF24603__22604.2414237329$1367896730$gmane$org@Krystal>
References: <CAG15VGA_O+6P9cLT8h3U-_W=YUVHEVFiBN5Zrm6Gj4i1qBV6BQ@mail.gmail.com>
	<511E463F.2080605@efficios.com>
	<CAG15VGC0HbAaJXwzkwbf5QTDPS8NPN_sW1UieA1oeoQb_iurcQ@mail.gmail.com>
	<CAG15VGDe4wvC0gzt8e3zGff-ow=NThetDMiZFZWk5u1dGmfFLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZYPz-0004ml-DS
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 23:18:19 -0400
Content-Disposition: inline
In-Reply-To: <CAG15VGDe4wvC0gzt8e3zGff-ow=NThetDMiZFZWk5u1dGmfFLQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vivek Kumar <vivekkumar.p@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Vivek,

When reporting an issue, please provide:

- lttng-sessiond verbose logs, debug logs,
- detailed command line usage,

in text-only format. Sorry, we're kind of busy, so don't expect us to
dig this information from attachments.

The best way to do this is to file a bug on bugs.lttng.org, so we can
track the issue.

Thanks,

Mathieu

* Vivek Kumar (vivekkumar.p@gmail.com) wrote:
> Hi David,
> 
> Any update?
> 
> Please let me know if more info is required.
> 
> Regards, Vivek
> 
> On Mon, Feb 18, 2013 at 4:26 PM, Vivek Kumar <vivekkumar.p@gmail.com> wrote:
> 
> > Hi David,
> >
> > Thanks for the response. LTTng-ust is also ported.
> > Please find attached the PPT where I have taken the snaps and described
> > the issue faced.
> > At present I am trying to port and instrument LTTng for userspace only.
> >
> > My SoC is ARM-Cortex A9 from Mindspeed and the os is openWRT Linux.
> >
> > LTTng doesn't report any issue when I run it to instrument in userspace
> > but CTF is not logged in the Home directory, please take a look to the
> > powerpoint slides for descriptions and commands that I give.
> >
> > Regards, Vivek
> >
> >
> >
> > On Fri, Feb 15, 2013 at 7:59 PM, David Goulet <dgoulet@efficios.com>wrote:
> >
> >> Hi Vivek,
> >>
> >> In order to collect a trace you need to instrument your application with
> >> LTTng-UST tracepoints.
> >>
> >> If you like to gather the syscalls for instance, you need to install the
> >> LTTng modules and start your session daemon as root.
> >>
> >> If you are still experiencing problem, please provide the commands you
> >> use and setup.
> >>
> >> Thanks!
> >> David
> >>
> >> Vivek Kumar:
> >> > Hi,
> >> >
> >> > I am trying to port LTTng to my arm based board.
> >> > For userspace tracing, I have been able to successfully port followings:
> >> > LTTng-tools,
> >> > LTT-ust Library
> >> > Userspace-rcu
> >> > libpopt
> >> >
> >> > Now I can see that lttng-sessiond is running, and am able to create
> >> > sessions, enable-event and start and stop tracing.
> >> > But, I don't see traces be logged in the home directory (indeed nothing
> >> > happens, i.e, not even the creation of the base directory ->
> >> lttng-traces).
> >> > Am I missing anything because of that LTTng is failing to log traces?
> >> > Please help.
> >> >
> >> > Regards, Vivek
> >> >
> >> >
> >> > --
> >> > Best, Vivek
> >> >
> >> >
> >> > This body part will be downloaded on demand.
> >>
> >
> >
> >
> > --
> > Best, Vivek
> 
> 
> 
> 
> -- 
> Best, Vivek

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
