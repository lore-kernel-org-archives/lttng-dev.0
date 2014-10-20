From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.6.0-rc1 - Gaia
Date: Mon, 20 Oct 2014 13:26:54 -0400
Message-ID: <20141020172654.GE15954__33321.0016637624$1413826084$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067633201=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XgGjV-0005DI-NL
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 13:27:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 5347F87F54
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 17:26:58 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id i3gtHRKFz-JN for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 17:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id B95BE87F91
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 17:26:56 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Mh9zImwspE0j for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 17:26:56 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id 902C387F54
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 17:26:56 +0000 (UTC)
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


--===============2067633201==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng bards!),

The lttng-tools project provides a session daemon (lttng-sessiond) that acts as
a tracing registry, the "lttng" command line for tracing control, a lttng-ctl
library for tracing control and a lttng-relayd for network streaming and live
reading.

This is the release candidate number 1 of version 2.6, code name: Gaia.

This features are listed below but here is a quick howto to use them. For the
MI feature, simply adds to the lttng command line the option "--mi xml". Only
XML is supported for now.

	lttng --mi xml version

Note that there are now new lines for parsing efficiency. You can find the XML
schema in "src/common/mi_lttng.xsd". Big thanks to Jonathan Rajotte for this
great feature that the lttng bash completion file has already started using it!

Also, Java log4j support has been added as a new domain (like JUL) that you can
use with the command line option -l, --log4j and with the API using
LTTNG_DOMAIN_LOG4J.

Finally, it's now possible to do per syscall tracing. You can get a full list
of the available syscalls on your system with "lttng list -k --syscall". To
enable a syscall, use its name like so:

	lttng enable-event -k --syscall connect

Note that it's not possible to choose the bitness of the syscall thus for
instance enabling "read" on a kernel supporting both 32 and 64 bit will enabled
both of them.

Of course, we fix a BUNCH of things that hopefully will make lttng tools more
stable and powerful :). Here is the ChangeLog entry for 2.6-rc1.

2014-10-20 lttng-tools 2.6.0-rc1 (Harry Belafonte records Banana Boat Song)
	* Machine Interface added to lttng command line (--mi)
	* Java Log4j agent support (--log4j)
	* Kernel per syscall tracing
	* Multiple fixes. A lot!

Please report ANY issues to bugs.lttng.org or on that mailing list.

Using it is testing it!

Project website: https://lttng.org
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2
GPG sig: https://lttng.org/files/lttng-tools/lttng-tools-2.6.0-rc1.tar.bz2.asc

Cheers!
David

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBCABmBQJURUXeXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02FZcIAMm4CtwUcsh+8horx9WNE8ol
a7tX55CE+66fomxNvTpokJu3fCHfo28DdOpbdWKgX8cynuke9E1Hjur0BwboufnK
37XHOq+Vg2v9zr3KW7L/DsmKoP/mn1ksT+kzwKHDL+h1weVo1w5L8qWosrPXWznX
GwT8sySGGSf3B3O79MFOvUOg9ThcR1cwDu+eoaWPkSnTRO1FxoGFw5sn02WqnBfO
VUIrD4bqQdkSO6z1IhHfqoihydAggifUqowzZFRtcA3M/Jsm2TdpkdJtSe2uLcPs
fCIqroCJ+sLzUqvggbVejUddFV+JjLP4UpQcz++upnRW9x6DF71EgW6utmDkjUg=
=iCgw
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--


--===============2067633201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2067633201==--
