From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.3.2
Date: Fri, 28 Feb 2014 13:08:22 -0500
Message-ID: <20140228180822.GC14281__23022.457821253$1393610972$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1023214014=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WJRrK-0006Vi-LB
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 13:08:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id A2282A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:08:07 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1fs7LfSz-qa3 for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:08:07 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 2D42DA1D9C
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:08:07 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vs55_7R79kIe for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:08:07 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 97BE4A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:08:06 +0000 (UTC)
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


--===============1023214014==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

2014-02-28 lttng-tools 2.3.2
     * Fix: minor rephrasing of the lttng.1 man page
     * Fix: possible NULL deref. in sessiond error path
     * Fix: flag that kernel streams FDs has been sent
     * Fix: forbid session name creation if contains /
     * Fix: don't start session if no channel
     * Fix: report error if consumer can't be spawned
     * Fix: lttng list -u <name> should only list UST
     * Fix: kernel channel destroy on consumer if sent
     * Fix: Define __STDC_LIMIT_MACROS to fix C++ builds
     * Fix: remove unused goto label
     * Fix: relayd: add LPOLLERR to events
     * Fix: relayd: initialize lttcomm inet
     * Fix: consumerd: HT init/teardown with program
     * Fix: consumerd should initialize lttcomm
     * Fix: measure UST clock offset with best sample (v2)
     * Fix: report to client when snapshot will be empty
     * Fix: missing reset when listing UST fields for multiple PIDs
     * Fix: filter: check binary op nesting
     * Fix: remove break in epoll loop of apps. thread
     * Fix: wrong comment in snapshot public API
     * Fix: remove bad code from previous backport patch
     * Fix: bad logical check of error codes
     * Fix: resource leak in enable-event command
     * Fix: unchecked return value in ust app delete
     * Fix: dereference after null check in UST registry
     * Fix: Resource leak in ust registry
     * Fix: backported from urcu commit 92af1a30
     * Fix: update back the metadata len sent on failure
     * Fix: don't fail on push metadata if no channel
     * Fix: comparison of unsigned enum expression >= 0
     * Add libuuid as dependency in README
     * Fix: implicit conversion of enum types in consumer
     * Fix: implicit conversion of enum types in sessiond
     * Fix: comparison of unsigned value agains < 0


Please report ANY issues to bugs.lttng.org or through that mailing list.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.3.2.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTENCWXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02m4cH/3a0a7KQeukfZV6zDbSu5otT
ppMMhXw9Dkp5+R2QfCcfy2F1bTEzU0l6/wAEN0XYXoLSNl7bug1CUMCPHr5NNQE1
cd5Gkma+AOYjlZ3C9c/8cNFrl7Kt3k8LThMPPOTA0svd1W/Dlv+7NkDM62txRd9L
YWzE8rJI9FLn7ZfmVodl9L3Sdupu3YT8Q9aobf4A3oyz8zZn0NWT6xpE6taZcs9d
lTY40I01uJzI1nZ/NWrLe5tVGBbZIXZ8xnRECjPS5jbAPTKLleRuEgA4c0ia+V23
eWImn4v1rAk5Pvf9fs0cpVd4xA0DM5JHg5p+58TO4CY0db1csKlRHSF300jTQLg=
=ap3o
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--


--===============1023214014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1023214014==--
