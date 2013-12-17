From: David Goulet <dgoulet@efficios.com>
Subject: LTTng-Tools 2.4 stable branch
Date: Tue, 17 Dec 2013 13:53:38 -0500
Message-ID: <20131217185338.GE9433__24059.2577647933$1387306495$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1589784983=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vszm9-0002KV-1y
	for lttng-dev@lists.lttng.org; Tue, 17 Dec 2013 13:53:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id BEA94A1D9C
	for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2013 18:53:36 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RHSFsQEDo1dp for <lttng-dev@lists.lttng.org>;
	Tue, 17 Dec 2013 18:53:36 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 35296A1DA0
	for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2013 18:53:36 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Je1SOZqmKmxx for <lttng-dev@lists.lttng.org>;
	Tue, 17 Dec 2013 18:53:36 +0000 (UTC)
Received: from thessa (cable-10.246.173-146.electronicbox.net [173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 5CE62A1D9C
	for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2013 18:53:35 +0000 (UTC)
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


--===============1589784983==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

I've created the "stable-2.4" branch from master even though the tree is
still in the RC cycle. This is to be able to push patches for 2.5 in the
master tree.

So please, if you are using master as the upstream reference to test
2.4-rc*, change it to the "stable-2.4" branch.

As a reminder, 2.5 needs a codename! :)
https://bugs.lttng.org/issues/663

Thanks everyone!
David

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSsJ2yXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02KFQH/0QE4hLn0rXEIyyCTunuzqkA
R+XPL5V6NJnHIpcq3Wh+xC2XpPgQmwem4ELw7RpepXNZzJDbE7EzBKxgb1kg8Mcu
ziTb1BMdnoZKCKwDEoMUelRfg5FmUarS1hpRJcJZ4NGL+joKtLJXR/HzEmR5eZrn
gVRkh77TeWuUZl+39QJMNDyKXzSa5SSK5qiCBPHCkU8NCqgWlmUYX37kjBle+Dx1
ZexltLouwUYOsku+1cr5ly0Vt1dId9S9hSrnuzpV5viSNdHcHBMmCtpFIden8u4Y
YCwilrpFjMmKhgcBO71LyeIanbSAu184q9eUu+WbmgBxQll4p3sT3B/AXWKGjwk=
=Enwk
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--


--===============1589784983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1589784983==--
