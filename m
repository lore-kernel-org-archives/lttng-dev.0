From: Zvi Vered <veredz72@gmail.com>
Subject: Re: lttng-tools-2.10.6: Spawning consumerd failed
Date: Sun, 19 May 2019 17:01:08 +0300
Message-ID: <CABRndgynx5+Qo_X-oJh0LaGuTPAAV=3Y+m0uQF51t0FoDexNsQ__4493.54628087662$1558274729$gmane$org@mail.gmail.com>
References: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ@mail.gmail.com>
 <20190514142948.GA10361@joraj-alpa> <20190514180433.GB10361@joraj-alpa>
 <CABRndgxNtLbXZ0peWNm7qq_kxT4fY_PspgJ6hR=H82r3o8Nhmw@mail.gmail.com>
 <20190515143300.GA15967@joraj-alpa>
 <CABRndgwxboyBQ_5pSXEV+S2687=9rUsPEtww29qAxAHEnSOMfw@mail.gmail.com>
 <20190517194826.GC9052@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0080521638328087924=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by lists.lttng.org (Postfix) with ESMTPS id 456P1Q0kcgzyyx
 for <lttng-dev@lists.lttng.org>; Sun, 19 May 2019 10:05:13 -0400 (EDT)
Received: by mail-yb1-xb42.google.com with SMTP id k202so4647862ybk.2
 for <lttng-dev@lists.lttng.org>; Sun, 19 May 2019 07:05:13 -0700 (PDT)
In-Reply-To: <20190517194826.GC9052@joraj-alpa>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0080521638328087924==
Content-Type: multipart/alternative; boundary="000000000000bcedc505893e1a67"

--000000000000bcedc505893e1a67
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

I had to run:
export LTTNG_CONSUMERD32_BIN=/lib/lttng/libexec/lttng-consumerd

Thank you very much !
Zvika

On Fri, May 17, 2019 at 10:48 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> You forgot to cc the mailing list. Adding it.
>
> On Fri, May 17, 2019 at 04:50:02AM +0300, Zvi Vered wrote:
> > Hi Janathan, All,
> >
> > I solved the path issue with
> >
> > export LTTNG_CONSUMERD32_BIN=/lib/lttng/libexec
> > export LTTNG_CONSUMERD32_LIBDIR =/lib
> > export LTTNG_SESSION_CONFIG_XSD_PATH=/share/lttng/...
>
> This is a way to solve it, I would still recommend you fix it at the source
> (proper cross build).
>
> ...
>
> > ....
> > DEBUG3 - 00:13:48.436226116 [1980/1980]: Looking for a kernel consumer at
> > these locations: (in spawn_consumerd() at main.c:2429)
> > DEBUG3 - 00:13:48.436252139 [1980/1980]:        1) NULL (in
> > spawn_consumerd() at main.c:2430)
> > DEBUG3 - 00:13:48.436256414 [1980/1980]:        2)
> >
> /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec/lttng-consumerd
> > (in spawn_consumerd() at main.c:2431)
> > DEBUG3 - 00:13:48.436260543 [1980/1980]:        3) /lib/lttng/libexec (in
> > spawn_consumerd() at main.c:2432)
> > DEBUG3 - 00:13:48.436313492 [1980/1980]: Found location #3 (in
> > spawn_consumerd() at main.c:2441)
> > DEBUG1 - 00:13:48.436319027 [1980/1980]: Using kernel consumer at:
> > /lib/lttng/libexec (in spawn_consumerd() at main.c:2448)
> > PERROR - 00:13:48.436341261 [1980/1980]: Consumer execl(): Permission
> > denied (in spawn_consumerd() at main.c:2539)
>
> We found the consumerd in /lib/lttng/libexec/lttng-consumerd. Good.
>
> We now try to execl the following:
>
> /lib/lttng/libexec/lttng-consumerd -k --consumerd-cmd-sock <a_path>
> --consumerd-error-sock <b_path> --group root
>
> And execl returns "Permission Denied".
>
> Clearly, /lib/lttng/libexec/lttng-consumerd have some permissions problem.
>
> "Permission denied" is linked to EACCES on my system.
>   asm-generic/errno-base.h
>   17:#define    EACCES          13     /* Permission denied */
>
> "man execve" list all the reasons why execl might return EACCES per "man
> execl":
>
>   EACCES Search permission is denied on a component of the path prefix of
> filename or the name of a script interpreter.  (See also
> path_resolution(7).)
>   EACCES The file or a script interpreter is not a regular file.
>   EACCES Execute permission is denied for the file or a script or ELF
> interpreter.
>   EACCES The filesystem is mounted noexec.
>
> One of them probably fit your current scenario.
>
> Let us know how it goes.
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000bcedc505893e1a67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>I had to run:</div><div><s=
pan style=3D"color:rgb(80,0,80)">export LTTNG_CONSUMERD32_BIN=3D/lib/ltt</s=
pan><span style=3D"color:rgb(80,0,80)">ng/libexec/lttng-consumerd</span></d=
iv><div><br></div><div>Thank you very much !</div><div>Zvika=C2=A0=C2=A0<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, May 17, 2019 at 10:48 PM Jonathan Rajotte-Julien &lt;<a href=
=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@ef=
ficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi,<br>
<br>
You forgot to cc the mailing list. Adding it.<br>
<br>
On Fri, May 17, 2019 at 04:50:02AM +0300, Zvi Vered wrote:<br>
&gt; Hi Janathan, All,<br>
&gt; <br>
&gt; I solved the path issue with<br>
&gt; <br>
&gt; export LTTNG_CONSUMERD32_BIN=3D/lib/lttng/libexec<br>
&gt; export LTTNG_CONSUMERD32_LIBDIR =3D/lib<br>
&gt; export LTTNG_SESSION_CONFIG_XSD_PATH=3D/share/lttng/...<br>
<br>
This is a way to solve it, I would still recommend you fix it at the source=
<br>
(proper cross build).<br>
<br>
...<br>
<br>
&gt; ....<br>
&gt; DEBUG3 - 00:13:48.436226116 [1980/1980]: Looking for a kernel consumer=
 at<br>
