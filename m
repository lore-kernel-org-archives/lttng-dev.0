From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: LTTng on Docker
Date: Mon, 10 Apr 2017 15:26:46 -0400
Message-ID: <CA+jJMxs1Qn=WOQ087VYb3sKHxvd8NL-=o6FzCt44pRufNVvq7w__48719.9230389253$1491852419$gmane$org@mail.gmail.com>
References: <CY4PR13MB152689FB577CFBEF185495EAC70C0@CY4PR13MB1526.namprd13.prod.outlook.com>
 <CA+jJMxvVeQFci4Yx5a=AJ-9NnSpxfbE00Jk8e2wnPZY67Hkk5g@mail.gmail.com>
 <CY4PR13MB1526BBB771C31BF53C41C6C4C7010@CY4PR13MB1526.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7855634572139903001=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3w20Yv0fJxzyF1
 for <lttng-dev@lists.lttng.org>; Mon, 10 Apr 2017 19:27:14 +0000 (UTC)
Received: by mail-yb0-x243.google.com with SMTP id l201so5807813ybf.3
 for <lttng-dev@lists.lttng.org>; Mon, 10 Apr 2017 12:26:47 -0700 (PDT)
In-Reply-To: <CY4PR13MB1526BBB771C31BF53C41C6C4C7010@CY4PR13MB1526.namprd13.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeffrey Chen <cpthk@live.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7855634572139903001==
Content-Type: multipart/alternative; boundary=001a1147399abe6b09054cd4f426

--001a1147399abe6b09054cd4f426
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10 April 2017 at 14:06, Jeffrey Chen <cpthk@live.com> wrote:

> I have attached the logs from the lttng daemon. I could see errors like
> below.
>
>
> Error: Error creating UST channel "channel0" on the consumer daemon
>
>
> My commands to create a session are:
>
> lttng create test
> lttng enable-channel --session test --userspace --tracefile-size 8388608
> --subbuf-size 8388608 channel0
> lttng enable-event --channel channel0 --userspace "service:*"
> lttng add-context -u -t vtid
> lttng add-context -u -t vpid
> lttng start
>

Thanks for the info. Can you try to create the channel with the default
values and see if it works?

$ lttng enable-channel --session test --userspace channel0

Also, can you re-capture the session daemon logs launching it with the
"-vvv --verbose-consumer" option since the problem appears to occur on the
consumer's end.

Thanks,
J=C3=A9r=C3=A9mie


