From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: Need help in converting trace data into CTF
Date: Thu, 13 Jun 2019 15:59:26 +0530
Message-ID: <CAEWVvORHWTQLe_uhw2M+aT6tEjgdz3emfxEUosbo+bMsqdN=QA__33039.8632258706$1560421822$gmane$org@mail.gmail.com>
References: <CAEWVvOSE6QJQvQEdTLEhNQTE7H1Py1ggoqynSj3w-uOYBkTMCQ@mail.gmail.com>
 <72388180.2647.1558032721255.JavaMail.zimbra@efficios.com>
 <CAEWVvOS6WyAkE+5GAyn_WEoFW_6h_fWbze-im0w7oqvXS-+dBw@mail.gmail.com>
 <1448366760.18406.1559146893765.JavaMail.zimbra@efficios.com>
 <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa> <20190604145312.GB13240@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3646054741070108148=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by lists.lttng.org (Postfix) with ESMTPS id 45Pg3f32Ycz18bK
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 06:30:06 -0400 (EDT)
Received: by mail-wr1-x42c.google.com with SMTP id p11so20180268wre.7
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 03:30:06 -0700 (PDT)
In-Reply-To: <20190604145312.GB13240@joraj-alpa>
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

--===============3646054741070108148==
Content-Type: multipart/alternative; boundary="0000000000006011f3058b32031e"

--0000000000006011f3058b32031e
Content-Type: text/plain; charset="UTF-8"

>
>
> > See this dmesg source plugin for a base example of a source plugin [1].
> This is
> > valid for babeltrace 2.0 only (AKA the current master branch of
> babeltrace)
> >
> > For a more complete example of a source plugin,  you can take a look at
> the one for
> > ctf [2]. Once a source plugin is done you will be able to reuse all the
> current
> > infrastructure of babeltrace to output to ctf (ctf.sink).
> >
> > There is no magic solution here, you will need to write a decoder (source
> > plugin) for your format.
> >
> > [1]
> https://github.com/efficios/babeltrace/tree/master/plugins/text/dmesg
>
> For all the people coming here from the future:
>
> [1]
> http://git.efficios.com/?p=babeltrace.git;a=tree;f=plugins/text/dmesg;h=a45918aaf266dac29db6f7a0e4d08ffdb056131a
>
> > [2]
> https://github.com/efficios/babeltrace/tree/master/plugins/ctf/fs-src
>
> [2]
> http://git.efficios.com/?p=babeltrace.git;a=tree;f=plugins/ctf/fs-sink;h=b96b435706cac0ed50cb64918603172b67afc424
>

Thanks for sharing the links. I have cloned the babeltrace master branch
and installed all the dependencies required. The build was successful.

How should I use decoder(source plugin) example[1]? I mean I can see the
code and change it but how should I use it?

[1]
https://github.com/efficios/babeltrace/tree/master/src/plugins/ctf/fs-src

Thanks
-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000006011f3058b32031e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>&gt; See this dmesg source plugin for a base example=
 of a source plugin [1]. This is<br>
&gt; valid for babeltrace 2.0 only (AKA the current master branch of babelt=
race)<br>
&gt; <br>
&gt; For a more complete example of a source plugin,=C2=A0 you can take a l=
ook at the one for<br>
&gt; ctf [2]. Once a source plugin is done you will be able to reuse all th=
e current<br>
&gt; infrastructure of babeltrace to output to ctf (ctf.sink).<br>
&gt; <br>
&gt; There is no magic solution here, you will need to write a decoder (sou=
rce<br>
&gt; plugin) for your format.<br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/efficios/babeltrace/tree/master/plug=
ins/text/dmesg" rel=3D"noreferrer" target=3D"_blank">https://github.com/eff=
icios/babeltrace/tree/master/plugins/text/dmesg</a><br>
<br>
For all the people coming here from the future:<br>
<br>
[1] <a href=3D"http://git.efficios.com/?p=3Dbabeltrace.git;a=3Dtree;f=3Dplu=
gins/text/dmesg;h=3Da45918aaf266dac29db6f7a0e4d08ffdb056131a" rel=3D"norefe=
rrer" target=3D"_blank">http://git.efficios.com/?p=3Dbabeltrace.git;a=3Dtre=
e;f=3Dplugins/text/dmesg;h=3Da45918aaf266dac29db6f7a0e4d08ffdb056131a</a><b=
r>
<br>
&gt; [2] <a href=3D"https://github.com/efficios/babeltrace/tree/master/plug=
ins/ctf/fs-src" rel=3D"noreferrer" target=3D"_blank">https://github.com/eff=
icios/babeltrace/tree/master/plugins/ctf/fs-src</a><br>
<br>
[2] <a href=3D"http://git.efficios.com/?p=3Dbabeltrace.git;a=3Dtree;f=3Dplu=
gins/ctf/fs-sink;h=3Db96b435706cac0ed50cb64918603172b67afc424" rel=3D"noref=
errer" target=3D"_blank">http://git.efficios.com/?p=3Dbabeltrace.git;a=3Dtr=
ee;f=3Dplugins/ctf/fs-sink;h=3Db96b435706cac0ed50cb64918603172b67afc424</a>=
<br>
</blockquote></div><div><br></div>Thanks for sharing the links. I have clon=
ed the babeltrace master branch and installed all the dependencies required=
. The build was successful.<br clear=3D"all"><div><br></div><div>How should=
 I use decoder(source plugin) example[1]? I mean I can see the code and cha=
nge it but how should I use it?</div><div><br></div><div>[1]=C2=A0<a href=
=3D"https://github.com/efficios/babeltrace/tree/master/src/plugins/ctf/fs-s=
rc">https://github.com/efficios/babeltrace/tree/master/src/plugins/ctf/fs-s=
rc</a></div><div><br></div><div>Thanks</div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"4=
"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"color:rgb(102,102,=
102)">B. Tech. Computer Science and Engineering,<br></span></div><div><span=
 style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iitism.ac.in/" sty=
le=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institute of Technolog=
y (Indian School of Mines)</a>, Dhanbad</span></div></div></div></div></div=
></div>

--0000000000006011f3058b32031e--

--===============3646054741070108148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3646054741070108148==--
