From: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Subject: Re: Babel trace is throwing error while trying with -i
 lttng-live option
Date: Mon, 16 Feb 2015 10:33:03 +0000 (UTC)
Message-ID: <1012526699.3312416.1424082783825.JavaMail.yahoo__10592.2136492611$1424082864$gmane$org@mail.yahoo.com>
References: <CA+jJMxuy4rE9Lmcahupv8UVVUS=XRtDp0Ru8KtoKKktk2MnSbw@mail.gmail.com>
 <2049410326.3223875.1424076991840.JavaMail.yahoo@mail.yahoo.com>
Reply-To: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1649586209=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm30-vm2.bullet.mail.sg3.yahoo.com ([106.10.151.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ranganadh1991@yahoo.com>) id 1YNIzH-0005bZ-PW
 for lttng-dev@lists.lttng.org; Mon, 16 Feb 2015 05:33:15 -0500
In-Reply-To: <2049410326.3223875.1424076991840.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1649586209==
Content-Type: multipart/alternative;
	boundary="----=_Part_3312415_586895393.1424082783815"
Content-Length: 16329

------=_Part_3312415_586895393.1424082783815
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi,We are using babeltrace 1.2.4 and LTTng Trace Control 2.5.3.=C2=A0 Conti=
nously giving babeltrace is throwing this error. Sorry about previous conve=
rsation. I am actually getting this reading a snapshot session . I have giv=
en continously babeltrace and path to read the traces . Then I am getting t=
his error.We see below mentioned error while reading out traces using babel=
trace=E2=80=A6=20
=C2=A0
************************************************=20
[error] Unexpected end of packet. Either the trace data stream is corrupted=
 or metadata description does not match data layout.=20
[error] Reading event failed.=20
Error printing trace.=20
=C2=A0
************************************************=20

Thanks & Regards,K.V.Ranganadh.
=20

     On Monday, 16 February 2015 2:26 PM, Ranganadh Kanitmahanti <ranganadh=
1991@yahoo.com> wrote:
  =20

 Hi,
We are using "BabelTrace Trace Viewer and Converter 1.2.4 "

Thanks & Regards,K.V.Ranganadh.=20

     On Friday, 13 February 2015 8:19 PM, J=C3=A9r=C3=A9mie Galarneau <jere=
mie.galarneau@efficios.com> wrote:
  =20

=20

On Fri, Feb 13, 2015 at 12:47 AM, Ranganadh Kanitmahanti <ranganadh1991@yah=
oo.com> wrote:

Hi,
************************************************[error] Unexpected end of p=
acket. Either the trace data stream is corrupted or metadata description do=
es not match data layout.[error] Reading event failed.Error printing trace.=
=C2=A0************************************************
Can any body tell about this significance. I have seen a similar bug resolv=
ed Bug #686: stream parser should have a clearer error message when encount=
ering cross-packet fields - Babeltrace - LTTng bugs repositoryCan anybody t=
ell in which version the fix was released.


The fix only clarifies the error message. The corrupted stream probably can=
't be handled by Babeltrace anymore at that point. To answer your question,=
 that fix was introduced in v1.1.2 and is part of all v1.2.x releases.
Can you give us more information to reproduce the problem? Which version of=
 LTTng-Tools and Babeltrace are you using?
Thanks,J=C3=A9r=C3=A9mie=C2=A0

| =C2=A0 |
| =C2=A0 | =C2=A0 | =C2=A0 | =C2=A0 | =C2=A0 |
| Bug #686: stream parser should have a clearer error message when encounte=
ring cross-packet fields -...Redmine |
|  |
| View on bugs.lttng.org | Preview by Yahoo |
|  |
| =C2=A0 |



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev





--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

   =20

   
------=_Part_3312415_586895393.1424082783815
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;fo=
nt-size:12px"><div id=3D"yui_3_16_0_1_1424075672814_10037">hi,</div><div id=
=3D"yui_3_16_0_1_1424075672814_8947" dir=3D"ltr">We are using babeltrace 1.=
2.4 and LTTng Trace Control 2.5.3.&nbsp; Continously giving babeltrace is t=
hrowing this error. Sorry about previous conversation. I am actually gettin=
g this reading a snapshot session . I have given continously babeltrace and=
 path to read the traces . Then I am getting this error.</div><div id=3D"yu=
i_3_16_0_1_1424075672814_13600" dir=3D"ltr"><span class=3D"" id=3D"yui_3_16=
_0_1_1424075672814_13985" style=3D"FONT-FAMILY: 'Calibri','sans-serif'; FON=
T-SIZE: 10pt">We see below mentioned error while reading out traces using b=
abeltrace=E2=80=A6</span>=20
<span class=3D"" style=3D"FONT-FAMILY: 'Calibri','sans-serif'; FONT-SIZE: 1=
0pt"><br style=3D"" class=3D""></span>&nbsp;<span id=3D"yui_3_16_0_1_142407=
5672814_14003" class=3D"" style=3D"FONT-FAMILY: 'Calibri','sans-serif'; FON=
T-SIZE: 10pt"><br style=3D"" class=3D"">***********************************=
*************</span>=20
<span id=3D"yui_3_16_0_1_1424075672814_14004" class=3D"" style=3D"FONT-FAMI=
LY: 'Calibri','sans-serif'; FONT-SIZE: 10pt"><br style=3D"" class=3D"">[err=
or]=20
Unexpected end of packet. Either the trace data stream is corrupted or meta=
data=20
description does not match data layout.</span> <span class=3D"" style=3D"FO=
NT-FAMILY: 'Calibri','sans-serif'; FONT-SIZE: 10pt"><br style=3D"" class=3D=
"">[error] Reading=20
event failed.</span> <span class=3D"" style=3D"FONT-FAMILY: 'Calibri','sans=
-serif'; FONT-SIZE: 10pt"><br style=3D"" class=3D"">Error printing=20
trace.</span> <span class=3D"" style=3D"FONT-FAMILY: 'Calibri','sans-serif'=
; FONT-SIZE: 10pt"><br style=3D"" class=3D""></span>&nbsp;<span id=3D"yui_3=
_16_0_1_1424075672814_14384" class=3D"" style=3D"FONT-FAMILY: 'Calibri','sa=
ns-serif'; FONT-SIZE: 10pt"><br style=3D"" class=3D"">*********************=
***************************</span>=20
<span class=3D"" style=3D"FONT-FAMILY: 'Calibri','sans-serif'; FONT-SIZE: 1=
0pt"><br style=3D"" class=3D""></span></div><div id=3D"yui_3_16_0_1_1424075=
672814_12829" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_1_1424075672814_1=
3086" dir=3D"ltr">Thanks &amp; Regards,</div><div id=3D"yui_3_16_0_1_142407=
5672814_13601" dir=3D"ltr">K.V.Ranganadh.<br></div><div id=3D"yui_3_16_0_1_=
1424075672814_8946"><span></span></div> <div class=3D"qtdSeparateBR"><br><b=
r></div><div style=3D"display: block;" class=3D"yahoo_quoted"> <div style=
=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Gr=
ande, Sans-Serif; font-size: 12px;"> <div style=3D"font-family: HelveticaNe=
ue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif; font-size:=
 12px;"> <div dir=3D"ltr"> <font size=3D"2" face=3D"Arial"> On Monday, 16 F=
