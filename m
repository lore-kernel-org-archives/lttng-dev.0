From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.4.0-rc4
Date: Wed, 29 Jan 2014 13:01:25 -0500
Message-ID: <20140129180125.GD7904__6475.94071128896$1391018561$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1405809582=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1W8ZSA-0007Y5-Iv
	for lttng-dev@lists.lttng.org; Wed, 29 Jan 2014 13:01:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 83D15A1D7A
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 18:01:15 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X-0vm0GkZtrf for <lttng-dev@lists.lttng.org>;
	Wed, 29 Jan 2014 18:01:15 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id DF2A9A1D9C
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 18:01:14 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RLWJk_N_E3p9 for <lttng-dev@lists.lttng.org>;
	Wed, 29 Jan 2014 18:01:14 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 572E8A1D7A
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 18:01:14 +0000 (UTC)
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


--===============1405809582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

Here is the change log for the release candidate 4.

This version adds the missing support for JUL loglevel in lttng-tools
which needs to be used with lttng-ust 2.4.0-rc3 and later. Furthermore,
complete health check tests are introduced as well.

2014-01-29 lttng-tools 2.4.0-rc4
    * Fix: add -b, --background option
    * health check tests: test relayd and consumerd
    * tests: Add stop_lttng_relayd_nocheck
    * Fix: add missing JUL loglevel handling
    * relayd: add testpoints
    * relayd: use same pipe for live and main
    * Cleanup relayd live comment
    * Fix: relayd: add LPOLLERR to events
    * Fix: relayd: notify parent of readiness when all threads ready
    * Fix: tests: start relayd in background mode (-b)
    * lttng-relayd: implement background cmd line option
    * sessiond: add missing testpoints
    * tests: use --background for session daemon
    * sessiond: add --background argument
    * Use lib common daemonize
    * Fix: sessiond: wait for health check readiness
    * Fix: relayd: initialize lttcomm inet
    * Consumer: add testpoints
    * Fix: consumerd: HT init/teardown with program
    * Cleanup: lttng-ctl-health comment
    * Add daemonize() to libcommon
    * Fix: tests: wait for consumerd to complete
    * Fix: consumerd: use DBG rather than DBG2
    * Fix: consumerd: only return readiness when health is ready
    * Fix: consumerd should initialize lttcomm
    * Fix health check: signal parent before exit testpoint
    * Test health: add test_thread_ok
    * health check: change --relayd-path arg to --relayd-path=arg
    * relayd: add LTTNG_RELAYD_HEALTH env var
    * Add sessiond/SESSIOND_ prefix to sessiond testpoints
    * Fix: zero out data structure before using it
    * Fix: delete metadata stream before destroying it
    * Fix: report to client when snapshot will be empty


Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.4.0-rc4.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS6UH1XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02bpIIAIRM6oM2RVCBoa7zJfE01Q5U
1lLDY/+QZdqu6Pa8t8uH/zTJJ26cQ3B4J1SmHfVeX28xkjK5F594MRESqJtSpq9S
eIfi8ixadwqMEtpsMu8XuePG5b2nc3C70xFnbetQ9liDIH3nvyRK4/P32bEQT+li
uo+D+mqYdckm2giLIyvJm8smNY4A+kxnmzNaVCVlxGEeMKp/+C1jMPF7Pz4pzEbN
Z9P964tC/R3bGEphZoQDGQXfgiIgZVjhiokPnRV5k+Fk+zIe5owOuhNRfVnDYwjd
2dWsDWDYqLz+ROKTp7yFfIPdL8IuUH6c2nvM5JJMdYf8uZ+y5P51q9mBMDF9v6M=
=T/wT
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--


--===============1405809582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1405809582==--
