From: Dilong Zheng <Dilong.Zheng@mitel.com>
Subject: Re: UST Create Channel Failed, Why?
Date: Tue, 7 Jul 2015 15:26:36 +0000
Message-ID: <SN1PR12MB03190B1482175C51A50586249B920__38999.761027708$1436282859$gmane$org@SN1PR12MB0319.namprd12.prod.outlook.com>
References: <SN1PR12MB0319A4CF7ED35B7D250426BC9B930@SN1PR12MB0319.namprd12.prod.outlook.com>,
 <CA+jJMxs9SYDJpYyk8jMxRGfxZ1SzaBQbmqkA5dNFOvELJ1N40Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1018652633=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-by2on0059.outbound.protection.outlook.com ([207.46.100.59]
 helo=na01-by2-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Dilong.Zheng@mitel.com>) id 1ZCUlh-00075u-Dd
 for lttng-dev@lists.lttng.org; Tue, 07 Jul 2015 11:26:46 -0400
In-Reply-To: <CA+jJMxs9SYDJpYyk8jMxRGfxZ1SzaBQbmqkA5dNFOvELJ1N40Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1018652633==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB03190B1482175C51A50586249B920SN1PR12MB0319namp_"

--_000_SN1PR12MB03190B1482175C51A50586249B920SN1PR12MB0319namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jeremie,


I am using LTTng v2.5. I am not explicitly creating channels. I am only cre=
ating a session: lttng create [session-name] . It used to always just creat=
e a session and then enable whichever available user tracepoint that I need=
 (which out explicitly creating any channels).


Thanks,


Dilong

________________________________
From: jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on behalf o=
f J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
Sent: Tuesday, July 7, 2015 11:20 AM
To: Dilong Zheng
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] UST Create Channel Failed, Why?

Hi Dilong,

How do you create this channel and using which version of LTTng?

J=E9r=E9mie

On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng <Dilong.Zheng@mitel.com<mailto=
:Dilong.Zheng@mitel.com>> wrote:

Hi all,


While trying to enable UST events, I get the following error message:


Error: Event mitel:sem_wait_entry: UST create channel failed (channel chann=
el0, session mcdUST3)


When I type: lttng list -u I am able to see a list of all my UST tracepoint=
s.

Could someone please provide some insight as to why this error is appearing=
 and steps I could take to fix this error. Thanks.




_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev




--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--_000_SN1PR12MB03190B1482175C51A50586249B920SN1PR12MB0319namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Jeremie,</p>
<p><br>
</p>
<p>I am using LTTng v2.5. I am not explicitly creating channels. I am only =
creating a session:
<span style=3D"font-family: &quot;Courier New&quot;,monospace;">lttng creat=
e [session-name]</span>&nbsp;. It used to always just create a session and =
then enable whichever available user tracepoint that I need (which out expl=
icitly creating any channels).</p>
<p><br>
</p>
<p>Thanks,</p>
<p><br>
</p>
<p>Dilong<br style=3D"font-family: &quot;Courier New&quot;,monospace;">
</p>
<br>
<div style=3D"color: rgb(46, 52, 54);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> jeremie.galarneau@g=
mail.com &lt;jeremie.galarneau@gmail.com&gt; on behalf of J=E9r=E9mie Galar=
neau &lt;jeremie.galarneau@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, July 7, 2015 11:20 AM<br>
<b>To:</b> Dilong Zheng<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] UST Create Channel Failed, Why?</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Hi Dilong,
<div><br>
</div>
<div>How do you create this channel and using which version of LTTng?</div>
<div><br>
</div>
<div>J=E9r=E9mie</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng <sp=
an dir=3D"ltr">
&lt;<a title=3D"Ctrl&#43;Click or tap to follow the link" href=3D"mailto:Di=
long.Zheng@mitel.com" target=3D"_blank">Dilong.Zheng@mitel.com</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div style=3D"font-size:12pt; color:#000000; background-color:#ffffff; font=
-family:Calibri,Arial,Helvetica,sans-serif">
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
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
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
<div class=3D"gmail_signature">J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SN1PR12MB03190B1482175C51A50586249B920SN1PR12MB0319namp_--


--===============1018652633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1018652633==--
