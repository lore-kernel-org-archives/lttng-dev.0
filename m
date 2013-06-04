From: Amit Margalit <AMITM@il.ibm.com>
Subject: Question about TRACEPOINT_FORMAT
Date: Tue, 4 Jun 2013 10:41:23 +0300
Message-ID: <OF4D6A58C0.10B26BF7-ONC2257B80.00269F6C-C2257B80.002A27FA__13373.4879935675$1370331752$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0704538922=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UjlsG-0006Oh-S5
	for lttng-dev@lists.lttng.org; Tue, 04 Jun 2013 03:41:45 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 4 Jun 2013 08:38:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2E4CE1B08066
	for <lttng-dev@lists.lttng.org>; Tue,  4 Jun 2013 08:41:35 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r547fOZF52297770
	for <lttng-dev@lists.lttng.org>; Tue, 4 Jun 2013 07:41:24 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r547fYtn004353
	for <lttng-dev@lists.lttng.org>; Tue, 4 Jun 2013 01:41:34 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r547fYxO004349
	for <lttng-dev@lists.lttng.org>; Tue, 4 Jun 2013 01:41:34 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0704538922==
Content-Type: multipart/alternative; boundary="=_alternative 002A27D4C2257B80_="

This is a multipart message in MIME format.
--=_alternative 002A27D4C2257B80_=
Content-Type: text/plain; charset="US-ASCII"

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
Fax. 03-689-7230
--=_alternative 002A27D4C2257B80_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I've read the discussion in the past
about this suggested feature, and I'd like to ask what has become of this.
Is this still being considered? Has anyone come up with an idea for a solution
that does not include extending CTF?</font>
<br>
<br><font size=2 face="sans-serif">I understand that CTF doesn't support
looking into the ELF binary, but perhaps there is a way around this.</font>
<br>
<br><font size=2 face="sans-serif">First, I'd like to explain what I wish
to have, so that maybe a different solution could be suggested -</font>
<br><font size=2 face="sans-serif">In all, migration from an existing log-to-file
system for existing projects may push the entire formatted string as the
trace entry.</font>
<br><font size=2 face="sans-serif">We'd like to avoid storing the entire
format string multiple times, as this is wasteful, of course, and we'd
like the viewer to be in charge of performing the formatting.</font>
<br>
<br><font size=2 face="sans-serif">I was wondering whether we could use
CTF enums. The CTF specification for enums doesn't say that the textual
representation of the value has to be a valid identifier. In fact, the
example includes a quoted string.</font>
<br>
<br><font size=2 face="sans-serif">An instrumentation tool could generate
code that writes an enum description into the metadata, where each value
corresponds to a different format string.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 002A27D4C2257B80_=--



--===============0704538922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0704538922==--
