From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Getting function names with	lttng-ust-cyg-profile.so
Date: Wed, 11 Sep 2013 11:12:30 +0200
Message-ID: <OFD1B4818C.1C2E4DBC-ONC2257BE3.002FD513-C2257BE3.00328DCA__781.974689062004$1378890824$gmane$org@il.ibm.com>
References: <522E4FCE.7070000@voxpopuli.im>
	<20130909234409.GA11082@Krystal>	<522EC38B.6000501@mentor.com>
	<522F3CC1.5060005@ericsson.com> <522F3E95.7000203@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2145703008=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VJgTi-0003rY-Ey
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 05:12:53 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 11 Sep 2013 10:02:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 903152190071
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 10:12:42 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r8B9CUg3393582
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 09:12:30 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r8B9Cgvc018261
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 03:12:42 -0600
In-Reply-To: <522F3E95.7000203@mentor.com>
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
--===============2145703008==
Content-Type: multipart/alternative; boundary="=_alternative 00328D93C2257BE3_="

This is a multipart message in MIME format.
--=_alternative 00328D93C2257BE3_=
Content-Type: text/plain; charset="US-ASCII"

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



From:   "Woegerer, Paul" <Paul_Woegerer@mentor.com>
To:     Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc:     lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers 
<mathieu.desnoyers@efficios.com>
Date:   09/10/2013 06:47 PM
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



--=_alternative 00328D93C2257BE3_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">I agree with Paul, that no redundant data
gets replicated with his approach, and my only concern is that this approach
really forces a viewer to be sequential.</font>
<br>
<br><font size=2 face="sans-serif">Maybe &quot;forces&quot; is too strong
a word - but a viewer than wants to let you &quot;roam&quot; the trace
freely will have to read the entire trace to figure out the mapping between
address and symbol at each point in time.</font>
<br>
<br><font size=2 face="sans-serif">At this time, we keep 10GB worth of
LTTng traces in our system, but future models will certainly use more.
A user asking to go to the end of the trace will have to wait until the
entire trace is read in order to see correct translations.</font>
<br>
<br><font size=2 face="sans-serif">I have a different solution, which I
think I have explained here before: </font><a href="http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html"><font size=3 color=blue><u>http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html</u></font></a><font size=3>
</font>
<br>
<br><font size=2 face="sans-serif">I vote for adding this to the metadata.
It can be in addition to the ust_baddr events suggeted by Paul.</font>
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
&nbsp;</font><font size=1 face="sans-serif">Matthew Khouzam &lt;matthew.khouzam@ericsson.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev &lt;lttng-dev@lists.lttng.org&gt;,
Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">09/10/2013 06:47 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Getting function names with &nbsp; &nbsp; &nbsp; &nbsp;lttng-ust-cyg-profile.so</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>On 09/10/2013 05:37 PM, Matthew Khouzam wrote:<br>
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
&gt;&gt; </font></tt><a href="http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html"><tt><font size=2>http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html</font></tt></a><tt><font size=2><br>
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
Sourcery Analyzer &lt;</font></tt><a href=http://go.mentor.com/sourceryanalyzer><tt><font size=2>http://go.mentor.com/sourceryanalyzer</font></tt></a><tt><font size=2>&gt;<br>
Mentor Graphics, Embedded Software Division<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 00328D93C2257BE3_=--



--===============2145703008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2145703008==--
