From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.4.1 (OpenSSL heartbleed day)
Date: Tue, 8 Apr 2014 15:19:52 -0400
Message-ID: <20140408191952.GD10514__44205.7167216719$1396984867$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1270375938=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WXbYz-0002bW-Kl
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 15:20:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id B4E3DA28E8
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:19:35 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id RAz02po5WmnO for <lttng-dev@lists.lttng.org>;
 Tue,  8 Apr 2014 19:19:31 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 5FC73A28E9
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:19:31 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id IbmzErNfhNYL for <lttng-dev@lists.lttng.org>;
 Tue,  8 Apr 2014 19:19:31 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id CA502A28E8
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:19:30 +0000 (UTC)
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


--===============1270375938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming.

This version is bug fixes mostly aiming at stability. Here is the ChangeLog for
this stable version.

2014-04-08 lttng-tools 2.4.1 (OpenSSL heartbleed day)
    * Fix: don't delete stream from connection recv list
    * Fix: use after free of a relayd stream
    * Fix: don't print stream name in error message
    * Fix: take session list lock when listing tp
    * Fix: add consumer wake up pipe to avoid race
    * Fix: don't spawn relayd if URL is provided
    * Fix: don't ask data pending if session was not started
    * Fix: missing test file in EXTRA dist
    * Fix: allow empty URL for live session creation
    * Fix: missing valid return code when adding an URI to consumer
    * Fix: syntax error in lttng.1
    * Fix: check relayd fd leak in lttng cmdline
    * Fix: remove unused tp in high-throughput test
    * Use autoconf AM_MAINTAINER_MODE.
    * Fix: clang 'constant-out-of-range-compare' warning
    * Fix: Unchecked session pointer when destroying a connection in relayd


Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: https://lttng.org/lttng2.0
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.4.1.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTREvYXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02tVkIAIFLPMbRauFmzWVGYEEBqTwC
x30kuirZf0lbq6fLL1Z2vQLVStWkDRPtIpiDmLBOFL4xq0sMkPq6TPmxdC98TeRS
c+10rIM2jPHud5LUVbnmAga2TdBPaBejPNHdYNHvzsjOX5enRYnAU7dbq8j8sCqf
ZDahLJqYytRh2LKKpVvrFuzWrbClinoaGKGqrv+ylhUlb8m4bqYJ3qQ0V2K1tXyh
6G53u11En5GHqCMp+At3xDduazHTa2o0zsNy+84bm2SvbrAW2iHoY6iLYL79t7NG
coxSwXMPxmRrBlolr+2lNHaa1z1b5EUyO5Zz6Uwi8g/3pg8hhULONVWTY486Yp4=
=INqj
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--


--===============1270375938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1270375938==--
