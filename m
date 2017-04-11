From: Jeffrey Chen <cpthk@live.com>
Subject: Re: LTTng on Docker
Date: Tue, 11 Apr 2017 20:49:16 +0000
Message-ID: <CY4PR13MB1526D1CD28EF1A8341D8B868C7000__6245.45723335377$1492014057$gmane$org@CY4PR13MB1526.namprd13.prod.outlook.com>
References: <CY4PR13MB152689FB577CFBEF185495EAC70C0@CY4PR13MB1526.namprd13.prod.outlook.com>
 <CA+jJMxvVeQFci4Yx5a=AJ-9NnSpxfbE00Jk8e2wnPZY67Hkk5g@mail.gmail.com>
 <CY4PR13MB1526BBB771C31BF53C41C6C4C7010@CY4PR13MB1526.namprd13.prod.outlook.com>,
 <CA+jJMxs1Qn=WOQ087VYb3sKHxvd8NL-=o6FzCt44pRufNVvq7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4459273791582704781=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-oln040092002044.outbound.protection.outlook.com [40.92.2.44])
 by lists.lttng.org (Postfix) with ESMTPS id 3w38LJ5smZzCKy
 for <lttng-dev@lists.lttng.org>; Wed, 12 Apr 2017 16:21:12 +0000 (UTC)
In-Reply-To: <CA+jJMxs1Qn=WOQ087VYb3sKHxvd8NL-=o6FzCt44pRufNVvq7w@mail.gmail.com>
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

--===============4459273791582704781==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR13MB1526D1CD28EF1A8341D8B868C7000CY4PR13MB1526namp_"

--_000_CY4PR13MB1526D1CD28EF1A8341D8B868C7000CY4PR13MB1526namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I just tried using smaller value of subbuf size, and it works fine. I have =
16GB of memory in my host, so I should have more than enough memory. The sa=
me size works fine in my host machine. My Docker container does not have an=
y resource constraint. Do you know what could be the reason of the failure?

Thanks.


________________________________
From: jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on behalf o=
f J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
Sent: Monday, April 10, 2017 12:26 PM
To: Jeffrey Chen
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] LTTng on Docker



On 10 April 2017 at 14:06, Jeffrey Chen <cpthk@live.com<mailto:cpthk@live.c=
om>> wrote:

I have attached the logs from the lttng daemon. I could see errors like bel=
ow.


Error: Error creating UST channel "channel0" on the consumer daemon


My commands to create a session are:

lttng create test
lttng enable-channel --session test --userspace --tracefile-size 8388608 --=
subbuf-size 8388608 channel0
lttng enable-event --channel channel0 --userspace "service:*"
lttng add-context -u -t vtid
lttng add-context -u -t vpid
lttng start

Thanks for the info. Can you try to create the channel with the default val=
ues and see if it works?

$ lttng enable-channel --session test --userspace channel0

Also, can you re-capture the session daemon logs launching it with the "-vv=
v --verbose-consumer" option since the problem appears to occur on the cons=
umer's end.

Thanks,
J=E9r=E9mie


Installed:
apt-get -y install lttng-tools lttng-modules-dkms liblttng-ust0 liblttng-us=
t-dev


Thanks.

________________________________
From: jeremie.galarneau@gmail.com<mailto:jeremie.galarneau@gmail.com> <jere=
mie.galarneau@gmail.com<mailto:jeremie.galarneau@gmail.com>> on behalf of J=
=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com<mailto:jeremie.galarne=
au@efficios.com>>
Sent: Sunday, April 9, 2017 2:06 PM
To: Jeffrey Chen
Cc: lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] LTTng on Docker

On 7 April 2017 at 18:35, Jeffrey Chen <cpthk@live.com<mailto:cpthk@live.co=
m>> wrote:
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
> lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
lttng-dev Info Page<https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev>
lists.lttng.org<http://lists.lttng.org>
To see the collection of prior postings to the list, visit the lttng-dev Ar=
chives. Using lttng-dev: To post a message to all the list members, send ..=
.


>



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
EfficiOS<http://www.efficios.com/>
www.efficios.com<http://www.efficios.com>
At EfficiOS, our main goal is diminishing the amount of time our clients sp=
end identifying faults. We also enable our clients' applications to scale o=
n massive multi ...





--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--_000_CY4PR13MB1526D1CD28EF1A8341D8B868C7000CY4PR13MB1526namp_
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
<p>I just tried using smaller value of subbuf size, and it works fine. I ha=
ve 16GB of memory in my host, so I should have more than enough memory. The=
 same size works fine in my host machine. My Docker container does not have=
 any resource constraint. Do you
 know what could be the reason of the failure?</p>
