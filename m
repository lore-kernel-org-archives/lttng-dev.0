From: "Nwafor, Ebelechukwu" <ebelechukwu.nwafor@bison.howard.edu>
Subject: Re: Installing LTTNG on beaglebone black or rasberry pi
Date: Thu, 17 Nov 2016 16:24:29 -0500
Message-ID: <CAAuy2AQmRSC4Zg59gALTstfL+gBRTLynfAv0u6vhmgu-TumNpw__48754.7112898484$1479417883$gmane$org@mail.gmail.com>
References: <CAAuy2ATLED2dopcqdjF4+Xpy7wA+OLeTwOvYma+BRkWR9xPKRg@mail.gmail.com>
 <CAF4oYfGS5Vf5CrS3XVFxDQkdrs=wtoNCNw5qOpf_G6_TDBLBsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8008758487675099225=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x235.google.com (mail-yb0-x235.google.com
 [IPv6:2607:f8b0:4002:c09::235])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKZ105qkRzmvJ
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 21:25:40 +0000 (UTC)
Received: by mail-yb0-x235.google.com with SMTP id d128so74813207ybh.2
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 13:24:30 -0800 (PST)
In-Reply-To: <CAF4oYfGS5Vf5CrS3XVFxDQkdrs=wtoNCNw5qOpf_G6_TDBLBsg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8008758487675099225==
Content-Type: multipart/alternative; boundary=94eb2c035c50a02226054185d00d

--94eb2c035c50a02226054185d00d
Content-Type: text/plain; charset=UTF-8

Hi Jonathan. Thank you for your response.

On the beaglebone black, i tried building lttng-tools, lttng-modules-dkms
and lttng-ust-dev from source v2.8.1 by following the documentation.
lttng-modules-dkms runs fine but the module does not show up on the list of
running modules when i issue an lsmod command. Also, i run into errors
while trying to build and compile lttng-tools. Beaglebone black runs on
debian. Linux beaglebone 3.8.13-bone70 #1 SMP Fri Jan 23 02:15:42 UTC 2015
armv7l GNU/Linux


On the raspberry pi, I use the commands, apt-get install lttng-modules-dkms
lttng-tools lttng-ust-dev. Everything seems to work fine with the exception
of lttng-modules-dkms which does not show up on the list on running
modules. Also, every time i try to view available kernel events, it comes
up with an error saying unable to list kernel events: kernel tracer not
available. The LTTNG version installed using apt-get is 2.7.1. I am running
ubuntu mate OS. Below are the output while installing lttng-modules-dkms


root@ebele-desktop:~# apt-get install lttng-modules-dkms
Reading package lists... Done
Building dependency tree
Reading state information... Done
lttng-modules-dkms is already the newest version (2.7.1-1).
0 upgraded, 0 newly installed, 0 to remove and 14 not upgraded.
2 not fully installed or removed.
After this operation, 0 B of additional disk space will be used.
Do you want to continue? [Y/n] Y
Setting up linux-headers-4.4.0-22 (4.4.0-22.40) ...
Setting up lttng-modules-dkms (2.7.1-1) ...
Loading new lttng-modules-2.7.1 DKMS files...
First Installation: checking all kernels...
dpkg: warning: version '*-*' has bad syntax: version number does not start
with digit
It is likely that 4.4.30-v7+ belongs to a chroot's host
Module build for the currently running kernel was skipped since the
kernel source for this kernel does not seem to be installed.
root@ebele-desktop:~#



On Thu, Nov 17, 2016 at 3:00 PM, Jonathan Rajotte <
jonathan.r.julien@gmail.com> wrote:

> Hi,
>
> Could you be a bit more precise regarding which part of the documentation
> does not work ?
>
> How did you install it ? Distribution packages ? From sources ? Cross
> compiled ?
>
> What is your setup ? Raspian for the Pi ? Custom kernel image ?
>
> Cheers
>
> On Thu, Nov 17, 2016 at 2:54 PM, Nwafor, Ebelechukwu <
> ebelechukwu.nwafor@bison.howard.edu> wrote:
>
>> Hello.
>>
>> I am trying to install LTTNG tracing tool on raspberry pi and beaglebone
>> black board.The official LTTNG documentation does not work on these
>> devices. Does anyone know of any tutorial that can help me accomplish this?
>> Thanks.
>>
>> --
>> Ebelechukwu Nwafor,
>> Graduate Student,
>> Howard University.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
> --
> Jonathan Rajotte Julien
>
>


-- 
Ebelechukwu Nwafor,
Graduate Student,
Howard University.

