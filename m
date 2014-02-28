From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.2.6
Date: Fri, 28 Feb 2014 12:59:26 -0500
Message-ID: <20140228175926.GB14281__28238.1294332028$1393610439$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1683481040=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WJRig-0006Ob-Ru
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 12:59:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 92453A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:59:11 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Y0DAV3J7V-12 for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:59:11 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 2E0F4A1D9C
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:59:11 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vd8PEnthRNtd for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:59:11 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 97E01A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:59:10 +0000 (UTC)
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


--===============1683481040==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming.

This is the last stable 2.2 release and thus it will not be supported anymore
after this.

2014-02-28 lttng-tools 2.2.6
    * Fix: remove break in epoll loop of apps. thread
    * Fix: remove bad code from previous backport patch
    * Fix: bad logical check of error codes
    * Fix: resource leak in enable-event command
    * Fix: unchecked return value in ust app delete
    * Fix: dereference after null check in UST registry
    * Fix: Resource leak in ust registry
    * Fix: backported from urcu commit 92af1a30
    * Fix: add missing values for a backported fix
    * Fix: update back the metadata len sent on failure
    * Fix: don't fail on push metadata if no channel
    * Fix: comparison of unsigned enum expression >= 0
    * Fix: implicit conversion of enum types in sessiond
    * Fix: comparison of unsigned value agains < 0
    * Add libuuid as dependency in README

Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.6.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTEM5+XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02JIkH/RMMoZ6u00ZTV4tZ7s687XF1
jLOorULTVLqCRHpabOwsMMjV2HpIaxQKpFyZ/b+RRqurtBe3vlqkVnsjhT1gB+oy
LBM8oTjgyvue3+JESq+j6VvDTmeGcFwBUv55r8OxYOZ8a+NL6QobaMJ0rgzOFjRk
wM95nFIjiOCDXwktKjp6bVpxeGB2URFQpOFPnl4NQkPgxHf8Wa9N2OIVw7N2dC99
AmlVzTK8r4B2WaTtPbf0FMl3Am7fbE1D38TE5W0riE/2Ieu9UzXflXhW+gkCfKc9
wUM/zygnXxJv//a8NpXr+o0AO1RQsGvYg7EU56foRxKciIY0HsFNqxQB5G1S3sg=
=7KBi
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--


--===============1683481040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1683481040==--
