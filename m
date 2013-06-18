From: Amit Margalit <AMITM@il.ibm.com>
Subject: Weird assertion failure in
	__lttng_events_init__provider () at
	/usr/include/lttng/ust-tracepoint-event.h:687
Date: Tue, 18 Jun 2013 13:57:03 +0300
Message-ID: <OF02578AAF.2F483DCE-ONC2257B8E.003BBD95-C2257B8E.003C1290__5850.86854775927$1371553200$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1738701757=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UotbH-000339-BI
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 06:57:23 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 18 Jun 2013 11:52:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CDCC81B0805F
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 11:57:15 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5IAv4DI56230058
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 10:57:04 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5IAvEr5000951
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 04:57:14 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5IAvE5r000941
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 04:57:14 -0600
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
--===============1738701757==
Content-Type: multipart/alternative; boundary="=_alternative 003C125EC2257B8E_="

This is a multipart message in MIME format.
--=_alternative 003C125EC2257B8E_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I'm getting an assertion failure as listed above. Any idea what this is?

Program terminated with signal 6, Aborted.
#0  0x00007fc304edb945 in raise () from /lib64/libc.so.6
(gdb) bt
#0  0x00007fc304edb945 in raise () from /lib64/libc.so.6
#1  0x00007fc304edcf21 in abort () from /lib64/libc.so.6
#2  0x00007fc304ed4810 in __assert_fail () from /lib64/libc.so.6
#3  0x00007fc30a48d58a in __lttng_events_init__provider () at 
/usr/include/lttng/ust-tracepoint-event.h:687

The change I made was to add 2 more tracepoints, in a separate file. The 
provider is the same.

I am using --buffers-uid, btw. The code is stock 2.2.0rc2 + my LTTNG_HOME 
patch.

Thanks,


Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 003C125EC2257B8E_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I'm getting an assertion failure as
listed above. Any idea what this is?</font>
<br>
<br><font size=2 face="sans-serif">Program terminated with signal 6, Aborted.</font>
<br><font size=2 face="sans-serif">#0 &nbsp;0x00007fc304edb945 in raise
() from /lib64/libc.so.6</font>
<br><font size=2 face="sans-serif">(gdb) bt</font>
<br><font size=2 face="sans-serif">#0 &nbsp;0x00007fc304edb945 in raise
() from /lib64/libc.so.6</font>
<br><font size=2 face="sans-serif">#1 &nbsp;0x00007fc304edcf21 in abort
() from /lib64/libc.so.6</font>
<br><font size=2 face="sans-serif">#2 &nbsp;0x00007fc304ed4810 in __assert_fail
() from /lib64/libc.so.6</font>
<br><font size=2 face="sans-serif">#3 &nbsp;0x00007fc30a48d58a in __lttng_events_init__provider
() at /usr/include/lttng/ust-tracepoint-event.h:687</font>
<br>
<br><font size=2 face="sans-serif">The change I made was to add 2 more
tracepoints, in a separate file. The provider is the same.</font>
<br>
<br><font size=2 face="sans-serif">I am using --buffers-uid, btw. The code
is stock 2.2.0rc2 + my LTTNG_HOME patch.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 003C125EC2257B8E_=--



--===============1738701757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1738701757==--
