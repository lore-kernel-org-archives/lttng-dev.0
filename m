From: Amit Margalit <AMITM@il.ibm.com>
Subject: Limitations on subbuf_size / num_subbuf?
Date: Sun, 14 Apr 2013 13:49:55 +0300
Message-ID: <OFC51F8E88.28285A69-ONC2257B4D.003B3B3E-C2257B4D.003B6399__25934.169200673$1365936654$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0793291178=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1URKVl-0007FA-7r
	for lttng-dev@lists.lttng.org; Sun, 14 Apr 2013 06:50:17 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Sun, 14 Apr 2013 11:48:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0F10C1B0805F
	for <lttng-dev@lists.lttng.org>; Sun, 14 Apr 2013 11:50:07 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r3EAnv9v45744264
	for <lttng-dev@lists.lttng.org>; Sun, 14 Apr 2013 10:49:57 GMT
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id r3EAo6jx018359
	for <lttng-dev@lists.lttng.org>; Sun, 14 Apr 2013 04:50:06 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with
	ESMTP id r3EAo6iP018356
	for <lttng-dev@lists.lttng.org>; Sun, 14 Apr 2013 04:50:06 -0600
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
--===============0793291178==
Content-Type: multipart/alternative; boundary="=_alternative 003B6327C2257B4D_="

This is a multipart message in MIME format.
--=_alternative 003B6327C2257B4D_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

Sorry for the noob question. I seem to be unable to define the total of 
subbuf_size * num_subbuf higher than 4MB. I am getting ~30% discarded 
tracepoint data.

Any assistance would be greatly appreciated.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 003B6327C2257B4D_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">Sorry for the noob question. I seem
to be unable to define the total of subbuf_size * num_subbuf higher than
4MB. I am getting ~30% discarded tracepoint data.</font>
<br>
<br><font size=2 face="sans-serif">Any assistance would be greatly appreciated.</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 003B6327C2257B4D_=--



--===============0793291178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0793291178==--
