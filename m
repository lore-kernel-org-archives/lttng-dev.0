From: =?UTF-8?B?UmFwaGHDq2wgQmVhbW9udGU=?= <raphael.beamonte@gmail.com>
Subject: Re: [PATCH] Add a git version information in LTTng
 versions compiled from git sources
Date: Thu, 14 Mar 2013 14:50:58 -0400
Message-ID: <51421C12.5050907__42274.1488241174$1363287121$gmane$org@gmail.com>
References: <5140A719.6020003@gmail.com>
	<1363230220-11071-1-git-send-email-raphael.beamonte@gmail.com>
	<51420073.7060005@efficios.com> <51420336.1070502@efficios.com>
	<5142059B.7050708@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1909784387=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UGDF8-0000PE-EU
	for lttng-dev@lists.lttng.org; Thu, 14 Mar 2013 14:51:10 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so2439942iag.31
	for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2013 11:51:05 -0700 (PDT)
In-Reply-To: <5142059B.7050708@gmail.com>
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1909784387==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2JMGJPXVXDDUJGNHVJJUD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JMGJPXVXDDUJGNHVJJUD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-03-14 12:53, David Goulet wrote:
> Another thing, we really do prefer having #ifdef statement in one call
> site per binaries this means that you might want to use like
> "lttng-sessiond.h", put the ifdef there and do an inline function to
> print the correct version.

Ok, no problem ! Will be like that in the next try of the patch.

> Last thing, don't use spaces please! You can use extras/checkpatch.pl t=
o
> make sure you are ok with the std we have.

Sorry, copy/paste mistake. I'll correct that.

On 2013-03-14 13:04, David Goulet wrote:
> Oh wait it did create the version.h with the GIT_VERSION but I had to
> compile again so this header file could be used in the code.

Thanks for reporting that. Didn't see it at first !

On 2013-03-14 13:15, Yannick Brosseau wrote:
> I think this method is really sensible on the execution order of the
> makefile. Maybe it should be put at the top level.

Right, I'll do that.


------enig2JMGJPXVXDDUJGNHVJJUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQhwSAAoJECV+8Ygg/tEosfMQAL3YtkQ9j3Q5td71xyHqKS7b
k+qvQHQ7nq2WcC5vTzqVamR1KGdtjtqe4xyMO1PGOhJT5OJspMK4sx0Ba+ZHrZJ8
c3ME2fBDE5lA63xfx1D9QnTSs+b1y18w7ZKVBqFEg/bQWSlEo0YaPPAarOr48ES6
tIcVtl3jNozqH/wVcGR6d/jlmwvtTP31751zEPI56uSFagpuqsaMqYJMdZ8bTme8
YJNWsP8aJLCFTM3iRotP/86Ts1ebeHCpbDPPwdhPLmDTmW2xK6kBey5E+1sKCsMf
LG0/X9lsTlkK6tb8VCI0zgkDQnr5lPtSpH7WcQbL5sUXC9ptv7YMZcf2VQqgnYQU
8ivif2EvxhINCWc2REMVrPmhuF/pPxaKiM8kb9y19Tnl4qk7ihPVEvDra7iamFIg
gFhcpKWSWwwxG3lEd4oiJ672nCPnurPzBnoPgXSW3xdBbzsOxHVuCCxW6HzQEJ30
YnkMvGB3e6hJwxOD5l61Gz5C5Tz+B3BHuA7wN5uQDTZ6osSEEMM93iPsA5MAMsYk
4g45ZUiSUrPYXrW9Ab8QgrnGJ+3Dm8TMQv+ULwF1UwAuONbvBu0hp3w7HYA2o1V9
tkx1GZJvJc5g8c7CjQ7C0Uau/gkOM+svxHEw1JauCxKZsKk3sSxVfEjAz/gOA9PQ
BCOoIWkh9T6TwV7eLh9B
=4NjA
-----END PGP SIGNATURE-----

------enig2JMGJPXVXDDUJGNHVJJUD--


--===============1909784387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1909784387==--
