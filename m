From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0-rc1
Date: Fri, 17 Aug 2012 16:11:58 -0400
Message-ID: <502EA58E.2060003__33222.0292454169$1345234349$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1T2Stk-0007hB-J7
	for lttng-dev@lists.lttng.org; Fri, 17 Aug 2012 16:12:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id C430418720D
	for <lttng-dev@lists.lttng.org>; Fri, 17 Aug 2012 16:13:26 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36TlDQf8At7Q for <lttng-dev@lists.lttng.org>;
	Fri, 17 Aug 2012 16:13:26 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id E3807186CA9
	for <lttng-dev@lists.lttng.org>; Fri, 17 Aug 2012 16:13:25 -0400 (EDT)
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

This is the first release candidate for lttng-tools 2.1 which brings
two exciting new features, network streaming and filtering support.

It's the combination of a lot of work from the LTTng team so please,
to help us improve our tools, report any bugs or misbehaving
feature(s) that you may encounter through this mailing list or the bug
tracker (https://bugs.lttng.org).

- From now on, lttng-tools is in feature freeze mode unless an *IMMENSE*
show stopper is found.

2012-08-17 lttng-tools 2.1.0-rc1
    * Feature: Network Streaming
    * Add the lttng-relayd binary for network streaming
    * Support user space tracer filtering
    * Multiple fixes

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc1.tar.bz2

Cheers!
David
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQLqWLAAoJEELoaioR9I023WUH+gNuU+NL0gZInlFbFiqGG5n8
DyvtZaUOtHr7ZoSU2cmEcNfgxzOj0jTt5lGPm7EaU7X5OUiQCiu8gz5kKsL0h5PW
UPZ7DbGHxv8JQQCt/Ac6cydlOjbRT1fB/5GXGT+OX+g/Xzp+Utb6vrTCWCC0RvSO
01U2NK2+IWTuRTol7ykK1WWqTStQSKPZ6ncdYjgq1FJu2gakQA4RnhblMbXWCuP9
EZPxafSaH19mHlhDiDmtdTl7hcWTPAd0u+qNoq7kmh+stcNSn2zjv/bNldbNfaHI
m0kfl8NferiyRpyeD4CgNtFE5W4jm29NId7IRI14/Ow8psZegF8SNlAL76Puqo8=
=PU4p
-----END PGP SIGNATURE-----
