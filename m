From: Amit Margalit <AMITM@il.ibm.com>
Subject: What is the size overhead of UST tracepoints? (hint:
	very large indeed)
Date: Tue, 29 Oct 2013 10:42:20 +0200
Message-ID: <OF98A3476E.B164A434-ONC2257C13.003269EB-C2257C13.00354EB7__10366.2249086939$1383036299$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1445720096=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Vb4uI-0005Dq-9F
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 04:44:12 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 29 Oct 2013 08:44:04 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8436817D8062
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 08:43:30 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r9T8gTgs54395086
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 08:42:29 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r9T8gXPg025250
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 04:42:33 -0400
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r9T8gXAw025245
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 04:42:33 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1445720096==
Content-Type: multipart/alternative; boundary="=_alternative 00354E7BC2257C13_="

This is a multipart message in MIME format.
--=_alternative 00354E7BC2257C13_=
Content-Type: text/plain; charset="US-ASCII"

Hello all,

Let me start with my bottom line conclusions, and then explain them:

LTTng's size overhead and start-up time overhead is huge! An application 
cannot use (directly or through linking in shared libraries with TPs) more 
than about 1000-2000 tracepoints.

I am working on incorporating LTTng as an alternative logging method for 
an existing project, which already has many thousands of places in the 
code that do logging of some data.

By many thousands, I mean > 15K.

I have basically written an automated instrumentor that generates custom 
tracepoints, for every log location plus 1 entry-tracepoints and 1 
exit-tracepoint for every function.

This totals about 100K tracepoints, with approximately 600K different 
fields, and has increased the size of the project's resulting executables 
from ~100MB to ~900MB (!!) - although this is with debug symbols.

Analysis of the reasons for this has revealed some interesting (but 
discouraging) facts:
Each tracepoint name is stored in a static buffer sized 256 bytes, 
regardless of how long the name actually is (contributing some 25MB to the 
size)
Each trace event field name is store also in a 256-byte buffer 
(contirbuting another 150MB)
Each event / tracepoint holds an event structure which holds the fields, 
etc. and is padded generously.

Additionally, there is a ton of code to calculate the event size, its 
alignment, and to verify that the names are not longer than the 256 byte 
buffer, and more.

Some of this is either used just once, or even never used, merely compiled 
to let the compiler complain if the sizes are wrong, etc.

Now this code won't be included if you compile a statically linked 
executable, but my project compiles almost everything into shared libs.

Another big big problem is the time it takes to register all of these 
tracepoints. For one of my executables which includes ~10K tracepoints, it 
took over 5 seconds just to get to "main()" due to tracepoint constructor 
code registering the tracepoints...

I've started working on an alternative method of doing the same...

Is anyone already aware of this? Is anyone already working on improving 
this? I'd be very happy to work together on this.


Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 00354E7BC2257C13_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello all,</font>
<br>
<br><font size=2 face="sans-serif">Let me start with my bottom line conclusions,
and then explain them:</font>
<br>
<br><font size=2 face="sans-serif">LTTng's size overhead and start-up time
overhead is huge! An application cannot use (directly or through linking
in shared libraries with TPs) more than about 1000-2000 tracepoints.</font>
<br>
<br><font size=2 face="sans-serif">I am working on incorporating LTTng
as an alternative logging method for an existing project, which already
has many thousands of places in the code that do logging of some data.</font>
<br>
<br><font size=2 face="sans-serif">By many thousands, I mean &gt; 15K.</font>
<br>
<br><font size=2 face="sans-serif">I have basically written an automated
instrumentor that generates custom tracepoints, for every log location
plus 1 entry-tracepoints and 1 exit-tracepoint for every function.</font>
<br>
<br><font size=2 face="sans-serif">This totals about 100K tracepoints,
with approximately 600K different fields, and has increased the size of
the project's resulting executables from ~100MB to ~900MB (!!) - although
this is with debug symbols.</font>
<br>
<br><font size=2 face="sans-serif">Analysis of the reasons for this has
revealed some interesting (but discouraging) facts:</font>
<ol>
<li value=1><font size=2 face="sans-serif">Each tracepoint name is stored
in a static buffer sized 256 bytes, regardless of how long the name actually
is (contributing some 25MB to the size)</font>
<li value=2><font size=2 face="sans-serif">Each trace event field name
is store also in a 256-byte buffer (contirbuting another 150MB)</font>
<li value=3><font size=2 face="sans-serif">Each event / tracepoint holds
an event structure which holds the fields, etc. and is padded generously.</font></ol>
<br><font size=2 face="sans-serif">Additionally, there is a ton of code
to calculate the event size, its alignment, and to verify that the names
are not longer than the 256 byte buffer, and more.</font>
<br>
<br><font size=2 face="sans-serif">Some of this is either used just once,
or even never used, merely compiled to let the compiler complain if the
sizes are wrong, etc.</font>
<br>
<br><font size=2 face="sans-serif">Now this code won't be included if you
compile a statically linked executable, but my project compiles almost
everything into shared libs.</font>
<br>
<br><font size=2 face="sans-serif">Another big big problem is the time
it takes to register all of these tracepoints. For one of my executables
which includes ~10K tracepoints, it took over 5 seconds just to get to
&quot;main()&quot; due to tracepoint constructor code registering the tracepoints...</font>
<br>
<br><font size=2 face="sans-serif">I've started working on an alternative
method of doing the same...<br>
</font>
<br><font size=2 face="sans-serif">Is anyone already aware of this? Is
anyone already working on improving this? I'd be very happy to work together
on this.</font>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 00354E7BC2257C13_=--



--===============1445720096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1445720096==--