ebruary 2015 2:26 PM, Ranganadh Kanitmahanti &lt;ranganadh1991@yahoo.com&gt=
; wrote:<br> </font> </div>  <br><br> <div class=3D"y_msg_container"><div i=
d=3D"yiv5417939430"><div><div style=3D"color:#000;background-color:#fff;fon=
t-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sa=
ns-Serif;font-size:12px;"><div id=3D"yiv5417939430yui_3_16_0_1_142407567281=
4_5451">Hi,</div><div id=3D"yiv5417939430yui_3_16_0_1_1424075672814_5450"><=
br clear=3D"none"></div><div class=3D"yiv5417939430" dir=3D"ltr" id=3D"yiv5=
417939430yui_3_16_0_1_1424075672814_5449" style=3D"">We are using<span clas=
s=3D"yiv5417939430" id=3D"yiv5417939430yui_3_16_0_1_1424075672814_5038" sty=
le=3D"font-size:9pt;font-family:Segoe UI;color:rgb(0, 0, 0);"> "BabelTrace =
Trace Viewer and Converter 1.2.4</span> "<br clear=3D"none"><br clear=3D"no=
ne"></div><div dir=3D"ltr" id=3D"yiv5417939430yui_3_16_0_1_1424075672814_50=
31"><span id=3D"yiv5417939430yui_3_16_0_1_1424075672814_5209">Thanks &amp; =
Regards,</span></div><div dir=3D"ltr" id=3D"yiv5417939430yui_3_16_0_1_14240=
75672814_5231"><span id=3D"yiv5417939430yui_3_16_0_1_1424075672814_5209">K.=
V.Ranganadh.</span></div> <div class=3D"yiv5417939430qtdSeparateBR"><br cle=
ar=3D"none"><br clear=3D"none"></div><div class=3D"yiv5417939430yqt81329701=
34" id=3D"yiv5417939430yqt56366"><div class=3D"yiv5417939430yahoo_quoted" s=
tyle=3D"display:block;"> <div style=3D"font-family:HelveticaNeue, Helvetica=
 Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;font-size:12px;"> <div s=
