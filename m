From: Amit Margalit <AMITM@il.ibm.com>
Subject: Question about filtering bytecode
Date: Thu, 18 Jul 2013 10:12:08 +0300
Message-ID: <OFA394F5DC.943733C6-ONC2257BAC.00273BA0-C2257BAC.00277FA2__4653.70858223668$1374131616$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0209412027=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UziO7-0005OJ-25
	for lttng-dev@lists.lttng.org; Thu, 18 Jul 2013 03:12:35 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 18 Jul 2013 08:08:03 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 745231B0805D
	for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2013 08:12:21 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6I7CAjT62587040
	for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2013 07:12:10 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6I7CKav012083
	for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2013 01:12:20 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r6I7CKxW012070
	for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2013 01:12:20 -0600
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
--===============0209412027==
Content-Type: multipart/alternative; boundary="=_alternative 00277F7BC2257BAC_="

This is a multipart message in MIME format.
--=_alternative 00277F7BC2257BAC_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I'm considering whether I can write a wrapper for the libbabeltrace ctf 
iterator which provides a filtered "next()" method.

I've started reading the code in the hopes of understanding how to do 
this, and yet, I'd really appreciate a link to some ordered documentation, 
or - any other kind of explanation.

For example, one thing I still don't understand is the exact sequence, and 
where the bytecode is actually executed? What is the meaning and purpose 
of "linking" the filter to an event.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 00277F7BC2257BAC_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I'm considering whether I can write
a wrapper for the libbabeltrace ctf iterator which provides a filtered
&quot;next()&quot; method.</font>
<br>
<br><font size=2 face="sans-serif">I've started reading the code in the
hopes of understanding how to do this, and yet, I'd really appreciate a
link to some ordered documentation, or - any other kind of explanation.</font>
<br>
<br><font size=2 face="sans-serif">For example, one thing I still don't
understand is the exact sequence, and where the bytecode is actually executed?
What is the meaning and purpose of &quot;linking&quot; the filter to an
event.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 00277F7BC2257BAC_=--



--===============0209412027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0209412027==--
