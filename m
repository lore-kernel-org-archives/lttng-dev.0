From: Amit Margalit <AMITM@il.ibm.com>
Subject: Problem compiling Babeltrace 1.1.1 python bindings with
	old Bison
Date: Sun, 14 Jul 2013 15:21:03 +0300
Message-ID: <OFAC6F4FD9.22CFFBB5-ONC2257BA8.0043725C-C2257BA8.0043C772__1060.28452651135$1373804520$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1478267215=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UyLIo-00081b-IH
	for lttng-dev@lists.lttng.org; Sun, 14 Jul 2013 08:21:22 -0400
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Sun, 14 Jul 2013 13:15:23 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D6F0217D801A
	for <lttng-dev@lists.lttng.org>; Sun, 14 Jul 2013 13:22:50 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6ECL3SR50331778
	for <lttng-dev@lists.lttng.org>; Sun, 14 Jul 2013 12:21:03 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6ECLEJZ023466
	for <lttng-dev@lists.lttng.org>; Sun, 14 Jul 2013 06:21:14 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r6ECLEQL023463
	for <lttng-dev@lists.lttng.org>; Sun, 14 Jul 2013 06:21:14 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1478267215==
Content-Type: multipart/alternative; boundary="=_alternative 0043C722C2257BA8_="

This is a multipart message in MIME format.
--=_alternative 0043C722C2257BA8_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Seems like the configure script doesn't fail when bison version is too 
old. I am using bison 2.3, which doesn't support pure parser generation, 
causing a failure in formats/ctf/metadata/ctf-parser.y :

The following line expects a value to the define:

%define api.pure

Adding "true" or "full" doesn't help either.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0043C722C2257BA8_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Seems like the configure script doesn't
fail when bison version is too old. I am using bison 2.3, which doesn't
support pure parser generation, causing a failure in </font><tt><font size=2>formats/ctf/metadata/ctf-parser.y</font></tt><font size=2 face="sans-serif">
:</font>
<br>
<br><font size=2 face="sans-serif">The following line expects a value to
the define:</font>
<br>
<br><font size=2 face="sans-serif">%define api.pure</font>
<br>
<br><font size=2 face="sans-serif">Adding &quot;true&quot; or &quot;full&quot;
doesn't help either.</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0043C722C2257BA8_=--



--===============1478267215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1478267215==--
