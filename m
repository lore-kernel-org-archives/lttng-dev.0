From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Getting function names with	lttng-ust-cyg-profile.so
Date: Tue, 10 Sep 2013 12:52:06 +0200
Message-ID: <OF4ABDBDD2.13F4ECC0-ONC2257BE2.003B5F1C-C2257BE2.003BAC6E__40146.3531460196$1378810402$gmane$org@il.ibm.com>
References: <522E4FCE.7070000@voxpopuli.im> <20130909234409.GA11082@Krystal>
	<522EC38B.6000501@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0875286756=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VJLYb-0003QB-LG
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 06:52:33 -0400
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 10 Sep 2013 11:45:04 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9C0ED17D8058
	for <lttng-dev@lists.lttng.org>; Tue, 10 Sep 2013 11:52:26 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r8AAq8fs47579180
	for <lttng-dev@lists.lttng.org>; Tue, 10 Sep 2013 10:52:08 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r8AAqJ4B005307
	for <lttng-dev@lists.lttng.org>; Tue, 10 Sep 2013 04:52:19 -0600
In-Reply-To: <522EC38B.6000501@mentor.com>
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
--===============0875286756==
Content-Type: multipart/alternative; boundary="=_alternative 003BAC45C2257BE2_="

This is a multipart message in MIME format.
--=_alternative 003BAC45C2257BE2_=
Content-Type: text/plain; charset="US-ASCII"

+1 on that.

I think we should have a way for UST to store the function names in the 
metadata, so the trace remains valid for any viewer that correctly 
supports CTF.

I think Mathieu Desnoyers said once that this requires a modification to 
the CTF spec, so let's start raising out voice for this...

As Paul mentioned, he has a solution, and I have a somewhat different 
solution (which I will share sometime in the near future), but I still 
think that having the function names in the metadata is better.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   "Woegerer, Paul" <Paul_Woegerer@mentor.com>
To:     <alexmonthy@voxpopuli.im>, Mathieu Desnoyers 
<mathieu.desnoyers@efficios.com>
Cc:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   09/10/2013 10:01 AM
Subject:        Re: [lttng-dev] Getting function names with 
lttng-ust-cyg-profile.so



Hi Alexandre,

For trivial examples you can go with 'nm -CS' (or the like), but when
you start to use liblttng-ust-cyg-profile.so in combination with shared
objects you will need to record base address information as well (to
allow you map a virtual memory address at a given point in time to
offset and path of a shared object (or executable)).

That is one of the reasons why I have submitted:
http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html

Thanks,
Paul