&gt; these locations: (in spawn_consumerd() at main.c:2429)<br>
&gt; DEBUG3 - 00:13:48.436252139 [1980/1980]:=C2=A0 =C2=A0 =C2=A0 =C2=A0 1)=
 NULL (in<br>
&gt; spawn_consumerd() at main.c:2430)<br>
&gt; DEBUG3 - 00:13:48.436256414 [1980/1980]:=C2=A0 =C2=A0 =C2=A0 =C2=A0 2)=
<br>
&gt; /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec=
/lttng-consumerd<br>
&gt; (in spawn_consumerd() at main.c:2431)<br>
&gt; DEBUG3 - 00:13:48.436260543 [1980/1980]:=C2=A0 =C2=A0 =C2=A0 =C2=A0 3)=
 /lib/lttng/libexec (in<br>
&gt; spawn_consumerd() at main.c:2432)<br>
&gt; DEBUG3 - 00:13:48.436313492 [1980/1980]: Found location #3 (in<br>
&gt; spawn_consumerd() at main.c:2441)<br>
&gt; DEBUG1 - 00:13:48.436319027 [1980/1980]: Using kernel consumer at:<br>
&gt; /lib/lttng/libexec (in spawn_consumerd() at main.c:2448)<br>
&gt; PERROR - 00:13:48.436341261 [1980/1980]: Consumer execl(): Permission<=
br>
&gt; denied (in spawn_consumerd() at main.c:2539)<br>
<br>
We found the consumerd in /lib/lttng/libexec/lttng-consumerd. Good.<br>
<br>
We now try to execl the following:<br>
<br>
/lib/lttng/libexec/lttng-consumerd -k --consumerd-cmd-sock &lt;a_path&gt; -=
-consumerd-error-sock &lt;b_path&gt; --group root<br>
<br>
And execl returns &quot;Permission Denied&quot;.<br>
<br>
Clearly, /lib/lttng/libexec/lttng-consumerd have some permissions problem.<=
br>
<br>
&quot;Permission denied&quot; is linked to EACCES on my system.<br>
=C2=A0 asm-generic/errno-base.h<br>
=C2=A0 17:#define=C2=A0 =C2=A0 EACCES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13=
=C2=A0 =C2=A0 =C2=A0/* Permission denied */<br>
<br>
&quot;man execve&quot; list all the reasons why execl might return EACCES p=
er &quot;man execl&quot;:<br>
<br>
=C2=A0 EACCES Search permission is denied on a component of the path prefix=
 of filename or the name of a script interpreter.=C2=A0 (See also path_reso=
lution(7).)<br>
=C2=A0 EACCES The file or a script interpreter is not a regular file.<br>
=C2=A0 EACCES Execute permission is denied for the file or a script or ELF =
interpreter.<br>
=C2=A0 EACCES The filesystem is mounted noexec.<br>
<br>
One of them probably fit your current scenario.<br>
<br>
Let us know how it goes.<br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--000000000000bcedc505893e1a67--

--===============0080521638328087924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0080521638328087924==--
