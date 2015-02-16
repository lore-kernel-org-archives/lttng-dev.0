From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Babel trace is throwing error while trying with -i
 lttng-live option
Date: Mon, 16 Feb 2015 10:30:18 -0500
Message-ID: <CA+jJMxsd6PezNr4O_C1LiUWy5NwnJUKf-QqLWcWLuvrEUXBoZQ__37073.1558105492$1424100719$gmane$org@mail.gmail.com>
References: <CA+jJMxuy4rE9Lmcahupv8UVVUS=XRtDp0Ru8KtoKKktk2MnSbw@mail.gmail.com>
 <2049410326.3223875.1424076991840.JavaMail.yahoo@mail.yahoo.com>
 <1012526699.3312416.1424082783825.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1560107959=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YNNcv-0007IK-L9
 for lttng-dev@lists.lttng.org; Mon, 16 Feb 2015 10:30:31 -0500
Received: by mail-qc0-f173.google.com with SMTP id w7so24474798qcr.4
 for <lttng-dev@lists.lttng.org>; Mon, 16 Feb 2015 07:30:20 -0800 (PST)
In-Reply-To: <1012526699.3312416.1424082783825.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1560107959==
Content-Type: multipart/alternative; boundary=001a11343a4c80a7e4050f36431c

--001a11343a4c80a7e4050f36431c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2015 at 5:33 AM, Ranganadh Kanitmahanti <
ranganadh1991@yahoo.com> wrote:

> hi,
> We are using babeltrace 1.2.4 and LTTng Trace Control 2.5.3.  Continously
> giving babeltrace is throwing this error. Sorry about previous
> conversation. I am actually getting this reading a snapshot session . I
> have given continously babeltrace and path to read the traces . Then I am
> getting this error.
> We see below mentioned error while reading out traces using babeltrace=E2=
=80=A6
>

Okay, so "live" is not involved at all here?
Would it be possible to share the trace?

Also, can you provide the commands issued to capture this trace?

Thanks,
J=C3=A9r=C3=A9mie


