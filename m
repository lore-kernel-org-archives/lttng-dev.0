From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Request information on "Live" view of traces
Date: Wed, 11 Sep 2013 11:23:22 +0200
Message-ID: <OFCCBF1239.08FFE951-ONC2257BE3.00331BD2-C2257BE3.00338CD3__10208.2649748356$1378891477$gmane$org@il.ibm.com>
References: <CAFw4v59-2FvgVtQ=YCNhYXX3B9+y+hNdFpb0JnpOHxNCvc5vCA@mail.gmail.com>	<CAGDH53n23sZ30Uh+7DUmfM2oujb3R6yu-CroROztqhDchffJKA@mail.gmail.com>
	<5227441F.4050908@efficios.com>
	<OF4342D089.5717C1CD-ONC2257BE2.003AD21A-C2257BE2.003B13DD@il.ibm.com>
	<522F2ECD.7030509@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1490523414=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VJgeM-0004Ym-Qs
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 05:23:54 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 11 Sep 2013 10:16:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2D8E81B08072
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 10:23:36 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r8B9NNPP45613284
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 09:23:23 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r8B9NZ9f030599
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 05:23:35 -0400
In-Reply-To: <522F2ECD.7030509@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>, Dror Granot <dror@reduxio.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1490523414==
Content-Type: multipart/alternative; boundary="=_alternative 00338CA5C2257BE3_="

This is a multipart message in MIME format.
--=_alternative 00338CA5C2257BE3_=
Content-Type: text/plain; charset="US-ASCII"

> I guess that you are mostly interested in making sure your traces are
> readable after a crash from the system that produces them, right ?

That is a concern, yes.

Additionally, I would like to make sure that I can safely view events on a 
running system up to (close to) the end. Plus - I rather not have to use 
relayd to do this.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     Julien Desfossez <jdesfossez@efficios.com>, 
"lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Dror Granot 
<dror@reduxio.com>
Date:   09/10/2013 05:38 PM
Subject:        Re: [lttng-dev] Request information on "Live" view of 
traces



On 10/09/13 03:45 AM, Amit Margalit wrote:
> Hi,
>
> > The 2.4 release will include a major upgrade in the lttng-relayd to
> > support live trace viewing.
> > The trace viewers will be able to connect to a new TCP port on the 
relay
> > to list the tracing sessions currently established, attach to a 
session,
> > receive all the streams for this session, and then ask for metadata 
and
> > trace packets.
>
> Is relayd going to be the only way that a viewer can achieve this?
>
> I'm actually only interested in having libbabeltrace be able to read
> the trace up to the last valid event at a specific time, and not
> interested in "live" viewing of the events as they happen.

I guess that you are mostly interested in making sure your traces are
readable after a crash from the system that produces them, right ?

Thanks,

