From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Trace rotation across sessions
Date: Tue, 18 Mar 2014 16:50:18 +0200
Message-ID: <OFC6ABC089.115C7BE8-ONC2257C9F.00518CEA-C2257C9F.00519169__6881.12498396567$1395154310$gmane$org@il.ibm.com>
References: <OFBBFCF198.C68E7A66-ONC2257C9F.00309BBF-C2257C9F.0030CCEA@il.ibm.com>	<CA+jJMxsBWqc24+ib8QVmTzx85PG6eXkGYOHD5=6R2ehRUCBzOw@mail.gmail.com>
	<OF08BD8E32.191B0BC5-ONC2257C9F.004F7CAC-C2257C9F.004F942B@il.ibm.com>
	<CA+jJMxvu2t0+83H6QyRLPdg_vZmiwQ3XTahCaEYapKwm5a0eSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1112947483=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1WPvLl-0002HA-AQ
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 10:50:47 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 18 Mar 2014 14:50:34 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2728D2190046
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 14:50:27 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id s2IEoK0Y61014158
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 14:50:20 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id s2IEoVcL016188
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 08:50:31 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id s2IEoVw0016176
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 08:50:31 -0600
In-Reply-To: <CA+jJMxvu2t0+83H6QyRLPdg_vZmiwQ3XTahCaEYapKwm5a0eSA@mail.gmail.com>
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
--===============1112947483==
Content-Type: multipart/alternative; boundary="=_alternative 005190F8C2257C9F_="

This is a multipart message in MIME format.
--=_alternative 005190F8C2257C9F_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

So - how do I get this kind of thing on the wishlist?

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   03/18/2014 04:42 PM
Subject:        Re: [lttng-dev] Trace rotation across sessions
Sent by:        jeremie.galarneau@gmail.com



On Tue, Mar 18, 2014 at 10:28 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> It may be what I am looking for.
>
> Are you saying that lttng-sessiond will pick up the session from=20
whereever
> it is and continue it?

No. As far as I know, the session daemon will simply overwrite the files.

J=E9r=E9mie

>
> BTW, I am using only UST for now.
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
>
>
>
> From:        J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> To:        Amit Margalit/Israel/IBM@IBMIL
> Cc:        lttng-dev <lttng-dev@lists.lttng.org>
> Date:        03/18/2014 04:19 PM
> Subject:        Re: [lttng-dev] Trace rotation across sessions
> Sent by:        jeremie.galarneau@gmail.com
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F
>
>
>
> On Tue, Mar 18, 2014 at 4:52 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
>> Hello,
>>
>> Our system has a running session that stays on continuously.
>>
>> Occasionally, our customer will upgrade the software, leading to a=20
reboot,
>> which in turn means we will have a new session.
>>
>> Is there any way to make LTTng aware of the total size of all sessions
>> (current and past) and simply rotate files to keep the entire set of
>> traces
>> under a size limit?
>>
>
> The only way I can see this working is by recreating the same session
> configuration (with the same output destination) and using lttng
> enable-channel's -C (tracefile-size) and -W (tracefile-count) options
> to define an upper bound on each trace's size.
>
> Is this what you are looking for?
>
> J=E9r=E9mie
>
>> Thanks,
>>
>> Amit Margalit
>> IBM XIV - Storage Reinvented
>> XIV-NAS Development Team
>> Tel. 03-689-7774
>> Fax. 03-689-7230
>> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com



--=_alternative 005190F8C2257C9F_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">So - how do I get this kind of thing on
the wishlist?</font>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">03/18/2014 04:42 PM</font>
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
<br><tt><font size=3D2>On Tue, Mar 18, 2014 at 10:28 AM, Amit Margalit &lt;=
AMITM@il.ibm.com&gt;
wrote:<br>
&gt; It may be what I am looking for.<br>
&gt;<br>
&gt; Are you saying that lttng-sessiond will pick up the session from where=
ever<br>
&gt; it is and continue it?<br>
<br>
No. As far as I know, the session daemon will simply overwrite the files.<b=
r>
<br>
J=E9r=E9mie<br>
<br>
&gt;<br>
&gt; BTW, I am using only UST for now.<br>
&gt;<br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: &nbsp; &nbsp; &nbsp; &nbsp;J=E9r=E9mie Galarneau &lt;jeremie.gal=
arneau@efficios.com&gt;<br>
&gt; To: &nbsp; &nbsp; &nbsp; &nbsp;Amit Margalit/Israel/IBM@IBMIL<br>
&gt; Cc: &nbsp; &nbsp; &nbsp; &nbsp;lttng-dev &lt;lttng-dev@lists.lttng.org=
&gt;<br>
&gt; Date: &nbsp; &nbsp; &nbsp; &nbsp;03/18/2014 04:19 PM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] Trace rotation
across sessions<br>
&gt; Sent by: &nbsp; &nbsp; &nbsp; &nbsp;jeremie.galarneau@gmail.com<br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Mar 18, 2014 at 4:52 AM, Amit Margalit &lt;AMITM@il.ibm.com&gt;
wrote:<br>
&gt;&gt; Hello,<br>
&gt;&gt;<br>
&gt;&gt; Our system has a running session that stays on continuously.<br>
&gt;&gt;<br>
&gt;&gt; Occasionally, our customer will upgrade the software, leading
to a reboot,<br>
&gt;&gt; which in turn means we will have a new session.<br>
&gt;&gt;<br>
&gt;&gt; Is there any way to make LTTng aware of the total size of all
sessions<br>
&gt;&gt; (current and past) and simply rotate files to keep the entire
set of<br>
&gt;&gt; traces<br>
&gt;&gt; under a size limit?<br>
&gt;&gt;<br>
&gt;<br>
&gt; The only way I can see this working is by recreating the same session<=
br>
&gt; configuration (with the same output destination) and using lttng<br>
&gt; enable-channel's -C (tracefile-size) and -W (tracefile-count) options<=
br>
&gt; to define an upper bound on each trace's size.<br>
&gt;<br>
&gt; Is this what you are looking for?<br>
&gt;<br>
&gt; J=E9r=E9mie<br>
&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt;<br>
&gt;&gt; Amit Margalit<br>
&gt;&gt; IBM XIV - Storage Reinvented<br>
&gt;&gt; XIV-NAS Development Team<br>
&gt;&gt; Tel. 03-689-7774<br>
&gt;&gt; Fax. 03-689-7230<br>
&gt;&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; lttng-dev@lists.lttng.org<br>
&gt;&gt; </font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</font></tt></a><tt><font size=3D2><br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; J=E9r=E9mie Galarneau<br>
&gt; EfficiOS Inc.<br>
&gt; </font></tt><a href=3Dhttp://www.efficios.com/><tt><font size=3D2>http=
://www.efficios.com</font></tt></a><tt><font size=3D2><br>
&gt;<br>
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
--=_alternative 005190F8C2257C9F_=--



--===============1112947483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1112947483==--
