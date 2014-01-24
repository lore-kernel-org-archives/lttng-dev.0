From: David Goulet <dgoulet@efficios.com>
Subject: [RFC] Java JUL loglevel mapping to LTTng
Date: Fri, 24 Jan 2014 12:32:45 -0500
Message-ID: <20140124173245.GC7517__25060.1317304701$1390584832$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1709008502=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1W6kcg-0001lZ-51
	for lttng-dev@lists.lttng.org; Fri, 24 Jan 2014 12:33:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id C03A5A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 24 Jan 2014 17:32:35 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OlQDnzdzajpQ for <lttng-dev@lists.lttng.org>;
	Fri, 24 Jan 2014 17:32:35 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 50A91A1D9C
	for <lttng-dev@lists.lttng.org>; Fri, 24 Jan 2014 17:32:35 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ThfROHuLidZW for <lttng-dev@lists.lttng.org>;
	Fri, 24 Jan 2014 17:32:35 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id C0D68A1D7A
	for <lttng-dev@lists.lttng.org>; Fri, 24 Jan 2014 17:32:34 +0000 (UTC)
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


--===============1709008502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone!

Quick email to submit you all the mapping I did between Java JUL
loglevel[1] and LTTng[2]. This is for the support of loglevels in LTTng
JUL library.

Since Java loglevels don't make sense at all nor are following any
standard (like syslog), this is a best effort :P.

LOGLEVEL_EMERG:
LOGLEVEL_ALERT:
LOGLEVEL_CRIT:
LOGLEVEL_ERR:
	JUL Level --> SEVERE

LOGLEVEL_WARNING:
LOGLEVEL_NOTICE:
	JUL Level --> WARNING

LOGLEVEL_INFO:
	JUL Level --> INFO

LOGLEVEL_DEBUG_SYSTEM:
LOGLEVEL_DEBUG_PROGRAM:
LOGLEVEL_DEBUG_PROCESS:
LOGLEVEL_DEBUG_MODULE:
	JUL Level --> CONFIG

LOGLEVEL_DEBUG_UNIT:
	JUL Level --> FINE

LOGLEVEL_DEBUG_FUNCTION:
	JUL Level --> FINER

LOGLEVEL_DEBUG_LINE:
	JUL Level --> FINEST

LOGLEVEL_DEBUG:
default:
	JUL Level --> ALL

Any input on that is welcome!

Cheers!
David

[1] http://docs.oracle.com/javase/7/docs/api/java/util/logging/Level.html
[2] https://git.lttng.org/?p=lttng-tools.git;a=blob;f=include/lttng/lttng.h;h=85fdfaa257605f36ebbd7d99030e8f3ca32e97b9;hb=HEAD#l71

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS4qO9XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02F4EH/iin2HP8GdC6pZhRrSl6fxQx
DOpWeyX38puGG+ff/aiBU5UQyoKT26xriJ4cofHbjtrsQkYtBwVzvkGgOXAJkmVJ
uDaVspIrTeKlG+cAozxMq3CieIkVYZPMb9EuANOF1+4Q5Tt64YfgOchhFHfrcamR
0lPCDWcxpY7Am+NJ2myG1gFVHhtx6Ab6uRhm0jUcQLYtdFz+5ZvCV9oiPTP/GEu8
WNmj72d4h8rbaMMztj+YVUuPZ5OVVitVEIKVg/3/G/eHpW5ZIl9jBW6cjYlpj9jH
0S/QaBP21I/Pn71Q011gw/7jvW8ug077mJXTpXzfT35CWt+d3xHJ9Vqu9eb/qWM=
=VXnH
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--


--===============1709008502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1709008502==--
