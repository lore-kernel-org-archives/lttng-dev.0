From: Amit Margalit <AMITM@il.ibm.com>
Subject: Problem running lttng enable-channel shortly after
	lttng create
Date: Wed, 2 Apr 2014 13:56:39 +0300
Message-ID: <OFBB2685C6.309D33C4-ONC2257CAE.0034A252-C2257CAE.003C2323__30228.7927050658$1396517015$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1585208159=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WVIqq-0007UY-Bm
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 06:57:01 -0400
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Wed, 2 Apr 2014 11:56:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 046021B08066
 for <lttng-dev@lists.lttng.org>; Wed,  2 Apr 2014 11:56:48 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s32AueXB327970
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 10:56:40 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s32AupKT008953
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 04:56:51 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s32Auo8C008934
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 04:56:50 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1585208159==
Content-Type: multipart/alternative; boundary="=_alternative 003C22D9C2257CAE_="

This is a multipart message in MIME format.
--=_alternative 003C22D9C2257CAE_=
Content-Type: text/plain; charset="US-ASCII"

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
Fax. 03-689-7230
--=_alternative 003C22D9C2257CAE_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I keep getting the following error from
lttng enable-channel:</font>
<br>
<br><tt><font size=2>libust[2984/2986]: Error: Timed out waiting for lttng-sessiond
(in lttng_ust_init() at lttng-ust-comm.c:1444)</font></tt>
<br>
<br><font size=2 face="sans-serif">The scenario is quite simple - during
boot of the system, we create a session, enable a channel, etc., like this:</font>
<br>
<br><tt><font size=2># /usr/bin/lttng-sessiond --no-kernel -b</font></tt>
<br><tt><font size=2>Warning: No tracing group detected</font></tt>
<br><tt><font size=2># /usr/bin/lttng create nextra -o /local/traces/lttng/20140402123725</font></tt>
<br><tt><font size=2>Session nextra created.</font></tt>
<br><tt><font size=2>Traces will be written in /local/traces/lttng/20140402123725</font></tt>
<br><tt><font size=2># /usr/bin/lttng enable-channel channel0 -u --tracefile-size
67108864 --tracefile-count 40 --buffers-uid --switch-timer 1000000 --num-subbuf
16 --subbuf-size 262144</font></tt>
<br><tt><font size=2>libust[2984/2986]: Error: Timed out waiting for lttng-sessiond
(in lttng_ust_init() at lttng-ust-comm.c:1444)</font></tt>
<br><tt><font size=2>Warning: No tracing group detected</font></tt>
<br>
<br><font size=2 face="sans-serif">The PID </font><tt><font size=2>2984</font></tt><font size=2 face="sans-serif">
belongs to the lttng-consumerd. At that point in time I see the following
in syslog:</font>
<br>
<br><font size=2 face="sans-serif">2014/04/02 12:38:03.370576 kernel &nbsp;
error &nbsp; &nbsp;nextra-6663235-module-1 &nbsp;[ &nbsp; 56.376155] proc
lttng-sessiond with pid 632 goes to delayed retry in epoll_wait(): start
jiffies 4294904844, stop jiffies=4294906390 (+1546), expected final stop
jiffies=9223372041149680651 (+9223372036854775807), next stop jiffies=9223372041149682197
(+9223372036854775807)</font>
<br><font size=2 face="sans-serif">2014/04/02 12:38:03.399245 kernel &nbsp;
error &nbsp; &nbsp;nextra-6663235-module-1 &nbsp;[ &nbsp; 56.405166] proc
lttng-sessiond with pid 632 goes to delayed retry in epoll_wait(): start
jiffies 4294904844, stop jiffies=4294906397 (+1553), expected final stop
jiffies=9223372041149680651 (+9223372036854775807), next stop jiffies=9223372041149682204
(+9223372036854775807)</font>
<br><font size=2 face="sans-serif">2014/04/02 12:38:03.405700 kernel &nbsp;
error &nbsp; &nbsp;nextra-6663235-module-1 &nbsp;[ &nbsp; 56.411791] proc
lttng-sessiond with pid 632 goes to delayed retry in epoll_wait(): start
jiffies 4294904844, stop jiffies=4294906398 (+1554), expected final stop
jiffies=9223372041149680651 (+9223372036854775807), next stop jiffies=9223372041149682205
(+9223372036854775807)</font>
<br>
<br><font size=2 face="sans-serif">And finally, the command succeeds:</font>
<br>
<br><tt><font size=2>UST channel channel0 enabled for session nextra</font></tt>
<br>
<br><font size=2 face="sans-serif">My guess is that the boot sequence is
loading some traced application before the channel is enabled, and the
consumerd is started, which under heavy system load (exists during initial
boot time) times out waiting for the sessiond. If that was the case, I
could try to increase the timeout time, but that also delays my booting,
which I cannot afford to do.</font>
<br>
<br><font size=2 face="sans-serif">Suggestions?</font>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 003C22D9C2257CAE_=--



--===============1585208159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1585208159==--
