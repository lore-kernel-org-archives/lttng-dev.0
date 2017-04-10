From: Jeffrey Chen <cpthk@live.com>
Subject: Re: LTTng on Docker
Date: Mon, 10 Apr 2017 18:50:34 +0000
Message-ID: <CY4PR13MB15266E0923AB26568F163499C7010__32676.2599907399$1491876246$gmane$org@CY4PR13MB1526.namprd13.prod.outlook.com>
References: <CY4PR13MB152689FB577CFBEF185495EAC70C0@CY4PR13MB1526.namprd13.prod.outlook.com>,
 <CA+jJMxvVeQFci4Yx5a=AJ-9NnSpxfbE00Jk8e2wnPZY67Hkk5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7174880566771031329=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-oln040092010077.outbound.protection.outlook.com [40.92.10.77])
 by lists.lttng.org (Postfix) with ESMTPS id 3w29N51nDQzCcl
 for <lttng-dev@lists.lttng.org>; Tue, 11 Apr 2017 02:04:20 +0000 (UTC)
In-Reply-To: <CA+jJMxvVeQFci4Yx5a=AJ-9NnSpxfbE00Jk8e2wnPZY67Hkk5g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7174880566771031329==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR13MB15266E0923AB26568F163499C7010CY4PR13MB1526namp_"

--_000_CY4PR13MB15266E0923AB26568F163499C7010CY4PR13MB1526namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Forgot to add the versions.

My environment is:

Docker: 1.12.1, build 23cf638

LTTng 2.7.1, (default version in Ubuntu 16.04 repo)

Docker image: ubuntu:latest (16.04)


Thanks.


________________________________
From: jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on behalf o=
f J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
Sent: Sunday, April 9, 2017 2:06 PM
To: Jeffrey Chen
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] LTTng on Docker

On 7 April 2017 at 18:35, Jeffrey Chen <cpthk@live.com> wrote:
> Hi:
>
>
> I am trying to have LTTng UST tracing inside a docker container. I wasn't
> able to get the UST tracing working. LTTng would not write any UST trace
> files in the directory, even though it printed it would. Has it been test=
ed
> before? Is there any known problem?

Tracing inside a container (not Docker), where the LTTng daemons and
the applications are running in the same container, is known to work
as this is how most of the LTTng CI works.

As far as Docker is concerned, I tested it a number of times and it
worked. Can you provide the versions of LTTng and Docker you're using
and the session daemon's logs (launching it with the -vvv option)?

Thanks,
J=E9r=E9mie

>
>
> $ lttng enable-channel --session test --userspace channel0
>
> Error: Channel channel0: UST create channel failed (session ServiceFabric=
_0)
> Error: Command error
>
>
> Thanks.
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
lttng-dev Info Page<https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev>
lists.lttng.org
To see the collection of prior postings to the list, visit the lttng-dev Ar=
chives. Using lttng-dev: To post a message to all the list members, send ..=
.


>



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
EfficiOS<http://www.efficios.com/>
www.efficios.com
At EfficiOS, our main goal is diminishing the amount of time our clients sp=
end identifying faults. We also enable our clients' applications to scale o=
n massive multi ...



