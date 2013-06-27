From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Problem with adding vpid and vtid context to UST
Date: Thu, 27 Jun 2013 08:56:02 +0300
Message-ID: <OF24FECA43.5FD04F40-ONC2257B97.00205068-C2257B97.00208359__33310.8916799121$1372312612$gmane$org@il.ibm.com>
References: <OFA2B17967.FDD790B6-ONC2257B8C.002C000A-C2257B8C.002C70E3@il.ibm.com>
	<51BF6B2C.1060509@efficios.com>
	<OF1628A49E.BD456539-ONC2257B8E.0022531F-C2257B8E.0022D404@il.ibm.com>
	<20130626183650.GA1115@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1720531654=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Us5Bo-0005yY-EX
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 01:56:16 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 27 Jun 2013 06:52:01 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DC04B2190019
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 06:59:45 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5R5tvSO54460638
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 05:55:57 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5R5u7px020959
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 01:56:07 -0400
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5R5u7N5020955
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 01:56:07 -0400
In-Reply-To: <20130626183650.GA1115@Krystal>
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
--===============1720531654==
Content-Type: multipart/alternative; boundary="=_alternative 00208318C2257B97_="

This is a multipart message in MIME format.
--=_alternative 00208318C2257B97_=
Content-Type: text/plain; charset="US-ASCII"

So, what you're saying is that with per-UID buffers, I cannot add 
vpid/vtid to the context because these are somehow written once per set of 
buffers, and the buffers are shared between all applications?

If that is so - why is it that I can add 'procname' to the context and see 
multiple processes in the trace files without any issue?

I believe I misunderstood your meaning, then. Could you please explain in 
some more detail?

Thanks in advance,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     David Goulet <dgoulet@efficios.com>, lttng-dev@lists.lttng.org
Date:   06/26/2013 09:36 PM
Subject:        Re: [lttng-dev] Problem with adding vpid and vtid context 
to UST



* Amit Margalit (AMITM@il.ibm.com) wrote:
> Thanks for the explanation.
> 
> The reason I am running enable-channel is to add arguments like number 
of 
> subbuffers, and to select per-uid buffers. The vtid / vpid context is 
> something I'd like to have on every channel, and I really only want a 
> single channel...
> 
> In fact, it is unclear to me how to tell an application which channel to 

> use - is it even possible?

No. Currently, channels apply to all registered applications.

However, with per-PID channels, you have one set of buffers per process.

With per-UID channels, you have one set of buffers per user ID, shared
amongst processes.

Thanks,

Mathieu

> 
> Thanks,
> 
> P.S. I intend to send a man-page patch for the domain separation as you 
> suggested.
> 
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:   David Goulet <dgoulet@efficios.com>
> To:     Amit Margalit/Israel/IBM@IBMIL
> Cc:     lttng-dev@lists.lttng.org
> Date:   06/17/2013 11:01 PM
> Subject:        Re: [lttng-dev] Problem with adding vpid and vtid 
context 
> to UST
> 
> 
> 
> Hi Amit,
> 
> Amit Margalit:
> > Hi,
> > 
> > Every time I try this, I get the following error:
> > 
> > Error: Error starting tracing for app pid: 5663 (ret: -1027)
> > 
> > Here's my sequence:
> > 
> > lttng create foo -o /store/
> > lttng enable-channel -u
> > lttng add-context -u -t vpid -t vtid -t procname
> > lttng enable-event -u -a
> > lttng start foo
> > 
> > At this point I start my application and get that error. When the 
> application
> > exits, I stop the tracing, and run lttng view.
> > 
> > The trace session seems to have worked just fine, and "procname" was 
> indeed
> > added to the context, but vtid and vpid were not.
> 
> What's going on here is that you enable a channel then add contexts. 
This 
> is
> perfectly OK (although your example is missing a channel name). So, the
> following "lttng enable-event" creates a default channel "channel0" 
since 
> no
> "-c" was specified.
> 
> So basically, the contexts are available on the first channel and not 
the 
> second
> one.
> 
> This sequence should work:
> 
> lttng create foo -o /store/
> lttng enable-event -u -a
> lttng add-context -u -t vpid -t vtid -t procname
> lttng start foo
> 
> We should detail that a bit better in the documentation that an 
> add-context
> needs to be done *after* a channel is enabled. This allows you to create
> multiple channel with different contexts.
> 
> Now, an other issue here in terms of usability is that the enable-event 
> *after*
> an enable-channel should be apply to this channel. I think there is been 
a
> discussion at some point on lttng-dev on in the bug tracker.
> 
> > 
> > And BTW, the documentation doesn't clearly state that pid and tid are
> > kernel-only contexts, and that one should use vtid and vpid.
> 
> Yes! The list of contexts accepted per domain would be quite useful and 
I 
> do
> agree with you that it's missing in the doc.
> 
> We would be *happy* to welcome a contribution for that :).
> 
> Cheers!
> David
> 
> > 
> > Any help is appreciated.
> > 
> > Thanks,
> > 
> > Amit Margalit
> > IBM XIV - /Storage Reinvented/
> > XIV-NAS Development Team
> > Tel. 03-689-7774
> > Fax. 03-689-7230
> > 
> > 
> > This body part will be downloaded on demand.
> 
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



