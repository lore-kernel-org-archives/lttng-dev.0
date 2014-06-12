From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: lttng ubuntu .deb packages - compilation error
Date: Fri, 13 Jun 2014 03:04:39 +0530
Message-ID: <CAM5kDqxJSHNcEj7=Jv+yDNJk9+bPCwTEjvYgdk36Pz8iMcw+qQ__43697.9997939945$1402608938$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0759130262=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1WvCdx-0004zh-Jh
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 17:34:49 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so1860401wgh.4
 for <lttng-dev@lists.lttng.org>; Thu, 12 Jun 2014 14:34:39 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0759130262==
Content-Type: multipart/alternative; boundary=047d7bfd016606adbb04fbaa5406

--047d7bfd016606adbb04fbaa5406
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm using a i386 ubuntu deb package to get include file of lttng-ust and
urcu
I have just instrumented with a basic tracepoint, my tracepoint .c and .h
look good.

i get following error fatal error: sys/sdt.h: No such file or directory

/home/aneeli/evo_all/cevo/liblogtrace_test/src/logtrace_test.c
In file included from
/home/aneeli/evo_all/cevo/liblogtrace_test/src/logtest_tracepoint.h:11:0,
                 from
/home/aneeli/evo_all/cevo/liblogtrace_test/src/logtrace_test.c:18:
/home/aneeli/evo_all/cevo/lttng/obj-native/install/usr/include/lttng/tracepoint.h:38:21:
fatal error: sys/sdt.h: No such file or directory
compilation terminated.

looks like LTTNG_UST_HAVE_SDT_INTEGRATION flag is set in deb i386 files
lttng/ust-config.h:
#define LTTNG_UST_HAVE_SDT_INTEGRATION 1

Where as LTTNG_UST_HAVE_SDT_INTEGRATION=1 is commented when i compile
manually for some other platforms

Am i missing anything here?
how can i compile for i386 using include files from deb.


Thanks,
Anand Neeli



On Fri, Jun 13, 2014 at 12:28 AM, Alexandre Montplaisir <
alexmonthy@voxpopuli.im> wrote:

>  Yes! There are PPAs for Ubuntu packages, one for the stable branches:
> https://launchpad.net/~lttng/+archive/ppa
>
> and one for builds of the git master:
> https://launchpad.net/~lttng/+archive/daily
>
>
> Cheers,
> Alexandre
>
>
>
> On 06/12/2014 02:27 PM, Anand Neeli wrote:
>
> Hi All,
> are there latest ubuntu .deb of lttng-ust, lttng-ust-dev, liburcu,
> liburcu-dev available?
> i'm looking for i386 and amd64 CPU target
> if yes, can some one tell me the location to download?
>
> i'm able to find older versions in http://packages.ubuntu.com, but i'm
> looking for the latest deb files
>
> Thanks,
> Anand Neeli
>
>
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>

--047d7bfd016606adbb04fbaa5406
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m using a i386 ubuntu deb package to get=
 include file of lttng-ust and urcu</div><div>I have just instrumented with=
 a basic tracepoint, my tracepoint .c and .h look good.</div><div><br></div=
>
<div>i get following error fatal error: sys/sdt.h: No such file or director=
y</div><div><br></div><div><div>/home/aneeli/evo_all/cevo/liblogtrace_test/=
src/logtrace_test.c</div><div>In file included from /home/aneeli/evo_all/ce=
vo/liblogtrace_test/src/logtest_tracepoint.h:11:0,</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /ho=
me/aneeli/evo_all/cevo/liblogtrace_test/src/logtrace_test.c:18:</div><div>/=
home/aneeli/evo_all/cevo/lttng/obj-native/install/usr/include/lttng/tracepo=
int.h:38:21: fatal error: sys/sdt.h: No such file or directory</div>
<div>compilation terminated.</div></div><div><br></div><div>looks like=C2=
=A0LTTNG_UST_HAVE_SDT_INTEGRATION flag is set in deb i386 files</div><div><=
div>lttng/ust-config.h:</div><div>#define LTTNG_UST_HAVE_SDT_INTEGRATION 1<=
/div>
</div><div><br></div><div>Where as=C2=A0LTTNG_UST_HAVE_SDT_INTEGRATION=3D1=
=C2=A0is commented when i compile manually for some other platforms</div><d=
iv><br></div><div>Am i missing anything here?</div><div>how can i compile f=
or i386 using include files from deb.</div>
<div><br></div><div><br></div><div class=3D"gmail_extra">Thanks,</div><div =
class=3D"gmail_extra">Anand Neeli</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Jun =
13, 2014 at 12:28 AM, Alexandre Montplaisir <span dir=3D"ltr">&lt;<a href=
=3D"mailto:alexmonthy@voxpopuli.im" target=3D"_blank">alexmonthy@voxpopuli.=
im</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    Yes! There are PPAs for Ubuntu packages, one for the stable
    branches:<br>
    <a href=3D"https://launchpad.net/~lttng/+archive/ppa" target=3D"_blank"=
>https://launchpad.net/~lttng/+archive/ppa</a><br>
    <br>
    and one for builds of the git master:<br>
    <a href=3D"https://launchpad.net/~lttng/+archive/daily" target=3D"_blan=
k">https://launchpad.net/~lttng/+archive/daily</a><br>
    <br>
    <br>
    Cheers,<br>
    Alexandre<div><div class=3D"h5"><br>
    <br>
    <br>
    <div>On 06/12/2014 02:27 PM, Anand Neeli
      wrote:<br>
    </div>
    </div></div><blockquote type=3D"cite"><div><div class=3D"h5">
      <pre>Hi All,
are there latest ubuntu .deb of lttng-ust, lttng-ust-dev, liburcu,
liburcu-dev available?
i&#39;m looking for i386 and amd64 CPU target
if yes, can some one tell me the location to download?

i&#39;m able to find older versions in <a href=3D"http://packages.ubuntu.co=
m" target=3D"_blank">http://packages.ubuntu.com</a>, but i&#39;m
looking for the latest deb files

Thanks,
Anand Neeli

</pre>
      <br>
      <fieldset></fieldset>
      <br>
      </div></div><pre>_______________________________________________
lttng-dev mailing list
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div><br></div></div>

--047d7bfd016606adbb04fbaa5406--


--===============0759130262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0759130262==--