--_000_CY4PR13MB15266E0923AB26568F163499C7010CY4PR13MB1526namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Forgot to add the versions.</p>
<p>My environment is:</p>
<p><span>Docker: 1.12.1, build 23cf638</span></p>
<p>LTTng 2.7.1, (default version in Ubuntu 16.04 repo)</p>
<p>Docker image: ubuntu:latest (16.04)</p>
<p><br>
</p>
<p>Thanks.<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> jeremie.galarneau@g=
mail.com &lt;jeremie.galarneau@gmail.com&gt; on behalf of J=E9r=E9mie Galar=
neau &lt;jeremie.galarneau@efficios.com&gt;<br>
<b>Sent:</b> Sunday, April 9, 2017 2:06 PM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] LTTng on Docker</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 7 April 2017 at 18:35, Jeffrey Chen &lt;cpthk@l=
ive.com&gt; wrote:<br>
&gt; Hi:<br>
&gt;<br>
&gt;<br>
&gt; I am trying to have LTTng UST tracing inside a docker container. I was=
n't<br>
&gt; able to get the UST tracing working. LTTng would not write any UST tra=
ce<br>
&gt; files in the directory, even though it printed it would. Has it been t=
ested<br>
&gt; before? Is there any known problem?<br>
<br>
Tracing inside a container (not Docker), where the LTTng daemons and<br>
the applications are running in the same container, is known to work<br>
as this is how most of the LTTng CI works.<br>
<br>
As far as Docker is concerned, I tested it a number of times and it<br>
worked. Can you provide the versions of LTTng and Docker you're using<br>
and the session daemon's logs (launching it with the -vvv option)?<br>
<br>
Thanks,<br>
J=E9r=E9mie<br>
<br>
&gt;<br>
&gt;<br>
&gt; $ lttng enable-channel --session test --userspace channel0<br>
&gt;<br>
&gt; Error: Channel channel0: UST create channel failed (session ServiceFab=
ric_0)<br>
&gt; Error: Command error<br>
&gt;<br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 id=3D"LPlnk535771" previewremoved=3D"true">
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
<div id=3D"LPBorder_GT_14918500589430.5773051133579731" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14918500589380.33559500912603846" style=3D"width: =
90%; background-color: rgb(255, 255, 255); position: relative; overflow: au=
to; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: =
1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200)=
;" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_14918500589390.545817820893863" style=3D"vertical-align:=
 top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2"=
>
<div id=3D"LPRemovePreviewContainer_14918500589390.19075971417171111"></div=
>
<div id=3D"LPTitle_14918500589400.3937147003517715" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quo=
t;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,&quot;Apple Color=
 Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbo=
l&quot;,&quot;Android Emoji&quot;,EmojiSymbols,sans-serif; line-height: 21p=
x;">
<a id=3D"LPUrlAnchor_14918500589410.6778783578127024" style=3D"text-decorat=
ion: none;" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" target=3D"_blank">lttng-dev Info Page</a></div>
<div id=3D"LPMetadata_14918500589410.6276000969024302" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmo=
ji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols,sans-=
serif; font-size: 14px; line-height: 14px;">
lists.lttng.org</div>
<div id=3D"LPDescription_14918500589420.14883062087535615" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Ari=
al,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,=
&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols,sans-ser=
if; font-size: 14px; line-height: 20px; max-height: 100px; overflow: hidden=
;">
To see the collection of prior postings to the list, visit the lttng-dev Ar=
chives. Using lttng-dev: To post a message to all the list members, send ..=
.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
&gt;<br>
<br>
<br>
<br>
-- <br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" id=3D"LPlnk337621" previewremoved=3D"tr=
ue">http://www.efficios.com</a>
<div id=3D"LPBorder_GT_14918500589280.29225093033000105" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14918500589230.8456043234743867" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_14918500589240.349607617488226" style=3D"vertical-align:=
 top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2"=
>
<div id=3D"LPRemovePreviewContainer_14918500589250.200938956581464"></div>
<div id=3D"LPTitle_14918500589250.09652577117808792" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot=
;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&qu=
ot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,&quot;Apple Colo=
r Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symb=
ol&quot;,&quot;Android Emoji&quot;,EmojiSymbols,sans-serif; line-height: 21=
px;">
<a id=3D"LPUrlAnchor_14918500589260.5704384596458033" style=3D"text-decorat=
ion: none;" href=3D"http://www.efficios.com/" target=3D"_blank">EfficiOS</a=
></div>
<div id=3D"LPMetadata_14918500589260.5842080703589804" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmo=
ji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols,sans-=
serif; font-size: 14px; line-height: 14px;">
www.efficios.com</div>
<div id=3D"LPDescription_14918500589270.38199620539789525" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Ari=
al,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,=
&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols,sans-ser=
if; font-size: 14px; line-height: 20px; max-height: 100px; overflow: hidden=
;">
At EfficiOS, our main goal is diminishing the amount of time our clients sp=
end identifying faults. We also enable our clients' applications to scale o=
n massive multi ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR13MB15266E0923AB26568F163499C7010CY4PR13MB1526namp_--

--===============7174880566771031329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7174880566771031329==--