--94eb2c035c50a02226054185d00d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jonathan. Thank you for your response.</div><div><=
br></div>On the beaglebone black, i tried building lttng-tools, lttng-modul=
es-dkms and lttng-ust-dev from source v2.8.1 by following the documentation=
. lttng-modules-dkms runs fine but the module does not show up on the list =
of running modules when i issue an lsmod command. Also, i run into errors w=
hile trying to build and compile lttng-tools. Beaglebone black runs on debi=
an. Linux beaglebone 3.8.13-bone70 #1 SMP Fri Jan 23 02:15:42 UTC 2015 armv=
7l GNU/Linux<br><br><br><div>On the raspberry pi, I use the commands, apt-g=
et install lttng-modules-dkms lttng-tools lttng-ust-dev. Everything seems t=
o work fine with the exception of lttng-modules-dkms which does not show up=
 on the list on running modules. Also, every time i try to view available k=
ernel events, it comes up with an error saying unable to list kernel events=
: kernel tracer not available. The LTTNG version installed using apt-get is=
 2.7.1. I am running ubuntu mate OS. Below are the output while installing =
lttng-modules-dkms</div><div><br></div><div><br></div><div>root@ebele-deskt=
op:~# apt-get install lttng-modules-dkms=C2=A0<br>Reading package lists... =
Done<br>Building dependency tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<=
br>Reading state information... Done<br>lttng-modules-dkms is already the n=
ewest version (2.7.1-1).<br>0 upgraded, 0 newly installed, 0 to remove and =
14 not upgraded.<br>2 not fully installed or removed.<br>After this operati=
on, 0 B of additional disk space will be used.<br>Do you want to continue? =
[Y/n] Y<br>Setting up linux-headers-4.4.0-22 (4.4.0-22.40) ...<br>Setting u=
p lttng-modules-dkms (2.7.1-1) ...<br>Loading new lttng-modules-2.7.1 DKMS =
files...<br>First Installation: checking all kernels...<br>dpkg: warning: v=
ersion &#39;*-*&#39; has bad syntax: version number does not start with dig=
it<br>It is likely that 4.4.30-v7+ belongs to a chroot&#39;s host<br>Module=
 build for the currently running kernel was skipped since the<br>kernel sou=
rce for this kernel does not seem to be installed.<br>root@ebele-desktop:~#=
=C2=A0<br></div><div><br></div><div><br></div></div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">On Thu, Nov 17, 2016 at 3:00 PM, Jonatha=
n Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.r.julien@gmail.c=
om" target=3D"_blank">jonathan.r.julien@gmail.com</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>Coul=
d you be a bit more precise regarding which part of the documentation does =
not work ?</div><div><br></div><div>How did you install it ? Distribution p=
ackages ? From sources ? Cross compiled ?</div><div><br></div><div>What is =
your setup ? Raspian for the Pi ? Custom kernel image ?=C2=A0</div><div><br=
></div><div>Cheers</div></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote"><div><div class=3D"h5">On Thu, Nov 17, 2016 at 2:54 PM, Nwafor=
, Ebelechukwu <span dir=3D"ltr">&lt;<a href=3D"mailto:ebelechukwu.nwafor@bi=
son.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bison.<wbr>howard.edu<=
/a>&gt;</span> wrote:<br></div></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><d=
iv class=3D"h5"><div dir=3D"ltr"><div>Hello.</div><div><br></div>I am tryin=
g to install LTTNG tracing tool on raspberry pi and beaglebone black board.=
The official LTTNG documentation does not work on these devices. Does anyon=
e know of any tutorial that can help me accomplish this? Thanks.<span class=
=3D"m_-3084267195904687416HOEnZb"><font color=3D"#888888"><br clear=3D"all"=
><div><br></div>-- <br><div class=3D"m_-3084267195904687416m_-7757085018109=
737659gmail_signature"><div dir=3D"ltr">Ebelechukwu Nwafor,<div>Graduate St=
udent,</div><div>Howard University.</div></div></div>
</font></span></div>
<br></div></div>______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><br><=
br clear=3D"all"><div><br></div>-- <br><div class=3D"m_-3084267195904687416=
gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><=
div dir=3D"ltr">Jonathan Rajotte Julien<div><br></div></div></div></div></d=
iv>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Eb=
elechukwu Nwafor,<div>Graduate Student,</div><div>Howard University.</div><=
/div></div>
</div>

--94eb2c035c50a02226054185d00d--

--===============8008758487675099225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8008758487675099225==--
