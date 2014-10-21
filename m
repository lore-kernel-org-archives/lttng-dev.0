From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.6.0-rc2
Date: Tue, 21 Oct 2014 14:37:55 -0400
Message-ID: <20141021183755.GA19125__38503.4530344003$1413916746$gmane$org@dalia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1033974014=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XgeJo-0005Lz-8v
 for lttng-dev@lists.lttng.org; Tue, 21 Oct 2014 14:38:09 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id C3EC185400
 for <lttng-dev@lists.lttng.org>; Tue, 21 Oct 2014 18:38:02 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id a0QmJimagJe7 for <lttng-dev@lists.lttng.org>;
 Tue, 21 Oct 2014 18:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 37D9B88028
 for <lttng-dev@lists.lttng.org>; Tue, 21 Oct 2014 18:38:01 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id X4d65OQYekVT for <lttng-dev@lists.lttng.org>;
 Tue, 21 Oct 2014 18:38:01 +0000 (UTC)
Received: from dalia (cable-22.246.173-116.electronicbox.net [173.246.22.116])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id F08DA85400
 for <lttng-dev@lists.lttng.org>; Tue, 21 Oct 2014 18:38:00 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1033974014==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng bards!),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming and live reading.

This is version 2.6.0 release candidate 2. Yes, one day after rc1, we
had to add a kernel version check because of the syscall tracing feature
that extends the kernel ABI.

To be clear, you NEED rc2 to work with lttng-modules rc1.

2014-10-21 lttng-tools 2.6.0-rc2
    * Use lttng-modules ABI version ioctl
	* Fix: syscall list ioctl number conflict


Please report ANY issues to bugs.lttng.org or on that mailing list.

Using it is testing it!

Project website: https://lttng.org
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc2.tar.bz2
GPG sig: https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc2.tar.bz2.asc

Cheers!
David

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJURqgDXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02YRIIAKOZBhupXbtiIRVJUo2CXHVR
Es45+XH8GF4aCdfHePNUDg3TM0RGXll+hNgWdPoC+tvA3wZYj/1maMpKd6AfglUD
0LCN7oLXaVRIFUDN9HglYi8dDksIRobHOrKv5Yb8rqmP9cmq9dhUS3JeHFNGs5dh
hydXDEOXGr2Skyn/gqeBkEbxU6sqq34jvyuEXSByCZ98zfwpF7yOkuezzv/dHf7b
KJ2/ldj8baY8NNob9ifoefmxZxdwfjB8UVqUeqTYhm67n1zLrOy/9kpFbLDRrovT
XoicTbQecurLh3jVI8g9jLYUloSE9LJ+8FvWRXQn/Q89ZgV32G0/FwiyoKAh/g4=
=o34H
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


--===============1033974014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1033974014==--
