From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.4.0-rc5
Date: Fri, 14 Feb 2014 17:19:03 -0500
Message-ID: <20140214221903.GB28202__17661.3832278692$1392416423$gmane$org@dalia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2094256228=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WER6F-00075F-V7
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 17:19:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id C867EA1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 22:18:50 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id JFC8orv9Zs9E for <lttng-dev@lists.lttng.org>;
	Fri, 14 Feb 2014 22:18:50 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 4B1A2A1D9C
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 22:18:50 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E915bQsk1toN for <lttng-dev@lists.lttng.org>;
	Fri, 14 Feb 2014 22:18:50 +0000 (UTC)
Received: from dalia (unknown [96.127.212.51])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id B277FA1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 22:18:49 +0000 (UTC)
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


--===============2094256228==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

Here is the change log for the release candidate 5. Massive amount of fixes for
the live tracing feature so this version should be much more stable with live
streaming.

2014-02-14 lttng-tools 2.4.0-rc5
	* Fix: race with index file creation [David Goulet]
	* Fix: deadlock during rotation [David Goulet]
	* Fix: simplify get next index in live
	* Fix: steal channel key in the consumer to avoid race
	* Fix: change ERR statement to DBG in kernel read subbuffer
	* Fix: handle snapshot ENODATA in live timer
	* Fix: relayd leak on error in consumer splice()
	* Fix: protect close_write_flag with the rotation lock
	* Man: clarify loglevel for JUL domain
	* Fix: Define __STDC_LIMIT_MACROS to fix C++ builds
	* Fix: bad indentation of lttng list in man page
	* Fix: wrong data structure used in commit df41f83
	* Fix: add missing optional dependency to babeltrace in README
	* Fix: cleanup inconsistent use of spaces/tabs in README
	* Fix: only set the new_streams flag if a viewer is attached
	* Fix: lttng-live documentation
	* Fix: remove dead code in relayd live code
	* Fix: use after free error code path
	* Fix: wrong sizeof argument in live viewer create session
	* Fix: zero out the reply structure in viewer_connect
	* Fix: write index only if fd is valid
	* Fix: cleanup relayd on any I/O error in read subbuffer mmap
	* Fix: memory/fd leak when cleaning streams in channel
	* Fix: destroy streams in consumer del channel
	* Fix: add missing urcu wfqueue headers in relayd
	* Fix: in lttng_read/write deny count bigger than the possible returned value
	* Fix: fd leak when closing metadata stream
	* Fix: read subbuffer mmap/splice signedness issue
	* Doc: live protocol clarifications
	* Fix: remove unused create_viewer_session option
	* Fix: don't sleep(1) on the consumer ready flag
	* Fix: free viewer session in connection_free()
	* Fix: add missing ctf trace delete before destroy
	* Fix: don't delete ctf trace while in snapshot mode
	* Fix: add flag to create session command and fix tests
	* Fix: cleanup indef guards following the rename
	* Fix: merge issue with thread quit pipe
	* Fix: use uint32_t for metadata_flag in viewer's ABI
	* Fix: check for new streams in all attached sessions
	* Fix: Move static functions up in the code
	* Fix: allow attach command to multiple sessions
	* Fix: handle session hang up in get_new_streams
	* Fix: force the client to create a viewer session before attaching
	* Fix: Namespace lttng-viewer-abi
	* Fix: relayd connection object refactor
	* Fix: big relayd cleanup and refactor
	* Fix: code refactoring of viewer streams in relayd
	* Fix: handle new streams in live mode in relayd
	* Fix: notify the viewer if new streams got added
	* Fix: send the streams sent message after metadata
	* Add extern C to the health-check header
	* Fix: memory leak in unit test
	* Man: add JUL DOMAIN section to lttng.1
	* Fix: handle invalid URL passed to lttng_create_session_live
	* Fix: add --jul-tcp-port to sessiond man page
	* Fix: measure UST clock offset with best sample (v2)
	* Fix: remove free in unit test not needed anymore
	* Fix: relay create session for version before 2.4
	* Fix: memory leak when UST events are enabled with exclusions

Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.4.0-rc5.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS/pZXXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02GvoIAJyeafAnCve4TXNz8FHgt3r2
tGNbHPOBTLLY+8gcn7rozsplO1b7Og1l8gLJtNJY4RO3vmfnI4+FmEKExZU0Dt71
mBuErBTdAzpYJ5COBPeLFl9LTxtxf75wRwph70frKN66qUizRSA6ljlImfNxaT2J
lp5/WRFRE+fQDRkSpQBpeLkzXviFENmJtsaZwu5PLAEmK0K19K4tPgM01RT8P8HK
p42Ehmsulmji/38PU62Wop9SsfC+eLGpsM4g73cySLsldLQ7Ly8b6wsV9Uv8sJ+G
jqhaoKbWrgvWnmRt0zYQLvk28srxUbjOmkxDtbbT1ACLbF4TNl1j5dWFbygwKQw=
=1WSI
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--


--===============2094256228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2094256228==--
