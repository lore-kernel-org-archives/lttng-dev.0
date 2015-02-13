From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Babel trace is throwing error while trying with -i
 lttng-live option
Date: Fri, 13 Feb 2015 09:49:20 -0500
Message-ID: <CA+jJMxuy4rE9Lmcahupv8UVVUS=XRtDp0Ru8KtoKKktk2MnSbw__36718.8484561213$1423839062$gmane$org@mail.gmail.com>
References: <1899927093.15232.1423806442050.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1625013901=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YMHYb-0002pZ-Pn
 for lttng-dev@lists.lttng.org; Fri, 13 Feb 2015 09:49:28 -0500
Received: by mail-qc0-f173.google.com with SMTP id w7so14106958qcr.4
 for <lttng-dev@lists.lttng.org>; Fri, 13 Feb 2015 06:49:20 -0800 (PST)
In-Reply-To: <1899927093.15232.1423806442050.JavaMail.yahoo@mail.yahoo.com>
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

--===============1625013901==
Content-Type: multipart/alternative; boundary=001a1135f90272b50e050ef957b5

--001a1135f90272b50e050ef957b5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2015 at 12:47 AM, Ranganadh Kanitmahanti <
ranganadh1991@yahoo.com> wrote:

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

The fix only clarifies the error message. The corrupted stream probably
can't be handled by Babeltrace anymore at that point. To answer your
question, that fix was introduced in v1.1.2 and is part of all v1.2.x
releases.

Can you give us more information to reproduce the problem? Which version of
LTTng-Tools and Babeltrace are you using?

Thanks,
J=C3=A9r=C3=A9mie


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


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1135f90272b50e050ef957b5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Feb 13, 2015 at 12:47 AM, Ranganadh Kanitmahanti <span dir=3D"l=
tr">&lt;<a href=3D"mailto:ranganadh1991@yahoo.com" target=3D"_blank">rangan=
adh1991@yahoo.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div><div style=3D"color:#000;background-color:#fff;font-family:HelveticaNeu=
e,Helvetica Neue,Helvetica,Arial,Lucida Grande,Sans-Serif;font-size:12px"><=
div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div><span lang=3D"EN-U=
S">************************************************</span></div>
<div><span lang=3D"EN-US">[error] Unexpected end of packet. Either the=20
trace data stream is corrupted or metadata description does not match data=
=20
layout.</span></div>
<div><span lang=3D"EN-US">[error] Reading event=20
failed.</span></div>
<div><span lang=3D"EN-US">Error printing trace.</span></div>
<div><span lang=3D"EN-US">=C2=A0</span></div>
<div><span lang=3D"EN-US">************************************************<=
/span></div><div><br><span lang=3D"EN-US"></span></div><div dir=3D"ltr"><sp=
an lang=3D"EN-US">Can any body tell about this significance. I have seen a =
similar bug resolved <a href=3D"https://bugs.lttng.org/issues/686" target=
=3D"_blank">Bug #686: stream parser should have a clearer error message whe=
n encountering cross-packet fields - Babeltrace - LTTng bugs repository</a>=
</span></div><div dir=3D"ltr"><span lang=3D"EN-US">Can anybody tell in whic=
h version the fix was released.<br></span></div></div></div></blockquote><d=
iv><br></div><div>The fix only clarifies the error message. The corrupted s=
tream probably can&#39;t be handled by Babeltrace anymore at that point. To=
 answer your question, that fix was introduced in v1.1.2 and is part of all=
 v1.2.x releases.</div><div><br></div><div>Can you give us more information=
 to reproduce the problem? Which version of LTTng-Tools and Babeltrace are =
