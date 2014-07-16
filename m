From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.4.2
Date: Wed, 16 Jul 2014 11:17:53 -0400
Message-ID: <20140716151753.GH7717__1377.91916863552$1405523937$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1431979818=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1X7Qy1-0005fp-CN
 for lttng-dev@lists.lttng.org; Wed, 16 Jul 2014 11:18:06 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id BD98380DDB
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 15:17:56 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id t2fWjDOLTiGS for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 15:17:55 +0000 (UTC)
Received: from smtp.ini-tech.com (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 28C8483CC7
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 15:17:55 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id 07D2580DDB
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 15:17:55 +0000 (UTC)
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


--===============1431979818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng gnomes),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming.

This is the minor release of LTTng Tools 2.4.2. Here is the ChangeLog.

2014-07-16 lttng-tools 2.4.2 (Take Your Poet to Work Day
	* Fix: Create a lock file to prevent multiple session daemons
	* Fix: relayd stream set close_flag on stream close
	* Fix: ustctl_get_stream_id without UST support
	* Fix: get the stream_id when generating live beacons
	* Fix: missing include for getpwuid()
	* Fix: add a get HOME dir fallback to getpwuid
	* Fix: don't set enabled flag is session start fails
	* Fix: logger name dropped from filter condition when loglevels are used
	* Fix: memory leak in lttng_enable_event_with_exclusions
	* Fix: check malloc return value
	* Fix: static array larger than necessary
	* Fix: set session in output mode if URL are set afterwards
	* Fix: Add vpid, vppid and vtid info in add-context help
	* Fix: alignment problems on targets not supporting unaligned access.
	* Fix: possible use after free in consumer
	* Fix: improve and update lttng.h comments
	* Fix: JUL filtering for event *
	* Fix: deny overwrite mode and num subbuf less than 2
	* Fix: remove bad option in enable channel --help
	* Fix: implicit conversion from enumeration
	* Fix: clarify man page lttng.1
	* Fix: Copy-pasted PERROR messages may be misleading
	* Fix: incorrect printf format
	* Fix: handle ENOENT when creating a kernel event
	* Fix: move JUL filter creation to a function
	* Fix: JUL filtering done on the UST level
	* Fix: Don't include the binary in the live test's EXTRA_DIST
	* Fix: add JUL filter to UST event on logger_name
	* Fix: Racy event validation in tests
	* Fix: rework utils_parse_size_suffix


Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: https://lttng.org/lttng2.0
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.4.2.tar.bz2
(for the PGP signature, same file with .asc appended)

Cheers!
David

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTxpehXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02pOoIALloR8T8GIGxP1PzzFwk6ytF
YbZ9DZitW7ymgXNY3EtzbBqHav8q6bIucwSP/wqZ/S2Dod1Xiw4kuu8XCDNqvPC9
jSnYNb2uzGnTYUBplxM2ZCNLtHhIVxQvq4CrOaDZS14IOCl3VnsJPzqKdTWMVXBP
tTCLICtMgc3esT/H16Uy8U43+1aTuPxNAj3nQPvFXst47yTbkOBRlOI36kbfoUKB
cKPxWYOGW8kQlAO21NIMTN8Pj+e8OjkOfn7UVzHzRYuk7oaqCLVEjSRCPylCz38G
r+TMt4od3ajMq1ega+jmWmoOoX3nwOi/wsjBRWlqg+BttnHTuLY1SWprPz0sXk8=
=uWaF
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--


--===============1431979818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1431979818==--