<p>Thanks.<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> jeremie.galarneau@g=
mail.com &lt;jeremie.galarneau@gmail.com&gt; on behalf of J=E9r=E9mie Galar=
neau &lt;jeremie.galarneau@efficios.com&gt;<br>
<b>Sent:</b> Monday, April 10, 2017 12:26 PM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] LTTng on Docker</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr"><br>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On 10 April 2017 at 14:06, Jeffrey Chen <span di=
r=3D"ltr">
&lt;<a href=3D"mailto:cpthk@live.com" target=3D"_blank">cpthk@live.com</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; border=
-left:1px solid rgb(204,204,204); padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"gmail-m_-3517871239381958006divtagdefaultwrapper" dir=3D"ltr" st=
yle=3D"font-size:12pt; color:rgb(0,0,0); font-family:calibri,arial,helvetic=
a,sans-serif">
<p>I have attached the logs from the lttng daemon. I could see errors like =
below.</p>
<p><br>
</p>
<p></p>
<div><span style=3D"background-color:rgb(255,255,0)">Error: Error creating =
UST channel &quot;channel0&quot; on the consumer daemon</span><br>
</div>
<p></p>
<p><br>
</p>
<p>My commands to create a session are:</p>
<p></p>
<div>lttng create test<br>
lttng enable-channel --session test --userspace --tracefile-size 8388608 --=
subbuf-size 8388608 channel0<br>
lttng enable-event --channel channel0 --userspace &quot;service:*&quot;<br>
lttng add-context -u -t vtid<br>
lttng add-context -u -t vpid<br>
lttng start<br>
</div>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>Thanks for the info. Can you try to create the channel with the defaul=
t values and see if it works?</div>
<div><br>
</div>
<div>$&nbsp;lttng enable-channel --session test --userspace channel0</div>
<div>&nbsp;</div>
<div>Also, can you re-capture the session daemon logs launching it with the=
 &quot;-vvv --verbose-consumer&quot; option since the problem appears to oc=
cur on the consumer's end.</div>
<div><br>
</div>
<div>Thanks,</div>
<div>J=E9r=E9mie</div>
<div><br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; border=
-left:1px solid rgb(204,204,204); padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"gmail-m_-3517871239381958006divtagdefaultwrapper" dir=3D"ltr" st=
yle=3D"font-size:12pt; color:rgb(0,0,0); font-family:calibri,arial,helvetic=
a,sans-serif">
<div><br>
Installed:<br>
<span>apt-get -y install lttng-tools lttng-modules-dkms liblttng-ust0 <span=
>liblttng-ust-dev</span></span>
<br>
</div>
<br>
<p></p>
Thanks.<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr style=3D"display:inline-block; width:98%">
<div id=3D"gmail-m_-3517871239381958006x_divRplyFwdMsg" dir=3D"ltr"><font s=
tyle=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>F=
rom:</b>
<a href=3D"mailto:jeremie.galarneau@gmail.com" target=3D"_blank">jeremie.ga=
larneau@gmail.com</a> &lt;<a href=3D"mailto:jeremie.galarneau@gmail.com" ta=
rget=3D"_blank">jeremie.galarneau@gmail.com</a>&gt; on behalf of J=E9r=E9mi=
e Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D=
"_blank">jeremie.galarneau@efficios.<wbr>com</a>&gt;<br>
<b>Sent:</b> Sunday, April 9, 2017 2:06 PM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> Re: [lttng-dev] LTTng on Docker</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"gmail-m_-3517871239381958006PlainText"><span class=3D"gmail-"=
>On 7 April 2017 at 18:35, Jeffrey Chen &lt;<a href=3D"mailto:cpthk@live.co=
m" target=3D"_blank">cpthk@live.com</a>&gt; wrote:<br>
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
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 id=3D"gmail-m_-3517871239381958006LPlnk632716" target=3D"_blank">
https://lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a> </span>
<div id=3D"gmail-m_-3517871239381958006LPBorder_GT_14918472778530.774934833=
6754354" style=3D"margin-bottom:20px; overflow:auto; width:100%; text-inden=
t:0px">
<table id=3D"gmail-m_-3517871239381958006LPContainer_14918472778450.5226343=
4094437" style=3D"width:90%; background-color:rgb(255,255,255); overflow:au=
to; padding-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px =
dotted rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)" cellspa=
cing=3D"0">
<tbody>
<tr valign=3D"top">
<td id=3D"gmail-m_-3517871239381958006TextCell_14918472778480.4117515003584=
903" colspan=3D"2" style=3D"vertical-align:top; padding:0px; display:table-=
cell">
<div id=3D"gmail-m_-3517871239381958006LPRemovePreviewContainer_14918472778=
480.343333967527086">
</div>
<div id=3D"gmail-m_-3517871239381958006LPTitle_14918472778480.8766887868350=
135" style=3D"color:rgb(0,120,215); font-weight:400; font-size:21px; font-f=
amily:wf_segoe-ui_light,&quot;segoe ui light&quot;,&quot;segoe wp light&quo=
t;,&quot;segoe ui&quot;,&quot;segoe wp&quot;,tahoma,arial,&quot;apple color=
 emoji&quot;,&quot;segoe ui emoji&quot;,notocoloremoji,&quot;segoe ui symbo=
