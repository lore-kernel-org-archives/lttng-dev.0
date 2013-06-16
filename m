From: Amit Margalit <AMITM@il.ibm.com>
Subject: Problem with adding vpid and vtid context to UST
Date: Sun, 16 Jun 2013 11:06:19 +0300
Message-ID: <OFA2B17967.FDD790B6-ONC2257B8C.002C000A-C2257B8C.002C70E3__18330.2071797245$1371370039$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1163157387=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Uo7yx-0005yw-LW
	for lttng-dev@lists.lttng.org; Sun, 16 Jun 2013 04:06:39 -0400
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Sun, 16 Jun 2013 09:01:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 62D6A1B0805F
	for <lttng-dev@lists.lttng.org>; Sun, 16 Jun 2013 09:06:30 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5G86JWK55902276
	for <lttng-dev@lists.lttng.org>; Sun, 16 Jun 2013 08:06:19 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5G86T41024563
	for <lttng-dev@lists.lttng.org>; Sun, 16 Jun 2013 02:06:29 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5G86TdJ024560
	for <lttng-dev@lists.lttng.org>; Sun, 16 Jun 2013 02:06:29 -0600
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
--===============1163157387==
Content-Type: multipart/alternative; boundary="=_alternative 002C7090C2257B8C_="

This is a multipart message in MIME format.
--=_alternative 002C7090C2257B8C_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Every time I try this, I get the following error:

Error: Error starting tracing for app pid: 5663 (ret: -1027)

Here's my sequence:

lttng create foo -o /store/
lttng enable-channel -u
lttng add-context -u -t vpid -t vtid -t procname
lttng enable-event -u -a
lttng start foo

At this point I start my application and get that error. When the 
application exits, I stop the tracing, and run lttng view.

The trace session seems to have worked just fine, and "procname" was 
indeed added to the context, but vtid and vpid were not.

And BTW, the documentation doesn't clearly state that pid and tid are 
kernel-only contexts, and that one should use vtid and vpid.

Any help is appreciated.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 002C7090C2257B8C_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Every time I try this, I get the following
error:</font>
<br>
<br><font size=2 face="sans-serif">Error: Error starting tracing for app
pid: 5663 (ret: -1027)</font>
<br>
<br><font size=2 face="sans-serif">Here's my sequence:</font>
<br>
<br><font size=2 face="sans-serif">lttng create foo -o /store/</font>
<br><font size=2 face="sans-serif">lttng enable-channel -u</font>
<br><font size=2 face="sans-serif">lttng add-context -u -t vpid -t vtid
-t procname</font>
<br><font size=2 face="sans-serif">lttng enable-event -u -a</font>
<br><font size=2 face="sans-serif">lttng start foo</font>
<br>
<br><font size=2 face="sans-serif">At this point I start my application
and get that error. When the application exits, I stop the tracing, and
run lttng view.</font>
<br>
<br><font size=2 face="sans-serif">The trace session seems to have worked
just fine, and &quot;procname&quot; was indeed added to the context, but
vtid and vpid were not.</font>
<br>
<br><font size=2 face="sans-serif">And BTW, the documentation doesn't clearly
state that pid and tid are kernel-only contexts, and that one should use
vtid and vpid.</font>
<br>
<br><font size=2 face="sans-serif">Any help is appreciated.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 002C7090C2257B8C_=--



--===============1163157387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1163157387==--
