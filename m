From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.4.0-rc2
Date: Tue, 10 Dec 2013 14:33:12 -0500
Message-ID: <20131210193312.GC7440__4308.3653240048$1386704056$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1321651904=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VqT3Y-0008CQ-Ve
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 14:33:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 026FBA1D7A
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:33:10 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Qqk6q4W75T1M for <lttng-dev@lists.lttng.org>;
	Tue, 10 Dec 2013 19:33:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 72596A1DA0
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:33:09 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Nw-TIzbgWsqw for <lttng-dev@lists.lttng.org>;
	Tue, 10 Dec 2013 19:33:09 +0000 (UTC)
Received: from thessa (cable-10.246.173-146.electronicbox.net [173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id BC399A1D7A
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:33:08 +0000 (UTC)
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


--===============1321651904==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming.

Here is the change log for the release candidate 2.

2013-12-10 lttng-tools 2.4.0-rc2
    * Fix: close connection on incompatible version check
    * Fix: fields alignements in live protocol
    * Tests: add regression test for Java JUL support
    * Fix: possible use after free
    * Fix: remove unused code in session daemon
    * Fix: string format with unsigned value
    * Fix: remove useless assert
    * Fix: bad logical check of error codes
    * Fix: resource leak in enable-event command
    * Fix: unchecked return value in ust app delete
    * Fix: dereference after null check in UST registry
    * Fix: Resource leak in ust registry
    * Fix: backported from urcu commit 92af1a30
    * Tests: fix racy tests and misleading output messages
    * Tests: fix bad argument parsing in test app
    * Fix: remove assert on fd in the read/write layer
    * Fix: missing lock/unlock when sending index
    * Fix: update back the metadata len sent on failure
    * Fix: don't fail on push metadata if no channel
    * Rename LTTng index in CTF index
    * Fix: set the enable all event command type
    * Fix: implicit conversion of enum types in sessiond
    * Fix: implicit conversion of enum types in consumer
    * Fix: comparison of unsigned enum expression >= 0
    * Fix: comparison of unsigned value agains < 0
    * Fix: create a fast and a long UST snapshot test
    * Tests: fix racy UST snapshot post mortem test
    * Tests: remove useless sleep when spawning sessiond
    * Add travis-ci configuration file
    * Add libuuid as dependency in README
    * Tests: add valid test cases to test_utils_expand_path
    * Tests: add symlink tests for test_utils_expand_path
    * Fix: utils_expand_path now works for paths that ends with '/.' or '/..'
    * Fix: comment indentation
    * Add missing copyright to utils.c
    * Fix: use non block waitpid to lookup child state

Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.4.0-rc2.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSp2x3XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I027agH/1QYe4fRRoXkopQSJVk0SQjt
lr/sacU0r39DxTgkklr2kWL0WvMLwMlHRb0f6wQXlyPvKerhEwNtvPBG3CmQ0zhd
LWyM4Cdy5BBv/ay3IhvA7bsYwFeUv6f4gHKmDsjvd4Ja3jkxX7hf5W0gbUcbf04U
PgdTe3ANh1V1kQ5HIaqB8XwKqsapqOzGvXjqbIXm4ab6LDPv5L/eXBRBPFT1rtEn
M1TunIeaYTobvP7z84zi21SrAVXGj9eYNNLfJwwKwiTGD16DqkOyU+7QpXDG/NjL
RMQ4QF16UvAlwemgwbCNfwC/Z3zEEz2uIyCKYhfD3AoW7t/EcFyfveCSE97XZZQ=
=ytfd
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--


--===============1321651904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1321651904==--