l&quot;,&quot;android emoji&quot;,emojisymbols,sans-serif; line-height:21px=
">
<a id=3D"gmail-m_-3517871239381958006LPUrlAnchor_14918472778490.70798860273=
54777" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank" style=3D"text-decoration:none">lttng-dev Info Page</a></d=
iv>
<div id=3D"gmail-m_-3517871239381958006LPMetadata_14918472778500.4711223158=
9813147" style=3D"margin:10px 0px 16px; color:rgb(102,102,102); font-weight=
:400; font-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&qu=
ot;,tahoma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,n=
otocoloremoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisy=
mbols,sans-serif; font-size:14px; line-height:14px">
<a href=3D"http://lists.lttng.org" target=3D"_blank">lists.lttng.org</a></d=
iv>
<div id=3D"gmail-m_-3517871239381958006LPDescription_14918472778520.6602582=
148353134" style=3D"display:block; color:rgb(102,102,102); font-weight:400;=
 font-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&quot;,t=
ahoma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,notoco=
loremoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisymbols=
,sans-serif; font-size:14px; line-height:20px; max-height:100px; overflow:h=
idden">
To see the collection of prior postings to the list, visit the lttng-dev Ar=
chives. Using lttng-dev: To post a message to all the list members, send ..=
.</div>
</td>
</tr>
</tbody>
</table>
</div>
<span class=3D"gmail-"><br>
&gt;<br>
<br>
<br>
<br>
-- <br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" id=3D"gmail-m_-3517871239381958006LPlnk=
440294" target=3D"_blank">http://www.efficios.com</a>
</span>
<div id=3D"gmail-m_-3517871239381958006LPBorder_GT_14918473357550.248963055=
382728" style=3D"margin-bottom:20px; overflow:auto; width:100%; text-indent=
:0px">
<table id=3D"gmail-m_-3517871239381958006LPContainer_14918473357460.4144245=
49224911" style=3D"width:90%; background-color:rgb(255,255,255); overflow:a=
uto; padding-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px=
 dotted rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)" cellsp=
acing=3D"0">
<tbody>
<tr valign=3D"top">
<td id=3D"gmail-m_-3517871239381958006TextCell_14918473357480.9923752452490=
312" colspan=3D"2" style=3D"vertical-align:top; padding:0px; display:table-=
cell">
<div id=3D"gmail-m_-3517871239381958006LPRemovePreviewContainer_14918473357=
480.48768909434730534">
</div>
<div id=3D"gmail-m_-3517871239381958006LPTitle_14918473357490.5288885228874=
352" style=3D"color:rgb(0,120,215); font-weight:400; font-size:21px; font-f=
amily:wf_segoe-ui_light,&quot;segoe ui light&quot;,&quot;segoe wp light&quo=
t;,&quot;segoe ui&quot;,&quot;segoe wp&quot;,tahoma,arial,&quot;apple color=
 emoji&quot;,&quot;segoe ui emoji&quot;,notocoloremoji,&quot;segoe ui symbo=
l&quot;,&quot;android emoji&quot;,emojisymbols,sans-serif; line-height:21px=
">
<a id=3D"gmail-m_-3517871239381958006LPUrlAnchor_14918473357500.70673789786=
25205" href=3D"http://www.efficios.com/" target=3D"_blank" style=3D"text-de=
coration:none">EfficiOS</a></div>
<div id=3D"gmail-m_-3517871239381958006LPMetadata_14918473357520.6810205760=
820718" style=3D"margin:10px 0px 16px; color:rgb(102,102,102); font-weight:=
400; font-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&quo=
t;,tahoma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,no=
tocoloremoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisym=
bols,sans-serif; font-size:14px; line-height:14px">
<a href=3D"http://www.efficios.com" target=3D"_blank">www.efficios.com</a><=
/div>
<div id=3D"gmail-m_-3517871239381958006LPDescription_14918473357530.6577156=
845495322" style=3D"display:block; color:rgb(102,102,102); font-weight:400;=
 font-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&quot;,t=
ahoma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,notoco=
loremoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisymbols=
,sans-serif; font-size:14px; line-height:20px; max-height:100px; overflow:h=
idden">
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
</div>
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
</div>
</body>
</html>

--_000_CY4PR13MB1526D1CD28EF1A8341D8B868C7000CY4PR13MB1526namp_--

--===============4459273791582704781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4459273791582704781==--
