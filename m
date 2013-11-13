From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.3.1
Date: Wed, 13 Nov 2013 16:55:23 -0500
Message-ID: <20131113215523.GE7694__43983.3210003146$1384379791$gmane$org@dalia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1034692226=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VgiPM-0002uq-A9
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 16:55:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id BB7B5A1D7A
	for <lttng-dev@lists.lttng.org>; Wed, 13 Nov 2013 21:55:26 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lBRkzgVWAkjV for <lttng-dev@lists.lttng.org>;
	Wed, 13 Nov 2013 21:55:26 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 36987A1D9C
	for <lttng-dev@lists.lttng.org>; Wed, 13 Nov 2013 21:55:26 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K8gHXaatKe3O for <lttng-dev@lists.lttng.org>;
	Wed, 13 Nov 2013 21:55:26 +0000 (UTC)
Received: from dalia (bas3-montreal42-1168091155.dsl.bell.ca [69.159.168.19])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 79F6DA1D7A
	for <lttng-dev@lists.lttng.org>; Wed, 13 Nov 2013 21:55:25 +0000 (UTC)
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


--===============1034692226==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming.

A stable release for the LTTng RELEASE TRAIN! :) Here is the ChangeLog.

2013-11-13 lttng-tools 2.3.1
    * Fix: typo in --sig-parent help
    * Fix: application SIGBUS when starting in parallel with sessiond
    * Fix: missing LTTNG_OK return value for snapshot
    * Fix: arguments in the wrong order for fd-limit
    * Fix: Some corrections to the lttng man page
    * Fix: recv creds comm should handle partial receive
    * Fix: set app socket timeout just after accept()
    * Fix typo in lttng snapshot add-output example of lttng(1)

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.3.1.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSg/VLXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02T3cH/jW1+hjLNUqCYWLJApH81k0r
wSoj/xsITsEFV9HOcU5W38k2QquatX8Ra8lbcGXHzWipqT5SiuXlQdqHYu0sTyjS
m/YIG2G7fJH6zUohiIRzhtB0K1/8hf2GqYVaju4RViS2CbAavljc9i6EsfLKAGsk
b3b8ubLrcSsscyMC4ucW+QXqavVuzYuGbroyD82oevJkV6hq2mkam/kQnsW9GUHp
k92GS39VKRfmPHU3gyvoDJ9zEJcJSjvJEr9K+hDAcKBn5UwGzoQkA2wHzI7ixB1C
H4Ara6Yo/ODkmBngZ+IYnkUOS+8Q3piCJuhTrmY/4DD/bG6wneCEMJpaLi6fXp4=
=TOW2
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--


--===============1034692226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1034692226==--