> Installed:
> apt-get -y install lttng-tools lttng-modules-dkms liblttng-ust0
> liblttng-ust-dev
>
> Thanks.
>
> ------------------------------
> *From:* jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on
> behalf of J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
> *Sent:* Sunday, April 9, 2017 2:06 PM
> *To:* Jeffrey Chen
> *Cc:* lttng-dev@lists.lttng.org
> *Subject:* Re: [lttng-dev] LTTng on Docker
>
> On 7 April 2017 at 18:35, Jeffrey Chen <cpthk@live.com> wrote:
> > Hi:
> >
> >
> > I am trying to have LTTng UST tracing inside a docker container. I wasn=
't
> > able to get the UST tracing working. LTTng would not write any UST trac=
e
> > files in the directory, even though it printed it would. Has it been
> tested
> > before? Is there any known problem?
>
> Tracing inside a container (not Docker), where the LTTng daemons and
> the applications are running in the same container, is known to work
> as this is how most of the LTTng CI works.
>
> As far as Docker is concerned, I tested it a number of times and it
> worked. Can you provide the versions of LTTng and Docker you're using
> and the session daemon's logs (launching it with the -vvv option)?
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
> >
> >
> > $ lttng enable-channel --session test --userspace channel0
> >
> > Error: Channel channel0: UST create channel failed (session
> ServiceFabric_0)
> > Error: Command error
> >
> >
> > Thanks.
> >
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> lttng-dev Info Page
> <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
> lists.lttng.org
> To see the collection of prior postings to the list, visit the lttng-dev
> Archives. Using lttng-dev: To post a message to all the list members, sen=
d
> ...
>
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
> EfficiOS <http://www.efficios.com/>
> www.efficios.com
> At EfficiOS, our main goal is diminishing the amount of time our clients
> spend identifying faults. We also enable our clients' applications to sca=
le
> on massive multi ...
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1147399abe6b09054cd4f426
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 10 April 2017 at 14:06, Jeffrey Chen <span dir=3D"ltr">&lt;<a href=
=3D"mailto:cpthk@live.com" target=3D"_blank">cpthk@live.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"gmail-m_-3517871239381958006divtagdefaultwrapper" style=3D"font-=
size:12pt;color:rgb(0,0,0);font-family:calibri,arial,helvetica,sans-serif" =
dir=3D"ltr">
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
lttng start<br></div></div></div></blockquote><div><br></div><div>Thanks fo=
r the info. Can you try to create the channel with the default values and s=
ee if it works?</div><div><br></div><div>$=C2=A0lttng enable-channel --sess=
ion test --userspace channel0</div><div>=C2=A0</div><div>Also, can you re-c=
apture the session daemon logs launching it with the &quot;-vvv --verbose-c=
onsumer&quot; option since the problem appears to occur on the consumer&#39=
;s end.</div><div><br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie</div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div id=3D"gmail-m_-3517871239381958006divtagdefaultwrapper" style=3D=
"font-size:12pt;color:rgb(0,0,0);font-family:calibri,arial,helvetica,sans-s=
erif" dir=3D"ltr"><div>
<br>
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
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_-3517871239381958006x_divRplyFwdMsg" dir=3D"ltr"><font s=
tyle=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>F=
rom:</b> <a href=3D"mailto:jeremie.galarneau@gmail.com" target=3D"_blank">j=
eremie.galarneau@gmail.com</a> &lt;<a href=3D"mailto:jeremie.galarneau@gmai=
l.com" target=3D"_blank">jeremie.galarneau@gmail.com</a>&gt; on behalf of J=
=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios=
.com" target=3D"_blank">jeremie.galarneau@efficios.<wbr>com</a>&gt;<br>
<b>Sent:</b> Sunday, April 9, 2017 2:06 PM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> Re: [lttng-dev] LTTng on Docker</font>
<div>=C2=A0</div>
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
n&#39;t<br>
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
worked. Can you provide the versions of LTTng and Docker you&#39;re using<b=
r>
and the session daemon&#39;s logs (launching it with the -vvv option)?<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
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
https://lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a>
</span><div id=3D"gmail-m_-3517871239381958006LPBorder_GT_14918472778530.77=
49348336754354" style=3D"margin-bottom:20px;overflow:auto;width:100%;text-i=
ndent:0px">
<table id=3D"gmail-m_-3517871239381958006LPContainer_14918472778450.5226343=
4094437" style=3D"width:90%;background-color:rgb(255,255,255);overflow:auto=
;padding-top:20px;padding-bottom:20px;margin-top:20px;border-top:1px dotted=
 rgb(200,200,200);border-bottom:1px dotted rgb(200,200,200)" cellspacing=3D=
