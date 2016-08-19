From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
 guest-to-QEMU trace channel
Date: Fri, 19 Aug 2016 11:02:07 +0100
Message-ID: <20160819100207.GA17385__3034.18558692119$1471600943$gmane$org@stefanha-x1.localdomain>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <20160818121950.6a8d3c2d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2154802322420152304=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1A815A2BCD
 for <lttng-dev@lists.lttng.org>; Fri, 19 Aug 2016 10:02:19 +0000 (UTC)
In-Reply-To: <20160818121950.6a8d3c2d@gandalf.local.home>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
List-Id: lttng-dev@lists.lttng.org


--===============2154802322420152304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2016 at 12:19:50PM -0400, Steven Rostedt wrote:
> On Thu, 18 Aug 2016 11:54:24 +0100
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> > Steven is working on a host/guest solution for trace-cmd.  It is also
> > asynchronous.  No new paravirt hardware is needed and it makes me wonder
> > whether the hypertrace PCI device is trying to solve the problem at the
> > wrong layer.
>=20
> Yes, and I'm currently working on it again. In fact, if any of you will
> be at LinuxCon in Toronto next week, I'll be presenting[1] what I have
> and what I plan to complete in the near future.
>=20
> -- Steve
>=20
> [1] https://lcccna2016.sched.org/event/7JWL/trace-cmd-virt-server-a-statu=
s-update-steven-rostedt-red-hat?iframe=3Dno&w=3Di:100;&sidebar=3Dyes&bg=3Dno

Cool, that's very interesting!  I'll try to attend.

I guess LinuxCon will post a video of your talk and the slides will be
available after the talk so people not at LinuxCon will be able to check
it out too.

Stefan

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXttkfAAoJEJykq7OBq3PI9SIH/1Jtr5PsU9WmfqB2EWyLNmH3
hLMiWPj6RT5qe0LKGeJucEZ2kM3aFvWz9bsOIcPAzVbGFki/O9SHq+x+Gq4PKgui
oHGDqLok9FuJ32FvbT5D5iuGelIdAe6nxyjzWvzDFPFU9Vze1U8wDRoasVyAtvIy
ha3bJxVLxX2lpOMlcb7Q3zH0o6qA6IzTCZIo6m5uUo2DXfPIHlNcDPxq1w6w3IeW
qEwOEydCXS0q4q1UKXMgyP0JdIjeGQCkMJHI6DZKHET9BW111GSu9IhoLwUBP933
JrCYYtIwy4Jn0lecyPj3OKaNOAPAGZSYAyY8hN9uQilV0ha0SEBKv3euXaBvOzk=
=4wcB
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

--===============2154802322420152304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2154802322420152304==--
