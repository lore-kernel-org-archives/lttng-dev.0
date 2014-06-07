From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: Centos 6.5 support ?
Date: Sat, 7 Jun 2014 05:15:19 -0700
Message-ID: <CAEzWAeKe-y0FCXcDv_igdmdMSQ1+2mr8e_GOEBin6VgPZFVvjQ__49930.6756807075$1402143373$gmane$org@mail.gmail.com>
References: <CAMAQheN4oJYEGMML4CsQ6jBZ=VnHZQjEuiDg5uXadDNqRrMsSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1068137546=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <yannick.brosseau@gmail.com>) id 1WtFWv-0000dW-02
 for lttng-dev@lists.lttng.org; Sat, 07 Jun 2014 08:15:26 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so6483602qge.22
 for <lttng-dev@lists.lttng.org>; Sat, 07 Jun 2014 05:15:19 -0700 (PDT)
In-Reply-To: <CAMAQheN4oJYEGMML4CsQ6jBZ=VnHZQjEuiDg5uXadDNqRrMsSw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eduardo Silva <edsiper@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1068137546==
Content-Type: multipart/alternative; boundary=001a11c27e38791a5004fb3dee6b

--001a11c27e38791a5004fb3dee6b
Content-Type: text/plain; charset=UTF-8

I think the structure you are using might need a newer version of
LTTng-ust.
Hopefully, the 2.4 version is currently in EPEL testing, and it should be
available in EPEL stable in a few days.
https://admin.fedoraproject.org/updates/FEDORA-EPEL-2014-1482/lttng-ust-2.4.1-1.el6,lttng-tools-2.4.1-1.el6


On Fri, Jun 6, 2014 at 2:06 PM, Eduardo Silva <edsiper@gmail.com> wrote:

> Hi Folks,
>
> we just got a report from one user of Monkey Project where the
> software have some missing dependencies in the system, e.g:
>
> [root@centos65 monkey-1.5.0]# make
>   CC    jemalloc [all]
>   CC    src/monkey.o
> In file included from ./include/mk_linuxtrace.h:67,
>                  from monkey.c:29:
> /usr/include/lttng/tracepoint-event.h:39:28: error:
> TRACEPOINT_INCLUDE_FILE: No such file or directory
> make[1]: *** [monkey.o] Error 1
> make: *** [all] Error 2
> [root@centos65 monkey-1.5.0]# rpm -qa |grep lttng
> lttng-ust-devel-2.0.8-1.el6.x86_64
> lttng-tools-devel-2.0.4-2.el6.x86_64
> lttng-ust-2.0.8-1.el6.x86_64
> lttng-tools-2.0.4-2.el6.x86_64
>
> after test this in a VM i found all packages are installed, is there
> anything extra required or are we missing something from the caller
> (monkey server) ?
>
> thanks for your help
>
> --
> Eduardo Silva
> http://edsiper.linuxchile.cl
> http://monkey-project.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a11c27e38791a5004fb3dee6b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think the structure you are using might need a newer ver=
sion of LTTng-ust.=C2=A0<div>Hopefully, the 2.4 version is currently in EPE=
L testing, and it should be available in EPEL stable in a few days.=C2=A0</=
div><div>
<a href=3D"https://admin.fedoraproject.org/updates/FEDORA-EPEL-2014-1482/lt=
tng-ust-2.4.1-1.el6,lttng-tools-2.4.1-1.el6">https://admin.fedoraproject.or=
g/updates/FEDORA-EPEL-2014-1482/lttng-ust-2.4.1-1.el6,lttng-tools-2.4.1-1.e=
l6</a><br>
</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">O=
n Fri, Jun 6, 2014 at 2:06 PM, Eduardo Silva <span dir=3D"ltr">&lt;<a href=
=3D"mailto:edsiper@gmail.com" target=3D"_blank">edsiper@gmail.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Folks,<br>
<br>
we just got a report from one user of Monkey Project where the<br>
software have some missing dependencies in the system, e.g:<br>
<br>
[root@centos65 monkey-1.5.0]# make<br>
=C2=A0 CC =C2=A0 =C2=A0jemalloc [all]<br>
=C2=A0 CC =C2=A0 =C2=A0src/monkey.o<br>
In file included from ./include/mk_linuxtrace.h:67,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from monkey.c=
:29:<br>
/usr/include/lttng/tracepoint-event.h:39:28: error:<br>
TRACEPOINT_INCLUDE_FILE: No such file or directory<br>
make[1]: *** [monkey.o] Error 1<br>
make: *** [all] Error 2<br>
[root@centos65 monkey-1.5.0]# rpm -qa |grep lttng<br>
lttng-ust-devel-2.0.8-1.el6.x86_64<br>
lttng-tools-devel-2.0.4-2.el6.x86_64<br>
lttng-ust-2.0.8-1.el6.x86_64<br>
lttng-tools-2.0.4-2.el6.x86_64<br>
<br>
after test this in a VM i found all packages are installed, is there<br>
anything extra required or are we missing something from the caller<br>
(monkey server) ?<br>
<br>
thanks for your help<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Eduardo Silva<br>
<a href=3D"http://edsiper.linuxchile.cl" target=3D"_blank">http://edsiper.l=
inuxchile.cl</a><br>
<a href=3D"http://monkey-project.com" target=3D"_blank">http://monkey-proje=
ct.com</a><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br></div>

--001a11c27e38791a5004fb3dee6b--


--===============1068137546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1068137546==--