>
>
> ************************************************
> [error] Unexpected end of packet. Either the trace data stream is
> corrupted or metadata description does not match data layout.
> [error] Reading event failed.
> Error printing trace.
>
> ************************************************
>
> Thanks & Regards,
> K.V.Ranganadh.
>
>
>   On Monday, 16 February 2015 2:26 PM, Ranganadh Kanitmahanti <
> ranganadh1991@yahoo.com> wrote:
>
>
> Hi,
>
> We are using "BabelTrace Trace Viewer and Converter 1.2.4 "
>
> Thanks & Regards,
> K.V.Ranganadh.
>
>
>   On Friday, 13 February 2015 8:19 PM, J=C3=A9r=C3=A9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>
>
>
> On Fri, Feb 13, 2015 at 12:47 AM, Ranganadh Kanitmahanti <
> ranganadh1991@yahoo.com> wrote:
>
> Hi,
>
> ************************************************
> [error] Unexpected end of packet. Either the trace data stream is
> corrupted or metadata description does not match data layout.
> [error] Reading event failed.
> Error printing trace.
>
> ************************************************
>
> Can any body tell about this significance. I have seen a similar bug
> resolved Bug #686: stream parser should have a clearer error message when
> encountering cross-packet fields - Babeltrace - LTTng bugs repository
> <https://bugs.lttng.org/issues/686>
> Can anybody tell in which version the fix was released.
>
>
> The fix only clarifies the error message. The corrupted stream probably
> can't be handled by Babeltrace anymore at that point. To answer your
> question, that fix was introduced in v1.1.2 and is part of all v1.2.x
> releases.
>
> Can you give us more information to reproduce the problem? Which version
> of LTTng-Tools and Babeltrace are you using?
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
>
>
>
>
>
>
>
> Bug #686: stream parser should have a clearer error message when
> encountering cross-packet fields -... <https://bugs.lttng.org/issues/686>
> Redmine
> View on bugs.lttng.org <https://bugs.lttng.org/issues/686>
> Preview by Yahoo
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
>
>
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11343a4c80a7e4050f36431c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Feb 16, 2015 at 5:33 AM, Ranganadh Kanitmahanti <span dir=3D"lt=
r">&lt;<a href=3D"mailto:ranganadh1991@yahoo.com" target=3D"_blank">rangana=
dh1991@yahoo.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv><div style=3D"color:#000;background-color:#fff;font-family:HelveticaNeue=
,Helvetica Neue,Helvetica,Arial,Lucida Grande,Sans-Serif;font-size:12px"><d=
iv>hi,</div><div dir=3D"ltr">We are using babeltrace 1.2.4 and LTTng Trace =
Control 2.5.3.=C2=A0 Continously giving babeltrace is throwing this error. =
Sorry about previous conversation. I am actually getting this reading a sna=
pshot session . I have given continously babeltrace and path to read the tr=
aces . Then I am getting this error.</div><div dir=3D"ltr"><span style=3D"F=
ONT-FAMILY:&#39;Calibri&#39;,&#39;sans-serif&#39;;FONT-SIZE:10pt">We see be=
low mentioned error while reading out traces using babeltrace=E2=80=A6</spa=
n> </div></div></div></blockquote><div><br></div><div>Okay, so &quot;live&q=
uot; is not involved at all here?</div><div>Would it be possible to share t=
he trace?</div><div><br></div><div>Also, can you provide the commands issue=
d to capture this trace?</div><div><br></div><div>Thanks,</div><div>J=C3=A9=
r=C3=A9mie</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div s=
tyle=3D"color:#000;background-color:#fff;font-family:HelveticaNeue,Helvetic=
a Neue,Helvetica,Arial,Lucida Grande,Sans-Serif;font-size:12px"><div dir=3D=
"ltr">
<span style=3D"FONT-FAMILY:&#39;Calibri&#39;,&#39;sans-serif&#39;;FONT-SIZE=
:10pt"><br></span><span class=3D"">=C2=A0<span style=3D"FONT-FAMILY:&#39;Ca=
libri&#39;,&#39;sans-serif&#39;;FONT-SIZE:10pt"><br>***********************=
*************************</span>=20
<span style=3D"FONT-FAMILY:&#39;Calibri&#39;,&#39;sans-serif&#39;;FONT-SIZE=
:10pt"><br>[error]=20
Unexpected end of packet. Either the trace data stream is corrupted or meta=
data=20
description does not match data layout.</span> <span style=3D"FONT-FAMILY:&=
#39;Calibri&#39;,&#39;sans-serif&#39;;FONT-SIZE:10pt"><br>[error] Reading=
=20
event failed.</span> <span style=3D"FONT-FAMILY:&#39;Calibri&#39;,&#39;sans=
-serif&#39;;FONT-SIZE:10pt"><br>Error printing=20
trace.</span> <span style=3D"FONT-FAMILY:&#39;Calibri&#39;,&#39;sans-serif&=
#39;;FONT-SIZE:10pt"><br></span>=C2=A0<span style=3D"FONT-FAMILY:&#39;Calib=
ri&#39;,&#39;sans-serif&#39;;FONT-SIZE:10pt"><br>**************************=
**********************</span>=20
<span style=3D"FONT-FAMILY:&#39;Calibri&#39;,&#39;sans-serif&#39;;FONT-SIZE=
:10pt"><br></span></span></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
Thanks &amp; Regards,</div><div dir=3D"ltr">K.V.Ranganadh.<br></div><div><d=
iv class=3D"h5"><div><span></span></div> <div><br><br></div><div style=3D"d=
isplay:block"> <div style=3D"font-family:HelveticaNeue,Helvetica Neue,Helve=
tica,Arial,Lucida Grande,Sans-Serif;font-size:12px"> <div style=3D"font-fam=
ily:HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,Sans-Serif;f=
ont-size:12px"> <div dir=3D"ltr"> <font face=3D"Arial"> On Monday, 16 Febru=
ary 2015 2:26 PM, Ranganadh Kanitmahanti &lt;<a href=3D"mailto:ranganadh199=
1@yahoo.com" target=3D"_blank">ranganadh1991@yahoo.com</a>&gt; wrote:<br> <=
/font> </div>  <br><br> <div><div><div><div style=3D"color:#000;background-=
color:#fff;font-family:HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida =
Grande,Sans-Serif;font-size:12px"><div>Hi,</div><div><br clear=3D"none"></d=
iv><div dir=3D"ltr">We are using<span style=3D"font-size:9pt;font-family:Se=
goe UI;color:rgb(0,0,0)"> &quot;BabelTrace Trace Viewer and Converter 1.2.4=
</span> &quot;<br clear=3D"none"><br clear=3D"none"></div><div dir=3D"ltr">=
<span>Thanks &amp; Regards,</span></div><div dir=3D"ltr"><span>K.V.Ranganad=
h.</span></div> <div><br clear=3D"none"><br clear=3D"none"></div><div><div =
style=3D"display:block"> <div style=3D"font-family:HelveticaNeue,Helvetica =
Neue,Helvetica,Arial,Lucida Grande,Sans-Serif;font-size:12px"> <div style=
=3D"font-family:HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,=
Sans-Serif;font-size:12px"> <div dir=3D"ltr"> <font face=3D"Arial"> On Frid=
ay, 13 February 2015 8:19 PM, J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"ma=
ilto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@ef=
ficios.com</a>&gt; wrote:<br clear=3D"none"> </font> </div>  <br clear=3D"n=
one"><br clear=3D"none"> <div><div><div><div dir=3D"ltr"><br clear=3D"none"=
><div><br clear=3D"none"><div>On Fri, Feb 13, 2015 at 12:47 AM, Ranganadh K=
anitmahanti <span dir=3D"ltr">&lt;<a rel=3D"nofollow" shape=3D"rect" href=
=3D"mailto:ranganadh1991@yahoo.com" target=3D"_blank">ranganadh1991@yahoo.c=
om</a>&gt;</span> wrote:<br clear=3D"none"><blockquote style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"colo=
r:#000;background-color:#fff;font-family:HelveticaNeue,Helvetica Neue,Helve=
tica,Arial,Lucida Grande,Sans-Serif;font-size:12px"><div dir=3D"ltr">Hi,</d=
iv><div dir=3D"ltr"><br clear=3D"none"></div><div><span lang=3D"EN-US">****=
********************************************</span></div>
<div><span lang=3D"EN-US">[error] Unexpected end of packet. Either the=20
trace data stream is corrupted or metadata description does not match data=
=20
layout.</span></div>
<div><span lang=3D"EN-US">[error] Reading event=20
failed.</span></div>
<div><span lang=3D"EN-US">Error printing trace.</span></div>
<div><span lang=3D"EN-US">=C2=A0</span></div>
<div><span lang=3D"EN-US">************************************************<=
/span></div><div><br clear=3D"none"><span lang=3D"EN-US"></span></div><div =
dir=3D"ltr"><span lang=3D"EN-US">Can any body tell about this significance.=
 I have seen a similar bug resolved <a rel=3D"nofollow" shape=3D"rect" href=
