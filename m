From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation
	for	some pthread functions.
Date: Fri, 2 Aug 2013 21:28:44 -0400
Message-ID: <20130803012844.GI9033__18698.3319501907$1375493425$gmane$org@Krystal>
References: <51F97688.30704@mentor.com>
	<CA+jJMxsoH8Rz6fwZJOPnG-4xvB2w8GO5eqi0JDtHUy7iM-n2WA@mail.gmail.com>
	<51F9A917.9010509@seefeld.name>
	<CA+jJMxv4oS0SbMqUF247jS0s0E+6DfdepNT8yHimY=TULHD+tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V5QeD-0003fP-La
	for lttng-dev@lists.lttng.org; Fri, 02 Aug 2013 21:28:49 -0400
Content-Disposition: inline
In-Reply-To: <CA+jJMxv4oS0SbMqUF247jS0s0E+6DfdepNT8yHimY=TULHD+tQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> On Wed, Jul 31, 2013 at 8:17 PM, Stefan Seefeld <stefan@seefeld.name> wro=
te:
> > On 07/31/2013 06:00 PM, J=E9r=E9mie Galarneau wrote:
> >> Hi Stefan,
> >>
> >> Please inline your patches in the future as it makes the review proces=
s simpler.
> >> There are a number of stylistic problems, mostly misplaced braces.
> >>
> >> You can run your patches through the checkpatch.pl script found in
> >> lttng-tools/extras. It will spot most coding-style related problems
> >> right away.
> >
> > OK, will do, once the patch is approved functionally.
> >
> >> Also, I think lttng-ust-pthread-mutex.c may be a more appropriate name
> >> than pthread.c
> >
> > Wouldn't that just be redundant ? (And I actually expect the file to
> > grow instrumentation that's not mutex-specific.)
> =

> I'd keep the file name in line with what's already there, namely
> lttng-ust-malloc.c.
> If you plan on instrumenting other parts of the pthread API,
> lttng-ust-pthread.c would make sense.

Agreed.

Mathieu

> =

> >
> > Thanks,
> >     Stefan
> >
> > --
> >
> >       ...ich hab' noch einen Koffer in Berlin...
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
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
