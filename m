From: Amit Margalit <AMITM@il.ibm.com>
Subject: Use of sub-buffers - more subbuffers but smaller,
	or less but bigger?
Date: Wed, 31 Jul 2013 12:26:43 +0300
Message-ID: <OF47254F23.1A4EBFF6-ONC2257BB9.003393B9-C2257BB9.0033D3A6__35358.4679346115$1375262879$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0540872956=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1V4SgS-0000JX-9P
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 05:27:08 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 31 Jul 2013 10:20:51 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8B9B117D805A
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 10:28:40 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6V9Qi5d61276214
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 09:26:44 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6V9QtdC030016
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 03:26:55 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r6V9Qtqi030007
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 03:26:55 -0600
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
--===============0540872956==
Content-Type: multipart/alternative; boundary="=_alternative 0033D33FC2257BB9_="

This is a multipart message in MIME format.
--=_alternative 0033D33FC2257BB9_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

I'm trying to understand the trade-offs involved in choosing sub-buffer 
number and size.

So the question is what are the benefits and the disadvantages of 
choosing, say, 32 subbuffers of 1MB versus 8 subbuffers of 4MB, or maybe 4 
subbuffers of 8MB?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0033D33FC2257BB9_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I'm trying to understand the trade-offs
involved in choosing sub-buffer number and size.</font>
<br>
<br><font size=2 face="sans-serif">So the question is what are the benefits
and the disadvantages of choosing, say, 32 subbuffers of 1MB versus 8 subbuffers
of 4MB, or maybe 4 subbuffers of 8MB?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0033D33FC2257BB9_=--



--===============0540872956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0540872956==--
