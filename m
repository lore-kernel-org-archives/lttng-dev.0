From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Problem running lttng enable-channel shortly
 after	lttng create
Date: Thu, 3 Apr 2014 15:10:19 +0300
Message-ID: <OFF13A0F4F.5B371440-ONC2257CAF.0042DEFC-C2257CAF.0042E1CD__45169.820104684$1396532720$gmane$org@il.ibm.com>
References: <OFBB2685C6.309D33C4-ONC2257CAE.0034A252-C2257CAE.003C2323@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1909669122=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WVgTg-0008TF-GP
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 08:10:42 -0400
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Thu, 3 Apr 2014 13:10:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1083917D8047
 for <lttng-dev@lists.lttng.org>; Thu,  3 Apr 2014 13:11:21 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s33CAJuU64618724
 for <lttng-dev@lists.lttng.org>; Thu, 3 Apr 2014 12:10:19 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s33DAVFn000759
 for <lttng-dev@lists.lttng.org>; Thu, 3 Apr 2014 07:10:31 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s33DAVYT000756
 for <lttng-dev@lists.lttng.org>; Thu, 3 Apr 2014 07:10:31 -0600
In-Reply-To: <OFBB2685C6.309D33C4-ONC2257CAE.0034A252-C2257CAE.003C2323@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1909669122==
Content-Type: multipart/alternative; boundary="=_alternative 0042E182C2257CAF_="

This is a multipart message in MIME format.
--=_alternative 0042E182C2257CAF_=
Content-Type: text/plain; charset="US-ASCII"

Bump...

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Amit Margalit/Israel/IBM@IBMIL
To:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   04/02/2014 01:57 PM
Subject:        [lttng-dev] Problem running lttng enable-channel shortly 
after   lttng create



Hello, 

I keep getting the following error from lttng enable-channel: 

libust[2984/2986]: Error: Timed out waiting for lttng-sessiond (in 
lttng_ust_init() at lttng-ust-comm.c:1444) 

The scenario is quite simple - during boot of the system, we create a 
session, enable a channel, etc., like this: 

# /usr/bin/lttng-sessiond --no-kernel -b 
Warning: No tracing group detected 
# /usr/bin/lttng create nextra -o /local/traces/lttng/20140402123725 
Session nextra created. 
Traces will be written in /local/traces/lttng/20140402123725 
# /usr/bin/lttng enable-channel channel0 -u --tracefile-size 67108864 
--tracefile-count 40 --buffers-uid --switch-timer 1000000 --num-subbuf 16 
--subbuf-size 262144 
libust[2984/2986]: Error: Timed out waiting for lttng-sessiond (in 
lttng_ust_init() at lttng-ust-comm.c:1444) 
Warning: No tracing group detected 

The PID 2984 belongs to the lttng-consumerd. At that point in time I see 
the following in syslog: 

2014/04/02 12:38:03.370576 kernel   error    nextra-6663235-module-1  [ 
56.376155] proc lttng-sessiond with pid 632 goes to delayed retry in 
epoll_wait(): start jiffies 4294904844, stop jiffies=4294906390 (+1546), 
expected final stop jiffies=9223372041149680651 (+9223372036854775807), 
next stop jiffies=9223372041149682197 (+9223372036854775807) 
2014/04/02 12:38:03.399245 kernel   error    nextra-6663235-module-1  [ 
56.405166] proc lttng-sessiond with pid 632 goes to delayed retry in 
epoll_wait(): start jiffies 4294904844, stop jiffies=4294906397 (+1553), 
expected final stop jiffies=9223372041149680651 (+9223372036854775807), 
next stop jiffies=9223372041149682204 (+9223372036854775807) 
2014/04/02 12:38:03.405700 kernel   error    nextra-6663235-module-1  [ 
56.411791] proc lttng-sessiond with pid 632 goes to delayed retry in 
epoll_wait(): start jiffies 4294904844, stop jiffies=4294906398 (+1554), 
expected final stop jiffies=9223372041149680651 (+9223372036854775807), 
next stop jiffies=9223372041149682205 (+9223372036854775807) 

And finally, the command succeeds: 

UST channel channel0 enabled for session nextra 

My guess is that the boot sequence is loading some traced application 
before the channel is enabled, and the consumerd is started, which under 
heavy system load (exists during initial boot time) times out waiting for 
the sessiond. If that was the case, I could try to increase the timeout 
time, but that also delays my booting, which I cannot afford to do. 

Suggestions? 


