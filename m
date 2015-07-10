From: Dilong Zheng <Dilong.Zheng@mitel.com>
Subject: Re: Enabling Syscalls LTTng v2.5.1
Date: Fri, 10 Jul 2015 12:51:32 +0000
Message-ID: <DM2PR12MB0314E2AFBE343911C07BB8309B9F0__42133.3287879408$1436532771$gmane$org@DM2PR12MB0314.namprd12.prod.outlook.com>
References: <DM2PR12MB03148D7374C0C505D2D8EAB19B900@DM2PR12MB0314.namprd12.prod.outlook.com>,
 <CA+jJMxs1+j+AAJyKCzKi71sXW4Bv73Zjj_FTfduLQL-LW5O+vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2040711030=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-by2on0085.outbound.protection.outlook.com ([207.46.100.85]
 helo=na01-by2-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Dilong.Zheng@mitel.com>) id 1ZDXmI-0002pL-4y
 for lttng-dev@lists.lttng.org; Fri, 10 Jul 2015 08:51:47 -0400
In-Reply-To: <CA+jJMxs1+j+AAJyKCzKi71sXW4Bv73Zjj_FTfduLQL-LW5O+vg@mail.gmail.com>
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

--===============2040711030==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM2PR12MB0314E2AFBE343911C07BB8309B9F0DM2PR12MB0314namp_"

--_000_DM2PR12MB0314E2AFBE343911C07BB8309B9F0DM2PR12MB0314namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

https://bugs.lttng.org/issues/644 <- thats the link I read from. I have not=
 yet trie with the latest 2.5.x release I will soon though.


Thanks,


Dilong

________________________________
From: jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on behalf o=
f J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
Sent: Thursday, July 9, 2015 10:36 AM
To: Dilong Zheng
Cc: lttng-dev@lists.lttng.org
Subject: Re: Enabling Syscalls LTTng v2.5.1


On Jul 9, 2015 9:23 AM, "Dilong Zheng" <Dilong.Zheng@mitel.com<mailto:Dilon=
g.Zheng@mitel.com>> wrote:
>
> Hi Jeremie,
>
>
> I am attempting to enable syscalls by doing: lttng enable-event -a -k --s=
yscall but I am received a warning: "Warning: Kernel events already enabled=
". From searching online, I read that the warning is just a UI issue and do=
esn't actually

Can you provide a link to this?
Have you tried with the latest 2.5.x release?

Thanks,
J=E9r=E9mie

affect the functionality of LTTng; that the syscalls are actually being ena=
bled. However when viewing the kernel trace inside TraceCompass or Tracealy=
zer I do barely ever see any system calls. The only syscalls that appear if=
 any are almost always "clone". I am currently using Fedora 22, x86 archite=
cture. Be great to get some insight regarding the warning and what I could =
be doing better to see syscalls by enabling the event. Thanks for your help=
.
>
>
> Dilong Zheng

--_000_DM2PR12MB0314E2AFBE343911C07BB8309B9F0DM2PR12MB0314namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><a id=3D"LPlnk235965" href=3D"https://bugs.lttng.org/issues/644">https:/=
/bugs.lttng.org/issues/644</a> &lt;- thats the link I read from. I have not=
 yet trie with the latest 2.5.x release I will soon though.</p>
<p><br>
</p>
<p>Thanks,</p>
<p><br>
</p>
<p>Dilong<br>
</p>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> jeremie.galarneau@g=
mail.com &lt;jeremie.galarneau@gmail.com&gt; on behalf of J=E9r=E9mie Galar=
neau &lt;jeremie.galarneau@efficios.com&gt;<br>
<b>Sent:</b> Thursday, July 9, 2015 10:36 AM<br>
<b>To:</b> Dilong Zheng<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: Enabling Syscalls LTTng v2.5.1</font>
<div>&nbsp;</div>
</div>
<div>
<p dir=3D"ltr"><br>
On Jul 9, 2015 9:23 AM, &quot;Dilong Zheng&quot; &lt;<a href=3D"mailto:Dilo=
ng.Zheng@mitel.com">Dilong.Zheng@mitel.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Jeremie,<br>
&gt;<br>
&gt;<br>
&gt; I am attempting to enable syscalls by doing: lttng enable-event -a -k =
--syscall but I am received a warning: &quot;Warning: Kernel events already=
 enabled&quot;. From searching online, I read that the warning is just a UI=
 issue and doesn't actually</p>
<p dir=3D"ltr">Can you provide a link to this?<br>
Have you tried with the latest 2.5.x release?</p>
<p dir=3D"ltr">Thanks,<br>
J=E9r=E9mie</p>
<p dir=3D"ltr">affect the functionality of LTTng; that the syscalls are act=
ually being enabled. However when viewing the kernel trace inside TraceComp=
ass or Tracealyzer I do barely ever see any system calls. The only syscalls=
 that appear if any are almost always
 &quot;clone&quot;. I am currently using Fedora 22, x86 architecture. Be gr=
eat to get some insight regarding the warning and what I could be doing bet=
ter to see syscalls by enabling the event. Thanks for your help.<br>
&gt;<br>
&gt;<br>
&gt; Dilong Zheng<br>
</p>
</div>
</div>
</body>
</html>

--_000_DM2PR12MB0314E2AFBE343911C07BB8309B9F0DM2PR12MB0314namp_--


--===============2040711030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2040711030==--
