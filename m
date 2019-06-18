From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: Need help in converting trace data into CTF
Date: Tue, 18 Jun 2019 18:55:27 +0530
Message-ID: <CAEWVvOSXKF=Ey_edFSFp=CqUDHyhoB_iZQEdTHwcwwYNM3LpJg__559.712555126168$1560864383$gmane$org@mail.gmail.com>
References: <CAEWVvOSE6QJQvQEdTLEhNQTE7H1Py1ggoqynSj3w-uOYBkTMCQ@mail.gmail.com>
 <72388180.2647.1558032721255.JavaMail.zimbra@efficios.com>
 <CAEWVvOS6WyAkE+5GAyn_WEoFW_6h_fWbze-im0w7oqvXS-+dBw@mail.gmail.com>
 <1448366760.18406.1559146893765.JavaMail.zimbra@efficios.com>
 <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa> <20190604145312.GB13240@joraj-alpa>
 <CAEWVvORHWTQLe_uhw2M+aT6tEjgdz3emfxEUosbo+bMsqdN=QA@mail.gmail.com>
 <CAEWVvOR0wv2Du2KNCZE0dpNAhMaFh7JvDFG0FOQ8uWyTBpSoOw@mail.gmail.com>
 <20190617165154.GA7208@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0182695389618806352=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by lists.lttng.org (Postfix) with ESMTPS id 45Spjx6bP5z10dH
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2019 09:25:41 -0400 (EDT)
Received: by mail-wm1-x32a.google.com with SMTP id c66so3294452wmf.0
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2019 06:25:41 -0700 (PDT)
In-Reply-To: <20190617165154.GA7208@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0182695389618806352==
Content-Type: multipart/alternative; boundary="0000000000008869e9058b990cb3"

--0000000000008869e9058b990cb3
Content-Type: text/plain; charset="UTF-8"

>
>
> Hi,
>
> > I am trying to write a metadata file. I am following
> https://diamon.org/ctf/.
> > I found one metadata file on GitHub repository
> >
> https://github.com/efficios/epiphany-examples/tree/barectf-tracing/apps/barectf-tracing/ctf
> >
> >  Which file format is used for the metadata files?
>
> Babeltrace understand text based metadata file as long as it conforms to
> the TSDL
> grammar.
>
> See:
>     https://diamon.org/ctf/#spec7
>     https://diamon.org/ctf/#spec7.4
>     https://diamon.org/ctf/#specC

Okay. I was following the above links to writing my own metadata file.

>
>
> For an example of metadata generator, you can look at Barectf[1] or
> lttng-tools[2]
>
> [1]
> https://github.com/efficios/barectf/blob/a3ebf5855c025a86ebc2d62cbda1338461e84c5a/barectf/tsdl182gen.py

I used "barectf config.yaml -m ctf" command. It helpled me generating the
metadata file. I looked at some other metadata file but they are binary
packetized. The one I generated using barectf is not binary packetized.

Are these file different?
Will both work the same way?

>
> [2]
> https://github.com/lttng/lttng-tools/blob/c8e0c5f5d94fb574f4e5d7518f0f8e6f984dfe3d/src/bin/lttng-sessiond/ust-metadata.c
>
>

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000008869e9058b990cb3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><br>Hi,<br>
<br>
&gt; I am trying to write a metadata file. I am following <a href=3D"https:=
//diamon.org/ctf/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
diamon.org/ctf/</a>.<br>
&gt; I found one metadata file on GitHub repository<br>
&gt; <a href=3D"https://github.com/efficios/epiphany-examples/tree/barectf-=
tracing/apps/barectf-tracing/ctf" rel=3D"noreferrer noreferrer" target=3D"_=
blank">https://github.com/efficios/epiphany-examples/tree/barectf-tracing/a=
pps/barectf-tracing/ctf</a><br>
&gt; <br>
&gt;=C2=A0 Which file format is used for the metadata files?<br>
<br>
Babeltrace understand text based metadata file as long as it conforms to th=
e TSDL<br>
grammar.<br>
<br>
See:<br>
=C2=A0 =C2=A0 <a href=3D"https://diamon.org/ctf/#spec7" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">https://diamon.org/ctf/#spec7</a><br>
=C2=A0 =C2=A0 <a href=3D"https://diamon.org/ctf/#spec7.4" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://diamon.org/ctf/#spec7.4</a><br>
=C2=A0 =C2=A0 <a href=3D"https://diamon.org/ctf/#specC" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">https://diamon.org/ctf/#specC</a></blockquote>=
<div>Okay. I was following the above links to writing my own metadata file.=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
For an example of metadata generator, you can look at Barectf[1] or<br>
lttng-tools[2]<br>
<br>
[1] <a href=3D"https://github.com/efficios/barectf/blob/a3ebf5855c025a86ebc=
2d62cbda1338461e84c5a/barectf/tsdl182gen.py" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://github.com/efficios/barectf/blob/a3ebf5855c025a86=
ebc2d62cbda1338461e84c5a/barectf/tsdl182gen.py</a></blockquote><div>I used =
&quot;barectf config.yaml -m ctf&quot; command. It helpled me generating th=
e metadata file. I looked at some other metadata file but they are binary p=
acketized. The one I generated using barectf is not binary packetized.=C2=
=A0</div><div><br></div><div>Are these file different?</div><div dir=3D"aut=
o">Will both work the same way?</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
[2] <a href=3D"https://github.com/lttng/lttng-tools/blob/c8e0c5f5d94fb574f4=
e5d7518f0f8e6f984dfe3d/src/bin/lttng-sessiond/ust-metadata.c" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">https://github.com/lttng/lttng-tools/blo=
b/c8e0c5f5d94fb574f4e5d7518f0f8e6f984dfe3d/src/bin/lttng-sessiond/ust-metad=
ata.c</a><br><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"m_-5074802541275856454gmail_signature"><div dir=3D"ltr"><div><div=
 dir=3D"ltr"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span=
 style=3D"color:rgb(102,102,102)">B. Tech. Computer Science and Engineering=
,<br></span></div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"ht=
tps://www.iitism.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank" r=
el=3D"noreferrer">Indian Institute of Technology (Indian School of Mines)</=
a>, Dhanbad</span></div></div></div></div></div></div></div>

--0000000000008869e9058b990cb3--

--===============0182695389618806352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0182695389618806352==--
