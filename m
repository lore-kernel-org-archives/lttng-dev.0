From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
 guest-to-QEMU trace channel
Date: Tue, 23 Aug 2016 11:54:30 -0400
Message-ID: <20160823155430.GB3948__39734.3119526797$1471986765$gmane$org@stefanha-x1.localdomain>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7436600089045515693=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 705E5A205B
 for <lttng-dev@lists.lttng.org>; Tue, 23 Aug 2016 21:12:39 +0000 (UTC)
In-Reply-To: <8737lypajh.fsf@fimbulvetr.bsc.es>
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


--===============7436600089045515693==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 21, 2016 at 02:32:34PM +0200, Llu=EDs Vilanova wrote:
> Unfortuntely, I've been unable to to make dtrace recognise QEMU's events =
(I'm
> only able to see the host kernel events). If someone with more experience=
 on it
> can help me use dtrace with QEMU's events, I'll also add the supporting l=
ibrary
> to let dtrace do the callout to QEMU's moitor interface and control the e=
vents,
> and add a prperly useful example of that on the hypertrace docs (which wa=
s my
> original intention).

Which "dtrace" and host OS are you using?

QEMU builds with static user-space probes.  You need to tell DTrace or
SystemTap to enable those probes in order to record trace data.

Stefan

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXvHG2AAoJEJykq7OBq3PI1KEH/0xbdnpWhRaYvebFiy6mZXT0
rJz/HjTYmpVQ1ggya2kVTiX2/GkWvd2aeEfCowHuw3FWjJWu8NTItUbKN1jMYBHZ
WI3JXbR0g4KE/K4ScyOcy06P6hPwvC+GHMh3vYxdwFKRiWrPwBHaI/ffmUE1LyKS
CoZX017Ktf87pD4Pmov06qGZylbCWolV4djhYjbGFNxGdk+fGe8ZuMXkRh4DYuKI
VpRNGcWgYEcZ4tNBeOhUyeRQjaTJJGmXFbDs358Eg3e/kmY/BJtq6kS/aRJBpDBy
1oWf40ox8jxLkb/xJn+0WWhEn/4KPX4oECFvEmxbrQATyok802KI8+XLOYO7ir0=
=YCAu
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

--===============7436600089045515693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7436600089045515693==--
