From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.4.0-rc3
Date: Tue, 14 Jan 2014 13:10:47 -0500
Message-ID: <20140114181047.GB8177__7149.28973834521$1389725072$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0932062136=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1W38S0-0007H5-9W
	for lttng-dev@lists.lttng.org; Tue, 14 Jan 2014 13:11:01 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 0179CA1D7A
	for <lttng-dev@lists.lttng.org>; Tue, 14 Jan 2014 18:10:39 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wZ1HUHPIYF4K for <lttng-dev@lists.lttng.org>;
	Tue, 14 Jan 2014 18:10:38 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 39966A1DA9
	for <lttng-dev@lists.lttng.org>; Tue, 14 Jan 2014 18:10:38 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tjsxjiAbl3nT for <lttng-dev@lists.lttng.org>;
	Tue, 14 Jan 2014 18:10:38 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id ACEA3A1D7A
	for <lttng-dev@lists.lttng.org>; Tue, 14 Jan 2014 18:10:37 +0000 (UTC)
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


--===============0932062136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

Here is the change log for the release candidate 3.

2014-01-14 lttng-tools 2.4.0-rc3
    * Fix: metadata stream should be always flagged as ready
    * Fix: wrong check before destroying the viewer metadata stream
    * Fix: race with the viewer and readiness of streams
    * Fix: missing reset when listing UST fields for multiple PIDs
    * Fix: filter: check binary op nesting
    * Fix: relayd cmd line option for live port
    * Fix: remove break in epoll loop of apps. thread
    * Fix: wrong comment in snapshot public API
    * Fix: clear the CTF traces when all the streams are closed

Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.4.0-rc3.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS1X2nXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02hm8IAKbsBmbJNstp+o0b1Tq3kt4+
c+ofHwT3PIIl0ki+KIZUIlKXHtd6DPaZF1D7OZUsSYcb+iylK5KgqeDpYmAfPzaQ
U0eDiey32QAb3AOM/QHBcmutEtsAnxS6Ea8sC5G2LWYUyHILOrHXx2uU5NqdArT/
1+LzTPNyq2AKjq2KHFfQb0285wCaUe4YzVxEmTjwvtrIziIhzx+JCiyPEjqTSw0M
sNwKWAE7xd91x3Vg/5c6Cg489gF8p0Ehfel4vBuwd+sTyFuRwz6qQoZbdXHFEjt3
P5ZKdt1P9K2nTDU3LJ1pzgI1XUaI+w0FebZiyV6e2NdLWNbUp3GaWsD+bIcZ1+0=
=UEia
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--


--===============0932062136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0932062136==--
