From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [RFC PATCH lttng-ust] Make lttng-ust aware of
 shared	object base addresses (issue #474)
Date: Tue, 27 Aug 2013 12:53:26 +0300
Message-ID: <OF2E0D4AE6.BB12158A-ONC2257BD4.003113D1-C2257BD4.003649EE__44034.8500422717$1377597276$gmane$org@il.ibm.com>
References: <5877897.ECNuB8OFpD@atv-pwoegere-l3.atv.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1356770298=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VEFy7-0008Hu-Di
	for lttng-dev@lists.lttng.org; Tue, 27 Aug 2013 05:53:50 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 27 Aug 2013 10:48:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id BCB2217D8059
	for <lttng-dev@lists.lttng.org>; Tue, 27 Aug 2013 10:55:35 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7R9rPcT131394
	for <lttng-dev@lists.lttng.org>; Tue, 27 Aug 2013 09:53:25 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7R9raC9014319
	for <lttng-dev@lists.lttng.org>; Tue, 27 Aug 2013 03:53:37 -0600
In-Reply-To: <5877897.ECNuB8OFpD@atv-pwoegere-l3.atv.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul_Woegerer@mentor.com
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1356770298==
Content-Type: multipart/alternative; boundary="=_alternative 003648E5C2257BD4_="

This is a multipart message in MIME format.
--=_alternative 003648E5C2257BD4_=
Content-Type: text/plain; charset="US-ASCII"

Absolutely wonderful idea, IMHO.

I encountered the same problem, and partially solved it, differently. I 
think your idea complements my solution, so perhaps together we can come 
up with something even better.

There are a couple of requirements that are still hard to meet with your 
solution:
If I seek to an arbitrary position in the trace, I have no easy way to 
find which shared object the address belongs to.
If I read the trace on a different system than where it was generated, I 
may not have access to the same shared objects, so "/lib64/libc-2.17.so" 
may not be valid, or worse - may be valid but different architecture and 
therefore the symbol addresses would be different.

Solving the first problem required me to emit something that would 
identify the shared object with every tracepoint that includes a function 
pointer that needs translation.

Saving the base address of the shared object that the address belongs to 
plus the path or name of the shared object was too expensive, and didn't 
solve the second problem.

What I did was this:
Make a map of the loaded shared objects and their base addresses - called 
before anything can generate any trace
For each shared object, also keep a "signature" that uniquely identifies 
this shared object
Emit the signature and the function address (with the base address 
subtracted already)
Created a script that reads the shared objects to create a map of 
signature-to-(address-to-symbol) nested map, and post-process babeltrace 
output to provide the translation

For signature, I took the first 8 bytes of the unique build-id that GCC 
stores for every executable and shared object (SHA1) in the .note.build-id 
ELF section.

The problems with my approach are:
1. I wasn't handling dlopen/dlclose calls
2. Relying on external tools and post-processing

Combining the 2 sugestions gives a good solution - i.e. track 
dlopen/dlclose to generate the shared object maps during runtime so that 
we can emit signature+function-pointer(relative to its shared object).

Moreover, I suggest further improvement - a TP_FIELDS macro "ctf_symbol" 
that will automatically do exactly this, and store the 
signature+address-to-name mapping in the metadata...

What do you think?

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   <Paul_Woegerer@mentor.com>
To:     <lttng-dev@lists.lttng.org>, Mathieu Desnoyers 
<mathieu.desnoyers@efficios.com>
Date:   08/27/2013 09:33 AM
Subject:        [lttng-dev] [RFC PATCH lttng-ust] Make lttng-ust aware of 
shared  object base addresses (issue #474)



Hello,

To allow graphical trace viewers to provide features like 
address-to-symbol resolution or source lookup (address-to-lineinfo), 
information about the shared object base address mappings are required. 
These mappings are inherently time based and potentially change during the 
application runtime (dlopen, dlcose, dlopen, ...). It's even possible that 
at a later point in the program the same shared object gets mapped to a 
different base address (I saw that once on ARM or PPC)

The patch set below provides an initial (prof of concept) implementation 
(based on the previous discussion on https://bugs.lttng.org/issues/474). 
It's a starting point for further discussions that will hopefully help me 
to provide an implementation that is good enough for upstream inclusion.

Applying the patch provides the following additional events for userspace 
tracing:

*) ust_baddr:push with TP_ARGS(void *, baddr, const char*, sopath, 
int64_t, size, int64_t, mtime)
*) ust_baddr:pop with TP_ARGS(void *, baddr)

Tracepoints 'ust_baddr:push' and 'ust_baddr:pop' are emitted for every 
runtime object that makes use of tracing (i.e emits tracepoints/includes 
tracepoint.h). This is also true for shared objects that get loaded during 
application run time. Loading a shared object via dlopen will, for 
example, result in emitting:
[14:22:07.841547445] ust_baddr:push: { cpu_id = 4 }, { baddr = 
0x7F8D13DFD000, sopath = "/path/to/plugin1.so", size = 21968, mtime = 
1377519722 }
..likewise sometime later a corresponding dlclose in the program will 
result in emitting:
[14:22:07.841867307] ust_baddr:pop: { cpu_id = 4 }, { baddr = 
0x7F8D13DFD000 }

*) ust_baddr:init with TP_ARGS(void *, baddr, const char*, sopath, 
int64_t, size, int64_t, mtime)