Mathieu


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
>
> From:        Julien Desfossez <jdesfossez@efficios.com>
> To:        Dror Granot <dror@reduxio.com>
> Cc:        "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
> Date:        09/04/2013 05:32 PM
> Subject:        Re: [lttng-dev] Request information on "Live" view of
> traces
> ------------------------------------------------------------------------
>
>
>
> Hi,
>
> [...]
>
> >
> >> I would really appreciate if you can update me on the time frame of
> "live"
> >> view of traces. If you know, what will it include and when it is
> supposed to
> >> be, it can help us much in our decision.
>
> The 2.4 release will include a major upgrade in the lttng-relayd to
> support live trace viewing.
> The trace viewers will be able to connect to a new TCP port on the relay
> to list the tracing sessions currently established, attach to a session,
> receive all the streams for this session, and then ask for metadata and
> trace packets.
> The live trace reading mechanism offers guarantees that the viewer can
> never be in a position where it has to assume that it can read the trace
> safely. It is forced to fetch all the metadata before being able to read
> the trace and it receives information on all streams at a regular
> interval (user-defined).
>
> Along with this release of lttng-tools, we will provide a reference
> client in C for Babeltrace that will handle this new protocol.
>
> As of now, the live trace reading is working as a prototype in my
> development branches on github, if you want to try them I can send you
> the details, but I don't have much time to provide support on these
> branches.
>
> I will send updates on this mailing-list as soon as I consider this
> feature ready to test.
> I hope it answers your question, if you want more details, please don't
> hesitate to ask.
>
> Thanks,
>
> Julien
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=_alternative 00338CA5C2257BE3_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">&gt; </font><tt><font size=2>I guess that
you are mostly interested in making sure your traces are<br>
&gt; readable after a crash from the system that produces them, right ?<br>
</font></tt>
<br><tt><font size=2>That is a concern, yes.</font></tt>
<br>
<br><tt><font size=2>Additionally, I would like to make sure that I can
safely view events on a running system up to (close to) the end. Plus -
I rather not have to use relayd to do this.</font></tt>
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
&nbsp;</font><font size=1 face="sans-serif">Julien Desfossez &lt;jdesfossez@efficios.com&gt;,
&quot;lttng-dev@lists.lttng.org&quot; &lt;lttng-dev@lists.lttng.org&gt;,
Dror Granot &lt;dror@reduxio.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">09/10/2013 05:38 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Request information on &quot;Live&quot; view of traces</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>On 10/09/13 03:45 AM, Amit Margalit wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; &gt; The 2.4 release will include a major upgrade in the lttng-relayd
to<br>
&gt; &gt; support live trace viewing.<br>
&gt; &gt; The trace viewers will be able to connect to a new TCP port on
the relay<br>
&gt; &gt; to list the tracing sessions currently established, attach to
a session,<br>
&gt; &gt; receive all the streams for this session, and then ask for metadata
and<br>
&gt; &gt; trace packets.<br>
&gt;<br>
&gt; Is relayd going to be the only way that a viewer can achieve this?<br>
&gt;<br>
&gt; I'm actually only interested in having libbabeltrace be able to read<br>
&gt; the trace up to the last valid event at a specific time, and not<br>
&gt; interested in &quot;live&quot; viewing of the events as they happen.<br>
<br>
I guess that you are mostly interested in making sure your traces are<br>
readable after a crash from the system that produces them, right ?<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Amit Margalit<br>
&gt; IBM XIV - /Storage Reinvented/<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: &nbsp; &nbsp; &nbsp; &nbsp;Julien Desfossez &lt;jdesfossez@efficios.com&gt;<br>
&gt; To: &nbsp; &nbsp; &nbsp; &nbsp;Dror Granot &lt;dror@reduxio.com&gt;<br>
&gt; Cc: &nbsp; &nbsp; &nbsp; &nbsp;&quot;lttng-dev@lists.lttng.org&quot;
&lt;lttng-dev@lists.lttng.org&gt;<br>
&gt; Date: &nbsp; &nbsp; &nbsp; &nbsp;09/04/2013 05:32 PM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] Request information
on &quot;Live&quot; view of<br>
&gt; traces<br>
&gt; ------------------------------------------------------------------------<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; [...]<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; I would really appreciate if you can update me on the time
frame of<br>
&gt; &quot;live&quot;<br>
&gt; &gt;&gt; view of traces. If you know, what will it include and when
it is<br>
&gt; supposed to<br>
&gt; &gt;&gt; be, it can help us much in our decision.<br>
&gt;<br>
&gt; The 2.4 release will include a major upgrade in the lttng-relayd to<br>
&gt; support live trace viewing.<br>
&gt; The trace viewers will be able to connect to a new TCP port on the
relay<br>
&gt; to list the tracing sessions currently established, attach to a session,<br>
&gt; receive all the streams for this session, and then ask for metadata
and<br>
&gt; trace packets.<br>
&gt; The live trace reading mechanism offers guarantees that the viewer
can<br>
&gt; never be in a position where it has to assume that it can read the
trace<br>
&gt; safely. It is forced to fetch all the metadata before being able to
read<br>
&gt; the trace and it receives information on all streams at a regular<br>
&gt; interval (user-defined).<br>
&gt;<br>
&gt; Along with this release of lttng-tools, we will provide a reference<br>
&gt; client in C for Babeltrace that will handle this new protocol.<br>
&gt;<br>
&gt; As of now, the live trace reading is working as a prototype in my<br>
&gt; development branches on github, if you want to try them I can send
you<br>
&gt; the details, but I don't have much time to provide support on these<br>
&gt; branches.<br>
&gt;<br>
&gt; I will send updates on this mailing-list as soon as I consider this<br>
&gt; feature ready to test.<br>
&gt; I hope it answers your question, if you want more details, please
don't<br>
&gt; hesitate to ask.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Julien<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 00338CA5C2257BE3_=--



--===============1490523414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1490523414==--
