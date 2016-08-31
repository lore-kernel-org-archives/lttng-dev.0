From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
 guest-to-QEMU trace channel
Date: Wed, 31 Aug 2016 12:35:47 -0400
Message-ID: <20160831163547.GD18281__28736.0793249265$1472661363$gmane$org@stefanha-x1.localdomain>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
 <20160823155430.GB3948@stefanha-x1.localdomain>
 <87lgzm4g5p.fsf@fimbulvetr.bsc.es>
 <20160829134502.GA26282@stefanha-x1.localdomain>
 <87a8fvjtw5.fsf@fimbulvetr.bsc.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5701322658887028132=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 24F8CA3E9F
 for <lttng-dev@lists.lttng.org>; Wed, 31 Aug 2016 16:36:21 +0000 (UTC)
In-Reply-To: <87a8fvjtw5.fsf@fimbulvetr.bsc.es>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: lttng-dev@lists.lttng.org


--===============5701322658887028132==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2016 at 08:46:02PM +0200, Llu=EDs Vilanova wrote:
> >> Also, I'm still not sure how to interact with QEMU's monitor interface=
 from
> >> within the probe code (probes execute in kernel mode, including "guru =
mode"
> >> code).
>=20
> > When SystemTap is used the QEMU monitor interface does nothing.
>=20
> That's not what I've experienced. I was able to use a stap script to chan=
ge the
> tracing state of events:
>=20
>    #!/usr/bin/env stap
>=20
>    %{
>    #include </home/lluis/Projects/qemu-dbi-test/test.h>
>    %}
>=20
>    function event:long(cpu:long, addr:long, info:long)
>    %{
>        char *argv[4] =3D {"/bin/sh", "-c", "echo 'trace-event * off' | te=
lnet localhost 1234", NULL};
>        call_usermodehelper(argv[0], argv, NULL, UMH_WAIT_EXEC);
>        STAP_RETURN(0);
>    %}
>=20
>    probe begin {
>        printf("hello\n")
>    }
>    probe process("./install/vanilla/bin/qemu-system-i386").mark("guest_me=
m_before_exec")
>    {
>        printf("%x %d %d\n", $arg1, $arg2, $arg3)
>        event($arg1, $arg2, $arg3)
>        exit()
>    }
>=20
> The only caveat is that you must pass the "-g" argument to stap.
>=20
> Also, for some reason the printf in the probe always prints zeros, no mat=
ter
> what the actual event receives (I've debugged QEMU down to the call to the
> auto-generated stap functions). Could this be an error in systemtap?

It's strange that arguments do not have valid values.  Debugging the
stap functions is the next step if you want to figure out what happened.
I've never had this issue before so maybe something with Debian
SystemTap userspace probes is broken.

Stefan

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXxwdiAAoJEJykq7OBq3PIRWQH/0AIMgY1KK3dTbFOsthTwor9
wVrxRr8Kpvr0OsD3DoLNMpxUpaE3ug6KI5uogiduFayPI9IL5ehDGFwGtpwUhvbV
tFE6FmabOYCubG5jrDDx4mAWA9qO8PhMSZl/PO/5FSxpPMsqEhmL9tEQd0aQwvgZ
hYSy9M3LauzSrzUGOgdbstzRVeLjKzcCROcDGBxFlEW3fqqVsl0j4wVDuB7nGX3W
Pca+WuN6qRxoBpnR2pajHui4Q6cwYC8HAd/9x4izW5D2mQ5yhktSqZsEj5q1bE91
84X+iuNH7Ss+N4g8lsEXTA8VTcZ3ByB6vkukOQUH/A5AV70mHwqjsEOR6sR9g94=
=Ieda
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--

--===============5701322658887028132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5701322658887028132==--
