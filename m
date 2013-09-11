From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Getting function names with	lttng-ust-cyg-profile.so
Date: Wed, 11 Sep 2013 16:30:04 +0200
Message-ID: <OFC3A1E1D4.1FA9A997-ONC2257BE3.004DF99B-C2257BE3.004FA103__29423.3982022435$1378909916$gmane$org@il.ibm.com>
References: <522E4FCE.7070000@voxpopuli.im>
	<20130909234409.GA11082@Krystal>	<522EC38B.6000501@mentor.com>
	<522F3CC1.5060005@ericsson.com> <522F3E95.7000203@mentor.com>
	<OFD1B4818C.1C2E4DBC-ONC2257BE3.002FD513-C2257BE3.00328DCA@il.ibm.com>
	<523060FD.9020504@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0547907194=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VJlRH-0007Sv-IC
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 10:30:49 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 11 Sep 2013 15:24:23 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 117762190074
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 15:30:25 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r8BEU7tj66846876
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 14:30:08 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r8BEUJGj030208
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 08:30:19 -0600
In-Reply-To: <523060FD.9020504@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0547907194==
Content-Type: multipart/alternative; boundary="=_alternative 004FA0ACC2257BE3_="

This is a multipart message in MIME format.
--=_alternative 004FA0ACC2257BE3_=
Content-Type: text/plain; charset="ISO-2022-JP"

This kind of a solution is viable.

Here are the concerns we still need to hammer out for this -
Seeking to an arbitrary time means that our events (P frames by analogy) 
need to point to the full shared object state dump (the I-frame) somehow.
In video compression, the decoder (trace viewer in our analogy) is assumed 
to be receiving the stream sequentially and therefore keeps a copy of N 
previous frames (and the last I-frame).
Perhaps in CTF we can circumvent this problem by storing a field in one of 
the context headers that will allow us to quickly seek to the trace 
position where the full state dump is stored.
Emitting such a large set of events could happen at the same time that the 
system tries to emit high rate of events, which could cause loss of 
events.
While loss of events is something we have to consider "possible", I don't 
like to add to the chances of this happening.

The reason I think putting this in the metadata is preferable is that this 
keeps things (IMHO) more in the spirit of the CTF format - 
=> The trace files are self-contained, the metadata is in the metadata 
stream, and in my humble opinion, the symbolic name of a function is 
metadata.
=> The writing of pure application events / tracepoints is not burdened by 
writing some overhead (albeit an important kind of overhead).
=> The viewers retain the same type of simplicity that already exists.

This is why I really liked Matthew Khouzam's concept of writing the 
symbols in the metadata with validity start-time.

Amit

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   "Woegerer, Paul" <Paul_Woegerer@mentor.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers 
<mathieu.desnoyers@efficios.com>, Matthew Khouzam 
<matthew.khouzam@ericsson.com>
Date:   09/11/2013 03:24 PM
Subject:        Re: [lttng-dev] Getting function names with 
lttng-ust-cyg-profile.so



On 09/11/2013 11:12 AM, Amit Margalit wrote:
I agree with Paul, that no redundant data gets replicated with his 
approach, and my only concern is that this approach really forces a viewer 
to be sequential. 

Maybe "forces" is too strong a word - but a viewer than wants to let you 
"roam" the trace freely will have to read the entire trace to figure out 
the mapping between address and symbol at each point in time. 

At this time, we keep 10GB worth of LTTng traces in our system, but future 
models will certainly use more. A user asking to go to the end of the 
trace will have to wait until the entire trace is read in order to see 
correct translations. 

We could provide a solution to this problem with my approach by emitting 
an update of the shared object state info every n x K events 
(configurable).

Assuming we have a 10GB trace data set, we could emit a full shared object 
state dump after every 100K events of regular trace data (with the same 
baddr_init events we emit at session_start time). By doing so you don't 
need to start reading the entire trace from the beginning. Just start 
reading 100K events before the events you are interested in, and you can 
guarantee to find a "key frame" for shared object state info.

Note that this is the same concept as used by video compression/streaming:
I?frame, P?frame, P?frame, P?frame, ..., I?frame, P?frame, P?frame, 
P?frame, ...
See: http://en.wikipedia.org/wiki/Video_compression_picture_types

