From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.0.4
Date: Wed, 25 Jul 2012 11:33:44 -0400
Message-ID: <501011D8.2090504__27822.7807059467$1343230486$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Su3au-00024Q-61
	for lttng-dev@lists.lttng.org; Wed, 25 Jul 2012 11:33:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id F3EDE187202
	for <lttng-dev@lists.lttng.org>; Wed, 25 Jul 2012 11:34:20 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXn03ZFIDqk5 for <lttng-dev@lists.lttng.org>;
	Wed, 25 Jul 2012 11:34:20 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 29C6D18707D
	for <lttng-dev@lists.lttng.org>; Wed, 25 Jul 2012 11:34:20 -0400 (EDT)
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

Greetings everyone,

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control and the liblttng-ctl library also for tracing control.

This release fixes an important bug in the UST and Kernel mmap()
buffer extraction mechanism.

2012-07-25 lttng-tools 2.0.4
    * Fix: support large files on 32-bit systems
    * Fix: mmap write() for large subbuffers and handle EINTR (v2)
    * Fix: The session list count should provide unique identifiers
    * Fix: test: session list count cannot use "count" unique id
    * Fix typo: utils.sh

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.0.4.tar.bz2

Cheers!
David
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQEBHYAAoJEELoaioR9I02gU4H/iMT0H+wlNhYyK26HTWmsiXF
snR6nKdp+8fp/QHQ4tjY1fQPZZ29pFVuPNASryo1sclMH/1WzSN2iSJGrqQZ3XiP
PKzWg5GNo9S6nnJRVG7feKNM+iHR7qIWwuuufaARXXOudlkh0JdsTa3gK5dX9kOI
WKpdV0Q/Mln3VEf3falYcVkebHRrAbSL6xKVkQ7T7k0gU6KN1/42ud5jL8Zbwdvw
nJIadnpRax+B4YEVzjY/OMCMTKxYo5VfHdGCxccRUL6i7LqDQXdyqYt3+MDM6fWL
qablHcl360xYbIkD3uE9ucyG9IRqQhiPT+X1+xPujB9RH9PlJ1eeSBeUbxzX6VQ=
=W6gL
-----END PGP SIGNATURE-----
