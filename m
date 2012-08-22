From: David Goulet <david.goulet@polymtl.ca>
Subject: Fwd:  [RELEASE] LTTng-tools 2.1.0-rc2
Date: Wed, 22 Aug 2012 12:45:44 -0400
Message-ID: <50350CB8.1040004__26216.0411490642$1345653970$gmane$org@polymtl.ca>
References: <502EA58E.2060003@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1T4E3v-0000oT-0i
	for lttng-dev@lists.lttng.org; Wed, 22 Aug 2012 12:45:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 417CA187214
	for <lttng-dev@lists.lttng.org>; Wed, 22 Aug 2012 12:47:24 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id foZFJGM2Weg4 for <lttng-dev@lists.lttng.org>;
	Wed, 22 Aug 2012 12:47:23 -0400 (EDT)
Received: from [128.0.0.103] (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 553B7187186
	for <lttng-dev@lists.lttng.org>; Wed, 22 Aug 2012 12:47:23 -0400 (EDT)
In-Reply-To: <502EA58E.2060003@efficios.com>
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
Hash: SHA1

Greetings everyone,

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

This is the release candidate version 2 for lttng-tools.

2012-08-22 lttng-tools 2.1.0-rc2
        * Fix: put back 2.0 output text for lttng create cmd
        * Fix: remove set subdir call that uses bad ptr
        * Filter: Handle the unary bitwise not operator (~) with an unsupported
        * Fix: missing mutex unlock on register consumer err
        * Remove underscore from ifndef of lttng.h
        * Remove unused define in lttng.h
        * Standardize lttng command line usage text
        * Merge duplicate code in consumer for destroy relayd
        * Merge duplicate code in consumer for add relayd
        * Fix: Possible buffer overflows in strncat() usage
        * Move code out of main.c and fix some issues

Project website: http://lttng.org/lttng2.0
Download link: http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc2.tar.bz2

Cheers!
David
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQNQy4AAoJEELoaioR9I02RjQH+QGN3zpCpqjQ4s752ZtvFHd7
dthbrg/DhhSSew5YUBB4Wx7sQbGxG4RM3EATlzr482CmxqLmQpoWEl2PBtxJ762I
91PXm4+mwya0SIk8c70U+7/kNGT4ofBhmNwFOKxrNBAPnicxADZMP9n/w8IoJxFL
dh9GawjqfRmftLltPQlYRAdbfoj5P+4KCwi+dWHMguSSpQK2shMN7f4DmSf8L/fY
X1Z92NYV2I5Ez1/prAUKMh912yEQnKmH8d7bg7grMt92O2noBXRW5mldPw9p8MVV
NWpGqV4vSpw8dy7zseWpCJ/YfJETEOv9Zdcu15Asfj/izoiQxOW/5k0WMetGl1s=
=HZNa
-----END PGP SIGNATURE-----