In contrast, ust_baddr:init tracepoints are only emitted when a userspace 
application gets a "session enabled" sent by the sessiond (necessary if 
tracing starts in the middle of an already running application). In this 
case all the currently loaded shared objects are iterated and the base 
address mappings are recored as ust_baddr:init events with the same 
payload structure as ust_baddr:push. E.g.

[15:20:32.763114409]  ust_baddr:init: { cpu_id = 1 }, { baddr = 
0x7F5BAC083000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 
1359709982 }
[15:20:32.763118346]  ust_baddr:init: { cpu_id = 1 }, { baddr = 
0x7F5BAEAF0000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 
1359709980 }
[15:20:32.763125921]  ust_baddr:init: { cpu_id = 1 }, { baddr = 
0x7F5BAAE7C000, sopath = "/other/currently/loaded/shared-object.so.0.0.0", 
size = 58359, mtime = 1377516019 }
... and so on for all other currently loaded shared objects

The known deficiencies of the current implementation are:

Non-optional 'ust_baddr:push' and 'ust_baddr:pop' events 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=_alternative 003648E5C2257BD4_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Absolutely wonderful idea, IMHO.</font>
<br>
<br><font size=2 face="sans-serif">I encountered the same problem, and
partially solved it, differently. I think your idea complements my solution,
so perhaps together we can come up with something even better.</font>
<br>
<br><font size=2 face="sans-serif">There are a couple of requirements that
are still hard to meet with your solution:</font>
<ol>
<li value=1><font size=2 face="sans-serif">If I seek to an arbitrary position
in the trace, I have no easy way to find which shared object the address
belongs to.</font>
<li value=2><font size=2 face="sans-serif">If I read the trace on a different
system than where it was generated, I may not have access to the same shared
objects, so &quot;</font><tt><font size=2>/lib64/libc-2.17.so</font></tt><font size=2 face="sans-serif">&quot;
may not be valid, or worse - may be valid but different architecture and
therefore the symbol addresses would be different.</font></ol>
<br><font size=2 face="sans-serif">Solving the first problem required me
to emit something that would identify the shared object with every tracepoint
that includes a function pointer that needs translation.</font>
<br>
<br><font size=2 face="sans-serif">Saving the base address of the shared
object that the address belongs to plus the path or name of the shared
object was too expensive, and didn't solve the second problem.</font>
<br>
<br><font size=2 face="sans-serif">What I did was this:</font>
<ul>
<li><font size=2 face="sans-serif">Make a map of the loaded shared objects
and their base addresses - called before anything can generate any trace</font>
<li><font size=2 face="sans-serif">For each shared object, also keep a
&quot;signature&quot; that uniquely identifies this shared object</font>
<li><font size=2 face="sans-serif">Emit the signature and the function
address (with the base address subtracted already)</font>
<li><font size=2 face="sans-serif">Created a script that reads the shared
objects to create a map of signature-to-(address-to-symbol) nested map,
and post-process babeltrace output to provide the translation</font></ul>
<br><font size=2 face="sans-serif">For signature, I took the first 8 bytes
of the unique build-id that GCC stores for every executable and shared
object (SHA1) in the .note.build-id ELF section.</font>
<br>
<br><font size=2 face="sans-serif">The problems with my approach are:</font>
<br><font size=2 face="sans-serif">1. I wasn't handling dlopen/dlclose
calls</font>
<br><font size=2 face="sans-serif">2. Relying on external tools and post-processing</font>
<br>
<br><font size=2 face="sans-serif">Combining the 2 sugestions gives a good
solution - i.e. track dlopen/dlclose to generate the shared object maps
during runtime so that we can emit signature+function-pointer(relative
to its shared object).</font>
<br>
<br><font size=2 face="sans-serif">Moreover, I suggest further improvement
- a TP_FIELDS macro &quot;ctf_symbol&quot; that will automatically do exactly
this, and store the signature+address-to-name mapping in the metadata...</font>
<br>
<br><font size=2 face="sans-serif">What do you think?</font>
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
&nbsp;</font><font size=1 face="sans-serif">&lt;Paul_Woegerer@mentor.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">&lt;lttng-dev@lists.lttng.org&gt;,
Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">08/27/2013 09:33 AM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[lttng-dev]
[RFC PATCH lttng-ust] Make lttng-ust aware of shared &nbsp; &nbsp; &nbsp;
&nbsp;object base addresses (issue #474)</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hello,<br>
<br>
To allow graphical trace viewers to provide features like address-to-symbol
resolution or source lookup (address-to-lineinfo), information about the
shared object base address mappings are required. These mappings are inherently
time based and potentially change during the application runtime (dlopen,
dlcose, dlopen, ...). It's even possible that at a later point in the program
the same shared object gets mapped to a different base address (I saw that
once on ARM or PPC)<br>
<br>
The patch set below provides an initial (prof of concept) implementation
(based on the previous discussion on </font></tt><a href=https://bugs.lttng.org/issues/474><tt><font size=2>https://bugs.lttng.org/issues/474</font></tt></a><tt><font size=2>).
It's a starting point for further discussions that will hopefully help
me to provide an implementation that is good enough for upstream inclusion.<br>
<br>
Applying the patch provides the following additional events for userspace
tracing:<br>
<br>
*) ust_baddr:push with TP_ARGS(void *, baddr, const char*, sopath, int64_t,
size, int64_t, mtime)<br>
*) ust_baddr:pop with TP_ARGS(void *, baddr)<br>
<br>
Tracepoints 'ust_baddr:push' and 'ust_baddr:pop' are emitted for every
runtime object that makes use of tracing (i.e emits tracepoints/includes
tracepoint.h). This is also true for shared objects that get loaded during
application run time. Loading a shared object via dlopen will, for example,
result in emitting:<br>
[14:22:07.841547445] ust_baddr:push: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000,
sopath = &quot;/path/to/plugin1.so&quot;, size = 21968, mtime = 1377519722
}<br>
..likewise sometime later a corresponding dlclose in the program will result
in emitting:<br>
[14:22:07.841867307] ust_baddr:pop: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000
}<br>
<br>
*) ust_baddr:init with TP_ARGS(void *, baddr, const char*, sopath, int64_t,
size, int64_t, mtime)<br>
<br>
In contrast, ust_baddr:init tracepoints are only emitted when a userspace
application gets a &quot;session enabled&quot; sent by the sessiond (necessary
if tracing starts in the middle of an already running application). In
this case all the currently loaded shared objects are iterated and the
base address mappings are recored as ust_baddr:init events with the same
payload structure as ust_baddr:push. E.g.<br>
<br>
[15:20:32.763114409] &nbsp;ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAC083000,
sopath = &quot;/lib64/libc-2.17.so&quot;, size = 1992089, mtime = 1359709982
}<br>
[15:20:32.763118346] &nbsp;ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAEAF0000,
sopath = &quot;/lib64/ld-2.17.so&quot;, size = 163493, mtime = 1359709980
}<br>
[15:20:32.763125921] &nbsp;ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAAE7C000,
sopath = &quot;/other/currently/loaded/shared-object.so.0.0.0&quot;, size
= 58359, mtime = 1377516019 }<br>
... and so on for all other currently loaded shared objects<br>
<br>
The known deficiencies of the current implementation are:<br>
<br>
Non-optional 'ust_baddr:push' and 'ust_baddr:pop' events <br>
<br>
<br>
-- <br>
Paul Woegerer, SW Development Engineer<br>
Sourcery Analyzer &lt;</font></tt><a href=http://go.mentor.com/sourceryanalyzer><tt><font size=2>http://go.mentor.com/sourceryanalyzer</font></tt></a><tt><font size=2>&gt;<br>
Mentor Graphics, Embedded Software Division<br>
<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 003648E5C2257BD4_=--



--===============1356770298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1356770298==--
