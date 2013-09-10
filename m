From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Request information on "Live" view of traces
Date: Tue, 10 Sep 2013 12:45:36 +0200
Message-ID: <OF4342D089.5717C1CD-ONC2257BE2.003AD21A-C2257BE2.003B13DD__32631.2162251726$1378810008$gmane$org@il.ibm.com>
References: <CAFw4v59-2FvgVtQ=YCNhYXX3B9+y+hNdFpb0JnpOHxNCvc5vCA@mail.gmail.com>	<CAGDH53n23sZ30Uh+7DUmfM2oujb3R6yu-CroROztqhDchffJKA@mail.gmail.com>
	<5227441F.4050908@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0967790207=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VJLSJ-000348-29
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 06:46:01 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 10 Sep 2013 11:39:44 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D9FEF219005F
	for <lttng-dev@lists.lttng.org>; Tue, 10 Sep 2013 11:45:49 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r8AAjbIu62914694
	for <lttng-dev@lists.lttng.org>; Tue, 10 Sep 2013 10:45:37 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r8AAjn6m032647
	for <lttng-dev@lists.lttng.org>; Tue, 10 Sep 2013 04:45:49 -0600
In-Reply-To: <5227441F.4050908@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Dror Granot <dror@reduxio.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0967790207==
Content-Type: multipart/alternative; boundary="=_alternative 003B13A3C2257BE2_="

This is a multipart message in MIME format.
--=_alternative 003B13A3C2257BE2_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

> The 2.4 release will include a major upgrade in the lttng-relayd to
> support live trace viewing.
> The trace viewers will be able to connect to a new TCP port on the relay
> to list the tracing sessions currently established, attach to a session,
> receive all the streams for this session, and then ask for metadata and
> trace packets.

Is relayd going to be the only way that a viewer can achieve this?

I'm actually only interested in having libbabeltrace be able to read the 
trace up to the last valid event at a specific time, and not interested in 
"live" viewing of the events as they happen.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Julien Desfossez <jdesfossez@efficios.com>
To:     Dror Granot <dror@reduxio.com>
Cc:     "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Date:   09/04/2013 05:32 PM
Subject:        Re: [lttng-dev] Request information on "Live" view of 
traces



Hi,

[...]

> 
>> I would really appreciate if you can update me on the time frame of 
"live"
>> view of traces. If you know, what will it include and when it is 
supposed to
>> be, it can help us much in our decision.

The 2.4 release will include a major upgrade in the lttng-relayd to
support live trace viewing.
The trace viewers will be able to connect to a new TCP port on the relay
to list the tracing sessions currently established, attach to a session,
receive all the streams for this session, and then ask for metadata and
trace packets.
The live trace reading mechanism offers guarantees that the viewer can
never be in a position where it has to assume that it can read the trace
safely. It is forced to fetch all the metadata before being able to read
the trace and it receives information on all streams at a regular
interval (user-defined).

Along with this release of lttng-tools, we will provide a reference
client in C for Babeltrace that will handle this new protocol.

As of now, the live trace reading is working as a prototype in my
development branches on github, if you want to try them I can send you
the details, but I don't have much time to provide support on these
branches.

I will send updates on this mailing-list as soon as I consider this
feature ready to test.
I hope it answers your question, if you want more details, please don't
hesitate to ask.

Thanks,

Julien

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=_alternative 003B13A3C2257BE2_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><tt><font size=2>&gt; The 2.4 release will include a major upgrade
in the lttng-relayd to<br>
&gt; support live trace viewing.<br>
&gt; The trace viewers will be able to connect to a new TCP port on the
relay<br>
&gt; to list the tracing sessions currently established, attach to a session,<br>
&gt; receive all the streams for this session, and then ask for metadata
and<br>
&gt; trace packets.<br>
</font></tt>
<br><tt><font size=2>Is relayd going to be the only way that a viewer can
achieve this?</font></tt>
<br>
<br><tt><font size=2>I'm actually only interested in having libbabeltrace
be able to read the trace up to the last valid event at a specific time,
and not interested in &quot;live&quot; viewing of the events as they happen.</font></tt>
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
&nbsp;</font><font size=1 face="sans-serif">Julien Desfossez &lt;jdesfossez@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Dror Granot &lt;dror@reduxio.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">&quot;lttng-dev@lists.lttng.org&quot;
&lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">09/04/2013 05:32 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Request information on &quot;Live&quot; view of traces</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi,<br>
<br>
[...]<br>
<br>
&gt; <br>
&gt;&gt; I would really appreciate if you can update me on the time frame
of &quot;live&quot;<br>
&gt;&gt; view of traces. If you know, what will it include and when it
is supposed to<br>
&gt;&gt; be, it can help us much in our decision.<br>
<br>
The 2.4 release will include a major upgrade in the lttng-relayd to<br>
support live trace viewing.<br>
The trace viewers will be able to connect to a new TCP port on the relay<br>
to list the tracing sessions currently established, attach to a session,<br>
receive all the streams for this session, and then ask for metadata and<br>
trace packets.<br>
The live trace reading mechanism offers guarantees that the viewer can<br>
never be in a position where it has to assume that it can read the trace<br>
safely. It is forced to fetch all the metadata before being able to read<br>
the trace and it receives information on all streams at a regular<br>
interval (user-defined).<br>
<br>
Along with this release of lttng-tools, we will provide a reference<br>
client in C for Babeltrace that will handle this new protocol.<br>
<br>
As of now, the live trace reading is working as a prototype in my<br>
development branches on github, if you want to try them I can send you<br>
the details, but I don't have much time to provide support on these<br>
branches.<br>
<br>
I will send updates on this mailing-list as soon as I consider this<br>
feature ready to test.<br>
I hope it answers your question, if you want more details, please don't<br>
hesitate to ask.<br>
<br>
Thanks,<br>
<br>
Julien<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 003B13A3C2257BE2_=--



--===============0967790207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0967790207==--
