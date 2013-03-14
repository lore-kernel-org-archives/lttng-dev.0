From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [PATCH] Add a git version information in LTTng
 versions compiled from git sources
Date: Thu, 14 Mar 2013 00:49:37 -0400
Message-ID: <514156E1.6070300__26481.6558374607$1363236631$gmane$org@gmail.com>
References: <5140A719.6020003@gmail.com>
	<1363230220-11071-1-git-send-email-raphael.beamonte@gmail.com>
	<51414101.4080809@gmail.com>
	<CAEzWAe+Q41BjiSf+6FQ00jg3qrC71ZbdanDpunqFdYFeWBeGxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0015867700=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UG06r-0001mP-PU
	for lttng-dev@lists.lttng.org; Thu, 14 Mar 2013 00:49:45 -0400
Received: by mail-ia0-f175.google.com with SMTP id o25so1586982iad.20
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 21:49:40 -0700 (PDT)
In-Reply-To: <CAEzWAe+Q41BjiSf+6FQ00jg3qrC71ZbdanDpunqFdYFeWBeGxg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0015867700==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GDQSBKTGTNOKMTBTBSOE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GDQSBKTGTNOKMTBTBSOE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-14 00:34, Brosseau, Yannick wrote:
> For that part, you should probably have a version.h.in or something
> similar that is the template and the version.h that is generated.

Yes, that's an interesting idea. I'll look into that.

> A make dist should probably generate a version.h without the git
> version information.

Right. I'll find a way to do that.


------enig2GDQSBKTGTNOKMTBTBSOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQVbhAAoJECV+8Ygg/tEoGHAP/iUFEedgaV6CR/uInmD1Inrb
ys1jfmsO48HwzdUjXEn7u2rPF+gUJbf+yDZ3q12r/Z1A019gBGy27a4FGXGYaCBs
0ZV9yv/ToS7rx9fvPirMduSx4r9JUVN64fGHVCfXcSS1pzG739MoHhBBdyW2zg9b
n/lufhmQqLYv3kmIzvZBf7HdK4dNKuEqx/pt6sKh/Dp3UVptUFc4goScyeRgB+CN
xEIUSqLBr47/RyB8vXhBPY/gc8do+M3hTAZV2SzR1Di4xxvS4k95TvL7TqZF17+t
fIPAoFs92wZ/b29WyzGpReepuX1ry/XB3KAubXr14RdkLT6fgd4HGelhyHh7noCr
wAurqlEt6pARDowddBsS3odl26vO2JvHStStt47hLFqtqZwKWl2flEdL5Wg0n8P1
0dBA5UGnQKO1fHo9mTrHs2NSTSrCrdxMi8079eXMuTzydrdybFWAhwvLCDf5oAVE
luIAxFgPEHpew3YglMhjrL4asn8we2rfrlf8BZBnG4wpiW3Jvf7d5X/lf3fDAzp/
92zqH347JhyeFXBxed/bJjmFclPfIgM6Qg3gJlLC8lqyw8OTbz274lLb+k6ddwHU
HFv7iWCQnSHoCBQ2dn3R7OIqJgW0DjIIfUmnpVsMOrlj8GuES9QM7BCFBXar0jLW
2/IFyrylV2M6d0crWzCY
=zLgB
-----END PGP SIGNATURE-----

------enig2GDQSBKTGTNOKMTBTBSOE--


--===============0015867700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0015867700==--