tyle=3D"font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida=
 Grande, Sans-Serif;font-size:12px;"> <div dir=3D"ltr"> <font size=3D"2" fa=
ce=3D"Arial"> On Friday, 13 February 2015 8:19 PM, J=C3=A9r=C3=A9mie Galarn=
eau &lt;jeremie.galarneau@efficios.com&gt; wrote:<br clear=3D"none"> </font=
> </div>  <br clear=3D"none"><br clear=3D"none"> <div class=3D"yiv541793943=
0y_msg_container"><div id=3D"yiv5417939430"><div><div dir=3D"ltr"><br clear=
=3D"none"><div class=3D"yiv5417939430gmail_extra"><br clear=3D"none"><div c=
lass=3D"yiv5417939430gmail_quote">On Fri, Feb 13, 2015 at 12:47 AM, Rangana=
dh Kanitmahanti <span dir=3D"ltr">&lt;<a rel=3D"nofollow" shape=3D"rect" ym=
ailto=3D"mailto:ranganadh1991@yahoo.com" target=3D"_blank" href=3D"mailto:r=
anganadh1991@yahoo.com">ranganadh1991@yahoo.com</a>&gt;</span> wrote:<br cl=
ear=3D"none"><blockquote class=3D"yiv5417939430gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div><div style=
=3D"color:#000;background-color:#fff;font-family:HelveticaNeue, Helvetica N=
eue, Helvetica, Arial, Lucida Grande, Sans-Serif;font-size:12px;"><div dir=
=3D"ltr">Hi,</div><div dir=3D"ltr"><br clear=3D"none"></div><div><span lang=
=3D"EN-US">************************************************</span></div>
<div><span lang=3D"EN-US">[error] Unexpected end of packet. Either the=20
trace data stream is corrupted or metadata description does not match data=
=20
layout.</span></div>
<div><span lang=3D"EN-US">[error] Reading event=20
failed.</span></div>
<div><span lang=3D"EN-US">Error printing trace.</span></div>
<div><span lang=3D"EN-US">&nbsp;</span></div>
<div><span lang=3D"EN-US">************************************************<=
/span></div><div><br clear=3D"none"><span lang=3D"EN-US"></span></div><div =
dir=3D"ltr"><span lang=3D"EN-US">Can any body tell about this significance.=
 I have seen a similar bug resolved <a rel=3D"nofollow" shape=3D"rect" targ=