--=_alternative 00208318C2257B97_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">So, what you're saying is that with per-UID
buffers, I cannot add vpid/vtid to the context because these are somehow
written once per set of buffers, and the buffers are shared between all
applications?</font>
<br>
<br><font size=2 face="sans-serif">If that is so - why is it that I can
add 'procname' to the context and see multiple processes in the trace files
without any issue?</font>
<br>
<br><font size=2 face="sans-serif">I believe I misunderstood your meaning,
then. Could you please explain in some more detail?</font>
<br>
<br><font size=2 face="sans-serif">Thanks in advance,</font>
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
&nbsp;</font><font size=1 face="sans-serif">David Goulet &lt;dgoulet@efficios.com&gt;,
lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/26/2013 09:36 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Problem with adding vpid and vtid context to UST</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>* Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; Thanks for the explanation.<br>
&gt; <br>
&gt; The reason I am running enable-channel is to add arguments like number
of <br>
&gt; subbuffers, and to select per-uid buffers. The vtid / vpid context
is <br>
&gt; something I'd like to have on every channel, and I really only want
a <br>
&gt; single channel...<br>
&gt; <br>
&gt; In fact, it is unclear to me how to tell an application which channel
to <br>
&gt; use - is it even possible?<br>
<br>
No. Currently, channels apply to all registered applications.<br>
<br>
However, with per-PID channels, you have one set of buffers per process.<br>
<br>
With per-UID channels, you have one set of buffers per user ID, shared<br>
amongst processes.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; P.S. I intend to send a man-page patch for the domain separation as
you <br>
&gt; suggested.<br>
&gt; <br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; From: &nbsp; David Goulet &lt;dgoulet@efficios.com&gt;<br>
&gt; To: &nbsp; &nbsp; Amit Margalit/Israel/IBM@IBMIL<br>
&gt; Cc: &nbsp; &nbsp; lttng-dev@lists.lttng.org<br>
&gt; Date: &nbsp; 06/17/2013 11:01 PM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] Problem with adding
vpid and vtid context <br>
&gt; to UST<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Hi Amit,<br>
&gt; <br>
&gt; Amit Margalit:<br>
&gt; &gt; Hi,<br>
&gt; &gt; <br>
&gt; &gt; Every time I try this, I get the following error:<br>
&gt; &gt; <br>
&gt; &gt; Error: Error starting tracing for app pid: 5663 (ret: -1027)<br>
&gt; &gt; <br>
&gt; &gt; Here's my sequence:<br>
&gt; &gt; <br>
&gt; &gt; lttng create foo -o /store/<br>
&gt; &gt; lttng enable-channel -u<br>
&gt; &gt; lttng add-context -u -t vpid -t vtid -t procname<br>
&gt; &gt; lttng enable-event -u -a<br>
&gt; &gt; lttng start foo<br>
&gt; &gt; <br>
&gt; &gt; At this point I start my application and get that error. When
the <br>
&gt; application<br>
&gt; &gt; exits, I stop the tracing, and run lttng view.<br>
&gt; &gt; <br>
&gt; &gt; The trace session seems to have worked just fine, and &quot;procname&quot;
was <br>
&gt; indeed<br>
&gt; &gt; added to the context, but vtid and vpid were not.<br>
&gt; <br>
&gt; What's going on here is that you enable a channel then add contexts.
This <br>
&gt; is<br>
&gt; perfectly OK (although your example is missing a channel name). So,
the<br>
&gt; following &quot;lttng enable-event&quot; creates a default channel
&quot;channel0&quot; since <br>
&gt; no<br>
&gt; &quot;-c&quot; was specified.<br>
&gt; <br>
&gt; So basically, the contexts are available on the first channel and
not the <br>
&gt; second<br>
&gt; one.<br>
&gt; <br>
&gt; This sequence should work:<br>
&gt; <br>
&gt; lttng create foo -o /store/<br>
&gt; lttng enable-event -u -a<br>
&gt; lttng add-context -u -t vpid -t vtid -t procname<br>
&gt; lttng start foo<br>
&gt; <br>
&gt; We should detail that a bit better in the documentation that an <br>
&gt; add-context<br>
&gt; needs to be done *after* a channel is enabled. This allows you to
create<br>
&gt; multiple channel with different contexts.<br>
&gt; <br>
&gt; Now, an other issue here in terms of usability is that the enable-event
<br>
&gt; *after*<br>
&gt; an enable-channel should be apply to this channel. I think there is
been a<br>
&gt; discussion at some point on lttng-dev on in the bug tracker.<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; And BTW, the documentation doesn't clearly state that pid and
tid are<br>
&gt; &gt; kernel-only contexts, and that one should use vtid and vpid.<br>
&gt; <br>
&gt; Yes! The list of contexts accepted per domain would be quite useful
and I <br>
&gt; do<br>
&gt; agree with you that it's missing in the doc.<br>
&gt; <br>
&gt; We would be *happy* to welcome a contribution for that :).<br>
&gt; <br>
&gt; Cheers!<br>
&gt; David<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; Any help is appreciated.<br>
&gt; &gt; <br>
&gt; &gt; Thanks,<br>
&gt; &gt; <br>
&gt; &gt; Amit Margalit<br>
&gt; &gt; IBM XIV - /Storage Reinvented/<br>
&gt; &gt; XIV-NAS Development Team<br>
&gt; &gt; Tel. 03-689-7774<br>
&gt; &gt; Fax. 03-689-7230<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; This body part will be downloaded on demand.<br>
&gt; <br>
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
--=_alternative 00208318C2257B97_=--



--===============1720531654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1720531654==--