On 09/10/2013 01:44 AM, Mathieu Desnoyers wrote:
> We might want to investigate doing a side-program that gathers the
> executables on the system, and lookup the symbols from the ELF. We could
> save those in a bin/ subdirectory of a CTF trace. All we need is
> instrumentation of the dynamic linker, and to know the executable names
> associated with PIDs. There is a UST feature request for dynamic linker
> instrumentation.
>
> Thanks,
>
> Mathieu
>
> * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
>> Hi all,
>>
>> I've recently started playing with liblttng-ust-cyg-profile.so (aka,
>> getting UST events from -finstrument-functions), and I have to say it's
>> pretty nifty! I haven't done any benchmarks, but it's certainly faster
>> than the typical printf() that people use with it...
>>
>> However, in the resulting trace, one only gets the addresses of the
>> functions. I understand how it's relatively "easy" for the seasoned 
user
>> to use nm or addr2line to get the actual function names, but would it
>> possible - and how hard would it be - to have this information 
(function
>> names) directly in the trace?
>>
>>
>> I'm trying to leverage this feature in Eclipse TMF to display a call
>> stack for such UST traces. And to be honest, displaying a call stack
>> with only the function addresses is completely useless, we need the
>> function names.
>>
>> We could have the user import a text file (which he can generate with
>> "nm appname > file.txt" for example). But then he needs the original
>> binary, which he might not have. And that binary needs to be compiled
>> with debugging symbols. If the function name information was already in
>> the trace, it would make the user experience much better, and our job
>> much easier! ;)
>>
>>
>> Thoughts?
>>
>> Thanks,
>> Alex
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=_alternative 003BAC45C2257BE2_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">+1 on that.</font>
<br>
<br><font size=2 face="sans-serif">I think we should have a way for UST
to store the function names in the metadata, so the trace remains valid
for any viewer that correctly supports CTF.</font>
<br>
<br><font size=2 face="sans-serif">I think Mathieu Desnoyers said once
that this requires a modification to the CTF spec, so let's start raising
out voice for this...</font>
<br>
<br><font size=2 face="sans-serif">As Paul mentioned, he has a solution,
and I have a somewhat different solution (which I will share sometime in
the near future), but I still think that having the function names in the
metadata is better.</font>
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
&nbsp;</font><font size=1 face="sans-serif">&lt;alexmonthy@voxpopuli.im&gt;,
Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">09/10/2013 10:01 AM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Getting function names with &nbsp; &nbsp; &nbsp; &nbsp;lttng-ust-cyg-profile.so</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi Alexandre,<br>
<br>
For trivial examples you can go with 'nm -CS' (or the like), but when<br>
you start to use liblttng-ust-cyg-profile.so in combination with shared<br>
objects you will need to record base address information as well (to<br>
allow you map a virtual memory address at a given point in time to<br>
offset and path of a shared object (or executable)).<br>
<br>
That is one of the reasons why I have submitted:<br>
</font></tt><a href="http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html"><tt><font size=2>http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html</font></tt></a><tt><font size=2><br>
<br>
Thanks,<br>
Paul<br>
<br>
On 09/10/2013 01:44 AM, Mathieu Desnoyers wrote:<br>
&gt; We might want to investigate doing a side-program that gathers the<br>
&gt; executables on the system, and lookup the symbols from the ELF. We
could<br>
&gt; save those in a bin/ subdirectory of a CTF trace. All we need is<br>
&gt; instrumentation of the dynamic linker, and to know the executable
names<br>
&gt; associated with PIDs. There is a UST feature request for dynamic linker<br>
&gt; instrumentation.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Mathieu<br>
&gt;<br>
&gt; * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:<br>
&gt;&gt; Hi all,<br>
&gt;&gt;<br>
&gt;&gt; I've recently started playing with liblttng-ust-cyg-profile.so
(aka,<br>
&gt;&gt; getting UST events from -finstrument-functions), and I have to
say it's<br>
&gt;&gt; pretty nifty! I haven't done any benchmarks, but it's certainly
faster<br>
&gt;&gt; than the typical printf() that people use with it...<br>
&gt;&gt;<br>
&gt;&gt; However, in the resulting trace, one only gets the addresses of
the<br>
&gt;&gt; functions. I understand how it's relatively &quot;easy&quot; for
the seasoned user<br>
&gt;&gt; to use nm or addr2line to get the actual function names, but would
it<br>
&gt;&gt; possible - and how hard would it be - to have this information
(function<br>
&gt;&gt; names) directly in the trace?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I'm trying to leverage this feature in Eclipse TMF to display
a call<br>
&gt;&gt; stack for such UST traces. And to be honest, displaying a call
stack<br>
&gt;&gt; with only the function addresses is completely useless, we need
the<br>
&gt;&gt; function names.<br>
&gt;&gt;<br>
&gt;&gt; We could have the user import a text file (which he can generate
with<br>
&gt;&gt; &quot;nm appname &gt; file.txt&quot; for example). But then he
needs the original<br>
&gt;&gt; binary, which he might not have. And that binary needs to be compiled<br>
&gt;&gt; with debugging symbols. If the function name information was already
in<br>
&gt;&gt; the trace, it would make the user experience much better, and
our job<br>
&gt;&gt; much easier! ;)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thoughts?<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; lttng-dev@lists.lttng.org<br>
&gt;&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
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
--=_alternative 003BAC45C2257BE2_=--



--===============0875286756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0875286756==--
