From: Amit Margalit <AMITM@il.ibm.com>
Subject: UST - Is it possible to merge my source file and the
	tracepoint file?
Date: Mon, 21 Oct 2013 16:16:30 +0300
Message-ID: <OF57C1DB54.0A83C4A8-ONC2257C0B.004853B8-C2257C0B.0048E935__35882.7803204351$1382361463$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0408264398=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VYFLo-0005Qu-NP
	for lttng-dev@lists.lttng.org; Mon, 21 Oct 2013 09:16:54 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 21 Oct 2013 14:16:46 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B5F6219005F
	for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2013 14:16:43 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r9LDGUFv56229950
	for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2013 13:16:30 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r9LDGguO018911
	for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2013 09:16:43 -0400
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r9LDGghn018908
	for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2013 09:16:42 -0400
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
--===============0408264398==
Content-Type: multipart/alternative; boundary="=_alternative 0048E8E9C2257C0B_="

This is a multipart message in MIME format.
--=_alternative 0048E8E9C2257C0B_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Consider the following situation:

I wrote a header (lttng_tp_hdr.h) containing several tracepoints, matching 
some locations I want to instrument in one of my source files (let's call 
it source.c). I created a C file for this header (lttng_tp_src.c) and 
compiled it into object. I then compiled source.c into source.o and I link 
the two objects together.

This is the standard work mode.

Now I want to automate this procedure, which will cause me to generate new 
C files, and new headers for many of my sources.

How can I rewrite my source.c so it contains everything I need?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0048E8E9C2257C0B_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Consider the following situation:</font>
<br>
<br><font size=2 face="sans-serif">I wrote a header (lttng_tp_hdr.h) containing
several tracepoints, matching some locations I want to instrument in one
of my source files (let's call it source.c). I created a C file for this
header (lttng_tp_src.c) and compiled it into object. I then compiled source.c
into source.o and I link the two objects together.</font>
<br>
<br><font size=2 face="sans-serif">This is the standard work mode.</font>
<br>
<br><font size=2 face="sans-serif">Now I want to automate this procedure,
which will cause me to generate new C files, and new headers for many of
my sources.</font>
<br>
<br><font size=2 face="sans-serif">How can I rewrite my source.c so it
contains everything I need?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0048E8E9C2257C0B_=--



--===============0408264398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0408264398==--
