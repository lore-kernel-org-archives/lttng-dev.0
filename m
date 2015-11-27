From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: compile error in lttng-ust-2.4.4
Date: Fri, 27 Nov 2015 11:52:35 -0500
Message-ID: <CAF4oYfGjHjFY0MVRRht6KbxbDW74Grjo=hw1V_SVWtNydFPjTg__12902.819857891$1448643289$gmane$org@mail.gmail.com>
References: <CABRndgwATfY9cPKb2JSzg_aO=8Q6_qZxRsf-YxnahhoMU6QH1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0387271035=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f179.google.com ([209.85.223.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1a2MGG-0002Xw-Oh
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 11:52:45 -0500
Received: by iouu10 with SMTP id u10so120686469iou.0
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2015 08:52:35 -0800 (PST)
In-Reply-To: <CABRndgwATfY9cPKb2JSzg_aO=8Q6_qZxRsf-YxnahhoMU6QH1A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zvi Vered <veredz72@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0387271035==
Content-Type: multipart/alternative; boundary=001a113ece62acb89a05258884a5

--001a113ece62acb89a05258884a5
Content-Type: text/plain; charset=UTF-8

Hi Zvi,

The 2.4 tool set (modules/ust/tools) is not officially supported (actively
developed) anymore. I highly encourage you to move towards lttng 2.7 tool
set unless you have very specific requirements.

Cheers!


On Thu, Nov 26, 2015 at 11:20 PM, Zvi Vered <veredz72@gmail.com> wrote:

> Hello,
>
> I downloaded lttng-ust-2.4.4 extracted it and ran ./configure
> Then I ran make.
>
> I got the following error:
>
> ....
>   CC       lttng-filter-specialize.lo
>   CC       lttng-filter-interpreter.lo
>   CC       lttng-ust-baddr.lo
> In file included from ../include/lttng/ust-tracepoint-event.h:724,
>                  from ../include/lttng/tracepoint-event.h:58,
>                  from ust_baddr_statedump.h:56,
>                  from lttng-ust-baddr.c:40:
> ././ust_baddr_statedump.h:40: error: weak declaration of
> '__ref_loglevel___ust_baddr_statedump___soinfo' must be public
> ././ust_baddr_statedump.h:40: error:
> '__ref_loglevel___ust_baddr_statedump___soinfo' defined both normally
> and as an alias
> ././ust_baddr_statedump.h:40: error: weak declaration of
> '__ref_model_emf_uri___ust_baddr_statedump___soinfo' must be public
> ././ust_baddr_statedump.h:40: error:
> '__ref_model_emf_uri___ust_baddr_statedump___soinfo' defined both
> normally and as an alias
> make[2]: *** [lttng-ust-baddr.lo] Error 1
> make[2]: Leaving directory
> `/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4/liblttng-ust'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4'
> make: *** [all] Error 2
>
> I'm running under Centos 5.5 (32),
> gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>
> Best regards,
> Z.V
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- 
Jonathan Rajotte Julien

--001a113ece62acb89a05258884a5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Zvi,<div><br></div><div>The 2.4 tool set (modules/ust/t=
ools) is not officially supported (actively developed) anymore. I highly en=
courage you to move towards lttng 2.7 tool set unless you have very specifi=
c requirements.</div><div><br></div><div>Cheers!</div><div><br></div></div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Nov 26, 2=
015 at 11:20 PM, Zvi Vered <span dir=3D"ltr">&lt;<a href=3D"mailto:veredz72=
@gmail.com" target=3D"_blank">veredz72@gmail.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Hello,<br>
<br>
I downloaded lttng-ust-2.4.4 extracted it and ran ./configure<br>
Then I ran make.<br>
<br>
I got the following error:<br>
<br>
....<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng-filter-specialize.lo<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng-filter-interpreter.lo<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng-ust-baddr.lo<br>
In file included from ../include/lttng/ust-tracepoint-event.h:724,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../inclu=
de/lttng/tracepoint-event.h:58,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ust_badd=
r_statedump.h:56,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from lttng-us=
t-baddr.c:40:<br>
././ust_baddr_statedump.h:40: error: weak declaration of<br>
&#39;__ref_loglevel___ust_baddr_statedump___soinfo&#39; must be public<br>
././ust_baddr_statedump.h:40: error:<br>
&#39;__ref_loglevel___ust_baddr_statedump___soinfo&#39; defined both normal=
ly<br>
and as an alias<br>
././ust_baddr_statedump.h:40: error: weak declaration of<br>
&#39;__ref_model_emf_uri___ust_baddr_statedump___soinfo&#39; must be public=
<br>
././ust_baddr_statedump.h:40: error:<br>
&#39;__ref_model_emf_uri___ust_baddr_statedump___soinfo&#39; defined both<b=
r>
normally and as an alias<br>
make[2]: *** [lttng-ust-baddr.lo] Error 1<br>
make[2]: Leaving directory<br>
`/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4/liblttng-ust&#39;<br>
make[1]: *** [all-recursive] Error 1<br>
make[1]: Leaving directory `/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4&#3=
9;<br>
make: *** [all] Error 2<br>
<br>
I&#39;m running under Centos 5.5 (32),<br>
gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)<br>
<br>
Best regards,<br>
Z.V<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonathan Rajott=
e Julien<div><br></div></div></div></div></div>
</div>

--001a113ece62acb89a05258884a5--


--===============0387271035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0387271035==--
