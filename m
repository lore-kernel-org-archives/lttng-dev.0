From: Amit Margalit <AMITM@il.ibm.com>
Subject: How much shared memory is used by LTTng (UST) ?
Date: Wed, 10 Jul 2013 16:42:01 +0300
Message-ID: <OFCCB7B255.8E21590D-ONC2257BA4.004A6CD2-C2257BA4.004B3116__37115.9259499565$1373463781$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773505009=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Uwuf2-0003Ww-Dh
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 09:42:24 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 10 Jul 2013 14:37:27 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D82D42190061
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 14:46:07 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6ADg35l42402016
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 13:42:03 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6ADgEfm017162
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 07:42:14 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r6ADgElB017159
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 07:42:14 -0600
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
--===============0773505009==
Content-Type: multipart/alternative; boundary="=_alternative 004B30A1C2257BA4_="

This is a multipart message in MIME format.
--=_alternative 004B30A1C2257BA4_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Chasing down an issue with adding some context (see 
https://bugs.lttng.org/issues/579), I've encountered something that makes 
me think the failures I am seeing are related to amount of shared memory 
that LTTng uses...

In short - when the subbuffers have a large enough size and number, adding 
things to context on a multi-core system can cause libringbuffer/shm.c in 
lttng-ust to complain about "No space left on device", leading to 
everything looking OK, except that the trace directory stays empty.

I am working on a 6-core (12 with HT) system that has 24GB of RAM. This is 
one configuration, but we also have dual-CPU systems (i.e. 12 cores / 24 
with HT) with 96GB.

I am using 16 subbuffers of 256KB. In this setup, I have no problem adding 
procname, vpid and vtid to the context.

When I tried the same on the 12-core dual-CPU system, it failed as 
explained above. I tried reducing the subbuffer sizes to 64KB, and the 
problem disappeared.

So - how can I tell how much shared memory LTTng wants, and - if you know 
- how can I configure my system to allow more than the default?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 004B30A1C2257BA4_=
Content-Type: text/html; charset="US-ASCII"

<font size=3>Hi,</font>
<br>
<br><font size=3>Chasing down an issue with adding some context (see </font><a href=https://bugs.lttng.org/issues/579><font size=3 color=blue><u>https://bugs.lttng.org/issues/579</u></font></a><font size=3>),
I've encountered something that makes me think the failures I am seeing
are related to amount of shared memory that LTTng uses...</font>
<br>
<br><font size=3>In short - when the subbuffers have a large enough size
and number, adding things to context on a multi-core system can cause libringbuffer/shm.c
in lttng-ust to complain about &quot;No space left on device&quot;, leading
to everything looking OK, except that the trace directory stays empty.</font>
<br>
<br><font size=3>I am working on a 6-core (12 with HT) system that has
24GB of RAM. This is one configuration, but we also have dual-CPU systems
(i.e. 12 cores / 24 with HT) with 96GB.</font>
<br>
<br><font size=3>I am using 16 subbuffers of 256KB. In this setup, I have
no problem adding procname, vpid and vtid to the context.</font>
<br>
<br><font size=3>When I tried the same on the 12-core dual-CPU system,
it failed as explained above. I tried reducing the subbuffer sizes to 64KB,
and the problem disappeared.</font>
<br>
<br><font size=3>So - how can I tell how much shared memory LTTng wants,
and - if you know - how can I configure my system to allow more than the
default?</font>
<br>
<br><font size=3>Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 004B30A1C2257BA4_=--



--===============0773505009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0773505009==--
