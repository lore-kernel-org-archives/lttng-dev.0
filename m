From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Package liburcu: build for hurd-i386
Date: Fri, 22 Feb 2013 11:37:44 -0500
Message-ID: <20130222163744.GA24196__48092.1397371732$1361551175$gmane$org@Krystal>
References: <20130222140920.GA22156@Krystal>
	<20130222143032.GB8091@type.bordeaux.inria.fr>
	<20130222160111.GA23609@Krystal>
	<20130222160541.GD8091@type.bordeaux.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U8vd3-0007aT-Kf
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 11:37:45 -0500
Content-Disposition: inline
In-Reply-To: <20130222160541.GD8091@type.bordeaux.inria.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Samuel Thibault <sthibault@debian.org>, hurd-i386@buildd.debian.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Samuel Thibault (sthibault@debian.org) wrote:
> Mathieu Desnoyers, le Fri 22 Feb 2013 11:01:12 -0500, a =E9crit :
> > * Samuel Thibault (sthibault@debian.org) wrote:
> > > Hello,
> > > =

> > > Mathieu Desnoyers, le Fri 22 Feb 2013 09:09:20 -0500, a =E9crit :
> > > > I noticed a build failure on hurd-i386, and committed a fix in User=
space
> > > > RCU master branch to address this issue. Testing would be welcome.
> > > =

> > > Unfortunately it doesn't work, because sched_setaffinity is for now j=
ust
> > > a fail-stub on hurd-i386, and thus configure considers it as missing,
> > > and thus the CPU_SET test is disabled completely.
> > > =

> > > I however guess you could just disable defining your own cpu_set_t wh=
en
> > > !HAVE_SCHED_SETAFFINITY, since it is probably used only for using
> > > sched_setaffinity.
> > =

> > Either that or move the cpu_set_t, CPU_SET and CPU_ZERO tests outside of
> > the sched_setaffinity conditional within configure.ac. It will allow to
> > handle various configurations more elegantly. Here is the commit (pushed
> > into master), comments are welcome!
> =

> Yep, it does build fine now.

Thanks for testing!

I noticed that tests/api.h also needed to use cpuset.h (committed a
fix). I pulled these changes into stable-0.7.

Thanks,

Mathieu

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
