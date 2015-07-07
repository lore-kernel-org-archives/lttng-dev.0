From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: UST Create Channel Failed, Why?
Date: Tue, 7 Jul 2015 13:13:21 -0400
Message-ID: <CA+jJMxs-379mROWBkiYxCZCc6J_GzC92TZzA8Ewpb+oHus1MTw__7109.0025165633$1436289272$gmane$org@mail.gmail.com>
References: <SN1PR12MB0319A4CF7ED35B7D250426BC9B930@SN1PR12MB0319.namprd12.prod.outlook.com>
 <CA+jJMxs9SYDJpYyk8jMxRGfxZ1SzaBQbmqkA5dNFOvELJ1N40Q@mail.gmail.com>
 <SN1PR12MB03190B1482175C51A50586249B920@SN1PR12MB0319.namprd12.prod.outlook.com>
 <SN1PR12MB0319E6C9EB60A3165E259BD99B920@SN1PR12MB0319.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0323266213=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZCWQx-0007iU-8U
 for lttng-dev@lists.lttng.org; Tue, 07 Jul 2015 13:13:31 -0400
Received: by pddu5 with SMTP id u5so41611904pdd.3
 for <lttng-dev@lists.lttng.org>; Tue, 07 Jul 2015 10:13:21 -0700 (PDT)
In-Reply-To: <SN1PR12MB0319E6C9EB60A3165E259BD99B920@SN1PR12MB0319.namprd12.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dilong Zheng <Dilong.Zheng@mitel.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0323266213==
Content-Type: multipart/alternative; boundary=047d7bd74e6ca6762f051a4c23c7

--047d7bd74e6ca6762f051a4c23c7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Which release of 2.5 are you using? You can find out using:
$ lttng version

Can you launch the session daemon manually in verbose-mode and provide the
logs?
$ lttng-sessiond -vvv

and enable your events in another terminal.

Thanks,
J=C3=A9r=C3=A9mie


On Tue, Jul 7, 2015 at 11:28 AM, Dilong Zheng <Dilong.Zheng@mitel.com>
wrote:

>  Hi Jeremie,
>
>
>  Had some grammatical mistakes in my last email.... this should be
> clearer.
>
>
>  I am using LTTng v2.5. I am not explicitly creating any channels. I am
> only creating a session via: lttng create [session-name] . I used to
> always just create a session and then enable whichever available user
> tracepoint that I need (without explicitly creating any channels).
>
>
>  Thanks,
>
>
>  Dilong
>
>
>  ------------------------------
> *From:* Dilong Zheng
> *Sent:* Tuesday, July 7, 2015 11:26 AM
> *To:* J=C3=A9r=C3=A9mie Galarneau
>
> *Cc:* lttng-dev@lists.lttng.org
> *Subject:* Re: [lttng-dev] UST Create Channel Failed, Why?
>
>
> Hi Jeremie,
>
>
>  I am using LTTng v2.5. I am not explicitly creating channels. I am only
> creating a session: lttng create [session-name] . It used to always just
> create a session and then enable whichever available user tracepoint that=
 I
