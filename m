From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Problem with adding vpid and vtid context to UST
Date: Tue, 18 Jun 2013 09:21:19 +0300
Message-ID: <OF1628A49E.BD456539-ONC2257B8E.0022531F-C2257B8E.0022D404__28846.3458804928$1371536537$gmane$org@il.ibm.com>
References: <OFA2B17967.FDD790B6-ONC2257B8C.002C000A-C2257B8C.002C70E3@il.ibm.com>
	<51BF6B2C.1060509@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0092942261=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UopIP-0000aw-Bg
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 02:21:37 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 18 Jun 2013 07:16:47 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 230E82190019
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 07:24:56 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5I6LH0650659568
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 06:21:17 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5I6LSCY012360
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 00:21:28 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5I6LSYW012357
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 00:21:28 -0600
In-Reply-To: <51BF6B2C.1060509@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0092942261==
Content-Type: multipart/alternative; boundary="=_alternative 0022D389C2257B8E_="

This is a multipart message in MIME format.
--=_alternative 0022D389C2257B8E_=
Content-Type: text/plain; charset="US-ASCII"

Thanks for the explanation.

The reason I am running enable-channel is to add arguments like number of 
subbuffers, and to select per-uid buffers. The vtid / vpid context is 
something I'd like to have on every channel, and I really only want a 
single channel...

In fact, it is unclear to me how to tell an application which channel to 
use - is it even possible?

Thanks,

P.S. I intend to send a man-page patch for the domain separation as you 
suggested.


Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   David Goulet <dgoulet@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   06/17/2013 11:01 PM
Subject:        Re: [lttng-dev] Problem with adding vpid and vtid context 
to UST



Hi Amit,

Amit Margalit:
> Hi,
> 
> Every time I try this, I get the following error:
> 
> Error: Error starting tracing for app pid: 5663 (ret: -1027)
> 
> Here's my sequence:
> 
> lttng create foo -o /store/
> lttng enable-channel -u
> lttng add-context -u -t vpid -t vtid -t procname
> lttng enable-event -u -a
> lttng start foo
> 
> At this point I start my application and get that error. When the 
application
> exits, I stop the tracing, and run lttng view.
> 
> The trace session seems to have worked just fine, and "procname" was 
indeed
> added to the context, but vtid and vpid were not.

What's going on here is that you enable a channel then add contexts. This 
is
perfectly OK (although your example is missing a channel name). So, the
following "lttng enable-event" creates a default channel "channel0" since 
no
"-c" was specified.

So basically, the contexts are available on the first channel and not the 
second
one.

This sequence should work:

lttng create foo -o /store/
lttng enable-event -u -a
lttng add-context -u -t vpid -t vtid -t procname
lttng start foo

We should detail that a bit better in the documentation that an 
add-context
needs to be done *after* a channel is enabled. This allows you to create
multiple channel with different contexts.

Now, an other issue here in terms of usability is that the enable-event 
*after*
an enable-channel should be apply to this channel. I think there is been a
discussion at some point on lttng-dev on in the bug tracker.

> 
> And BTW, the documentation doesn't clearly state that pid and tid are
> kernel-only contexts, and that one should use vtid and vpid.

Yes! The list of contexts accepted per domain would be quite useful and I 
do
agree with you that it's missing in the doc.

We would be *happy* to welcome a contribution for that :).

Cheers!
David

> 
> Any help is appreciated.
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> This body part will be downloaded on demand.



--=_alternative 0022D389C2257B8E_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks for the explanation.</font>
<br>
<br><font size=2 face="sans-serif">The reason I am running enable-channel
is to add arguments like number of subbuffers, and to select per-uid buffers.
The vtid / vpid context is something I'd like to have on every channel,
and I really only want a single channel...</font>
<br>
<br><font size=2 face="sans-serif">In fact, it is unclear to me how to
tell an application which channel to use - is it even possible?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">P.S. </font><font size=2 face="sans-serif">I
intend to send a man-page patch for the domain separation as you suggested.</font>
<br>
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
&nbsp;</font><font size=1 face="sans-serif">David Goulet &lt;dgoulet@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/17/2013 11:01 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Problem with adding vpid and vtid context to UST</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi Amit,<br>
<br>
Amit Margalit:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Every time I try this, I get the following error:<br>
&gt; <br>
&gt; Error: Error starting tracing for app pid: 5663 (ret: -1027)<br>
&gt; <br>
&gt; Here's my sequence:<br>
&gt; <br>
&gt; lttng create foo -o /store/<br>
&gt; lttng enable-channel -u<br>
&gt; lttng add-context -u -t vpid -t vtid -t procname<br>
&gt; lttng enable-event -u -a<br>
&gt; lttng start foo<br>
&gt; <br>
&gt; At this point I start my application and get that error. When the
application<br>
&gt; exits, I stop the tracing, and run lttng view.<br>
&gt; <br>
&gt; The trace session seems to have worked just fine, and &quot;procname&quot;
was indeed<br>
&gt; added to the context, but vtid and vpid were not.<br>
<br>
What's going on here is that you enable a channel then add contexts. This
is<br>
perfectly OK (although your example is missing a channel name). So, the<br>
following &quot;lttng enable-event&quot; creates a default channel &quot;channel0&quot;
since no<br>
&quot;-c&quot; was specified.<br>
<br>
So basically, the contexts are available on the first channel and not the
second<br>
one.<br>
<br>
This sequence should work:<br>
<br>
lttng create foo -o /store/<br>
lttng enable-event -u -a<br>
lttng add-context -u -t vpid -t vtid -t procname<br>
lttng start foo<br>
<br>
We should detail that a bit better in the documentation that an add-context<br>
needs to be done *after* a channel is enabled. This allows you to create<br>
multiple channel with different contexts.<br>
<br>
Now, an other issue here in terms of usability is that the enable-event
*after*<br>
an enable-channel should be apply to this channel. I think there is been
a<br>
discussion at some point on lttng-dev on in the bug tracker.<br>
<br>
&gt; <br>
&gt; And BTW, the documentation doesn't clearly state that pid and tid
are<br>
&gt; kernel-only contexts, and that one should use vtid and vpid.<br>
<br>
Yes! The list of contexts accepted per domain would be quite useful and
I do<br>
agree with you that it's missing in the doc.<br>
<br>
We would be *happy* to welcome a contribution for that :).<br>
<br>
Cheers!<br>
David<br>
<br>
&gt; <br>
&gt; Any help is appreciated.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - /Storage Reinvented/<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; This body part will be downloaded on demand.<br>
<br>
</font></tt>
<br>
--=_alternative 0022D389C2257B8E_=--



--===============0092942261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0092942261==--
