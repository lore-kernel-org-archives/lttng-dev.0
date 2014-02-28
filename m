From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.4.0
Date: Fri, 28 Feb 2014 13:52:45 -0500
Message-ID: <20140228185245.GD14281__1681.04300178147$1393613634$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2004393768=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WJSYH-0006z4-Kk
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 13:52:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 9BDC3A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:52:30 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5W1JohtFayVG for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:52:30 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id EDE9CA1D9C
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:52:29 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GQqjaS9wSnWZ for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:52:29 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 5EC94A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:52:29 +0000 (UTC)
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


--===============2004393768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

We are PROUD to announce the release of the stable 2.4! A *lot* of work
when into that release to bring you the JUL support and Live mode.

2014-02-28 lttng-tools 2.4.0 (Public Sleeping Day)
     * Fix: improve lttng with live by spawning relayd
     * Fix: relayd should listen for viewers on localhost only by default
     * Fix: handle loglevel range ALL in list command
     * Tests: add JUL test for multiple loglevel
     * Fix: index JUL event by name *and* loglevel
     * Fix: JUL to enable user and root tracepoints
     * Fix: handle the registration done command for JUL
     * Test fix: use temp file sync. of test app
     * Fix: keep metadata channel attr in UST session
     * Tests fix: Missing waitpid in fork test
     * Fix: add loglevel type to lttng list <name>
     * Fix: minor rephrasing of the lttng.1 man page
     * Fix: Warn user if JUL port is already being used
     * Fix: add some sane default values to --live opt
     * Fix: possible NULL deref. in sessiond error path
     * Fix: flag that kernel streams FDs has been sent
     * Fix: forbid session name creation if contains /
     * Fix: don't start session if no channel
     * Fix: add missing relayd option to man page
     * Fix: report error if consumer can't be spawned
     * Fix: lttng list -u <name> should only list UST
     * Fix: kernel channel destroy on consumer if sent
     * Fix: only create UST metadata on start trace
     * Revert "Fix: wrong condition on startup for low-activity streams"
     * Fix: missing big endian conversion for one index field
     * Fix: wrong condition on startup for low-activity streams
     * Fix: perror on index directory creation error
     * Comments fix: lttngerr.h -> error.h (./Changelog:754)
     * Fix: consumerd errors on exit
     * Fix: scanf unbounded input
     * Fix: miscellaneous memory handling fixes
     * Fix: add missing VALGRIND ifdef checks and documentation


Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.4.0.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTENr9XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02kGkIAKOM5lKcZ2mXkMfOCcSpeTNl
q4ufcLFolfUjsuoM1n134iwtD2LV8xsXq/zRZRky8OOodzcR+1WfKhFCc3HWJpzP
zECcaggg1aMMtGEyIUAB1djKt7lmDdn8g5PWqtW1NUkTTyq9RxCpGY0zw86vbIis
nWg4FcL34iEIdR9jbV7R3mRT2nX+915OTm4+l9QEo8bG50xgMrRa9VFzK5+bB8dB
VJOCDRZ0CdvnbXnAVokhQ8tsc8q23Q0hYcpiZP6JjZ4cSJHMPI8hPSCKU65qR16O
A3eCVcV7PY3xv+Kk1ciQ5QvocWsewYGDO1LLgOtiElAMa0Sb0Wv98HH48CZwbJg=
=kfUo
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--


--===============2004393768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2004393768==--