"0">
<tbody>
<tr valign=3D"top">
<td id=3D"gmail-m_-3517871239381958006TextCell_14918472778480.4117515003584=
903" style=3D"vertical-align:top;padding:0px;display:table-cell" colspan=3D=
"2">
<div id=3D"gmail-m_-3517871239381958006LPRemovePreviewContainer_14918472778=
480.343333967527086"></div>
<div id=3D"gmail-m_-3517871239381958006LPTitle_14918472778480.8766887868350=
135" style=3D"color:rgb(0,120,215);font-weight:400;font-size:21px;font-fami=
ly:wf_segoe-ui_light,&quot;segoe ui light&quot;,&quot;segoe wp light&quot;,=
&quot;segoe ui&quot;,&quot;segoe wp&quot;,tahoma,arial,&quot;apple color em=
oji&quot;,&quot;segoe ui emoji&quot;,notocoloremoji,&quot;segoe ui symbol&q=
uot;,&quot;android emoji&quot;,emojisymbols,sans-serif;line-height:21px">
<a id=3D"gmail-m_-3517871239381958006LPUrlAnchor_14918472778490.70798860273=
54777" style=3D"text-decoration:none" href=3D"https://lists.lttng.org/cgi-b=
in/mailman/listinfo/lttng-dev" target=3D"_blank">lttng-dev Info Page</a></d=
iv>
<div id=3D"gmail-m_-3517871239381958006LPMetadata_14918472778500.4711223158=
9813147" style=3D"margin:10px 0px 16px;color:rgb(102,102,102);font-weight:4=
00;font-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&quot;=
,tahoma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,noto=
coloremoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisymbo=
ls,sans-serif;font-size:14px;line-height:14px">
<a href=3D"http://lists.lttng.org" target=3D"_blank">lists.lttng.org</a></d=
iv>
<div id=3D"gmail-m_-3517871239381958006LPDescription_14918472778520.6602582=
148353134" style=3D"display:block;color:rgb(102,102,102);font-weight:400;fo=
nt-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&quot;,taho=
ma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,notocolor=
emoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisymbols,sa=
ns-serif;font-size:14px;line-height:20px;max-height:100px;overflow:hidden">
To see the collection of prior postings to the list, visit the lttng-dev Ar=
chives. Using lttng-dev: To post a message to all the list members, send ..=
.</div>
</td>
</tr>
</tbody>
</table>
</div><span class=3D"gmail-">
<br>
&gt;<br>
<br>
<br>
<br>
-- <br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" id=3D"gmail-m_-3517871239381958006LPlnk=
440294" target=3D"_blank">http://www.efficios.com</a>
</span><div id=3D"gmail-m_-3517871239381958006LPBorder_GT_14918473357550.24=
8963055382728" style=3D"margin-bottom:20px;overflow:auto;width:100%;text-in=
dent:0px">
<table id=3D"gmail-m_-3517871239381958006LPContainer_14918473357460.4144245=
49224911" style=3D"width:90%;background-color:rgb(255,255,255);overflow:aut=
o;padding-top:20px;padding-bottom:20px;margin-top:20px;border-top:1px dotte=
d rgb(200,200,200);border-bottom:1px dotted rgb(200,200,200)" cellspacing=
=3D"0">
<tbody>
<tr valign=3D"top">
<td id=3D"gmail-m_-3517871239381958006TextCell_14918473357480.9923752452490=
312" style=3D"vertical-align:top;padding:0px;display:table-cell" colspan=3D=
"2">
<div id=3D"gmail-m_-3517871239381958006LPRemovePreviewContainer_14918473357=
480.48768909434730534"></div>
<div id=3D"gmail-m_-3517871239381958006LPTitle_14918473357490.5288885228874=
352" style=3D"color:rgb(0,120,215);font-weight:400;font-size:21px;font-fami=
ly:wf_segoe-ui_light,&quot;segoe ui light&quot;,&quot;segoe wp light&quot;,=
&quot;segoe ui&quot;,&quot;segoe wp&quot;,tahoma,arial,&quot;apple color em=
oji&quot;,&quot;segoe ui emoji&quot;,notocoloremoji,&quot;segoe ui symbol&q=
uot;,&quot;android emoji&quot;,emojisymbols,sans-serif;line-height:21px">
<a id=3D"gmail-m_-3517871239381958006LPUrlAnchor_14918473357500.70673789786=
25205" style=3D"text-decoration:none" href=3D"http://www.efficios.com/" tar=
get=3D"_blank">EfficiOS</a></div>
<div id=3D"gmail-m_-3517871239381958006LPMetadata_14918473357520.6810205760=
820718" style=3D"margin:10px 0px 16px;color:rgb(102,102,102);font-weight:40=
0;font-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&quot;,=
tahoma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,notoc=
oloremoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisymbol=
s,sans-serif;font-size:14px;line-height:14px">
<a href=3D"http://www.efficios.com" target=3D"_blank">www.efficios.com</a><=
/div>
<div id=3D"gmail-m_-3517871239381958006LPDescription_14918473357530.6577156=
845495322" style=3D"display:block;color:rgb(102,102,102);font-weight:400;fo=
nt-family:wf_segoe-ui_normal,&quot;segoe ui&quot;,&quot;segoe wp&quot;,taho=
ma,arial,&quot;apple color emoji&quot;,&quot;segoe ui emoji&quot;,notocolor=
emoji,&quot;segoe ui symbol&quot;,&quot;android emoji&quot;,emojisymbols,sa=
ns-serif;font-size:14px;line-height:20px;max-height:100px;overflow:hidden">
At EfficiOS, our main goal is diminishing the amount of time our clients sp=
end identifying faults. We also enable our clients&#39; applications to sca=
le on massive multi ...</div>
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

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div></div>

--001a1147399abe6b09054cd4f426--

--===============7855634572139903001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7855634572139903001==--
