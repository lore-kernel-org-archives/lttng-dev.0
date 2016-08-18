From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
 guest-to-QEMU trace channel
Date: Thu, 18 Aug 2016 14:53:27 +0100
Message-ID: <20160818135327.GJ4850__23321.8245128684$1471528423$gmane$org@stefanha-x1.localdomain>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818094720.GA4850@stefanha-x1.localdomain>
 <87wpjeqsv9.fsf@fimbulvetr.bsc.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0355525449713057246=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3F207A2A23
 for <lttng-dev@lists.lttng.org>; Thu, 18 Aug 2016 13:53:36 +0000 (UTC)
In-Reply-To: <87wpjeqsv9.fsf@fimbulvetr.bsc.es>
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


--===============0355525449713057246==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPTHnM80CEnHQ2WJ"
Content-Disposition: inline


--mPTHnM80CEnHQ2WJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2016 at 12:22:18PM +0200, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > On Fri, Aug 05, 2016 at 06:59:23PM +0200, Llu=EDs Vilanova wrote:
> >> The hypertrace channel allows guest code to emit events in QEMU (the h=
ost) using
> >> its tracing infrastructure (see "docs/trace.txt"). This works in both =
'system'
> >> and 'user' modes. That is, hypertrace is to tracing, what hypercalls a=
re to
> >> system calls.
> >>=20
> >> You can use this to emit an event on both guest and QEMU (host) traces=
 to easily
> >> synchronize or correlate them. You could also modify you guest's traci=
ng system
> >> to emit all events through the hypertrace channel, providing a unified=
 and fully
> >> synchronized trace log. Another use case is timing the performance of =
guest code
> >> when optimizing TCG (QEMU traces have a timestamp).
> >>=20
> >> See first commit for a full description.
> >>=20
> >> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> >> ---
>=20
> > CCing Steven Rostedt, Masami Hiramatsu, Luiz Capitulino, and LTTng folks
> > who have all looked into host/guest tracing solutions.
> [...]
>=20
> Oh, I wasn't aware of that. I'm certainly interested in collaborating.

They are working on or have worked on different approaches to host/guest
tracing.  Unfortunately there isn't an out-of-the-box solution as far as
I know.

It would be nice if there was a documented host/guest tracing approach
that didn't involve much manual setup and handled most use cases.

Stefan

--mPTHnM80CEnHQ2WJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXtb3XAAoJEJykq7OBq3PIwsoH/2UNq012uaauQNC4XY1dskPf
6+9xwwq3xhmb3UzXtVX4Fe1ZM7YXpa5OoqEZJeNdShJHc957F3s77AbpU9cJUG6D
Oh37a2TwOSRj/uRetid0Y51gGeSyc5/wFdIkhDaIAVKk2UgGN50i0NUMbIa1Ggaj
Kuo99BGB4L08XWgnz9YSKM3O3FeGlP/PIphi9OcTLocPE7d6Gw3Ox0FAkTQT+q/Y
qqxRE60U6XLeDVCkrbDkRPpRAwsGzP8vhep7OflBQzHcRPBje1RYnFmuDi/5KpC4
LBacb8/wM9N8rOb597f9D/SCvua6uqG0Lqrpnb864Lz3zXuhnSuLo0xovPUYPso=
=VVba
-----END PGP SIGNATURE-----

--mPTHnM80CEnHQ2WJ--

--===============0355525449713057246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0355525449713057246==--
