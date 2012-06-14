From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.0.2
Date: Thu, 14 Jun 2012 14:08:51 -0400
Message-ID: <4FDA28B3.90302__18588.2297032096$1339697370$gmane$org@efficios.com>
References: <4F902D0D.9020902@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SfETX-0000D4-Ut
	for lttng-dev@lists.lttng.org; Thu, 14 Jun 2012 14:08:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 4262F1871D7
	for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2012 14:12:52 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDAwPRm8uAMm for <lttng-dev@lists.lttng.org>;
	Thu, 14 Jun 2012 14:12:50 -0400 (EDT)
Received: from [128.0.0.30] (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id CA8511871D6
	for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2012 14:12:49 -0400 (EDT)
In-Reply-To: <4F902D0D.9020902@efficios.com>
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

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control and the
liblttng-ctl library also for tracing control.

2012-06-14 lttng-tools 2.0.2
	* Fix: enable event with different loglevel error
	* Fix: move memset in channel_set_attr after NULL check
	* Fix: close all file descriptors when executed as daemon
	* Fix: clang llvm warnings
	* Add CodingStyle to tarball
	* Add coding style document

Project website: http://lttng.org/lttng2.0
Download link: http://lttng.org/files/lttng-tools/lttng-tools-2.0.2.tar.bz2

Cheers!
David
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJP2iizAAoJEELoaioR9I021F4IAKkugbuwgmdpMNkAuTDNTgQz
TjHO2bVhGN4jlFelutytRWW92T+pY5qfivSPF+pIp4q4DD8I7srNmIzejCtMxCOH
QvFBQmHrD/2iuNv8qBesZxQaJ1rbb23dBRSLN5bfmjyOUU6ryHOAL/Y3oAHeehCf
A/qudeJmNyRXzYwXXli2kw6t5OvHjO0XFUEM8qoe8FZo+f56czcxeGFAMYnT+X5l
gFU19ane3Dz8HE4prhwndXK/Jwjm4fD4WBbzPq/I1LqMiivMSOVWN7tg8H27WqoI
gwTPZf4fjIO5Z6hER1mXAYdBu28UMCiZKAXRGBMhbqAVqx7ul1MbDd2Q2i4FDSs=
=j/A2
-----END PGP SIGNATURE-----