=3D"https://bugs.lttng.org/issues/686" target=3D"_blank">Bug #686: stream p=
arser should have a clearer error message when encountering cross-packet fi=
elds - Babeltrace - LTTng bugs repository</a></span></div><div dir=3D"ltr">=
<span lang=3D"EN-US">Can anybody tell in which version the fix was released=
.<br clear=3D"none"></span></div></div></div></blockquote><div><br clear=3D=
"none"></div><div>The fix only clarifies the error message. The corrupted s=
tream probably can&#39;t be handled by Babeltrace anymore at that point. To=
 answer your question, that fix was introduced in v1.1.2 and is part of all=
 v1.2.x releases.</div><div><br clear=3D"none"></div><div>Can you give us m=
ore information to reproduce the problem? Which version of LTTng-Tools and =
Babeltrace are you using?</div><div><br clear=3D"none"></div><div>Thanks,</=
div><div>J=C3=A9r=C3=A9mie</div><div><div>=C2=A0</div></div><blockquote sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><=
div style=3D"color:#000;background-color:#fff;font-family:HelveticaNeue,Hel=
vetica Neue,Helvetica,Arial,Lucida Grande,Sans-Serif;font-size:12px"><div><=
div dir=3D"ltr"><span lang=3D"EN-US"></span></div></div><div style=3D"width=
:450px;font-family:&#39;Georgia&#39;,&#39;Times&#39;,&#39;Times New Roman&#=
39;,&#39;serif&#39;;margin-top:5px;margin-bottom:5px;background-color:#ffff=
ff"><div></div><table style=3D"width:450px;height:auto;display:block" borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td colspan=3D"7" ro=
wspan=3D"1" style=3D"height:1px;background-color:#e5e5e5;font-size:1px;bord=
er-collapse:collapse"><div style=3D"min-height:1px;background-color:#e5e5e5=
;font-size:1px;line-height:0px">=C2=A0</div></td></tr><tr><td colspan=3D"1"=
 rowspan=3D"5" style=3D"width:1px;background-color:#e5e5e5;font-size:1pt;bo=
