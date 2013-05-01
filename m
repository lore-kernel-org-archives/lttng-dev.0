From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Is there a way to make LTTng use the
 same	subbuffers for multiple processes?
Date: Wed, 1 May 2013 16:11:05 +0300
Message-ID: <OF448C7914.DF62CA9B-ONC2257B5E.004813C8-C2257B5E.00485352__17856.2015099034$1367413929$gmane$org@il.ibm.com>
References: <OFDF63FF91.58AE5030-ONC2257B5B.004BA0B5-C2257B5B.004C083C@il.ibm.com>
	<1871619348.1882721367199149384.JavaMail.root@srv11.zimbra.polymtl.ca>
	<OF8C8BE38C.B94DDD3A-ONC2257B5C.004E2988-C2257B5C.004E3D1B@il.ibm.com>
	<20130429162752.GB17859@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0225255358=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UXWoh-0007qW-7n
	for lttng-dev@lists.lttng.org; Wed, 01 May 2013 09:11:27 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 1 May 2013 14:08:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 08F8F1B0805D
	for <lttng-dev@lists.lttng.org>; Wed,  1 May 2013 14:11:18 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r41DB8eC52428814
	for <lttng-dev@lists.lttng.org>; Wed, 1 May 2013 13:11:08 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r41DBHQj025795
	for <lttng-dev@lists.lttng.org>; Wed, 1 May 2013 07:11:17 -0600
In-Reply-To: <20130429162752.GB17859@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0225255358==
Content-Type: multipart/alternative; boundary="=_alternative 004852F4C2257B5E_="

This is a multipart message in MIME format.
--=_alternative 004852F4C2257B5E_=
Content-Type: text/plain; charset="US-ASCII"

This (current) behavior you describe is very suitable for our needs.

Is there an intention to insert a hook into setuid() in the future?
If yes - will the existing behavior remain as a default and the hook be 
used only if I choose to use it?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     Michel Dagenais <michel.dagenais@polymtl.ca>, 
lttng-dev@lists.lttng.org
Date:   04/29/2013 07:27 PM
Subject:        Re: [lttng-dev] Is there a way to make LTTng use the same 
subbuffers for multiple processes?



* Amit Margalit (AMITM@il.ibm.com) wrote:
> Another 2.2 question -
> 
> What if I have a single process, that forks, and each child process then 

> changes its own UID. Will the tracing continue on the parent UID 
buffers?

Yes, we indeed currently keep the user ID that was effective at process
creation or last exec() encountered, because we don't have hooks in
libc's setuid() at the moment.

Thanks,

Mathieu

> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:   Michel Dagenais <michel.dagenais@polymtl.ca>
> To:     Amit Margalit/Israel/IBM@IBMIL
> Cc:     lttng-dev@lists.lttng.org
> Date:   04/29/2013 04:32 AM
> Subject:        Re: [lttng-dev] Is there a way to make LTTng use the 
same 
> subbuffers for multiple processes?
> 
> 
> 
> 
> > Our system is a 12-core x86 (6-core + HT). If I take 4 subbuffers of 
> 1MB, this means 4MB per
> > process. As the number of processes rises, this becomes prohibitive. 
> > For example, we may need to support > 500 sub-processes ==> 500 * 4MB 
= 
> 2GB - 
> > which is a bit too much.  Is there a way to tell LTTng to share the 
> sub-buffers with forked processes? 
> 
> This is the number one feature listed in the changelog for lttng-tools 
and 
> UST for version 2.2. The first release candidate is out so you can try 
the 
> feature, and the final 2.2 version should not be too far away.
> 
> http://lttng.org/lttng-tools-220-rc1
> - Add UST per UID buffers support
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



--=_alternative 004852F4C2257B5E_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">This (current) behavior you describe is
very suitable for our needs.</font>
<br>
<br><font size=2 face="sans-serif">Is there an intention to insert a hook
into setuid() in the future?</font>
<br><font size=2 face="sans-serif">If yes - will the existing behavior
remain as a default and the hook be used only if I choose to use it?</font>
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
&nbsp;</font><font size=1 face="sans-serif">Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Michel Dagenais &lt;michel.dagenais@polymtl.ca&gt;,
lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">04/29/2013 07:27 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Is there a way to make LTTng use the same &nbsp; &nbsp; &nbsp; &nbsp;subbuffers
for multiple processes?</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>* Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; Another 2.2 question -<br>
&gt; <br>
&gt; What if I have a single process, that forks, and each child process
then <br>
&gt; changes its own UID. Will the tracing continue on the parent UID buffers?<br>
<br>
Yes, we indeed currently keep the user ID that was effective at process<br>
creation or last exec() encountered, because we don't have hooks in<br>
libc's setuid() at the moment.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; From: &nbsp; Michel Dagenais &lt;michel.dagenais@polymtl.ca&gt;<br>
&gt; To: &nbsp; &nbsp; Amit Margalit/Israel/IBM@IBMIL<br>
&gt; Cc: &nbsp; &nbsp; lttng-dev@lists.lttng.org<br>
&gt; Date: &nbsp; 04/29/2013 04:32 AM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] Is there a way
to make LTTng use the same <br>
&gt; subbuffers for multiple processes?<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; &gt; Our system is a 12-core x86 (6-core + HT). If I take 4 subbuffers
of <br>
&gt; 1MB, this means 4MB per<br>
&gt; &gt; process. As the number of processes rises, this becomes prohibitive.
<br>
&gt; &gt; For example, we may need to support &gt; 500 sub-processes ==&gt;
500 * 4MB = <br>
&gt; 2GB - <br>
&gt; &gt; which is a bit too much. &nbsp;Is there a way to tell LTTng to
share the <br>
&gt; sub-buffers with forked processes? <br>
&gt; <br>
&gt; This is the number one feature listed in the changelog for lttng-tools
and <br>
&gt; UST for version 2.2. The first release candidate is out so you can
try the <br>
&gt; feature, and the final 2.2 version should not be too far away.<br>
&gt; <br>
&gt; </font></tt><a href="http://lttng.org/lttng-tools-220-rc1"><tt><font size=2>http://lttng.org/lttng-tools-220-rc1</font></tt></a><tt><font size=2><br>
&gt; - Add UST per UID buffers support<br>
&gt; <br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 004852F4C2257B5E_=--



--===============0225255358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0225255358==--
