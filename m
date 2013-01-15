From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Compile out of src tree
Date: Tue, 15 Jan 2013 08:48:50 -0500
Message-ID: <20130115134850.GA25260__47077.0585271113$1358257774$gmane$org@Krystal>
References: <8549183.73181358253376696.JavaMail.www@wsfrf1114>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tv6sm-0001Z0-Bz
	for lttng-dev@lists.lttng.org; Tue, 15 Jan 2013 08:48:52 -0500
Content-Disposition: inline
In-Reply-To: <8549183.73181358253376696.JavaMail.www@wsfrf1114>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: paul.chavent@fnac.net, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* paul.chavent@fnac.net (paul.chavent@fnac.net) wrote:
> Hi.
> =

> Just a little patch in order to succeed building out of src tree.

Good point!

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> =

> Regards.
> =

> Paul.
> =

> diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile=
.am
> index 26d2461..1424f63 100644
> --- a/tests/tools/health/Makefile.am
> +++ b/tests/tools/health/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS =3D -I. -O2 -g -I../../../include
> +AM_CFLAGS =3D -I$(srcdir) -O2 -g -I$(top_srcdir)/include
> =A0AM_LDFLAGS =3D
> =A0
> =A0if LTTNG_TOOLS_BUILD_WITH_LIBDL
> =

> =

> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
