From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Question about TRACEPOINT_FORMAT
Date: Thu, 4 Jul 2013 15:55:13 +0300
Message-ID: <OFD0EE71AC.5944B0C7-ONC2257B9E.0046DDB5-C2257B9E.0046E746__13674.7032440782$1372942568$gmane$org@il.ibm.com>
References: <OF4D6A58C0.10B26BF7-ONC2257B80.00269F6C-C2257B80.002A27FA@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1637340629=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Uuj4Q-00015H-Di
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 08:55:34 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 4 Jul 2013 13:52:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 86CAC17D8025
	for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2013 13:56:57 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r64CtED749086582
	for <lttng-dev@lists.lttng.org>; Thu, 4 Jul 2013 12:55:14 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r64CtPdE031759
	for <lttng-dev@lists.lttng.org>; Thu, 4 Jul 2013 06:55:25 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r64CtPFs031751
	for <lttng-dev@lists.lttng.org>; Thu, 4 Jul 2013 06:55:25 -0600
In-Reply-To: <OF4D6A58C0.10B26BF7-ONC2257B80.00269F6C-C2257B80.002A27FA@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1637340629==
Content-Type: multipart/alternative; boundary="=_alternative 0046E70FC2257B9E_="

This is a multipart message in MIME format.
--=_alternative 0046E70FC2257B9E_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I never got any response to this. Anyone care to comment?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Amit Margalit/Israel/IBM@IBMIL
To:     lttng-dev@lists.lttng.org
Date:   06/04/2013 10:41 AM
Subject:        [lttng-dev] Question about TRACEPOINT_FORMAT



Hello, 

I've read the discussion in the past about this suggested feature, and I'd 
like to ask what has become of this. Is this still being considered? Has 
anyone come up with an idea for a solution that does not include extending 
CTF? 

I understand that CTF doesn't support looking into the ELF binary, but 
perhaps there is a way around this. 

First, I'd like to explain what I wish to have, so that maybe a different 
solution could be suggested - 
In all, migration from an existing log-to-file system for existing 
projects may push the entire formatted string as the trace entry. 
We'd like to avoid storing the entire format string multiple times, as 
this is wasteful, of course, and we'd like the viewer to be in charge of 
performing the formatting. 

I was wondering whether we could use CTF enums. The CTF specification for 
enums doesn't say that the textual representation of the value has to be a 
valid identifier. In fact, the example includes a quoted string. 

An instrumentation tool could generate code that writes an enum 
description into the metadata, where each value corresponds to a different 
format string. 

Thanks, 

Amit Margalit 
IBM XIV - Storage Reinvented 
XIV-NAS Development Team 
Tel. 03-689-7774 
Fax. 03-689-7230_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0046E70FC2257B9E_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I never got any response to this. Anyone
care to comment?</font>
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
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/04/2013 10:41 AM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[lttng-dev]
Question about TRACEPOINT_FORMAT</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=2 face="sans-serif">Hello,</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
I've read the discussion in the past about this suggested feature, and
I'd like to ask what has become of this. Is this still being considered?
Has anyone come up with an idea for a solution that does not include extending
CTF?</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
I understand that CTF doesn't support looking into the ELF binary, but
perhaps there is a way around this.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
First, I'd like to explain what I wish to have, so that maybe a different
solution could be suggested -</font><font size=3> </font><font size=2 face="sans-serif"><br>
In all, migration from an existing log-to-file system for existing projects
may push the entire formatted string as the trace entry.</font><font size=3>
</font><font size=2 face="sans-serif"><br>
We'd like to avoid storing the entire format string multiple times, as
this is wasteful, of course, and we'd like the viewer to be in charge of
performing the formatting.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
I was wondering whether we could use CTF enums. The CTF specification for
enums doesn't say that the textual representation of the value has to be
a valid identifier. In fact, the example includes a quoted string.</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
An instrumentation tool could generate code that writes an enum description
into the metadata, where each value corresponds to a different format string.</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
Thanks,</font><font size=3> <br>
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
--=_alternative 0046E70FC2257B9E_=--



--===============1637340629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1637340629==--
