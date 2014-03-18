From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Trace rotation across sessions
Date: Tue, 18 Mar 2014 16:28:35 +0200
Message-ID: <OF08BD8E32.191B0BC5-ONC2257C9F.004F7CAC-C2257C9F.004F942B__22041.8752207936$1395153015$gmane$org@il.ibm.com>
References: <OFBBFCF198.C68E7A66-ONC2257C9F.00309BBF-C2257C9F.0030CCEA@il.ibm.com>
	<CA+jJMxsBWqc24+ib8QVmTzx85PG6eXkGYOHD5=6R2ehRUCBzOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1065173459=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1WPv0l-00023k-3F
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 10:29:05 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 18 Mar 2014 14:28:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A88EA1B08061
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 14:28:38 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id s2IESbJ565077278
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 14:28:37 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id s2IESm40026551
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 08:28:48 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id s2IESlgJ026519
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 08:28:47 -0600
In-Reply-To: <CA+jJMxsBWqc24+ib8QVmTzx85PG6eXkGYOHD5=6R2ehRUCBzOw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, jeremie.galarneau@gmail.com
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1065173459==
Content-Type: multipart/alternative; boundary="=_alternative 004F93C9C2257C9F_="

This is a multipart message in MIME format.
--=_alternative 004F93C9C2257C9F_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

It may be what I am looking for.

Are you saying that lttng-sessiond will pick up the session from whereever =

it is and continue it?

BTW, I am using only UST for now.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   03/18/2014 04:19 PM
Subject:        Re: [lttng-dev] Trace rotation across sessions
Sent by:        jeremie.galarneau@gmail.com



On Tue, Mar 18, 2014 at 4:52 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hello,
>
> Our system has a running session that stays on continuously.
>
> Occasionally, our customer will upgrade the software, leading to a=20
reboot,
> which in turn means we will have a new session.
>
> Is there any way to make LTTng aware of the total size of all sessions
> (current and past) and simply rotate files to keep the entire set of=20
traces
> under a size limit?
>

The only way I can see this working is by recreating the same session
configuration (with the same output destination) and using lttng
enable-channel's -C (tracefile-size) and -W (tracefile-count) options
to define an upper bound on each trace's size.

Is this what you are looking for?

J=E9r=E9mie

> Thanks,
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com



--=_alternative 004F93C9C2257C9F_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">It may be what I am looking for.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Are you saying that lttng-sessiond w=
ill
pick up the session from whereever it is and continue it?</font>
<br>
<br><font size=3D2 face=3D"sans-serif">BTW, I am using only UST for now.</f=
ont>
<br>
<br><font size=3D2 color=3D#000080 face=3D"sans-serif">Amit Margalit</font>
<br><font size=3D2 color=3D#808000 face=3D"sans-serif">IBM XIV </font><font=
 size=3D2 face=3D"sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=3D2 face=3D"sans-serif">XIV-NAS Development Team</font>
<br><font size=3D2 face=3D"sans-serif">Tel. 03</font><font size=3D2 face=3D=
"Arial">-689-7774</font>
<br><font size=3D2 face=3D"Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">J=E9r=E9mie Galarneau &lt;j=
eremie.galarneau@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Amit Margalit/Israel/IBM@IB=
MIL</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">lttng-dev &lt;lttng-dev@lis=
ts.lttng.org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">03/18/2014 04:19 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
Trace rotation across sessions</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Sent by: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">jeremie.galarneau@gm=
ail.com</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>On Tue, Mar 18, 2014 at 4:52 AM, Amit Margalit &lt;A=
MITM@il.ibm.com&gt;
wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; Our system has a running session that stays on continuously.<br>
&gt;<br>
&gt; Occasionally, our customer will upgrade the software, leading to a
reboot,<br>
&gt; which in turn means we will have a new session.<br>
&gt;<br>
&gt; Is there any way to make LTTng aware of the total size of all sessions=
<br>
&gt; (current and past) and simply rotate files to keep the entire set
of traces<br>
&gt; under a size limit?<br>
&gt;<br>
<br>
The only way I can see this working is by recreating the same session<br>
configuration (with the same output destination) and using lttng<br>
enable-channel's -C (tracefile-size) and -W (tracefile-count) options<br>
to define an upper bound on each trace's size.<br>
<br>
Is this what you are looking for?<br>
<br>
J=E9r=E9mie<br>
<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</font></tt></a><tt><font size=3D2><br>
&gt;<br>
<br>
<br>
<br>
-- <br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
</font></tt><a href=3Dhttp://www.efficios.com/><tt><font size=3D2>http://ww=
w.efficios.com</font></tt></a><tt><font size=3D2><br>
<br>
</font></tt>
<br>
--=_alternative 004F93C9C2257C9F_=--



--===============1065173459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1065173459==--
