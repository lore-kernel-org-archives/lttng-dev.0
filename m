From: Francis Deslauriers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: convert call_site to func/offset
Date: Wed, 1 Jul 2020 12:25:08 -0400
Message-ID: <CADcCL0jxNy9hbvxpnQdKF_QGXYSeWD2WT+enFJO5UB7wAA8Bqw@mail.gmail.com>
References: <20200701155309.GA99920@jerryopenix>
Reply-To: Francis Deslauriers <francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1915000930479380642=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by lists.lttng.org (Postfix) with ESMTPS id 49xmmK1qbsz18mG
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 12:25:21 -0400 (EDT)
Received: by mail-pg1-f176.google.com with SMTP id p3so11962360pgh.3
 for <lttng-dev@lists.lttng.org>; Wed, 01 Jul 2020 09:25:21 -0700 (PDT)
In-Reply-To: <20200701155309.GA99920@jerryopenix>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1915000930479380642==
Content-Type: multipart/alternative; boundary="000000000000ec806505a963bc85"

--000000000000ec806505a963bc85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changcheng,

This is not currently supported by Babeltrace. It could probably be done
the same way we do it with the "ip" and "vpid" contexts in the debug-info
component class but it's not done yet.

Thanks,
Francis

Le mer. 1 juill. 2020, =C3=A0 11 h 58, Liu, Changcheng via lttng-dev <
lttng-dev@lists.lttng.org> a =C3=A9crit :

> Hi all,
>     I checked __cyg_profile_func_enter implementation.
>     The caller address is recorded into call_site field.
>
>     Does anyone know how to let babeltrace show the call_site into
>     "func/offset" format instead of the running virtual address?
>
> B.R.
> Changcheng
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--=20
Francis Deslauriers
Computer Engineer
EfficiOS inc.

--000000000000ec806505a963bc85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Changcheng,</div><div><br></div><div>This is not c=
urrently supported by Babeltrace. It could probably be done the same way we=
 do it with the &quot;ip&quot; and &quot;vpid&quot; contexts in the debug-i=
nfo component class but it&#39;s not done yet.</div><div><br></div><div>Tha=
nks,</div><div>Francis<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Le mer. 1 juill. 2020, =C3=A0 11 h 58, Liu,=
 Changcheng via lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">=
lttng-dev@lists.lttng.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Hi all,<br>
=C2=A0 =C2=A0 I checked __cyg_profile_func_enter implementation.<br>
=C2=A0 =C2=A0 The caller address is recorded into call_site field.<br>
<br>
=C2=A0 =C2=A0 Does anyone know how to let babeltrace show the call_site int=
o<br>
=C2=A0 =C2=A0 &quot;func/offset&quot; format instead of the running virtual=
 address?<br>
<br>
B.R.<br>
Changcheng<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div>Francis De=
slauriers</div><div dir=3D"ltr">Computer Engineer<div>EfficiOS inc.</div></=
div></div></div></div></div></div>

--000000000000ec806505a963bc85--

--===============1915000930479380642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1915000930479380642==--
