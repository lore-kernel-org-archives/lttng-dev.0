From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Is there a way to make LTTng use the same
 subbuffers for multiple processes?
Date: Mon, 29 Apr 2013 17:15:40 +0300
Message-ID: <OF8C8BE38C.B94DDD3A-ONC2257B5C.004E2988-C2257B5C.004E3D1B__45319.4432695911$1367244986$gmane$org@il.ibm.com>
References: <OFDF63FF91.58AE5030-ONC2257B5B.004BA0B5-C2257B5B.004C083C@il.ibm.com>
	<1871619348.1882721367199149384.JavaMail.root@srv11.zimbra.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1262374453=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UWos7-0003JO-IV
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 10:16:03 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 29 Apr 2013 15:12:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D70062190061
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 15:18:23 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r3TEFi0C47710260
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 14:15:44 GMT
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id r3TEFrlr016811
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 08:15:53 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with
	ESMTP id r3TEFq8n016723
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 08:15:52 -0600
In-Reply-To: <1871619348.1882721367199149384.JavaMail.root@srv11.zimbra.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1262374453==
Content-Type: multipart/alternative; boundary="=_alternative 004E3CCFC2257B5C_="

This is a multipart message in MIME format.
--=_alternative 004E3CCFC2257B5C_=
Content-Type: text/plain; charset="US-ASCII"

Another 2.2 question -

What if I have a single process, that forks, and each child process then 
changes its own UID. Will the tracing continue on the parent UID buffers?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Michel Dagenais <michel.dagenais@polymtl.ca>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   04/29/2013 04:32 AM
Subject:        Re: [lttng-dev] Is there a way to make LTTng use the same 
subbuffers for multiple processes?




> Our system is a 12-core x86 (6-core + HT). If I take 4 subbuffers of 
1MB, this means 4MB per
> process. As the number of processes rises, this becomes prohibitive. 
> For example, we may need to support > 500 sub-processes ==> 500 * 4MB = 
2GB - 
> which is a bit too much.  Is there a way to tell LTTng to share the 
sub-buffers with forked processes? 

This is the number one feature listed in the changelog for lttng-tools and 
UST for version 2.2. The first release candidate is out so you can try the 
feature, and the final 2.2 version should not be too far away.

http://lttng.org/lttng-tools-220-rc1
- Add UST per UID buffers support


--=_alternative 004E3CCFC2257B5C_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Another 2.2 question -</font>
<br>
<br><font size=2 face="sans-serif">What if I have a single process, that
forks, and each child process then changes its own UID. Will the tracing
continue on the parent UID buffers?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
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
&nbsp;</font><font size=1 face="sans-serif">Michel Dagenais &lt;michel.dagenais@polymtl.ca&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">04/29/2013 04:32 AM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Is there a way to make LTTng use the same subbuffers for multiple processes?</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3><br>
&gt; </font><font size=2 face="sans-serif">Our system is a 12-core x86
(6-core + HT). If I take 4 subbuffers of 1MB, this means 4MB per<br>
&gt; process. As the number of processes rises, this becomes prohibitive.</font><font size=3>
&nbsp;<br>
&gt; </font><font size=2 face="sans-serif">For example, we may need to
support &gt; 500 sub-processes ==&gt; 500 * 4MB = 2GB - <br>
&gt; which is a bit too much.</font><font size=3> &nbsp;</font><font size=2 face="sans-serif">Is
there a way to tell LTTng to share the sub-buffers with forked processes?</font><font size=3>
<br>
<br>
This is the number one feature listed in the changelog for lttng-tools
and UST for version 2.2. The first release candidate is out so you can
try the feature, and the final 2.2 version should not be too far away.<br>
<br>
</font><a href="http://lttng.org/lttng-tools-220-rc1"><font size=3>http://lttng.org/lttng-tools-220-rc1</font></a><font size=3><br>
- Add UST per UID buffers support<br>
</font>
<br>
--=_alternative 004E3CCFC2257B5C_=--



--===============1262374453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1262374453==--