you using?</div><div><br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"color:=
#000;background-color:#fff;font-family:HelveticaNeue,Helvetica Neue,Helveti=
ca,Arial,Lucida Grande,Sans-Serif;font-size:12px"><div dir=3D"ltr"><span la=
ng=3D"EN-US"></span></div><div style=3D"width:450px;font-family:&#39;Georgi=
a&#39;,&#39;Times&#39;,&#39;Times New Roman&#39;,&#39;serif&#39;;margin-top=
:5px;margin-bottom:5px;background-color:#ffffff"><table style=3D"width:450p=
x;height:auto;display:block" border=3D"0" cellpadding=3D"0" cellspacing=3D"=
0"><tbody><tr><td colspan=3D"7" style=3D"height:1px;background-color:#e5e5e=
5;font-size:1px;border-collapse:collapse"><div style=3D"min-height:1px;back=
ground-color:#e5e5e5;font-size:1px;line-height:0px">=C2=A0</div></td></tr><=
tr><td rowspan=3D"5" style=3D"width:1px;background-color:#e5e5e5;font-size:=
1pt;border-collapse:collapse"><div style=3D"width:1px;background-color:#e5e=
5e5;font-size:1pt">=C2=A0</div></td><td rowspan=3D"5" style=3D"width:14px;b=
ackground-color:#ffffff;font-size:0pt;border-collapse:collapse"><div style=
=3D"width:14px;background-color:#ffffff;font-size:14pt">=C2=A0</div></td><t=
d colspan=3D"2" style=3D"height:6px;background-color:#ffffff;font-size:0pt;=
border-collapse:collapse"><div style=3D"min-height:6px;background-color:#ff=
ffff;font-size:6pt">=C2=A0</div></td><td rowspan=3D"5" style=3D"width:20px;=
background-color:#ffffff;font-size:0pt;border-collapse:collapse"><div style=
=3D"width:20px;background-color:#ffffff;font-size:20pt">=C2=A0</div></td><t=
d rowspan=3D"5" style=3D"width:1px;background-color:#e5e5e5;font-size:1pt;b=
order-collapse:collapse" width=3D"1"><div style=3D"width:1px;background-col=
or:#e5e5e5;font-size:1pt">=C2=A0</div></td></tr><tr><td colspan=3D"2" style=
=3D"width:100%;vertical-align:middle;font-family:&#39;Georgia&#39;,&#39;Tim=
es&#39;,&#39;Times New Roman&#39;,&#39;serif&#39;"><div style=3D"line-heigh=
t:16.5px;background-color:#ffffff;width:414px"><div style=3D"word-wrap:brea=
k-word;word-break:break-all"><span></span><span></span><a href=3D"https://b=
ugs.lttng.org/issues/686" style=3D"text-decoration:none!important;color:#00=
0000!important;line-height:100%;font-size:18px;display:block" target=3D"_bl=
ank"><span style=3D"margin:0;font-weight:normal;margin-bottom:3px;font-size=
:18px;line-height:21px;max-height:43px;color:#000000;overflow:hidden!import=
ant;display:inline-block">Bug #686: stream parser should have a clearer err=
or message when encountering cross-packet fields -...</span></a><div style=
=3D"font-size:13px;line-height:20px;color:#999999;max-height:81px;font-fami=
ly:&#39;Georgia&#39;,&#39;Times&#39;,&#39;Times New Roman&#39;,&#39;serif&#=
39;;overflow:hidden">Redmine</div></div></div></td></tr><tr><td colspan=3D"=
2" style=3D"height:6px;background-color:#ffffff;font-size:0pt;border-collap=
se:collapse"><div style=3D"min-height:6px;background-color:#ffffff;font-siz=
e:6pt"></div></td></tr><tr><td style=3D"vertical-align:middle;font-family:&=
#39;Arial&#39;,&#39;Helvetica Neue&#39;,&#39;Helvetica&#39;,&#39;sans-serif=
&#39;"><div style=3D"font-size:0pt"><a href=3D"https://bugs.lttng.org/issue=
s/686" style=3D"color:black;text-decoration:none!important" target=3D"_blan=
k"><span style=3D"display:inline-block;line-height:11px;max-width:314px;min=
-width:254px;overflow:hidden;max-height:13px;word-break:break-all"><span st=
yle=3D"vertical-align:middle;font-size:9px;line-height:11px;color:#999999">=
View on <span style=3D"font-weight:bold">bugs.lttng.org</span></span></span=
></a></div></td><td style=3D"vertical-align:middle;width:100px;font-family:=
&#39;Arial&#39;,&#39;Helvetica Neue&#39;,&#39;Helvetica&#39;,&#39;sans-seri=
f&#39;"><div style=3D"max-width:100px;min-width:80px;overflow:hidden;text-a=
lign:right;line-height:11px;max-height:13px;font-size:0pt"><span style=3D"v=
ertical-align:middle;font-size:9px;line-height:11px;color:#999999">Preview =
by Yahoo</span></div></td></tr><tr><td colspan=3D"2" style=3D"height:9px;ba=
ckground-color:#ffffff;font-size:0pt;border-collapse:collapse"><div style=
=3D"min-height:9px;background-color:#ffffff;font-size:9pt"></div></td></tr>=
<tr><td colspan=3D"7" style=3D"height:1px;background-color:#e5e5e5;font-siz=
e:1px;border-collapse:collapse"><div style=3D"min-height:1px;background-col=
or:#e5e5e5;font-size:1px;line-height:0px">=C2=A0</div></td></tr></tbody></t=
able></div><div dir=3D"ltr"><br></div></div></div><br>_____________________=
__________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div></div>

--001a1135f90272b50e050ef957b5--


--===============1625013901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1625013901==--
