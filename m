From: Chidhu R <chid1989@gmail.com>
Subject: Re: Warning: HOME environment variable not set.
Date: Wed, 18 Mar 2015 09:31:04 -0700
Message-ID: <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA__7710.39739852331$1426696366$gmane$org@mail.gmail.com>
References: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1872564959=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YYGso-0005vA-Tn
 for lttng-dev@lists.lttng.org; Wed, 18 Mar 2015 12:31:52 -0400
Received: by lbblx11 with SMTP id lx11so11611249lbb.3
 for <lttng-dev@lists.lttng.org>; Wed, 18 Mar 2015 09:31:45 -0700 (PDT)
In-Reply-To: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1872564959==
Content-Type: multipart/alternative; boundary=001a11347b2c76fe740511929e1b

--001a11347b2c76fe740511929e1b
Content-Type: text/plain; charset=UTF-8

I too am getting the same errors. Inspite of setting LTTNG_HOME in my
program.

On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <anand.neeli@gmail.com> wrote:

> Hi All,
>
> any idea when do we get this error?
>
> app: libust[4745/4745]: Warning: HOME environment variable not set.
> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> lttng-ust-comm.c:385)
> app: libust[4751/4751]: Warning: HOME environment variable not set.
> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> lttng-ust-comm.c:385)
> app: libust[4760/4760]: Warning: HOME environment variable not set.
> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> lttng-ust-comm.c:385)
> app: libust[4780/4780]: Warning: HOME environment variable not set.
> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> lttng-ust-comm.c:385)
>
> i have set LTTNG_HOME=HOME=/home/root
> using 2.6
>
> Thanks,
> Anand Neeli
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--001a11347b2c76fe740511929e1b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I too am getting the same errors. Inspite of setting LTTNG=
_HOME in my program.=C2=A0</div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <span dir=3D"=
ltr">&lt;<a href=3D"mailto:anand.neeli@gmail.com" target=3D"_blank">anand.n=
eeli@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 dir=3D"ltr">Hi All,<div><br></div><div>any idea when do we get this error?=
</div><div><br></div><div><div>app: libust[4745/4745]: Warning: HOME enviro=
nment variable not set. Disabling LTTng-UST per-user tracing. (in setup_loc=
al_apps() at lttng-ust-comm.c:385)</div><div>app: libust[4751/4751]: Warnin=
g: HOME environment variable not set. Disabling LTTng-UST per-user tracing.=
 (in setup_local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[4760=
/4760]: Warning: HOME environment variable not set. Disabling LTTng-UST per=
-user tracing. (in setup_local_apps() at lttng-ust-comm.c:385)</div><div>ap=
p: libust[4780/4780]: Warning: HOME environment variable not set. Disabling=
 LTTng-UST per-user tracing. (in setup_local_apps() at lttng-ust-comm.c:385=
)</div></div><div><br></div><div>i have set LTTNG_HOME=3DHOME=3D/home/root<=
/div><div>using 2.6</div><div><br></div><div>Thanks,</div><div>Anand Neeli<=
/div><div><br></div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>

--001a11347b2c76fe740511929e1b--


--===============1872564959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1872564959==--
