From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [UST] SIGSEGV in lttng_ust_exit()
Date: Sun, 12 Jan 2014 13:52:58 +0200
Message-ID: <OFFEF0E305.3F03A005-ONC2257C5E.0041360D-C2257C5E.00414EBA__35724.3328159258$1389527663$gmane$org@il.ibm.com>
References: <OF99872887.58F6C4DA-ONC2257C4C.00466CBF-C2257C4C.00474033@il.ibm.com>
	<653943812.4048.1389041053865.JavaMail.zimbra@efficios.com>
	<1275424701.4355.1389109493760.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1813785311=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1W2JbU-0007EG-PL
	for lttng-dev@lists.lttng.org; Sun, 12 Jan 2014 06:53:22 -0500
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Sun, 12 Jan 2014 11:53:14 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 447E71B0805F
	for <lttng-dev@lists.lttng.org>; Sun, 12 Jan 2014 11:52:32 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id s0CBqx2L61735080
	for <lttng-dev@lists.lttng.org>; Sun, 12 Jan 2014 11:52:59 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id s0CBrASg010682
	for <lttng-dev@lists.lttng.org>; Sun, 12 Jan 2014 04:53:11 -0700
In-Reply-To: <1275424701.4355.1389109493760.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1813785311==
Content-Type: multipart/alternative; boundary="=_alternative 00414E73C2257C5E_="

This is a multipart message in MIME format.
--=_alternative 00414E73C2257C5E_=
Content-Type: text/plain; charset="US-ASCII"

Indeed, it seems that lttng-ust-fork is needed.

Thanks!

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   01/07/2014 05:44 PM
Subject:        Re: [lttng-dev] [UST] SIGSEGV in lttng_ust_exit()



Another thing: is your daemon using fork(), clone() or daemon() at any 
point ? If yes, did you LD_PRELOAD liblttng-ust-fork.so as stated in the 
lttng-ust(3) manpage in the environment starting your daemon ?

Thanks,

Mathieu



From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
To: "Amit Margalit" <AMITM@il.ibm.com>
Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
Sent: Monday, January 6, 2014 3:44:13 PM
Subject: Re: [lttng-dev] [UST] SIGSEGV in lttng_ust_exit()

Hi,

Can you try with updated lttng-ust (2.3.1 and stable-2.3 branch head) and 
update userspace RCU (0.8.1 and stable-0.8 head).

Thanks,

Mathieu