et=3D"_blank" href=3D"https://bugs.lttng.org/issues/686">Bug #686: stream p=
arser should have a clearer error message when encountering cross-packet fi=
elds - Babeltrace - LTTng bugs repository</a></span></div><div dir=3D"ltr">=
<span lang=3D"EN-US">Can anybody tell in which version the fix was released=
.<br clear=3D"none"></span></div></div></div></blockquote><div><br clear=3D=
"none"></div><div>The fix only clarifies the error message. The corrupted s=
tream probably can't be handled by Babeltrace anymore at that point. To ans=
wer your question, that fix was introduced in v1.1.2 and is part of all v1.=
2.x releases.</div><div><br clear=3D"none"></div><div>Can you give us more =
information to reproduce the problem? Which version of LTTng-Tools and Babe=
ltrace are you using?</div><div><br clear=3D"none"></div><div>Thanks,</div>=
<div>J=C3=A9r=C3=A9mie</div><div class=3D"yiv5417939430yqt4658476305" id=3D=
"yiv5417939430yqtfd58324"><div>&nbsp;</div></div><blockquote class=3D"yiv54=
17939430gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex;"><div><div style=3D"color:#000;background-color:#fff;font=
-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, San=
s-Serif;font-size:12px;"><div class=3D"yiv5417939430yqt4658476305" id=3D"yi=
v5417939430yqtfd00800"><div dir=3D"ltr"><span lang=3D"EN-US"></span></div><=
/div><div style=3D"width:450px;font-family:'Georgia', 'Times', 'Times New R=
oman', 'serif';margin-top:5px;margin-bottom:5px;background-color:#ffffff;">=
<div class=3D"yiv5417939430yqt4658476305" id=3D"yiv5417939430yqtfd43713"></=
div><table style=3D"width:450px;height:auto;display:block;" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0"><tbody><tr><td colspan=3D"7" rowspan=3D"1=
" style=3D"height:1px;background-color:#e5e5e5;font-size:1px;border-collaps=
e:collapse;"><div style=3D"min-height:1px;background-color:#e5e5e5;font-siz=
e:1px;line-height:0px;">&nbsp;</div></td></tr><tr><td colspan=3D"1" rowspan=
=3D"5" style=3D"width:1px;background-color:#e5e5e5;font-size:1pt;border-col=
lapse:collapse;"><div style=3D"width:1px;background-color:#e5e5e5;font-size=
:1pt;">&nbsp;</div></td><td colspan=3D"1" rowspan=3D"5" style=3D"width:14px=
;background-color:#ffffff;font-size:0pt;border-collapse:collapse;"><div sty=
le=3D"width:14px;background-color:#ffffff;font-size:14pt;">&nbsp;</div></td=
><td colspan=3D"2" rowspan=3D"1" style=3D"height:6px;background-color:#ffff=
ff;font-size:0pt;border-collapse:collapse;"><div style=3D"min-height:6px;ba=
ckground-color:#ffffff;font-size:6pt;">&nbsp;</div></td><td colspan=3D"1" r=
owspan=3D"5" style=3D"width:20px;background-color:#ffffff;font-size:0pt;bor=
der-collapse:collapse;"><div style=3D"width:20px;background-color:#ffffff;f=
ont-size:20pt;">&nbsp;</div></td><td colspan=3D"1" rowspan=3D"5" style=3D"w=
idth:1px;background-color:#e5e5e5;font-size:1pt;border-collapse:collapse;" =
width=3D"1"><div style=3D"width:1px;background-color:#e5e5e5;font-size:1pt;=
">&nbsp;</div></td></tr><tr><td colspan=3D"2" rowspan=3D"1" style=3D"width:=
100%;vertical-align:middle;font-family:'Georgia', 'Times', 'Times New Roman=
', 'serif';"><div style=3D"line-height:16.5px;background-color:#ffffff;widt=
h:414px;"><div style=3D"word-wrap:break-word;"><span></span><span></span><a=
 rel=3D"nofollow" shape=3D"rect" target=3D"_blank" href=3D"https://bugs.ltt=
