From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.5.1
Date: Mon, 20 Oct 2014 16:08:25 -0400
Message-ID: <20141020200825.GA7192__33468.5358022854$1413835844$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0902274177=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XgJFo-0006D0-S3
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 16:08:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id AD351856C9
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 20:08:29 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id FUI57ST_bZUF for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 20:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 2543F85C8A
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 20:08:28 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4vxPHJIG9f-j for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 20:08:28 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id F3020856C9
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 20:08:27 +0000 (UTC)
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


--===============0902274177==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng bards!),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming and live reading.

This is the version 2.5.1 of LTTng-Tools.

2014-10-20 lttng-tools 2.5.1
    * Fix: handle sysconf possible negative returned value
    * Fix: channel deref. after NULL check in kernel consumer
    * Fix: check for kernel session metadata during init
    * Fix: incorrect cast in ust consumer assert
    * Fix: bad handling of incoming data in consumer thread
    * Fix: disable event for JUL domain
    * Fix: send disable ALL command code if event is *
    * Fix: make sure no index is in flight before using inactivity beacons
    * Fix: Parenthesize previous statement when adding conditions to a filter
    * Fix: parse_prob_opts return the actual success of the function
    * Fix: Man page typos
    * Fix: disable JUL event on destroy
    * Fix: unbalanced ustconsumer32_data.pid_mutex lock

Please report ANY issues to bugs.lttng.org or on that mailing list.

Using it is testing it!

Project website: https://lttng.org
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.5.1.tar.bz2
GPG sig: https://lttng.org/files/lttng-tools/lttng-tools-2.5.1.tar.bz2.asc

Cheers!
David

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBCABmBQJURWu5XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02vX4IAJU2VwKZMhnMiulmJ371IWl2
2My5XAP9SXvXoHxiqA2GJ2ZMtBrPHrm900BwuOuf4Wl7aypNM6IHdWt+jdbLnytU
19a+lWxpjJm8Dybktq8AYLvSOBJ2NbgK0PjOfRvM3D6pQ2rBMDXOE6svpDYZg5iq
HQKb/VcgjUjlPtmDetSDN+rJtqbi82e32KoaMo3Nm1aZnHjt71S+l0QtQi7xi4oV
gqWdhmtsFcuIIOWeTebvxNLZEOHYdX9BBRaVS3R9fscXs1I2/woKfX3ZGiID+YVR
XIiuZ92/6R9vJ7TAxwvu4k+obLBI0j6BRD9Ej0ThTpvz+AfqrtlByKUQ3Z5zQhg=
=EGmL
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--


--===============0902274177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0902274177==--