> need (which out explicitly creating any channels).
>
>
>  Thanks,
>
>
>  Dilong
>
>  ------------------------------
> *From:* jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on
> behalf of J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
> *Sent:* Tuesday, July 7, 2015 11:20 AM
> *To:* Dilong Zheng
> *Cc:* lttng-dev@lists.lttng.org
> *Subject:* Re: [lttng-dev] UST Create Channel Failed, Why?
>
>  Hi Dilong,
>
>  How do you create this channel and using which version of LTTng?
>
>  J=C3=A9r=C3=A9mie
>
> On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng <Dilong.Zheng@mitel.com>
> wrote:
>
>>  Hi all,
>>
>>
>>  While trying to enable UST events, I get the following error message:
>>
>>
>>  Error: Event mitel:sem_wait_entry: UST create channel failed (channel
>> channel0, session mcdUST3)
>>
>>
>>  When I type: lttng list -u I am able to see a list of all my UST
>> tracepoints.
>>
>> Could someone please provide some insight as to why this error is
>> appearing and steps I could take to fix this error. Thanks.
>>
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
>  --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd74e6ca6762f051a4c23c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Which release of 2.5 are you using? You can find out using=
:<div>$ lttng version</div><div><br></div><div>Can you launch the session d=
aemon manually in verbose-mode and provide the logs?</div><div>$ lttng-sess=
iond -vvv</div><div><br></div><div>and enable your events in another termin=
al.</div><div><br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie</div><div>=
<br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Tue, Jul 7, 2015 at 11:28 AM, Dilong Zheng <span dir=3D"ltr">&lt;<a href=
=3D"mailto:Dilong.Zheng@mitel.com" target=3D"_blank">Dilong.Zheng@mitel.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div style=3D"font-size:12pt;color:#000000;background-color:#ffffff;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif">
<p>Hi Jeremie,</p>
<p><br>
</p>
<p>Had some grammatical mistakes in my last email.... this should be cleare=
r.<br>
</p>
<p><br>
</p>
<p>I am using LTTng v2.5. I am not explicitly creating any channels. I am o=
nly creating a session via:
<span style=3D"font-family:&quot;Courier New&quot;,monospace">lttng create =
[session-name]</span>=C2=A0. I used to always just create a session and the=
n enable whichever available user tracepoint that I need (without explicitl=
y creating any channels).</p>
<p><br>
</p>
<p>Thanks,</p>
<p><br>
</p>
<p>Dilong<br style=3D"font-family:&quot;Courier New&quot;,monospace">
</p>
<br>
<br>
<div style=3D"color:rgb(46,52,54)">
<hr style=3D"display:inline-block;width:98%">
<div dir=3D"ltr"><font style=3D"font-size:11pt" face=3D"Calibri, sans-serif=
" color=3D"#000000"><b>From:</b> Dilong Zheng<br>
<b>Sent:</b> Tuesday, July 7, 2015 11:26 AM<br>
<b>To:</b> J=C3=A9r=C3=A9mie Galarneau<div><div class=3D"h5"><br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> Re: [lttng-dev] UST Create Channel Failed, Why?</div></div>=
</font>
<div>=C2=A0</div>
</div><div><div class=3D"h5">
<div>
<div style=3D"font-size:12pt;color:#000000;background-color:#ffffff;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif">
<p>Hi Jeremie,</p>
<p><br>
</p>
<p>I am using LTTng v2.5. I am not explicitly creating channels. I am only =
creating a session:
<span style=3D"font-family:&quot;Courier New&quot;,monospace">lttng create =
[session-name]</span>=C2=A0. It used to always just create a session and th=
en enable whichever available user tracepoint that I need (which out explic=
itly creating any channels).</p>
<p><br>
</p>
<p>Thanks,</p>
<p><br>
</p>
<p>Dilong<br style=3D"font-family:&quot;Courier New&quot;,monospace">
</p>
<br>
<div style=3D"color:rgb(46,52,54)">
<hr style=3D"display:inline-block;width:98%">
<div dir=3D"ltr"><font style=3D"font-size:11pt" face=3D"Calibri, sans-serif=
" color=3D"#000000"><b>From:</b> <a href=3D"mailto:jeremie.galarneau@gmail.=
com" target=3D"_blank">jeremie.galarneau@gmail.com</a> &lt;<a href=3D"mailt=
o:jeremie.galarneau@gmail.com" target=3D"_blank">jeremie.galarneau@gmail.co=
m</a>&gt; on behalf of J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:je=
remie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.=
com</a>&gt;<br>
<b>Sent:</b> Tuesday, July 7, 2015 11:20 AM<br>
<b>To:</b> Dilong Zheng<br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> Re: [lttng-dev] UST Create Channel Failed, Why?</font>
<div>=C2=A0</div>
</div>
<div>
<div dir=3D"ltr">Hi Dilong,
<div><br>
</div>
<div>How do you create this channel and using which version of LTTng?</div>
<div><br>
</div>
<div>J=C3=A9r=C3=A9mie</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng <sp=
an dir=3D"ltr">
&lt;<a title=3D"Ctrl+Click or tap to follow the link" href=3D"mailto:Dilong=
.Zheng@mitel.com" target=3D"_blank">Dilong.Zheng@mitel.com</a>&gt;</span> w=
rote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div dir=3D"ltr">
<div style=3D"font-size:12pt;color:#000000;background-color:#ffffff;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif">
<p>Hi all,</p>
<p><br>
</p>
<p>While trying to enable UST events, I get the following error message:</p=
>
<p><br>
</p>
<p><span style=3D"font-family:&quot;Courier New&quot;,monospace">Error: Eve=
nt mitel:sem_wait_entry: UST create channel failed (channel channel0, sessi=
on mcdUST3)</span></p>
<p><br>
</p>
<p>When I type: <span style=3D"font-family:&quot;Courier New&quot;,monospac=
e"></span><span style=3D"font-family:&quot;Courier New&quot;,monospace">ltt=
ng list -u</span>
<span style=3D"font-family:Calibri,Arial,Helvetica,sans-serif">I am able to=
 see a list of all my UST tracepoints.</span><br>
</p>
<p>Could someone please provide some insight as to why this error is appear=
ing and steps I could take to fix this error. Thanks.</p>
<p><br>
</p>
<p><br>
<br>
</p>
</div>
</div>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br>
</blockquote>
</div>
<br>
<br clear=3D"all">
<div><br>
</div>
-- <br>
<div>J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</div>
</div>
</div>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div>

--047d7bd74e6ca6762f051a4c23c7--


--===============0323266213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0323266213==--