Amit Margalit 
IBM XIV - Storage Reinvented 
XIV-NAS Development Team 
Tel. 03-689-7774 
Fax. 03-689-7230_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0042E182C2257CAF_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Bump...</font>
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
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">04/02/2014 01:57 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[lttng-dev]
Problem running lttng enable-channel shortly after &nbsp; &nbsp; &nbsp;
&nbsp;lttng create</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=2 face="sans-serif">Hello,</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
I keep getting the following error from lttng enable-channel:</font><font size=3>
<br>
</font><tt><font size=2><br>
libust[2984/2986]: Error: Timed out waiting for lttng-sessiond (in lttng_ust_init()
at lttng-ust-comm.c:1444)</font></tt><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
The scenario is quite simple - during boot of the system, we create a session,
enable a channel, etc., like this:</font><font size=3> <br>
</font><tt><font size=2><br>
# /usr/bin/lttng-sessiond --no-kernel -b</font></tt><font size=3> </font><tt><font size=2><br>
Warning: No tracing group detected</font></tt><font size=3> </font><tt><font size=2><br>
# /usr/bin/lttng create nextra -o /local/traces/lttng/20140402123725</font></tt><font size=3>
</font><tt><font size=2><br>
Session nextra created.</font></tt><font size=3> </font><tt><font size=2><br>
Traces will be written in /local/traces/lttng/20140402123725</font></tt><font size=3>
</font><tt><font size=2><br>
# /usr/bin/lttng enable-channel channel0 -u --tracefile-size 67108864 --tracefile-count
40 --buffers-uid --switch-timer 1000000 --num-subbuf 16 --subbuf-size 262144</font></tt><font size=3>
</font><tt><font size=2><br>
libust[2984/2986]: Error: Timed out waiting for lttng-sessiond (in lttng_ust_init()
at lttng-ust-comm.c:1444)</font></tt><font size=3> </font><tt><font size=2><br>
Warning: No tracing group detected</font></tt><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
The PID </font><tt><font size=2>2984</font></tt><font size=2 face="sans-serif">
belongs to the lttng-consumerd. At that point in time I see the following
in syslog:</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
2014/04/02 12:38:03.370576 kernel &nbsp; error &nbsp; &nbsp;nextra-6663235-module-1
&nbsp;[ &nbsp; 56.376155] proc lttng-sessiond with pid 632 goes to delayed
retry in epoll_wait(): start jiffies 4294904844, stop jiffies=4294906390
(+1546), expected final stop jiffies=9223372041149680651 (+9223372036854775807),
next stop jiffies=9223372041149682197 (+9223372036854775807)</font><font size=3>
</font><font size=2 face="sans-serif"><br>
2014/04/02 12:38:03.399245 kernel &nbsp; error &nbsp; &nbsp;nextra-6663235-module-1
&nbsp;[ &nbsp; 56.405166] proc lttng-sessiond with pid 632 goes to delayed
retry in epoll_wait(): start jiffies 4294904844, stop jiffies=4294906397
(+1553), expected final stop jiffies=9223372041149680651 (+9223372036854775807),
next stop jiffies=9223372041149682204 (+9223372036854775807)</font><font size=3>
</font><font size=2 face="sans-serif"><br>
2014/04/02 12:38:03.405700 kernel &nbsp; error &nbsp; &nbsp;nextra-6663235-module-1
&nbsp;[ &nbsp; 56.411791] proc lttng-sessiond with pid 632 goes to delayed
retry in epoll_wait(): start jiffies 4294904844, stop jiffies=4294906398
(+1554), expected final stop jiffies=9223372041149680651 (+9223372036854775807),
next stop jiffies=9223372041149682205 (+9223372036854775807)</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
And finally, the command succeeds:</font><font size=3> <br>
</font><tt><font size=2><br>
UST channel channel0 enabled for session nextra</font></tt><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
My guess is that the boot sequence is loading some traced application before
the channel is enabled, and the consumerd is started, which under heavy
system load (exists during initial boot time) times out waiting for the
sessiond. If that was the case, I could try to increase the timeout time,
but that also delays my booting, which I cannot afford to do.</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
Suggestions?</font><font size=3> <br>
<br>
</font><font size=2 color=#000080 face="sans-serif"><br>
Amit Margalit</font><font size=3> </font><font size=2 color=#808000 face="sans-serif"><br>
IBM XIV </font><font size=2 face="sans-serif">- <i>Storage Reinvented</i></font><font size=3>
</font><font size=2 face="sans-serif"><br>
XIV-NAS Development Team</font><font size=3> </font><font size=2 face="sans-serif"><br>
Tel. 03</font><font size=2 face="Arial">-689-7774</font><font size=3> </font><font size=2 face="Arial"><br>
Fax. 03-689-7230</font><tt><font size=2>_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0042E182C2257CAF_=--



--===============1909669122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1909669122==--
