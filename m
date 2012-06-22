From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.0.3
Date: Fri, 22 Jun 2012 11:27:45 -0400
Message-ID: <4FE48EF1.2080409__20268.3723452084$1340378902$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Si5m6-0001mb-Fu
	for lttng-dev@lists.lttng.org; Fri, 22 Jun 2012 11:27:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 0C7981871E0
	for <lttng-dev@lists.lttng.org>; Fri, 22 Jun 2012 11:32:09 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g75GBOoIFppr for <lttng-dev@lists.lttng.org>;
	Fri, 22 Jun 2012 11:32:08 -0400 (EDT)
Received: from [128.0.0.30] (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 1F2D61871DE
	for <lttng-dev@lists.lttng.org>; Fri, 22 Jun 2012 11:32:08 -0400 (EDT)
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

This release fixes a show stopper in version 2.0.2. Enabling an event with the
loglevel type ALL was failing due to an error in the loglevel match function
on the session daemon side.

Sorry all for this inconvenience!

2012-06-22 lttng-tools 2.0.3
	* Fix: enable event loglevel match function
	* Fix: unchecked pointer from getenv() for lttng create
	* Ship license text file with the release archive

Project website: http://lttng.org/lttng2.0
Download link: http://lttng.org/files/lttng-tools/lttng-tools-2.0.3.tar.bz2

Cheers!
David
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJP5I7xAAoJEELoaioR9I02bewIAIsCrtibTXuNFlJ1L8GsUkOu
kkhLUhOXPP9SF2hA/ghoxX2j3cY4Kr4sKZClpWNqcdJA6K6N9WCttUtavilQXUHM
q0H7hozp+o3065aMOmWstFLXvKgIRtUnp53rhAzmny9wQsuay3zItvhagk/zQ/ZX
50n8DcmGzp1C5O9GXUsNhstn6CPEi7lKx9Ico21VX4Pu0aFOgue5/qlw9AHzF3T1
Q58L4OTQPHqGTbLpMeYDv7yG3Th3tglkI4ZN9lXyLjpobQM3NaROVgXdF6YJhXyP
XOtgMoqAzrjtIRIQfP/fhjKCBJkrjt6Nl7a9M3WpmfY9QbKGaTctjPQGsxp43Xw=
=0eqd
-----END PGP SIGNATURE-----
