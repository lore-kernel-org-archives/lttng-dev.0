From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.5.0 - Fumisterie
Date: Wed, 16 Jul 2014 16:21:01 -0400
Message-ID: <20140716202101.GM7717__39562.1622716591$1405542161$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0242010733=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1X7VhM-0007Ov-VY
 for lttng-dev@lists.lttng.org; Wed, 16 Jul 2014 16:21:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id DDD4383F33
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 20:21:04 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 7Flaz9OSMiQC for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 20:21:03 +0000 (UTC)
Received: from smtp.ini-tech.com (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 4789F84016
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 20:21:03 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id 2884D83F33
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 20:21:03 +0000 (UTC)
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


--===============0242010733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPrm2PuLP7ysUh6c"
Content-Disposition: inline


--bPrm2PuLP7ysUh6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng gnomes),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming.

This is the stable release of LTTng Tools 2.5.0, code name Fumisterie.
As a reminder, this release includes a save and load session feature,
UST perf counter support, daemon configuration file and the ability to
load user defined kernel probes using --kmod-probes with lttng-sessiond.

2014-07-16 lttng-tools 2.5.0 (Take Your Poet to Work Day)
    * Fix: validate file path creds in autoload mode
    * Fix: change session file loading order
    * Fix: add Loading Sessions section to lttng-sessiond.8
    * Fix: add default session conf. dir to manpage
    * Fix: on session load, add it to the .lttngrc
    * Fix: clarify session conf. directory in man
    * Fix: filter error path could free invalid ptr
    * Fix: Create a lock file to prevent multiple session daemons
    * Fix: relayd stream set close_flag on stream close
    * Fix: ustctl_get_stream_id without UST support
    * Fix: avoid freeing invalid ptr in filter bytecode
    * Fix: get the stream_id when generating live beacons
    * Fix: use biggest subbuffer size for snapshot max-size
    * Fix: Possible memory leak when multiple config files are loaded
    * Fix: Clamp verbosity value read from config file
    * Fix: Unchecked strdup return values in set_option


Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: https://lttng.org/lttng2.0
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.5.0.tar.bz2
(for the PGP signature, same file with .asc appended)

Cheers!
David

--bPrm2PuLP7ysUh6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTxt6tXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ep8H/2FwJcr5J7gvGp3WVDNIOx7m
jnrfk3FKlJnH2O8QmTXwss2Ojm4iS5N/YqTg5AZ/+bUsC/rEl4kNQggKzrgQMnRF
HCETS+gN43bCtKiwIWfi4TzFEn/GhUC8ctTTUSKzELd2H97qSGLHzJv2vYnd+6kV
bNEMDlB024iFXcdwaiP/8wzmUu1Wy2oRJy+57EYOu1Yn2ufbxoS+zUEKymU6cBQp
5RxjcFUjY6VAuvy4QLiaIMPjEri9l6KubqDHgf99ScZwD+HDhGnGqCpWITQDE1cJ
MCvVJd8RDkd8ZKDw6y208bVapEr5ZJRDPaiLuR1fxrcZx24cFCZU4UfAxC45Pa8=
=9CnR
-----END PGP SIGNATURE-----

--bPrm2PuLP7ysUh6c--


--===============0242010733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0242010733==--