rder-collapse:collapse"><div style=3D"width:1px;background-color:#e5e5e5;fo=
nt-size:1pt">=C2=A0</div></td><td colspan=3D"1" rowspan=3D"5" style=3D"widt=
h:14px;background-color:#ffffff;font-size:0pt;border-collapse:collapse"><di=
v style=3D"width:14px;background-color:#ffffff;font-size:14pt">=C2=A0</div>=
</td><td colspan=3D"2" rowspan=3D"1" style=3D"height:6px;background-color:#=
ffffff;font-size:0pt;border-collapse:collapse"><div style=3D"min-height:6px=
;background-color:#ffffff;font-size:6pt">=C2=A0</div></td><td colspan=3D"1"=
 rowspan=3D"5" style=3D"width:20px;background-color:#ffffff;font-size:0pt;b=
order-collapse:collapse"><div style=3D"width:20px;background-color:#ffffff;=
font-size:20pt">=C2=A0</div></td><td colspan=3D"1" rowspan=3D"5" style=3D"w=
idth:1px;background-color:#e5e5e5;font-size:1pt;border-collapse:collapse" w=
idth=3D"1"><div style=3D"width:1px;background-color:#e5e5e5;font-size:1pt">=
=C2=A0</div></td></tr><tr><td colspan=3D"2" rowspan=3D"1" style=3D"width:10=
0%;vertical-align:middle;font-family:&#39;Georgia&#39;,&#39;Times&#39;,&#39=
;Times New Roman&#39;,&#39;serif&#39;"><div style=3D"line-height:16.5px;bac=
kground-color:#ffffff;width:414px"><div style=3D"word-wrap:break-word"><spa=
n></span><span></span><a rel=3D"nofollow" shape=3D"rect" href=3D"https://bu=
gs.lttng.org/issues/686" style=3D"text-decoration:none!important;color:#000=
000!important;line-height:100%;font-size:18px;display:block" target=3D"_bla=
nk"><span style=3D"margin:0;font-weight:normal;margin-bottom:3px;font-size:=
18px;line-height:21px;max-height:43px;color:#000000;overflow:hidden!importa=
nt;display:inline-block">Bug #686: stream parser should have a clearer erro=
r message when encountering cross-packet fields -...</span></a><div style=
=3D"font-size:13px;line-height:20px;color:#999999;max-height:81px;font-fami=
ly:&#39;Georgia&#39;,&#39;Times&#39;,&#39;Times New Roman&#39;,&#39;serif&#=
39;;overflow:hidden">Redmine</div></div></div></td></tr><tr><td colspan=3D"=
2" rowspan=3D"1" style=3D"height:6px;background-color:#ffffff;font-size:0pt=
;border-collapse:collapse"><div style=3D"min-height:6px;background-color:#f=
fffff;font-size:6pt"></div></td></tr><tr><td colspan=3D"1" rowspan=3D"1" st=
yle=3D"vertical-align:middle;font-family:&#39;Arial&#39;,&#39;Helvetica Neu=
e&#39;,&#39;Helvetica&#39;,&#39;sans-serif&#39;"><div style=3D"font-size:0p=
t"><a rel=3D"nofollow" shape=3D"rect" href=3D"https://bugs.lttng.org/issues=
/686" style=3D"color:black;text-decoration:none!important" target=3D"_blank=
"><span style=3D"display:inline-block;line-height:11px;max-width:314px;min-=
width:254px;overflow:hidden;max-height:13px"><span style=3D"vertical-align:=
middle;font-size:9px;line-height:11px;color:#999999">View on <span style=3D=
"font-weight:bold">bugs.lttng.org</span></span></span></a></div></td><td co=
lspan=3D"1" rowspan=3D"1" style=3D"vertical-align:middle;width:100px;font-f=
amily:&#39;Arial&#39;,&#39;Helvetica Neue&#39;,&#39;Helvetica&#39;,&#39;san=
s-serif&#39;"><div style=3D"max-width:100px;min-width:80px;overflow:hidden;=
text-align:right;line-height:11px;max-height:13px;font-size:0pt"><span styl=
e=3D"vertical-align:middle;font-size:9px;line-height:11px;color:#999999">Pr=
eview by Yahoo</span></div></td></tr><tr><td colspan=3D"2" rowspan=3D"1" st=
yle=3D"height:9px;background-color:#ffffff;font-size:0pt;border-collapse:co=
llapse"><div style=3D"min-height:9px;background-color:#ffffff;font-size:9pt=
"></div></td></tr><tr><td colspan=3D"7" rowspan=3D"1" style=3D"height:1px;b=
ackground-color:#e5e5e5;font-size:1px;border-collapse:collapse"><div style=
=3D"min-height:1px;background-color:#e5e5e5;font-size:1px;line-height:0px">=
=C2=A0</div></td></tr></tbody></table></div><div dir=3D"ltr"><br clear=3D"n=
one"></div></div></div><br clear=3D"none">_________________________________=
______________<br clear=3D"none">
lttng-dev mailing list<br clear=3D"none">
<a rel=3D"nofollow" shape=3D"rect" href=3D"mailto:lttng-dev@lists.lttng.org=
" target=3D"_blank">lttng-dev@lists.lttng.org</a><br clear=3D"none">
<a rel=3D"nofollow" shape=3D"rect" href=3D"http://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev</a><br clear=3D"none">
<br clear=3D"none"></blockquote></div><br clear=3D"none"><br clear=3D"all">=
<div><br clear=3D"none"></div>-- <br clear=3D"none"><div>J=C3=A9r=C3=A9mie =
Galarneau<br clear=3D"none">EfficiOS Inc.<br clear=3D"none"><a rel=3D"nofol=
low" shape=3D"rect" href=3D"http://www.efficios.com/" target=3D"_blank">htt=
p://www.efficios.com</a></div><div>
</div></div></div></div></div><br clear=3D"none"><br clear=3D"none"></div> =
 </div> </div>  </div></div> </div></div></div><br><br></div>  </div> </div=
>  </div> </div></div></div></div></blockquote></div><br><br clear=3D"all">=
<div><br></div>-- <br><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Gala=
rneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_bl=
ank">http://www.efficios.com</a></div>
</div></div>

--001a11343a4c80a7e4050f36431c--


--===============1560107959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1560107959==--
