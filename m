From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: supporting new processor
Date: Tue, 11 Jun 2013 11:20:11 -0400
Message-ID: <20130611152011.GA31018__4000.19033481858$1370964055$gmane$org@Krystal>
References: <CANJoRMRRWiHAL=fcP717Dv9QmZVJBjpLjB0pBEioewtni8QkLw@mail.gmail.com>
	<CA+jJMxuvWRgyhzu4=QUh0+TR=9Lp1BV7PcHJHuj-LOgPDFTDUQ@mail.gmail.com>
	<CANJoRMS1y+rdpwkO+F2UVc72FL4WVbqrUVXH8iMBt344U3h71Q@mail.gmail.com>
	<CA+jJMxshwZh-6ysyAfFG6oFqx3KTmyDqRdmkxoHYzf0G_hqmJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UmQMn-00063i-Ba
	for lttng-dev@lists.lttng.org; Tue, 11 Jun 2013 11:20:13 -0400
Content-Disposition: inline
In-Reply-To: <CA+jJMxshwZh-6ysyAfFG6oFqx3KTmyDqRdmkxoHYzf0G_hqmJA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: Madhusudan Bhat <madhu.b77@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I just added MIPS to the urcu README file in master.

Thanks,

Mathieu

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> MIPS support was added as part of the Userspace RCU 0.7.4 release.
> Can't say I have tried it myself though.
> =

> Regards,
> J=E9r=E9mie
> =

> On Tue, Jun 11, 2013 at 6:42 AM, Madhusudan Bhat <madhu.b77@gmail.com> wr=
ote:
> > Hi J=E9r=E9mie,
> >
> > Thanks for the response. You have mentioned that MIPS is supported. How=
ever
> > README under U-RCU doesn't list the MIPS under the supported architectu=
re.
> > Is it possible to confirm again?
> >
> > Is there any order in which I need to build the different components li=
ke
> > URCU, lttng-tools, kernel module and UST?
> > thanks,
> > Madhu.
> >
> >
> > On Mon, Apr 22, 2013 at 7:47 PM, J=E9r=E9mie Galarneau
> > <jeremie.galarneau@efficios.com> wrote:
> >>
> >> Hi,
> >>
> >> Generally speaking, URCU is the most architecture-specific library of
> >> the project and it does support MIPS. Once it is compiled and
> >> installed, you should be able to build lttng-ust, lttng-tools and the
> >> kernel modules.
> >>
> >> I'd recommend running each project's test suite since I don't think
> >> that architecture has been thoroughly tested. Let us know if you
> >> encounter any problem on your particular architecture.
> >>
> >> Regards,
> >> J=E9r=E9mie
> >>
> >> On Mon, Apr 22, 2013 at 1:30 AM, Madhusudan Bhat <madhu.b77@gmail.com>
> >> wrote:
> >> > Hi All,
> >> >
> >> > I need to support lttng tools, I have new MIPS based multi core
> >> > processor on
> >> > which 3.7 linux kernel boots up.
> >> >
> >> > To support lttng tools, does it require any drivers/kernel hook ups =
to
> >> > new
> >> > processor? Or is it independent of processor architecture?
> >> >
> >> > For ex, to support Oprofile tools, we need to provide oprofile driver
> >> > which
> >> > is specific to particular processor. In similar ways,any thing is
> >> > required
> >> > to support lttng tools?
> >> >
> >> > thanks,
> >> > Madhu.
> >> >
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> >
> >>
> >>
> >>
> >> --
> >> J=E9r=E9mie Galarneau
> >> EfficiOS Inc.
> >> http://www.efficios.com
> >
> >
> =

> =

> =

> -- =

> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
