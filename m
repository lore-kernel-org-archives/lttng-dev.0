From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.5.0-rc2
Date: Fri, 27 Jun 2014 10:41:54 -0400
Message-ID: <20140627144154.GC7900__45906.2170856216$1403880191$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1712854560=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1X0XLl-00084X-QV
 for lttng-dev@lists.lttng.org; Fri, 27 Jun 2014 10:42:09 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 4F99081100
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:43:21 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id iaUCPPnyLzE3 for <lttng-dev@lists.lttng.org>;
 Fri, 27 Jun 2014 14:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id A0E4C81BCC
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:43:19 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id clDJz68rTA7V for <lttng-dev@lists.lttng.org>;
 Fri, 27 Jun 2014 14:43:19 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id 69E9B81100
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:43:19 +0000 (UTC)
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


--===============1712854560==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

This is the release candidate 2 and here is the change log:

2014-06-27 lttng-tools 2.5.0-rc2
	* Test: add JUL disable event tests
	* Fix: disable JUL event on UST side
    * Fix: accept override flag even without a load path
    * Fix: bad error code path when loading session
    * Fix: set session in output mode if URL are set afterwards
    * Fix: add a kernel context list to the channel
    * Fix: Add vpid, vppid and vtid info in add-context help
    * Fix: wrong behavior of save command when no session name is provided
    * Fix: missing context type string in save for ust context
    * Fix: wrong casting of return value
    * Fix: add dependency to libcommon for python binding
    * Fix: remove the default GIT_VERSION


Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: https://lttng.org/lttng2.0
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.5.0-rc2.tar.bz2
(for the PGP signature, same file with .asc appended)

Cheers!
David

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTrYKyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02OigH/joWQxVIBrHzYMfImBYpFRvu
Z0L8tx/4KczVark+ybMkdYHJ2G22qkiiTR81kJtpWmq0LIGEk9HQXGjrvyjBaEbA
GS91JLfqeLaaWHK4afe+6Avxv45ep4Ja/f4HHVy0fAadJZ+1ncGH0XIla1ccb4Sd
8F14irtSyX+bVCLq+GT6+ANRfLAJJhakw8eCCVFHtIMKubTevAQT1Rp8poksUJ/S
NIgnxiLm+Pm7T4N120zwx9mOimKr+SLUo+dxLNQt75jnkf5yJRIkbA6H4aazansT
KJlWeXH2FMPQyD7tzia443R9AyGLpPu0jva/p7Qznv9+HSoXjyHdGhSvaA5CI8w=
=k9ry
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--


--===============1712854560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1712854560==--