ng.org/issues/686" style=3D"text-decoration:none!important;color:#000000!im=
portant;line-height:100%;font-size:18px;display:block;"><span style=3D"marg=
in:0;font-weight:normal;margin-bottom:3px;font-size:18px;line-height:21px;m=
ax-height:43px;color:#000000;overflow:hidden!important;display:inline-block=
;">Bug #686: stream parser should have a clearer error message when encount=
ering cross-packet fields -...</span></a><div style=3D"font-size:13px;line-=
height:20px;color:#999999;max-height:81px;font-family:'Georgia', 'Times', '=
Times New Roman', 'serif';overflow:hidden;">Redmine</div></div></div></td><=
/tr><tr><td colspan=3D"2" rowspan=3D"1" style=3D"height:6px;background-colo=
r:#ffffff;font-size:0pt;border-collapse:collapse;"><div style=3D"min-height=
:6px;background-color:#ffffff;font-size:6pt;"></div></td></tr><tr><td colsp=
an=3D"1" rowspan=3D"1" style=3D"vertical-align:middle;font-family:'Arial', =
'Helvetica Neue', 'Helvetica', 'sans-serif';"><div style=3D"font-size:0pt;"=
><a rel=3D"nofollow" shape=3D"rect" target=3D"_blank" href=3D"https://bugs.=
lttng.org/issues/686" style=3D"color:black;text-decoration:none!important;"=
><span style=3D"display:inline-block;line-height:11px;max-width:314px;min-w=
idth:254px;overflow:hidden;max-height:13px;"><span style=3D"vertical-align:=
middle;font-size:9px;line-height:11px;color:#999999;">View on <span style=
=3D"font-weight:bold;">bugs.lttng.org</span></span></span></a></div></td><t=
d colspan=3D"1" rowspan=3D"1" style=3D"vertical-align:middle;width:100px;fo=
nt-family:'Arial', 'Helvetica Neue', 'Helvetica', 'sans-serif';"><div style=
=3D"max-width:100px;min-width:80px;overflow:hidden;text-align:right;line-he=
ight:11px;max-height:13px;font-size:0pt;"><span style=3D"vertical-align:mid=
dle;font-size:9px;line-height:11px;color:#999999;">Preview by Yahoo</span><=
/div></td></tr><tr><td colspan=3D"2" rowspan=3D"1" style=3D"height:9px;back=
ground-color:#ffffff;font-size:0pt;border-collapse:collapse;"><div style=3D=
"min-height:9px;background-color:#ffffff;font-size:9pt;"></div></td></tr><t=
r><td colspan=3D"7" rowspan=3D"1" style=3D"height:1px;background-color:#e5e=
5e5;font-size:1px;border-collapse:collapse;"><div style=3D"min-height:1px;b=
ackground-color:#e5e5e5;font-size:1px;line-height:0px;">&nbsp;</div></td></=
tr></tbody></table></div><div dir=3D"ltr"><br clear=3D"none"></div></div></=
div><br clear=3D"none">_______________________________________________<br c=
lear=3D"none">
lttng-dev mailing list<br clear=3D"none">
<a rel=3D"nofollow" shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@=
lists.lttng.org</a><br clear=3D"none">
<a rel=3D"nofollow" shape=3D"rect" target=3D"_blank" href=3D"http://lists.l=
ttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev</a><br clear=3D"none">
<br clear=3D"none"></blockquote></div><br clear=3D"none"><br clear=3D"all">=
<div><br clear=3D"none"></div>-- <br clear=3D"none"><div class=3D"yiv541793=
9430gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br clear=3D"none">EfficiOS=
 Inc.<br clear=3D"none"><a rel=3D"nofollow" shape=3D"rect" target=3D"_blank=
" href=3D"http://www.efficios.com/">http://www.efficios.com</a></div><div c=
lass=3D"yiv5417939430yqt4658476305" id=3D"yiv5417939430yqtfd96690">
</div></div></div></div></div><br clear=3D"none"><br clear=3D"none"></div> =
 </div> </div>  </div></div> </div></div></div><br><br></div>  </div> </div=
>  </div> </div></body></html>
------=_Part_3312415_586895393.1424082783815--


--===============1649586209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1649586209==--
