From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.5.0-rc1 - Fumisterie -
 International Hamburger Day
Date: Wed, 28 May 2014 11:25:46 -0400
Message-ID: <20140528152546.GC7798__25229.8720450655$1401290862$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1526687654=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wpfjp-0002Qh-7z
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 11:26:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id D006B81BF2
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 15:26:21 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 6ccQsmepfLzx for <lttng-dev@lists.lttng.org>;
 Wed, 28 May 2014 15:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 89E7B81BF5
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 15:26:17 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CbYIUVfpu09z for <lttng-dev@lists.lttng.org>;
 Wed, 28 May 2014 15:26:17 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id 47D6C81BF2
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 15:26:17 +0000 (UTC)
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


--===============1526687654==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

We are VERY happy to release the rc1 of version 2.5.0 called
"Fumisterie", the F version of the LTTng toolchain. Here is the
description of this code name:

	The Fumisterie is a beer whose style is at the confluence of English
	and German ales. On the palate, it is full-bodied, malty and
	slightly caramelized. The organic hemp seeds incorporated during the
	brewing gives it a unique and original taste. The hop flavour comes
	through delicately in the after taste.

This is the feature freeze and the first 2.5.0 release candidate. This
release adds *multiple* fixes and new features details below.

1) Save and Load session feature. This introduce two new commands along
with API's functions allowing the user to save/load a session to/from an
XML file.

$ lttng save [OPTIONS] [SESSION]
(lttng_save_session_* in lttng/save.h)

$ lttng load [OPTIONS] [SESSION]
(lttng_load_session* in lttng/load.h)

The XML format of the session file is described in the tarball in
=2E/src/common/config/session.xsd. Note that this adds a dependency to
lttng-tools being libxml2.

2) Userspace Perf counter support. With the lttng add-context command
you can now use perf context "perf:thread:*" along with the
-u/--userspace option. See --help for an full list.

3) Daemon configuration files. A configuration file can be used for each
daemon to control their options. Three configuration files are
available:

* lttng-sessiond.conf
* lttng-relayd.conf
* lttng-consumerd.conf

These are simple INI format and can be placed in the system wide
directory /etc/lttng, ~/$HOME/.lttng/ or user defined with:

  -f  --config                       Load daemon configuration file

4) Thanks to Jan Glauber, it's now possible to load a user defined list
of lttng modules probes with the new option of the session daemon or by
using an environment variable. For instance:

	--kmod-probes ext4,btrfs,kvm
	or
	LTTNG_KMOD_PROBES=3Dext4,btrfs,kvm

These are the major features added for this release. A couple of things
also have changed that are worth mentionning.

* The lttng.h header file has been split into several components like
event.h, session.h and so on. If you are using lttng.h directly in your
application, this should not affect you at all because including lttng.h
also includes every other components.

* The *deprecated* lttng_enable_consumer(), lttng_disable_consumer() and
lttng_health_check() API functions have been removed for good.

* The list command now prints the loglevel of JUL events.

* Debug logs now have a timestamp (YAMAN!)

And voil=E0!

Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: https://lttng.org/lttng2.0
Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.5.0-rc1.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJThf/6XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02wlwIAKZH3bHU5X3uazDHRT+ZEECO
y1XdvaxnSicD18Xskh2YA/EY2Xjl9MaYv3PpHCI86PrGx6f/HUVdoozQsonueEq7
9rm2bsikh6Cr00aZnaVGF3cElmOVdLI2eZC8PEaslhfS6RX/O03kNWx6ejom8qGc
S8Y8tGsMHi6auTlfqSZlHgzYedLxtjH8eqOUBu1EVGyqqqhsJxPLoXeRoJuUP1ao
OcV2MZe13Yui1Z8bE36C43HtuT9s8glldXdDSYFUgtYtZnylIZezAee7BwCQ7cx3
cf0N1bt23Zv4Npscvg0mry14CHA6o7kLP+ydHb7smpzuHHXoNvNIHBCDvNTDBRg=
=GKqa
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--


--===============1526687654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1526687654==--
