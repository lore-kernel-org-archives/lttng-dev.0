From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Add missing buffers-uid
	folder	in ust regression test Makefile
Date: Thu, 21 Mar 2013 21:26:59 -0400
Message-ID: <20130322012659.GA17191__35177.7599462823$1363915680$gmane$org@Krystal>
References: <1363901187-7955-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UIql5-0000wt-4o
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 21:27:03 -0400
Content-Disposition: inline
In-Reply-To: <1363901187-7955-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

changing the subject, CCing to David.

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/regression/ust/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/tests/regression/ust/Makefile.am b/tests/regression/ust/Make=
file.am
> index d8904bb..c5dee21 100644
> --- a/tests/regression/ust/Makefile.am
> +++ b/tests/regression/ust/Makefile.am
> @@ -1,6 +1,6 @@
>  if HAVE_LIBLTTNG_UST_CTL
>  SUBDIRS =3D nprocesses high-throughput low-throughput before-after multi=
-session \
> -		  overlap
> +		  overlap buffers-uid
>  =

>  EXTRA_DIST =3D runall.sh run-ust-global-tests.sh test_event_basic test_e=
vent_wildcard
>  =

> -- =

> 1.8.2
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
