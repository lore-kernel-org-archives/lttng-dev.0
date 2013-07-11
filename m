From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: How much shared memory is used by LTTng (UST) ?
Date: Thu, 11 Jul 2013 17:42:33 +0300
Message-ID: <OFD63CCBF2.34244BE3-ONC2257BA5.0050AB53-C2257BA5.0050BBE0__2907.8847765506$1373553820$gmane$org@il.ibm.com>
References: <1054380936.280601373553250822.JavaMail.root@srv12.zimbra.polymtl.ca>
	<234052720.280781373553343864.JavaMail.root@srv12.zimbra.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1673714567=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UxI5A-0007JH-Tn
	for lttng-dev@lists.lttng.org; Thu, 11 Jul 2013 10:42:57 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 11 Jul 2013 15:37:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A43462190059
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 15:46:41 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6BEgaW226411184
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 14:42:36 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6BEgkcP013364
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 08:42:46 -0600
In-Reply-To: <234052720.280781373553343864.JavaMail.root@srv12.zimbra.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1673714567==
Content-Type: multipart/alternative; boundary="=_alternative 0050BB6CC2257BA5_="

This is a multipart message in MIME format.
--=_alternative 0050BB6CC2257BA5_=
Content-Type: text/plain; charset="US-ASCII"

Thanks for all the answers. I've now increased out SHM area size and the 
problem disappeared.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Michel Dagenais <michel.dagenais@polymtl.ca>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     lttng-dev@lists.lttng.org, Amit Margalit/Israel/IBM@IBMIL
Date:   07/11/2013 05:35 PM
Subject:        Re: [lttng-dev] How much shared memory is used by LTTng 
(UST) ?




> > It still doesn't explain why I was able to add procname to the
> > context but adding also vpid and vtid failed when the number of cores 
was 24
> > rather than 12.
> 
> No idea. These are unrelated.

Perhaps you were not tracing that much and not filling all buffers with 
the smaller events with less context? The kernel buffers are probably 
pre-allocated for real but other buffers in user-space may not.



--=_alternative 0050BB6CC2257BA5_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks for all the answers. I've now increased
out SHM area size and the problem disappeared.</font>
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
&nbsp;</font><font size=1 face="sans-serif">Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org,
Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">07/11/2013 05:35 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
How much shared memory is used by LTTng (UST) ?</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2><br>
&gt; &gt; It still doesn't explain why I was able to add procname to the<br>
&gt; &gt; context but adding also vpid and vtid failed when the number
of cores was 24<br>
&gt; &gt; rather than 12.<br>
&gt; <br>
&gt; No idea. These are unrelated.<br>
<br>
Perhaps you were not tracing that much and not filling all buffers with
the smaller events with less context? The kernel buffers are probably pre-allocated
for real but other buffers in user-space may not.<br>
<br>
</font></tt>
<br>
--=_alternative 0050BB6CC2257BA5_=--



--===============1673714567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1673714567==--
