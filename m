From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC patch 3/3] [Babeltrace python bindings]
	Added	missing typedef of ssize_t to babeltrace.i.in
Date: Mon, 26 Aug 2013 13:48:06 -0400
Message-ID: <20130826174806.GA18712__28292.4076113433$1377539343$gmane$org@Krystal>
References: <OFF39EE861.F113E1F5-ONC2257BCD.002B4E00-C2257BCD.002BCD61@il.ibm.com>
	<CA+jJMxt+1q7AYtK65siaZfXc=jmmTBEiewGauP0RfmVHbYjwpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VE0tb-0004y3-Kj
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 13:48:13 -0400
Content-Disposition: inline
In-Reply-To: <CA+jJMxt+1q7AYtK65siaZfXc=jmmTBEiewGauP0RfmVHbYjwpw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

OK, sorry, reverting this patch from the python bindings branch.

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> On Tue, Aug 20, 2013 at 3:58 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> > The file babeltrace.i.in contains a declaration of bt_get_int_len()
> > returning ssize_t, which SWIG does not recognize as an integer (perhaps=
 only
> > in some cases).
> > Adding a typedef causes generation of correct code.
> >
> > J=E9r=E9mie, perhaps your suggestion to solve this in config time is be=
tter, so
> > I would leave this to your discretion.
> >
> =

> Thanks for clarifying the problem in your previous e-mail. The
> generated code, albeit ugly, works fine (unless I'm missing
> something). I am tempted to leave it as is until we implement the
> proper fix.
> =

> Thanks,
> J=E9r=E9mie
> =

> >
> >
> > Thanks,
> >
> > Amit Margalit
> > IBM XIV - Storage Reinvented
> > XIV-NAS Development Team
> > Tel. 03-689-7774
> > Fax. 03-689-7230
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
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
