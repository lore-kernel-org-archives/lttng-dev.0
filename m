From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: UST Create Channel Failed, Why?
Date: Tue, 7 Jul 2015 11:20:36 -0400
Message-ID: <CA+jJMxs9SYDJpYyk8jMxRGfxZ1SzaBQbmqkA5dNFOvELJ1N40Q__12597.7854048417$1436282524$gmane$org@mail.gmail.com>
References: <SN1PR12MB0319A4CF7ED35B7D250426BC9B930@SN1PR12MB0319.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1731909576=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZCUfq-00072T-GZ
 for lttng-dev@lists.lttng.org; Tue, 07 Jul 2015 11:20:46 -0400
Received: by pdbep18 with SMTP id ep18so127535288pdb.1
 for <lttng-dev@lists.lttng.org>; Tue, 07 Jul 2015 08:20:36 -0700 (PDT)
In-Reply-To: <SN1PR12MB0319A4CF7ED35B7D250426BC9B930@SN1PR12MB0319.namprd12.prod.outlook.com>
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

--===============1731909576==
Content-Type: multipart/alternative; boundary=047d7b5d848d707435051a4a9024

--047d7b5d848d707435051a4a9024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Dilong,

How do you create this channel and using which version of LTTng?

J=C3=A9r=C3=A9mie

On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng <Dilong.Zheng@mitel.com> wrote=
:

>  Hi all,
>
>
>  While trying to enable UST events, I get the following error message:
>
>
>  Error: Event mitel:sem_wait_entry: UST create channel failed (channel
> channel0, session mcdUST3)
>
>
>  When I type: lttng list -u I am able to see a list of all my UST
> tracepoints.
>
> Could someone please provide some insight as to why this error is
> appearing and steps I could take to fix this error. Thanks.
>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b5d848d707435051a4a9024
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Dilong,<div><br></div><div>How do you create this chann=
el and using which version of LTTng?</div><div><br></div><div>J=C3=A9r=C3=
=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng <span dir=3D"ltr">&lt;<a href=
=3D"mailto:Dilong.Zheng@mitel.com" target=3D"_blank">Dilong.Zheng@mitel.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">




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

<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--047d7b5d848d707435051a4a9024--


--===============1731909576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1731909576==--
