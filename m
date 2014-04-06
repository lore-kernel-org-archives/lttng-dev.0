From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: lttng has No session daemon is available
Date: Sun, 6 Apr 2014 15:19:32 +0300
Message-ID: <OF16EAD26D.4E40231D-ONC2257CB2.00437890-C2257CB2.0043B9FB__34186.4036432982$1396786837$gmane$org@il.ibm.com>
References: <CANudz+tqbfjeyoxb8Nr5ZjrY5KABxjOsno=BZdw_V1HF3A=STQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1227953853=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WWm3C-0007zD-Uy
 for lttng-dev@lists.lttng.org; Sun, 06 Apr 2014 08:19:53 -0400
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Sun, 6 Apr 2014 13:19:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E341E2190041
 for <lttng-dev@lists.lttng.org>; Sun,  6 Apr 2014 13:19:36 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s36CJV4m3932660
 for <lttng-dev@lists.lttng.org>; Sun, 6 Apr 2014 12:19:31 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s36CJgv4029036
 for <lttng-dev@lists.lttng.org>; Sun, 6 Apr 2014 06:19:42 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s36CJgj4029033
 for <lttng-dev@lists.lttng.org>; Sun, 6 Apr 2014 06:19:42 -0600
In-Reply-To: <CANudz+tqbfjeyoxb8Nr5ZjrY5KABxjOsno=BZdw_V1HF3A=STQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: loody <miloody@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1227953853==
Content-Type: multipart/alternative; boundary="=_alternative 0043B98BC2257CB2_="

This is a multipart message in MIME format.
--=_alternative 0043B98BC2257CB2_=
Content-Type: text/plain; charset="US-ASCII"

The sessiond take a short while to become ready.

If you are running a script, I recommend using '-d' or '-b' to 
lttng-sessiond, instead of using "&".

Then, you need to wait for it to be ready, which can be done simply by a 
short sleep, or using signals (look at --sig-parent commandline argument).

The reason you are seeing the error is that you are running lttng create 
before the sessiond is really ready.

Amit

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   loody <miloody@gmail.com>
To:     lttng-dev@lists.lttng.org
Date:   04/06/2014 03:07 PM
Subject:        [lttng-dev] lttng has No session daemon is available



hi all:
I cross compile below elements for arm successfully.
1. userspace-rcu-0.8.4
2. popt-1.16
3. lttng-ust-2.3.2
4. lttng-tools-2.3.2
5. lttng-modules-2.4.0

I follow execution steps:
1. lttng-sessiond -vvv &
2. ps (to check whether lttng-sessiond execute successfully)
3. lttng -vvv create /mtd_unirw/testsession, where "
/mtd_unirw/testsession" is rw area of my rootfs to save sessions

I met bellow messages
No session daemon is available

when I am checking the debug message when running lttng-sessiond, I
cannot find any error message.
And from ps, lttng-sessiond is running good.
(I attach my log for your reference)

did I miss any setting or should I open more debug message to find out
where I am wrong?

appreciate your kind help in advance,
[attachment "lttng.log" deleted by Amit Margalit/Israel/IBM] 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0043B98BC2257CB2_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">The sessiond take a short while to become
ready.</font>
<br>
<br><font size=2 face="sans-serif">If you are running a script, I recommend
using '-d' or '-b' to lttng-sessiond, instead of using &quot;&amp;&quot;.</font>
<br>
<br><font size=2 face="sans-serif">Then, you need to wait for it to be
ready, which can be done simply by a short sleep, or using signals (look
at --sig-parent commandline argument).</font>
<br>
<br><font size=2 face="sans-serif">The reason you are seeing the error
is that you are running lttng create before the sessiond is really ready.</font>
<br>
<br><font size=2 face="sans-serif">Amit</font>
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
&nbsp;</font><font size=1 face="sans-serif">loody &lt;miloody@gmail.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">04/06/2014 03:07 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[lttng-dev]
lttng has No session daemon is available</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>hi all:<br>
I cross compile below elements for arm successfully.<br>
1. userspace-rcu-0.8.4<br>
2. popt-1.16<br>
3. lttng-ust-2.3.2<br>
4. lttng-tools-2.3.2<br>
5. lttng-modules-2.4.0<br>
<br>
I follow execution steps:<br>
1. lttng-sessiond -vvv &amp;<br>
2. ps (to check whether lttng-sessiond execute successfully)<br>
3. lttng -vvv create /mtd_unirw/testsession, where &quot;<br>
/mtd_unirw/testsession&quot; is rw area of my rootfs to save sessions<br>
<br>
I met bellow messages<br>
No session daemon is available<br>
<br>
when I am checking the debug message when running lttng-sessiond, I<br>
cannot find any error message.<br>
And from ps, lttng-sessiond is running good.<br>
(I attach my log for your reference)<br>
<br>
did I miss any setting or should I open more debug message to find out<br>
where I am wrong?<br>
<br>
appreciate your kind help in advance,<br>
[attachment &quot;lttng.log&quot; deleted by Amit Margalit/Israel/IBM]
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0043B98BC2257CB2_=--



--===============1227953853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1227953853==--