Best,
Paul


I have a different solution, which I think I have explained here before: 
http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html 

I vote for adding this to the metadata. It can be in addition to the 
ust_baddr events suggeted by Paul. 

Amit 

Amit Margalit 
IBM XIV - Storage Reinvented 
XIV-NAS Development Team 
Tel. 03-689-7774 
Fax. 03-689-7230 



From:        "Woegerer, Paul" <Paul_Woegerer@mentor.com> 
To:        Matthew Khouzam <matthew.khouzam@ericsson.com> 
Cc:        lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers 
<mathieu.desnoyers@efficios.com> 
Date:        09/10/2013 06:47 PM 
Subject:        Re: [lttng-dev] Getting function names with 
lttng-ust-cyg-profile.so 



On 09/10/2013 05:37 PM, Matthew Khouzam wrote:
> On 13-09-10 03:00 AM, Woegerer, Paul wrote:
>> Hi Alexandre,
>>
>> For trivial examples you can go with 'nm -CS' (or the like), but when
>> you start to use liblttng-ust-cyg-profile.so in combination with shared
>> objects you will need to record base address information as well (to
>> allow you map a virtual memory address at a given point in time to
>> offset and path of a shared object (or executable)).
>>
>> That is one of the reasons why I have submitted:
>> http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html
> This is a very interesting approach, +1 from me on that.

Thanks.

With that approach no redundant data (that is already available as
debuginfo) gets replicated in the actual trace data.
Only the bare minimum of information gets traced to allow you at any
time to map a VM address to a debuginfo address + debuginfo location.

-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev




-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division

--=_alternative 004FA0ACC2257BE3_=
Content-Type: text/html; charset="ISO-2022-JP"

