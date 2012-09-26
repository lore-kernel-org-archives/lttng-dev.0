From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0-rc4
Date: Wed, 26 Sep 2012 12:16:03 -0400
Message-ID: <50632A43.5020908__33881.6365031109$1348676209$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TGuHO-0008Kb-EW
	for lttng-dev@lists.lttng.org; Wed, 26 Sep 2012 12:16:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id D7786187232
	for <lttng-dev@lists.lttng.org>; Wed, 26 Sep 2012 12:19:02 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6zubqAw7_Y48 for <lttng-dev@lists.lttng.org>;
	Wed, 26 Sep 2012 12:19:02 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id BACB7187216
	for <lttng-dev@lists.lttng.org>; Wed, 26 Sep 2012 12:19:01 -0400 (EDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

Multiple fixes went in this fourth release candidate. Please don't
hesitate to report anything via bugs.lttng.org or the lttng-dev
mailing list.

Here is the changelog for rc4.

2012-09-26 lttng-tools 2.1.0-rc4
    * Fix: Change sempahore to pthread conditions
    * Fix: relayd relay_send_version: handle sscanf return code
    * Fix relayd: NULL ptr deref
    * Fix: relayd: possible NULL ptr deref, memory leak, accept fd leak
    * Tests: add print bytecode to filter grammar test
    * Cleanup: assign values to bytecode opcodes
    * Fix: Filter: Fix allocation length error
    * Fix: Filter: add missing ast free
    * Tests: Add high throughput with bandwidth limits test
    * Fix: Returned code when listing kernel channel
    * Tests: Rename helper functions to have consistent names
    * Tests: Cleanup redundant code and use printing helper functions
    * Tests: Add helper functions for printing status and banner
    * Tests: Add a check for color support when printing status
    * Fix: Lib lttng-ctl on error returns lttng code
    * Fix: lttng_set_event_filter() was returning bad error code
    * Fix: printing [no write] on lttng list -uf
    * Fix: Disable event on filter error with lttng
    * Fix: Wrong returned error code on UST enable event
    * Add consumer commands to lttng.1 man page
    * Add lttng_health_check(3) man page
    * Fix: Remove LPOLLNVAL from consumer metadata revents
    * Fix: Mismatch of field name between ust and tools
    * Add the written value when listing fields
    * Fix: Consumer return value check after mmap/splice
    * Don't send the subbuffer padding for streaming
    * Fix: Returned error code in consumer on read buffer

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc4.tar.bz2

Cheers!
David
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQYypDAAoJEELoaioR9I02sL8H/2aBibbZ+z2PT3PwW9iOnoCZ
MqknMuE4lbhipRd1OQ3w94CX6ylIecoy0V9FL0fOIu1/axx+YpzuZvB0+ThmaZVw
PPBATNI+MP/6oXnkYd5wMExTzzCfLp+M47K16JNpl6RhNtBWB7JUgtyri7q+NVCl
DlrhI4K/vHy6xvYDfbi7AqMMWA77K6uWAViIu3s49O06aDfN7Nbj04Isn+ac7kRG
Xr0FhdyOABLvdBCdmfgQL1R8Sy9d2ts8k9iqDfcQ0ncvlzNVtmy5xdkUVmCd7kzu
47DepWQrh4XhBHmWl9gFuWZwniXQxhf9u85p96jGeatCoNnFBKsX68RdLDOueTk=
=Nn1l
-----END PGP SIGNATURE-----
