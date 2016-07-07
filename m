From: Ravi Inder Singh <raviinder@gmail.com>
Subject: Re: In Redhat 7.1 kmod-lttng-modules is not installed
Date: Thu, 7 Jul 2016 11:27:09 -0400
Message-ID: <CA+=s6BZVYopq82J_bDgsd2gWC49r_+J=3_uk7H6GOH2Stiywpw__5652.32208832658$1467905279$gmane$org@mail.gmail.com>
References: <CA+=s6Bag3Pz6FkbLAmu2BEC_wbpC1ON=qrjvF=G6iVdd1N8NyQ@mail.gmail.com>
 <858964754.39767.1466176115372.JavaMail.zimbra@efficios.com>
 <CA+=s6BbTSLRR1E9ab+wwtN9jBDiZG5ybhoU4_HgEF+uUkeWu3A@mail.gmail.com>
 <987287341.60783.1467902117340.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6515915601112134243=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
 [209.85.161.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 30AF7A3B27
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jul 2016 15:27:41 +0000 (UTC)
Received: by mail-yw0-f180.google.com with SMTP id i12so16894229ywa.1
 for <lttng-dev@lists.lttng.org>; Thu, 07 Jul 2016 08:27:41 -0700 (PDT)
In-Reply-To: <987287341.60783.1467902117340.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6515915601112134243==
Content-Type: multipart/alternative; boundary=94eb2c0be6384cf5ec05370d53ed

--94eb2c0be6384cf5ec05370d53ed
Content-Type: text/plain; charset=UTF-8

Hi Michael,
    No   LTTNG modules are not installed

[root@xxxx SPECS]# lttng list --kernel
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error

Also for installing i gave following commands are commands all correct or
something else is required.

*$ rpm -i  kmod-lttng-modules-2.8.0-1.el7.x86_64.rpm
**$ cd ~/rpmbuild/SPECS
**$ rpmbuild -bb lttng-modules.spec*




Thanks,
Ravi

On Thu, Jul 7, 2016 at 10:35 AM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> ----- On Jul 6, 2016, at 6:22 PM, Ravi Inder Singh raviinder@gmail.com
> wrote:
>
> > Hi Michael,
> >     Kernel version used is :- Linux 3.10.0-229.el7.x86_64 x86_64
> >      Redahat version 7.1
> >
> >
> >      I compiled source package against my kernel it gives me following
> > Warning "Kernel ABI". Doees this effect my lttng-modules for getting
> > intsalld??
> >
>
> I think you are missing the kernel-abi-whitelists package which should be
> installed
> on the machine where you build the package. However your modules should
> work fine.
>
> Michael
>

--94eb2c0be6384cf5ec05370d53ed
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michael,=C2=A0<div>=C2=A0 =C2=A0 No=C2=A0=C2=A0 LTTNG m=
odules are not installed<br><br>[root@xxxx SPECS]# lttng list --kernel<br>E=
rror: Unable to list kernel events: Kernel tracer not available<br>Error: C=
ommand error<br><br></div><div>Also for installing i gave following command=
s are commands all correct or something else is required. <br><pre><i>$ rpm=
 -i  kmod-lttng-modules-2.8.0-1.el7.x86_64.rpm
</i><i>$ cd ~/rpmbuild/SPECS
</i><i>$ rpmbuild -bb lttng-modules.spec</i><br></pre></div><div><br></div>=
<div><br></div><div><br></div><div>Thanks,</div><div>Ravi=C2=A0<br><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jul 7, 2016 at 10=
:35 AM, Michael Jeanson <span dir=3D"ltr">&lt;<a href=3D"mailto:mjeanson@ef=
ficios.com" target=3D"_blank">mjeanson@efficios.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><span>----- On Jul 6, 2=
016, at 6:22 PM, Ravi Inder Singh <a href=3D"mailto:raviinder@gmail.com" ta=
rget=3D"_blank">raviinder@gmail.com</a> wrote:<br>
<br>
&gt; Hi Michael,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Kernel version used is :- Linux <a href=3D"tel:3.10=
.0-229" value=3D"+13100229" target=3D"_blank">3.10.0-229</a>.el7.x86_64 x86=
_64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Redahat version 7.1<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 I compiled source package against my kernel it giv=
es me following<br>
&gt; Warning &quot;Kernel ABI&quot;. Doees this effect my lttng-modules for=
 getting<br>
&gt; intsalld??<br>
&gt;<br>
<br>
</span>I think you are missing the kernel-abi-whitelists package which shou=
ld be installed<br>
on the machine where you build the package. However your modules should wor=
k fine.<br>
<span><font color=3D"#888888"><br>
Michael<br>
</font></span></blockquote></div><br></div></div></div>

--94eb2c0be6384cf5ec05370d53ed--

--===============6515915601112134243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6515915601112134243==--