<font size=2 face="sans-serif">This kind of a solution is viable.</font>
<br>
<br><font size=2 face="sans-serif">Here are the concerns we still need
to hammer out for this -</font>
<ul>
<li><font size=2 face="sans-serif">Seeking to an arbitrary time means that
our events (P frames by analogy) need to point to the full shared object
state dump (the I-frame) somehow.</font>
<ul>
<li><font size=2 face="sans-serif">In video compression, the decoder (trace
viewer in our analogy) is assumed to be receiving the stream sequentially
and therefore keeps a copy of N previous frames (and the last I-frame).</font>
<li><font size=2 face="sans-serif">Perhaps in CTF we can circumvent this
problem by storing a field in one of the context headers that will allow
us to quickly seek to the trace position where the full state dump is stored.</font></ul>
<li><font size=2 face="sans-serif">Emitting such a large set of events
could happen at the same time that the system tries to emit high rate of
events, which could cause loss of events.</font>
<ul>
<li><font size=2 face="sans-serif">While loss of events is something we
have to consider &quot;possible&quot;, I don't like to add to the chances
of this happening.</font></ul></ul>
<br><font size=2 face="sans-serif">The reason I think putting this in the
metadata is preferable is that this keeps things (IMHO) more in the spirit
of the CTF format - </font>
<br><font size=2 face="sans-serif">=&gt; The trace files are self-contained,
the metadata is in the metadata stream, and in my humble opinion, the symbolic
name of a function is metadata.</font>
<br><font size=2 face="sans-serif">=&gt; The writing of pure application
events / tracepoints is not burdened by writing some overhead (albeit an
important kind of overhead).</font>
<br><font size=2 face="sans-serif">=&gt; The viewers retain the same type
of simplicity that already exists.</font>
<br>
<br><font size=2 face="sans-serif">This is why I really liked Matthew Khouzam's
concept of writing the symbols in the metadata with validity start-time.</font>
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
&nbsp;</font><font size=1 face="sans-serif">&quot;Woegerer, Paul&quot;
&lt;Paul_Woegerer@mentor.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev &lt;lttng-dev@lists.lttng.org&gt;,
Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;, Matthew Khouzam
&lt;matthew.khouzam@ericsson.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">09/11/2013 03:24 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Getting function names with &nbsp; &nbsp; &nbsp; &nbsp;lttng-ust-cyg-profile.so</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3>On 09/11/2013 11:12 AM, Amit Margalit wrote:</font>
<br><font size=2 face="sans-serif">I agree with Paul, that no redundant
data gets replicated with his approach, and my only concern is that this
approach really forces a viewer to be sequential.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
Maybe &quot;forces&quot; is too strong a word - but a viewer than wants
to let you &quot;roam&quot; the trace freely will have to read the entire
trace to figure out the mapping between address and symbol at each point
in time.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
At this time, we keep 10GB worth of LTTng traces in our system, but future
models will certainly use more. A user asking to go to the end of the trace
will have to wait until the entire trace is read in order to see correct
translations.</font><font size=3> </font>
<br><font size=3><br>
We could provide a solution to this problem with my approach by emitting
an update of the shared object state info every n x K events (configurable).<br>
<br>
Assuming we have a 10GB trace data set, we could emit a full shared object
state dump after every 100K events of regular trace data (with the same
baddr_init events we emit at session_start time). By doing so you don't
need to start reading the entire trace from the beginning. Just start reading
100K events before the events you are interested in, and you can guarantee
to find a &quot;key frame&quot; for shared object state info.<br>
<br>
Note that this is the same concept as used by video compression/streaming:<br>
I&#8209;frame, P&#8209;frame, P&#8209;frame, P&#8209;frame, ..., I&#8209;frame, P&#8209;frame,
P&#8209;frame, P&#8209;frame, ...<br>
See: </font><a href=http://en.wikipedia.org/wiki/Video_compression_picture_types><font size=3 color=blue><u>http://en.wikipedia.org/wiki/Video_compression_picture_types</u></font></a><font size=3><br>
<br>
Best,<br>
Paul<b><br>
</b></font>
<br><font size=2 face="sans-serif"><b><br>
I have a different solution, which I think I have explained here before:
</b></font><a href="http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html"><font size=3 color=blue><b><u>http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html</u></b></font></a><font size=3><b>
<br>
</b></font><font size=2 face="sans-serif"><b><br>
I vote for adding this to the metadata. It can be in addition to the ust_baddr
events suggeted by Paul.</b></font><font size=3><b> <br>
</b></font><font size=2 face="sans-serif"><b><br>
Amit</b></font><font size=3><b> <br>
</b></font><font size=2 color=#000080 face="sans-serif"><b><br>
Amit Margalit</b></font><font size=3><b> </b></font><font size=2 color=#808000 face="sans-serif"><b><br>
IBM XIV </b></font><font size=2 face="sans-serif"><b>- <i>Storage Reinvented</i></b></font><font size=3><b>
</b></font><font size=2 face="sans-serif"><b><br>
XIV-NAS Development Team</b></font><font size=3><b> </b></font><font size=2 face="sans-serif"><b><br>
Tel. 03</b></font><font size=2 face="Arial"><b>-689-7774</b></font><font size=3><b>
</b></font><font size=2 face="Arial"><b><br>
Fax. 03-689-7230</b></font><font size=3><b> <br>
<br>
<br>
</b></font><font size=1 color=#5f5f5f face="sans-serif"><b><br>
From: &nbsp; &nbsp; &nbsp; &nbsp;</b></font><font size=1 face="sans-serif"><b>&quot;Woegerer,
Paul&quot; </b></font><a href=mailto:Paul_Woegerer@mentor.com><font size=1 color=blue face="sans-serif"><b><u>&lt;Paul_Woegerer@mentor.com&gt;</u></b></font></a><font size=3><b>
</b></font><font size=1 color=#5f5f5f face="sans-serif"><b><br>
To: &nbsp; &nbsp; &nbsp; &nbsp;</b></font><font size=1 face="sans-serif"><b>Matthew
Khouzam </b></font><a href=mailto:matthew.khouzam@ericsson.com><font size=1 color=blue face="sans-serif"><b><u>&lt;matthew.khouzam@ericsson.com&gt;</u></b></font></a><font size=3><b>
</b></font><font size=1 color=#5f5f5f face="sans-serif"><b><br>
Cc: &nbsp; &nbsp; &nbsp; &nbsp;</b></font><font size=1 face="sans-serif"><b>lttng-dev
</b></font><a href="mailto:lttng-dev@lists.lttng.org"><font size=1 color=blue face="sans-serif"><b><u>&lt;lttng-dev@lists.lttng.org&gt;</u></b></font></a><font size=1 face="sans-serif"><b>,
Mathieu Desnoyers </b></font><a href=mailto:mathieu.desnoyers@efficios.com><font size=1 color=blue face="sans-serif"><b><u>&lt;mathieu.desnoyers@efficios.com&gt;</u></b></font></a><font size=3><b>
</b></font><font size=1 color=#5f5f5f face="sans-serif"><b><br>
Date: &nbsp; &nbsp; &nbsp; &nbsp;</b></font><font size=1 face="sans-serif"><b>09/10/2013
06:47 PM</b></font><font size=3><b> </b></font><font size=1 color=#5f5f5f face="sans-serif"><b><br>
Subject: &nbsp; &nbsp; &nbsp; &nbsp;</b></font><font size=1 face="sans-serif"><b>Re:
[lttng-dev] Getting function names with &nbsp; &nbsp; &nbsp; &nbsp;lttng-ust-cyg-profile.so</b></font><font size=3><b>
</b><br>
</font>
<hr noshade><font size=3><b><br>
<br>
</b></font><tt><font size=2><b><br>
On 09/10/2013 05:37 PM, Matthew Khouzam wrote:<br>
&gt; On 13-09-10 03:00 AM, Woegerer, Paul wrote:<br>
&gt;&gt; Hi Alexandre,<br>
&gt;&gt;<br>
&gt;&gt; For trivial examples you can go with 'nm -CS' (or the like), but
when<br>
&gt;&gt; you start to use liblttng-ust-cyg-profile.so in combination with
shared<br>
&gt;&gt; objects you will need to record base address information as well
(to<br>
&gt;&gt; allow you map a virtual memory address at a given point in time
to<br>
&gt;&gt; offset and path of a shared object (or executable)).<br>
&gt;&gt;<br>
&gt;&gt; That is one of the reasons why I have submitted:<br>
&gt;&gt; </b></font></tt><a href="http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html"><tt><font size=2 color=blue><b><u>http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html</u></b></font></tt></a><tt><font size=2><b><br>
&gt; This is a very interesting approach, +1 from me on that.<br>
<br>
Thanks.<br>
<br>
With that approach no redundant data (that is already available as<br>
debuginfo) gets replicated in the actual trace data.<br>
Only the bare minimum of information gets traced to allow you at any<br>
time to map a VM address to a debuginfo address + debuginfo location.<br>
<br>
-- <br>
Paul Woegerer, SW Development Engineer<br>
Sourcery Analyzer &lt;</b></font></tt><a href=http://go.mentor.com/sourceryanalyzer><tt><font size=2 color=blue><b><u>http://go.mentor.com/sourceryanalyzer</u></b></font></tt></a><tt><font size=2><b>&gt;<br>
Mentor Graphics, Embedded Software Division<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list</b></font></tt><tt><font size=2 color=blue><b><u><br>
</u></b></font></tt><a href="mailto:lttng-dev@lists.lttng.org"><tt><font size=2 color=blue><b><u>lttng-dev@lists.lttng.org</u></b></font></tt></a><font size=3 color=blue><b><u><br>
</u></b></font><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2 color=blue><b><u>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</u></b></font></tt></a><tt><font size=2><b><br>
</b></font></tt><font size=3><b><br>
</b></font>
<br><font size=3><b><br>
</b></font>
<br><tt><font size=3>-- <br>
Paul Woegerer, SW Development Engineer<br>
Sourcery Analyzer </font></tt><a href=http://go.mentor.com/sourceryanalyzer><tt><font size=3 color=blue><u>&lt;http://go.mentor.com/sourceryanalyzer&gt;</u></font></tt></a><tt><font size=3><br>
Mentor Graphics, Embedded Software Division</font></tt>
<br>
--=_alternative 004FA0ACC2257BE3_=--



--===============0547907194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0547907194==--
