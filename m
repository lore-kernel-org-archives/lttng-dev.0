From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.2.5
Date: Fri, 15 Nov 2013 10:55:27 -0500
Message-ID: <20131115155527.GB6986__47315.7944194556$1384530989$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0207028017=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VhLk7-0000kL-3Q
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 10:55:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 485FFA1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 15:55:29 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UZbdj8GSSVFx for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 15:55:29 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id E8DF0A1DA0
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 15:55:28 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YRK6fGrEBR1J for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 15:55:28 +0000 (UTC)
Received: from thessa (cable-10.246.173-146.electronicbox.net [173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 69E6DA1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 15:55:28 +0000 (UTC)
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


--===============0207028017==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming.

A stable release for the LTTng RELEASE TRAIN! :) Here is the ChangeLog.

2013-11-15 lttng-tools 2.2.5
    * Fix: typo in --sig-parent help
    * Fix: application SIGBUS when starting in parallel with sessiond
    * Fix: arguments in the wrong order for fd-limit
    * Fix: recv creds comm should handle partial receive
    * Fix: backported fix uses msec vs sec in stable-2.2
    * Fix: set app socket timeout just after accept()

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.5.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJShkPvXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02BbgH/3jLIrHSwvmVBV3KB0IjESPO
Ji+HonK/mCsDXKtt2Sr1/KJrkvW+aW8AB1GsRvsgEV8DHnvuUtJVSNwkL5KFk203
o5lYh1Jjs0+pUtbp7rvpDZNhE4QFLc2NvFsuhUJ7KLhmdCEjB5qzkAKSdZegmhhx
LGSGr/0yFOvtczEcCqwRx6IrdYkgL0BPnCifmkHzRLg/HwvW8ev4c3Z+WlsbkRsB
iBUY28jAjndcE1LOwzIFtX8Uq8MHO0v3gCfNZgahVlHdhC30IKO9RfM4kXmOQgbk
ilOtGxKoBtfvrPrmy6YF80x/y8ca0QFh6+SqgvUp/dN0wrbwqSF5p7G3LuLDIXo=
=r8nN
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--


--===============0207028017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0207028017==--
