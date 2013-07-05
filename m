From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Question about TRACEPOINT_FORMAT
Date: Fri, 5 Jul 2013 19:17:14 +0300
Message-ID: <OF21F1828C.5DE8C30F-ONC2257B9F.0018F63F-C2257B9F.00596638__44093.4107908562$1373041096$gmane$org@il.ibm.com>
References: <OF4D6A58C0.10B26BF7-ONC2257B80.00269F6C-C2257B80.002A27FA@il.ibm.com>
	<OFD0EE71AC.5944B0C7-ONC2257B9E.0046DDB5-C2257B9E.0046E746@il.ibm.com>
	<20130704130630.GA26657@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2147199314=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Uv8hW-0006Va-4Q
	for lttng-dev@lists.lttng.org; Fri, 05 Jul 2013 12:17:38 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Fri, 5 Jul 2013 17:11:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B297B219005E
	for <lttng-dev@lists.lttng.org>; Fri,  5 Jul 2013 17:21:13 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r65GHF4b47317124
	for <lttng-dev@lists.lttng.org>; Fri, 5 Jul 2013 16:17:15 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r65GHQ7r015532
	for <lttng-dev@lists.lttng.org>; Fri, 5 Jul 2013 10:17:26 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r65GHQ9h015529
	for <lttng-dev@lists.lttng.org>; Fri, 5 Jul 2013 10:17:26 -0600
In-Reply-To: <20130704130630.GA26657@Krystal>
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
--===============2147199314==
Content-Type: multipart/alternative; boundary="=_alternative 0019341DC2257B9F_="

This is a multipart message in MIME format.
--=_alternative 0019341DC2257B9F_=
Content-Type: text/plain; charset="US-ASCII"

To me, your suggestion seems simple and elegant, but my experience in this 
area is still rather small...

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   07/04/2013 04:06 PM
Subject:        Re: [lttng-dev] Question about TRACEPOINT_FORMAT



* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hi,
> 
> I never got any response to this. Anyone care to comment?
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
> From:   Amit Margalit/Israel/IBM@IBMIL
> To:     lttng-dev@lists.lttng.org
> Date:   06/04/2013 10:41 AM
> Subject:        [lttng-dev] Question about TRACEPOINT_FORMAT
> 
> 
> 
> Hello, 
> 
> I've read the discussion in the past about this suggested feature, and 
I'd 
> like to ask what has become of this. Is this still being considered? Has 

> anyone come up with an idea for a solution that does not include 
extending 
> CTF? 
> 
> I understand that CTF doesn't support looking into the ELF binary, but 
> perhaps there is a way around this. 
> 
> First, I'd like to explain what I wish to have, so that maybe a 
different 
> solution could be suggested - 
> In all, migration from an existing log-to-file system for existing 
> projects may push the entire formatted string as the trace entry. 
> We'd like to avoid storing the entire format string multiple times, as 
> this is wasteful, of course, and we'd like the viewer to be in charge of 

> performing the formatting. 
> 
> I was wondering whether we could use CTF enums. The CTF specification 
for 
> enums doesn't say that the textual representation of the value has to be 
a 
> valid identifier. In fact, the example includes a quoted string. 
> 
> An instrumentation tool could generate code that writes an enum 
> description into the metadata, where each value corresponds to a 
different 
> format string. 

I have something quite simpler in mind for this, but it involves
extending the CTF spec. Adding, to the event {} description within the
metadata, something like:

event {
        ...
        format = "This is the first field: %u and the second: %llu";
        ...
}

Thoughts ?

Thanks,

Mathieu

> 
> Thanks, 
> 
> Amit Margalit 
> IBM XIV - Storage Reinvented 
> XIV-NAS Development Team 
> Tel. 03-689-7774 
> Fax. 03-689-7230_______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



--=_alternative 0019341DC2257B9F_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">To me, your suggestion seems simple and
elegant, but my experience in this area is still rather small...</font>
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
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">07/04/2013 04:06 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Question about TRACEPOINT_FORMAT</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>* Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I never got any response to this. Anyone care to comment?<br>
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
&gt; From: &nbsp; Amit Margalit/Israel/IBM@IBMIL<br>
&gt; To: &nbsp; &nbsp; lttng-dev@lists.lttng.org<br>
&gt; Date: &nbsp; 06/04/2013 10:41 AM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;[lttng-dev] Question about TRACEPOINT_FORMAT<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Hello, <br>
&gt; <br>
&gt; I've read the discussion in the past about this suggested feature,
and I'd <br>
&gt; like to ask what has become of this. Is this still being considered?
Has <br>
&gt; anyone come up with an idea for a solution that does not include extending
<br>
&gt; CTF? <br>
&gt; <br>
&gt; I understand that CTF doesn't support looking into the ELF binary,
but <br>
&gt; perhaps there is a way around this. <br>
&gt; <br>
&gt; First, I'd like to explain what I wish to have, so that maybe a different
<br>
&gt; solution could be suggested - <br>
&gt; In all, migration from an existing log-to-file system for existing
<br>
&gt; projects may push the entire formatted string as the trace entry.
<br>
&gt; We'd like to avoid storing the entire format string multiple times,
as <br>
&gt; this is wasteful, of course, and we'd like the viewer to be in charge
of <br>
&gt; performing the formatting. <br>
&gt; <br>
&gt; I was wondering whether we could use CTF enums. The CTF specification
for <br>
&gt; enums doesn't say that the textual representation of the value has
to be a <br>
&gt; valid identifier. In fact, the example includes a quoted string. <br>
&gt; <br>
&gt; An instrumentation tool could generate code that writes an enum <br>
&gt; description into the metadata, where each value corresponds to a different
<br>
&gt; format string. <br>
<br>
I have something quite simpler in mind for this, but it involves<br>
extending the CTF spec. Adding, to the event {} description within the<br>
metadata, something like:<br>
<br>
event {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;...<br>
 &nbsp; &nbsp; &nbsp; &nbsp;format = &quot;This is the first field: %u
and the second: %llu&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;...<br>
}<br>
<br>
Thoughts ?<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Thanks, <br>
&gt; <br>
&gt; Amit Margalit <br>
&gt; IBM XIV - Storage Reinvented <br>
&gt; XIV-NAS Development Team <br>
&gt; Tel. 03-689-7774 <br>
&gt; Fax. 03-689-7230_______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
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
--=_alternative 0019341DC2257B9F_=--



--===============2147199314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2147199314==--
