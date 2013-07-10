From: Amit Margalit <AMITM@il.ibm.com>
Subject: Question about performance and tracepoint structure
Date: Wed, 10 Jul 2013 20:16:53 +0300
Message-ID: <OFA2CEA64A.AB33A759-ONC2257BA4.005E65A6-C2257BA4.005EDCF5__7735.79727761007$1373476676$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0912080354=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Uwy0w-0005IW-Ug
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 13:17:15 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 10 Jul 2013 18:12:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5C3BF17D801A
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 18:18:41 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6AHGtRa53608612
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 17:16:55 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6AHH6XO000900
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 11:17:06 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r6AHH6xY000897
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 11:17:06 -0600
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
--===============0912080354==
Content-Type: multipart/alternative; boundary="=_alternative 005EDCAFC2257BA4_="

This is a multipart message in MIME format.
--=_alternative 005EDCAFC2257BA4_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

This may be a bit of a noob question, and I think I read about this 
somewhere but I can't find it now.

When I declare a tracepoint that's made up of a uint8_t, followed by a 
uint16_t followed by a uint32_t, for example, there are 2 ways to handle 
this - packed or unpacked.

If we're doing packed, then we have to include some code that does the 
packing properly as alignment issues can creep up. This code causes us to 
incur some CPU cycles at that point.

If we're doing unpacked, then we incur some cycles on passing the event to 
the sessiond, and sessiond suffers by having to write down some extra 
bytes, which is less efficient.

Either way, I think it means I can gain some minor performance 
improvements if I reorder my tracepoint arguments to a more efficient 
order - alignment-wise.

Am I barking up the wrong tree here?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 005EDCAFC2257BA4_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">This may be a bit of a noob question,
and I think I read about this somewhere but I can't find it now.</font>
<br>
<br><font size=2 face="sans-serif">When I declare a tracepoint that's made
up of a uint8_t, followed by a uint16_t followed by a uint32_t, for example,
there are 2 ways to handle this - packed or unpacked.</font>
<br>
<br><font size=2 face="sans-serif">If we're doing packed, then we have
to include some code that does the packing properly as alignment issues
can creep up. This code causes us to incur some CPU cycles at that point.</font>
<br>
<br><font size=2 face="sans-serif">If we're doing unpacked, then we incur
some cycles on passing the event to the sessiond, and sessiond suffers
by having to write down some extra bytes, which is less efficient.</font>
<br>
<br><font size=2 face="sans-serif">Either way, I think it means I can gain
some minor performance improvements if I reorder my tracepoint arguments
to a more efficient order - alignment-wise.</font>
<br>
<br><font size=2 face="sans-serif">Am I barking up the wrong tree here?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 005EDCAFC2257BA4_=--



--===============0912080354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0912080354==--
