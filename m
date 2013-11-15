From: David Goulet <dgoulet@efficios.com>
Subject: =?iso-8859-1?q?=5BRELEASE=5D_LTTng-Tools_2=2E4=2E0-rc?=
 =?iso-8859-1?q?1_-_=C9poque_Opaque?=
Date: Fri, 15 Nov 2013 12:27:01 -0500
Message-ID: <20131115172701.GD6986__36727.998374454$1384536486$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1300524787=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VhNAj-0003io-KJ
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 12:27:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 9D973A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 17:27:03 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id F8kmETfJ7rEZ for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 17:27:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 16743A1DA0
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 17:27:03 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PbmriQPLGTQl for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 17:27:02 +0000 (UTC)
Received: from thessa (cable-10.246.173-146.electronicbox.net [173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 65FD4A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 17:27:02 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1300524787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

Introducing the "=C9poque Opaque", the E version of the LTTng toolchain.
I invite everyone to read the small description of this version by doing
"lttng version" :).

This is the feature freeze and first 2.4.0 release candidate. This
version adds multiple fixes and some new *awesome* features.

1) Live support. It's now possible to stream traces (kernel and UST)
while they being extracted meaning a relayd can now receive traces live
and a viewer can attach to it to process the trace while running. The
"--live" has been added to lttng create command that sets up a live
tracing session.

See doc/live-reading-howto.txt and doc/live-reading-protocol.txt for
more detail on that feature.

2) Java Util Logging support. With a special LTTngAgent located in
lttng-ust project (liblttng-ust-jul) to trace JUL events and gather UST
traces with them.

The -j/--jul domain has been added to lttng command line so you can list
the possible JUL Logger object and enable/disable them. It is the same
as using the UST or Kernel domain.

As of now, filters and loglevel are ignored with the JUL domain.

3) Event exclusion. Thanks to JP Ikaheimonen for that contribution!, a
-x/--exclusion option has been added to lttng enable-event that allows
the user to exclude events from being enabled.

4) New health check API now integrated in lttng-sessiond, lttng-relayd
and the lttng-consumerd. Please see include/lttng/health.h for more
details on this new API.

Thanks to everyone that worked on this release! Too many people to thank
but just a special one to Julien Desfossez that worked like a *beast*
for the incredible live feature (and 4000 more lines of code to
maintain...  :P).

Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.4.0-rc1.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJShlllXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02rAEIALiYO0rcL3lTh3Ke6tbmyW+s
j7nqofm2X76lUIOAFuN+wESZwlIVMMqzv7Cu2RxTW5UDWj3z1Wbc/RKYo0S3C/Fe
iELCY1vJwP4crHsEtn0IY5JKyPWy5QBD/dvvhXBDE1isEACerlCeVLEMP20OJ+B0
hewRXeNGbyGVjcGrLrDAJ0zyL5wfNl4Zh4egK7fdZKdETE5Tx+hREHaH2reqsygZ
1AXbRlgChOc9/aXzYb9Ze5b2DAXtnHphtmPjnDFsp+gk0CblFctoF7tSqyd2Vo60
pSgEBS8lrwIolPW8JjlCPWxWEyzKd9dhmDS+MKK1y2GMQB9inFYqIltIKO3Jzqs=
=/7Me
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--


--===============1300524787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1300524787==--