From: "Amit Margalit" <AMITM@il.ibm.com>
To: "lttng-dev" <lttng-dev@lists.lttng.org>
Sent: Wednesday, December 25, 2013 7:58:05 AM
Subject: [lttng-dev] [UST] SIGSEGV in lttng_ust_exit()

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
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--=_alternative 00414E73C2257C5E_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Indeed, it seems that lttng-ust-fork is
needed.</font>
<br>
<br><font size=2 face="sans-serif">Thanks!</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">01/07/2014 05:44 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
[UST] SIGSEGV in lttng_ust_exit()</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3>Another thing: is your daemon using fork(), clone() or
daemon() at any point ? If yes, did you LD_PRELOAD liblttng-ust-fork.so
as stated in the lttng-ust(3) manpage in the environment starting your
daemon ?</font>
<br>
<br><font size=3>Thanks,</font>
<br>
<br><font size=3>Mathieu</font>
<br>
<br>
<br>
<hr>
<br><font size=3 face="Helvetica"><b>From: </b>&quot;Mathieu Desnoyers&quot;
&lt;mathieu.desnoyers@efficios.com&gt;<b><br>
To: </b>&quot;Amit Margalit&quot; &lt;AMITM@il.ibm.com&gt;<b><br>
Cc: </b>&quot;lttng-dev&quot; &lt;lttng-dev@lists.lttng.org&gt;<b><br>
Sent: </b>Monday, January 6, 2014 3:44:13 PM<b><br>
Subject: </b>Re: [lttng-dev] [UST] SIGSEGV in lttng_ust_exit()</font>
<br>
<br><font size=3>Hi,</font>
<br>
<br><font size=3>Can you try with updated lttng-ust (2.3.1 and stable-2.3
branch head) and update userspace RCU (0.8.1 and stable-0.8 head).</font>
<br>
<br><font size=3>Thanks,</font>
<br>
<br><font size=3>Mathieu</font>
<br>
<br>
<br>
<hr>
<br><font size=3 face="Helvetica"><b>From: </b>&quot;Amit Margalit&quot;
&lt;AMITM@il.ibm.com&gt;<b><br>
To: </b>&quot;lttng-dev&quot; &lt;lttng-dev@lists.lttng.org&gt;<b><br>
Sent: </b>Wednesday, December 25, 2013 7:58:05 AM<b><br>
Subject: </b>[lttng-dev] [UST] SIGSEGV in lttng_ust_exit()</font>
<br>
<br><font size=2 face="Helvetica">Hi,</font><font size=3 face="Helvetica">
<br>
</font><font size=2 face="Helvetica"><br>
Using 2.3.0, we have a daemon process that's being restarted. The process
is being asked to terminate using a simple 'kill', i.e. SIGTERM.</font><font size=3 face="Helvetica">
<br>
</font><font size=2 face="Helvetica"><br>
Here is most of the traceback - any help is appreciated.</font><font size=3 face="Helvetica">
<br>
</font><font size=2 face="Helvetica"><br>
.424636] ===26292=== #2 crash_sig_handler (sig=11, info=0xb519f0, uc=&lt;optimized
out&gt;) at common/crashandler/crashandler_client.c:139<br>
.424671] ===26292=== #3 &lt;signal handler called&gt;<br>
.424730] ===26292=== #4 0x00007f4c2cb57831 in pthread_cancel () from /lib64/libpthread.so.0<br>
.424788] ===26292=== #5 0x00007f4c2dec428e in lttng_ust_exit () at lttng-ust-comm.c:1296<br>
.424846] ===26292=== #6 0x00007f4c2e310469 in _dl_fini () from /lib64/ld-linux-x86-64.so.2<br>
.424904] ===26292=== #7 0x00007f4c2c4135e5 in __run_exit_handlers () from
/lib64/libc.so.6<br>
.424954] ===26292=== #8 0x00007f4c2c413635 in exit () from /lib64/libc.so.6<br>
.425011] ===26292=== #9 0x00007f4c2c3fcbcd in __libc_start_main () from
/lib64/libc.so.6<br>
.425072] ===26292=== #10 0x000000000041cd49 in _start () at ../sysdeps/x86_64/elf/start.S:113</font><font size=3 face="Helvetica">
<br>
<br>
</font><font size=2 color=#000080 face="Helvetica"><br>
Amit Margalit</font><font size=3 face="Helvetica"> </font><font size=2 color=#808000 face="Helvetica"><br>
IBM XIV </font><font size=2 face="Helvetica">- <i>Storage Reinvented</i></font><font size=3 face="Helvetica">
</font><font size=2 face="Helvetica"><br>
XIV-NAS Development Team</font><font size=3 face="Helvetica"> </font><font size=2 face="Helvetica"><br>
Tel. 03</font><font size=2 face="Arial">-689-7774</font><font size=3 face="Helvetica">
</font><font size=2 face="Arial"><br>
Fax. 03-689-7230</font><font size=3 face="Helvetica"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><font size=3 face="Helvetica">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></a>
<br>
<br>
<br>
<br><font size=3>-- </font>
<br><font size=3>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font><a href=http://www.efficios.com/><font size=3>http://www.efficios.com</font></a>
<br><font size=3 face="Helvetica"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><font size=3 face="Helvetica">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></a>
<br><font size=3><br>
</font>
<br>
<br><font size=3>-- </font>
<br><font size=3>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font><a href=http://www.efficios.com/><font size=3>http://www.efficios.com</font></a>
<br>
--=_alternative 00414E73C2257C5E_=--



--===============1813785311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1813785311==--
