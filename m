From: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Subject: Re: Babel trace is throwing error while trying with -i
 lttng-live option
Date: Mon, 16 Feb 2015 08:56:31 +0000 (UTC)
Message-ID: <2049410326.3223875.1424076991840.JavaMail.yahoo__10558.8411250666$1424077073$gmane$org@mail.yahoo.com>
References: <CA+jJMxuy4rE9Lmcahupv8UVVUS=XRtDp0Ru8KtoKKktk2MnSbw@mail.gmail.com>
Reply-To: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0597469660=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm13-vm4.bullet.mail.sg3.yahoo.com ([106.10.149.19])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ranganadh1991@yahoo.com>) id 1YNHTv-00055u-Rx
 for lttng-dev@lists.lttng.org; Mon, 16 Feb 2015 03:56:47 -0500
In-Reply-To: <CA+jJMxuy4rE9Lmcahupv8UVVUS=XRtDp0Ru8KtoKKktk2MnSbw@mail.gmail.com>
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

--===============0597469660==
Content-Type: multipart/alternative;
	boundary="----=_Part_3223874_1998267481.1424076991828"
Content-Length: 11882

------=_Part_3223874_1998267481.1424076991828
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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

   
------=_Part_3223874_1998267481.1424076991828
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;fo=
nt-size:12px"><div id=3D"yui_3_16_0_1_1424075672814_5451">Hi,</div><div id=
=3D"yui_3_16_0_1_1424075672814_5450"><br></div><div id=3D"yui_3_16_0_1_1424=
075672814_5449" style=3D"" class=3D"" dir=3D"ltr">We are using<span id=3D"y=
ui_3_16_0_1_1424075672814_5038" class=3D"" style=3D"font-size: 9pt; font-fa=
mily: Segoe UI; color: rgb(0, 0, 0);"> "BabelTrace Trace Viewer and Convert=
er 1.2.4</span> "<br><br></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_14240756=
72814_5031"><span id=3D"yui_3_16_0_1_1424075672814_5209">Thanks &amp; Regar=
ds,</span></div><div id=3D"yui_3_16_0_1_1424075672814_5231" dir=3D"ltr"><sp=
an id=3D"yui_3_16_0_1_1424075672814_5209">K.V.Ranganadh.</span></div> <div =
class=3D"qtdSeparateBR"><br><br></div><div style=3D"display: block;" class=
=3D"yahoo_quoted"> <div style=3D"font-family: HelveticaNeue, Helvetica Neue=
, Helvetica, Arial, Lucida Grande, Sans-Serif; font-size: 12px;"> <div styl=
e=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida G=
rande, Sans-Serif; font-size: 12px;"> <div dir=3D"ltr"> <font size=3D"2" fa=
ce=3D"Arial"> On Friday, 13 February 2015 8:19 PM, J=C3=A9r=C3=A9mie Galarn=
eau &lt;jeremie.galarneau@efficios.com&gt; wrote:<br> </font> </div>  <br><=
br> <div class=3D"y_msg_container"><div id=3D"yiv2347469485"><div><div dir=
=3D"ltr"><br clear=3D"none"><div class=3D"yiv2347469485gmail_extra"><br cle=
ar=3D"none"><div class=3D"yiv2347469485gmail_quote">On Fri, Feb 13, 2015 at=
 12:47 AM, Ranganadh Kanitmahanti <span dir=3D"ltr">&lt;<a rel=3D"nofollow"=
 shape=3D"rect" ymailto=3D"mailto:ranganadh1991@yahoo.com" target=3D"_blank=
" href=3D"mailto:ranganadh1991@yahoo.com">ranganadh1991@yahoo.com</a>&gt;</=
span> wrote:<br clear=3D"none"><blockquote class=3D"yiv2347469485gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"=
><div><div style=3D"color:#000;background-color:#fff;font-family:HelveticaN=
eue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;font-size:=
12px;"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br clear=3D"none"></div>=
<div><span lang=3D"EN-US">************************************************<=
/span></div>
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
<div>J=C3=A9r=C3=A9mie</div><div class=3D"yiv2347469485yqt4658476305" id=3D=
"yiv2347469485yqtfd58324"><div>&nbsp;</div></div><blockquote class=3D"yiv23=
47469485gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex;"><div><div style=3D"color:#000;background-color:#fff;font=
-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, San=
s-Serif;font-size:12px;"><div class=3D"yiv2347469485yqt4658476305" id=3D"yi=
v2347469485yqtfd00800"><div dir=3D"ltr"><span lang=3D"EN-US"></span></div><=
/div><div style=3D"width:450px;font-family:'Georgia', 'Times', 'Times New R=
oman', 'serif';margin-top:5px;margin-bottom:5px;background-color:#ffffff;">=
<div class=3D"yiv2347469485yqt4658476305" id=3D"yiv2347469485yqtfd43713"></=
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
<div><br clear=3D"none"></div>-- <br clear=3D"none"><div class=3D"yiv234746=
9485gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br clear=3D"none">EfficiOS=
 Inc.<br clear=3D"none"><a rel=3D"nofollow" shape=3D"rect" target=3D"_blank=
" href=3D"http://www.efficios.com/">http://www.efficios.com</a></div><div c=
lass=3D"yiv2347469485yqt4658476305" id=3D"yiv2347469485yqtfd96690">
</div></div></div></div></div><br><br></div>  </div> </div>  </div> </div><=
/body></html>
------=_Part_3223874_1998267481.1424076991828--


--===============0597469660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0597469660==--
