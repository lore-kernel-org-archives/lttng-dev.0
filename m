From: Amit Margalit <AMITM@il.ibm.com>
Subject: Trace rotation across sessions
Date: Tue, 18 Mar 2014 10:52:24 +0200
Message-ID: <OFBBFCF198.C68E7A66-ONC2257C9F.00309BBF-C2257C9F.0030CCEA__34293.747021775$1395132808$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0131032685=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1WPplN-0007Y8-8w
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 04:52:46 -0400
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 18 Mar 2014 08:52:39 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5FB2E2190041
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 08:52:32 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id s2I8qPUw52494552
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 08:52:25 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id s2I8qanr026551
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 02:52:36 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id s2I8qac0026542
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 02:52:36 -0600
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

This is a multipart message in MIME format.
--===============0131032685==
Content-Type: multipart/alternative; boundary="=_alternative 0030CCCAC2257C9F_="

This is a multipart message in MIME format.
--=_alternative 0030CCCAC2257C9F_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

Our system has a running session that stays on continuously.

Occasionally, our customer will upgrade the software, leading to a reboot, 
which in turn means we will have a new session.

Is there any way to make LTTng aware of the total size of all sessions 
(current and past) and simply rotate files to keep the entire set of 
traces under a size limit?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0030CCCAC2257C9F_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">Our system has a running session that
stays on continuously.</font>
<br>
<br><font size=2 face="sans-serif">Occasionally, our customer will upgrade
the software, leading to a reboot, which in turn means we will have a new
session.</font>
<br>
<br><font size=2 face="sans-serif">Is there any way to make LTTng aware
of the total size of all sessions (current and past) and simply rotate
files to keep the entire set of traces under a size limit?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0030CCCAC2257C9F_=--



--===============0131032685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0131032685==--
