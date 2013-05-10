From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH userspace-rcu] use a filled signal mask
	to	disable all signals
Date: Fri, 10 May 2013 08:46:50 -0400
Message-ID: <20130510124649.GA19767__43108.9330152192$1368190047$gmane$org@Krystal>
References: <29C931202891DE4ABE913168E7AC43EC014227E029@ONWVEXCHMB01.ciena.com>
	<20130510113802.GA15131@Krystal>
	<CAEzWAeJToVnojuAqAOg8BV3kLekgcw2apOycHQf6M7m26OJueA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uamip-0005mW-E1
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 08:46:51 -0400
Content-Disposition: inline
In-Reply-To: <CAEzWAeJToVnojuAqAOg8BV3kLekgcw2apOycHQf6M7m26OJueA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Brosseau, Yannick (yannick.brosseau@gmail.com) wrote:
> On Fri, May 10, 2013 at 7:38 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
> 
> > Hi Dave,
> >
> > Nice catch ! I've reworked the patch to also fix compat_arch_x86.c and
> > use SIG_BLOCK at those sites (details in changelog). Here is the version
> > I plan to merge into userspace rcu. Thanks for spotting this!
> >
> > Mathieu
> >
> > commit 6ed4b2e64c6cef5d6d1a1c1943f29dbf4edf026a
> > Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Date:   Fri May 10 07:30:18 2013 -0400
> >     Updates by Mathieu Desnoyers:
> >
> >     - Use SIG_BLOCK instead of SIG_SETMASK when setting a filled mask. This
> >       has the same behavior in this case (since we're blocking all
> > signals),
> >       but is semantically neater: if we ever some signals from that mask,
> >
> 
> if we ever what? Looks like a missing word in this changelog.

remove. sorry, it will stay like this.

Thanks,

Mathieu

> 
> 
> >       we'd like to to a union with the signal mask already blocked by the
> >       application.
> >     - Also fix incorrect signal masking in compat_arch_x86.c.
> >
> >     Reported-by: David Pelton <dpelton@ciena.com>
> >     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
