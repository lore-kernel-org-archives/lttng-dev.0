From: Aaron Spear <aspear@vmware.com>
Subject: Java and UST ?
Date: Tue, 8 Jan 2013 14:42:00 -0800 (PST)
Message-ID: <522299390.2953632.1357684920252.JavaMail.root__12831.4337613576$1357684974$gmane$org@vmware.com>
References: <268188172.2948226.1357684502836.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0667670858=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <aspear@vmware.com>) id 1Tshs0-0006js-Kc
	for lttng-dev@lists.lttng.org; Tue, 08 Jan 2013 17:42:08 -0500
Received: from sc9-mailhost3.vmware.com (sc9-mailhost3.vmware.com
	[10.113.161.73])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id 8A25328308
	for <lttng-dev@lists.lttng.org>; Tue,  8 Jan 2013 14:42:00 -0800 (PST)
Received: from zcs-prod-mta-2.vmware.com (zcs-prod-mta-2.vmware.com
	[10.113.163.64])
	by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 833F4400F4
	for <lttng-dev@lists.lttng.org>; Tue,  8 Jan 2013 14:42:00 -0800 (PST)
Received: from zcs-prod-mta-2.vmware.com (localhost.localdomain [127.0.0.1])
	by zcs-prod-mta-2.vmware.com (Postfix) with ESMTP id 74A8EE0010
	for <lttng-dev@lists.lttng.org>; Tue,  8 Jan 2013 14:42:00 -0800 (PST)
Received: from zimbra-prod-mbox-1.vmware.com (lbv-sc9-t2prod2-int.vmware.com
	[10.113.160.246]) by zcs-prod-mta-2.vmware.com (Postfix) with ESMTP
	for <lttng-dev@lists.lttng.org>; Tue,  8 Jan 2013 14:42:00 -0800 (PST)
In-Reply-To: <268188172.2948226.1357684502836.JavaMail.root@vmware.com>
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

--===============0667670858==
Content-Type: multipart/alternative;
	boundary="----=_Part_2953631_1122007271.1357684920251"

------=_Part_2953631_1122007271.1357684920251
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi All, 


In a conversation with Mathieu the other day he mentioned that there was some ongoing work to create some standard Java logging implementation that logged via UST. I was hoping to find some more detail about this and plans that are underway, and then ask how I can help. My ideal would be to have an SLF4J implementation (or java.util.logging) that I could easily build into any given java app that then uses UST to do the logging. There are many interesting questions that come up in my head with respect to what you do with mappings between Java and CTF (how "components" are treated, contexts, enable/disable, treatment of Java objects in CTF metadata, ...) 



cheers, 
Aaron Spear 




------=_Part_2953631_1122007271.1357684920251
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: tahoma,new york,times,serif; font-size: 12pt; col=
or: #000000'>Hi All,<div><br></div><div>In a conversation with Mathieu the =
other day he mentioned that there was some ongoing work to create some stan=
dard Java logging implementation that logged via UST. &nbsp;I was hoping to=
 find some more detail about this and plans that are underway, and then ask=
 how I can help. &nbsp;My ideal would be to have an SLF4J implementation (o=
r java.util.logging) that I could easily build into any given java app that=
 then uses UST to do the logging. &nbsp;There are many interesting question=
s that come up in my head with respect to what you do with mappings between=
 Java and CTF (how "components" are treated, contexts, enable/disable, trea=
tment of Java objects in CTF metadata, ...)</div><div><br></div><div></div>=
<div><span style=3D"font-size: 12pt;">cheers,</span></div><div>Aaron Spear<=
/div><div><div><span name=3D"x"></span><br></div><br></div></div></body></h=
tml>
------=_Part_2953631_1122007271.1357684920251--


--===============0667670858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0667670858==--
