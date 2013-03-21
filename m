From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-ust] Add missing buffers-uid folder in
 ust regression test Makefile
Date: Thu, 21 Mar 2013 17:28:00 -0400
Message-ID: <CA+jJMxsY17Y=01d5JZ2baegTt29fNEXmvy3gwvKRXrrVQgvStw__14894.1013882451$1363901330$gmane$org@mail.gmail.com>
References: <1363901187-7955-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UIn1q-0007X2-Ox
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 17:28:06 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so7117117wib.4
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 14:28:00 -0700 (PDT)
In-Reply-To: <1363901187-7955-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Oops...Wrong subject! Applies to lttng-tools, obviously.

J=E9r=E9mie

On Thu, Mar 21, 2013 at 5:26 PM, J=E9r=E9mie Galarneau
<jeremie.galarneau@efficios.com> wrote:
>
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/regression/ust/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/regression/ust/Makefile.am b/tests/regression/ust/Make=
file.am
> index d8904bb..c5dee21 100644
> --- a/tests/regression/ust/Makefile.am
> +++ b/tests/regression/ust/Makefile.am
> @@ -1,6 +1,6 @@
>  if HAVE_LIBLTTNG_UST_CTL
>  SUBDIRS =3D nprocesses high-throughput low-throughput before-after multi=
-session \
> -                 overlap
> +                 overlap buffers-uid
>
>  EXTRA_DIST =3D runall.sh run-ust-global-tests.sh test_event_basic test_e=
vent_wildcard
>
> --
> 1.8.2
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
