From: Amit Margalit <AMITM@il.ibm.com>
Subject: [UST] SIGSEGV in lttng_ust_exit()
Date: Wed, 25 Dec 2013 14:58:05 +0200
Message-ID: <OF99872887.58F6C4DA-ONC2257C4C.00466CBF-C2257C4C.00474033__24106.875973712$1387976350$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0375777612=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Vvo2Y-0003xj-2H
	for lttng-dev@lists.lttng.org; Wed, 25 Dec 2013 07:58:22 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 25 Dec 2013 12:58:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7079A17D8058
	for <lttng-dev@lists.lttng.org>; Wed, 25 Dec 2013 12:58:16 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rBPCw1QW31522900
	for <lttng-dev@lists.lttng.org>; Wed, 25 Dec 2013 12:58:02 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id rBPCwDSX026929
	for <lttng-dev@lists.lttng.org>; Wed, 25 Dec 2013 05:58:13 -0700
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id rBPCwDW6026926
	for <lttng-dev@lists.lttng.org>; Wed, 25 Dec 2013 05:58:13 -0700
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
--===============0375777612==
Content-Type: multipart/alternative; boundary="=_alternative 00473FE3C2257C4C_="

This is a multipart message in MIME format.
--=_alternative 00473FE3C2257C4C_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Using 2.3.0, we have a daemon process that's being restarted. The process 
is being asked to terminate using a simple 'kill', i.e. SIGTERM.

Here is most of the traceback - any help is appreciated.

.424636] ===26292=== #2 crash_sig_handler (sig=11, info=0xb519f0, 
uc=<optimized out>) at common/crashandler/crashandler_client.c:139
.424671] ===26292=== #3 <signal handler called>
.424730] ===26292=== #4 0x00007f4c2cb57831 in pthread_cancel () from 
/lib64/libpthread.so.0
.424788] ===26292=== #5 0x00007f4c2dec428e in lttng_ust_exit () at 
lttng-ust-comm.c:1296
.424846] ===26292=== #6 0x00007f4c2e310469 in _dl_fini () from 
/lib64/ld-linux-x86-64.so.2
.424904] ===26292=== #7 0x00007f4c2c4135e5 in __run_exit_handlers () from 
/lib64/libc.so.6
.424954] ===26292=== #8 0x00007f4c2c413635 in exit () from 
/lib64/libc.so.6
.425011] ===26292=== #9 0x00007f4c2c3fcbcd in __libc_start_main () from 
/lib64/libc.so.6
.425072] ===26292=== #10 0x000000000041cd49 in _start () at 
../sysdeps/x86_64/elf/start.S:113


Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 00473FE3C2257C4C_=
Content-Type: text/html; charset="US-ASCII"

<tt><font size=2>Hi,</font></tt>
<br>
<br><tt><font size=2>Using 2.3.0, we have a daemon process that's being
restarted. The process is being asked to terminate using a simple 'kill',
i.e. SIGTERM.</font></tt>
<br>
<br><tt><font size=2>Here is most of the traceback - any help is appreciated.</font></tt>
<br>
<br><tt><font size=2>.424636] ===26292=== #2 crash_sig_handler (sig=11,
info=0xb519f0, uc=&lt;optimized out&gt;) at common/crashandler/crashandler_client.c:139<br>
.424671] ===26292=== #3 &lt;signal handler called&gt;<br>
.424730] ===26292=== #4 0x00007f4c2cb57831 in pthread_cancel () from /lib64/libpthread.so.0<br>
.424788] ===26292=== #5 0x00007f4c2dec428e in lttng_ust_exit () at lttng-ust-comm.c:1296<br>
.424846] ===26292=== #6 0x00007f4c2e310469 in _dl_fini () from /lib64/ld-linux-x86-64.so.2<br>
.424904] ===26292=== #7 0x00007f4c2c4135e5 in __run_exit_handlers () from
/lib64/libc.so.6<br>
.424954] ===26292=== #8 0x00007f4c2c413635 in exit () from /lib64/libc.so.6<br>
.425011] ===26292=== #9 0x00007f4c2c3fcbcd in __libc_start_main () from
/lib64/libc.so.6<br>
.425072] ===26292=== #10 0x000000000041cd49 in _start () at ../sysdeps/x86_64/elf/start.S:113</font></tt>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 00473FE3C2257C4C_=--



--===============0375777612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0375777612==--
