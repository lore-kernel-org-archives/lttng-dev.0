From: "Nwafor, Ebelechukwu" <ebelechukwu.nwafor@bison.howard.edu>
Subject: Re: Installing LTTNG on beaglebone black or rasberry pi
Date: Thu, 17 Nov 2016 19:24:45 -0500
Message-ID: <CAAuy2AR_efNuciOO46HPiN+dvSOg6RWvpghptgp_QdBwYow80Q__10767.9476532669$1479428701$gmane$org@mail.gmail.com>
References: <CAAuy2ATLED2dopcqdjF4+Xpy7wA+OLeTwOvYma+BRkWR9xPKRg@mail.gmail.com>
 <CAF4oYfGS5Vf5CrS3XVFxDQkdrs=wtoNCNw5qOpf_G6_TDBLBsg@mail.gmail.com>
 <CAAuy2AQmRSC4Zg59gALTstfL+gBRTLynfAv0u6vhmgu-TumNpw@mail.gmail.com>
 <d0ef0af1-4c57-34bc-7764-fcf86764773f@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9060113560005173341=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKf111fmBzdMc
 for <lttng-dev@lists.lttng.org>; Fri, 18 Nov 2016 00:25:56 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id r204so18572970ywb.3
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 16:24:47 -0800 (PST)
In-Reply-To: <d0ef0af1-4c57-34bc-7764-fcf86764773f@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============9060113560005173341==
Content-Type: multipart/alternative; boundary=001a1142605c5185320541885552

--001a1142605c5185320541885552
Content-Type: text/plain; charset=UTF-8

Thanks Jonathan for you helpful response. I was able to install the
specific linux-headers and it seems to install all of the modules. Now i've
hit another roadblock. whenever i try to list all of the kernel events
using lttng list -k, it throws an error: unable to list kernel events:
Kernel tracer is not available. I have two lttng-sessiond running.

On Thu, Nov 17, 2016 at 4:45 PM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
>
> On 2016-11-17 04:24 PM, Nwafor, Ebelechukwu wrote:
>
>> Hi Jonathan. Thank you for your response.
>>
>> On the beaglebone black, i tried building lttng-tools, lttng-modules-dkms
>> and lttng-ust-dev from source v2.8.1 by following the documentation.
>> lttng-modules-dkms runs fine but the module does not show up on the list of
>> running modules when i issue an lsmod command. Also, i run into errors
>> while trying to build and compile lttng-tools. Beaglebone black runs on
>> debian. Linux beaglebone 3.8.13-bone70 #1 SMP Fri Jan 23 02:15:42 UTC 2015
>> armv7l GNU/Linux
>>
>
> What errors do you see when building lttng-tools?
>
>
>>
>> On the raspberry pi, I use the commands, apt-get install
>> lttng-modules-dkms lttng-tools lttng-ust-dev. Everything seems to work fine
>> with the exception of lttng-modules-dkms which does not show up on the list
>> on running modules. Also, every time i try to view available kernel events,
>> it comes up with an error saying unable to list kernel events: kernel
>> tracer not available. The LTTNG version installed using apt-get is 2.7.1. I
>> am running ubuntu mate OS. Below are the output while installing
>> lttng-modules-dkms
>>
>
> Well as the error points out do you have the kernel tracer started?
>
> ps -aux | grep lttng-sessiond
>
> Does the user trying to use lttng is part of the tracing group or is root ?
>
> You can start lttng-sessiond with the -vvv options make sure to be root
> when doing so lttng-sessiond load the tracing modules.
>
> Since you installed it from apt-get the lttng-tools package provide a
> daemon for lttng-sessiond so before testing manually:
>
> service lttng-sessiond stop
>
>
>>
>> root@ebele-desktop:~# apt-get install lttng-modules-dkms
>> Reading package lists... Done
>> Building dependency tree
>> Reading state information... Done
>> lttng-modules-dkms is already the newest version (2.7.1-1).
>> 0 upgraded, 0 newly installed, 0 to remove and 14 not upgraded.
>> 2 not fully installed or removed.
>> After this operation, 0 B of additional disk space will be used.
>> Do you want to continue? [Y/n] Y
>> Setting up linux-headers-4.4.0-22 (4.4.0-22.40) ...
>> Setting up lttng-modules-dkms (2.7.1-1) ...
>> Loading new lttng-modules-2.7.1 DKMS files...
>> First Installation: checking all kernels...
>> dpkg: warning: version '*-*' has bad syntax: version number does not
>> start with digit
>> It is likely that 4.4.30-v7+ belongs to a chroot's host
>> Module build for the currently running kernel was skipped since the
>> kernel source for this kernel does not seem to be installed.
>>
>
>
> Could you make sure that your linux header for the running kernel are
> installed.
>
> 4.4.30-v7+ seems like a custom kernel install.
>
> root@ebele-desktop:~#
>>
>>
>>
>> On Thu, Nov 17, 2016 at 3:00 PM, Jonathan Rajotte <
>> jonathan.r.julien@gmail.com <mailto:jonathan.r.julien@gmail.com>> wrote:
>>
>>     Hi,
>>
>>     Could you be a bit more precise regarding which part of the
>>     documentation does not work ?
>>
>>     How did you install it ? Distribution packages ? From sources ?
>>     Cross compiled ?
>>
>>     What is your setup ? Raspian for the Pi ? Custom kernel image ?
>>
>>     Cheers
>>
>>     On Thu, Nov 17, 2016 at 2:54 PM, Nwafor, Ebelechukwu
>>     <ebelechukwu.nwafor@bison.howard.edu
>>     <mailto:ebelechukwu.nwafor@bison.howard.edu>> wrote:
>>
>>         Hello.
>>
>>         I am trying to install LTTNG tracing tool on raspberry pi and
>>         beaglebone black board.The official LTTNG documentation does
>>         not work on these devices. Does anyone know of any tutorial
>>         that can help me accomplish this? Thanks.
>>
>>         --         Ebelechukwu Nwafor,
>>         Graduate Student,
>>         Howard University.
>>
>>         _______________________________________________
>>         lttng-dev mailing list
>>         lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>         <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>>
>>
>>
>>
>>     --     Jonathan Rajotte Julien
>>
>>
>>
>>
>> --
>> Ebelechukwu Nwafor,
>> Graduate Student,
>> Howard University.
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Jonathan R. Julien
> Efficios
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- 
Ebelechukwu Nwafor,
Graduate Student,
Howard University.

--001a1142605c5185320541885552
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Jonathan for you helpful response. I was able to in=
stall the specific linux-headers and it seems to install all of the modules=
. Now i&#39;ve hit another roadblock. whenever i try to list all of the ker=
nel events using lttng list -k, it throws an error: unable to list kernel e=
vents: Kernel tracer is not available. I have two lttng-sessiond running.=
=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Th=
u, Nov 17, 2016 at 4:45 PM, Jonathan Rajotte Julien <span dir=3D"ltr">&lt;<=
a href=3D"mailto:Jonathan.rajotte-julien@efficios.com" target=3D"_blank">Jo=
nathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Hi,<span class=3D""><br>
<br>
<br>
On 2016-11-17 04:24 PM, Nwafor, Ebelechukwu wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Jonathan. Thank you for your response.<br>
<br>
On the beaglebone black, i tried building lttng-tools, lttng-modules-dkms a=
nd lttng-ust-dev from source v2.8.1 by following the documentation. lttng-m=
odules-dkms runs fine but the module does not show up on the list of runnin=
g modules when i issue an lsmod command. Also, i run into errors while tryi=
ng to build and compile lttng-tools. Beaglebone black runs on debian. Linux=
 beaglebone 3.8.13-bone70 #1 SMP Fri Jan 23 02:15:42 UTC 2015 armv7l GNU/Li=
nux<br>
</blockquote>
<br></span>
What errors do you see when building lttng-tools?<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
On the raspberry pi, I use the commands, apt-get install lttng-modules-dkms=
 lttng-tools lttng-ust-dev. Everything seems to work fine with the exceptio=
n of lttng-modules-dkms which does not show up on the list on running modul=
es. Also, every time i try to view available kernel events, it comes up wit=
h an error saying unable to list kernel events: kernel tracer not available=
. The LTTNG version installed using apt-get is 2.7.1. I am running ubuntu m=
ate OS. Below are the output while installing lttng-modules-dkms<br>
</blockquote>
<br></span>
Well as the error points out do you have the kernel tracer started?<br>
<br>
ps -aux | grep lttng-sessiond<br>
<br>
Does the user trying to use lttng is part of the tracing group or is root ?=
<br>
<br>
You can start lttng-sessiond with the -vvv options make sure to be root whe=
n doing so lttng-sessiond load the tracing modules.<br>
<br>
Since you installed it from apt-get the lttng-tools package provide a daemo=
n for lttng-sessiond so before testing manually:<br>
<br>
service lttng-sessiond stop<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
root@ebele-desktop:~# apt-get install lttng-modules-dkms<br>
Reading package lists... Done<br>
Building dependency tree<br>
Reading state information... Done<br>
lttng-modules-dkms is already the newest version (2.7.1-1).<br>
0 upgraded, 0 newly installed, 0 to remove and 14 not upgraded.<br>
2 not fully installed or removed.<br>
After this operation, 0 B of additional disk space will be used.<br>
Do you want to continue? [Y/n] Y<br>
Setting up linux-headers-4.4.0-22 (4.4.0-22.40) ...<br>
Setting up lttng-modules-dkms (2.7.1-1) ...<br>
Loading new lttng-modules-2.7.1 DKMS files...<br>
First Installation: checking all kernels...<br>
dpkg: warning: version &#39;*-*&#39; has bad syntax: version number does no=
t start with digit<br>
It is likely that 4.4.30-v7+ belongs to a chroot&#39;s host<br>
Module build for the currently running kernel was skipped since the<br>
kernel source for this kernel does not seem to be installed.<br>
</blockquote>
<br>
<br></span>
Could you make sure that your linux header for the running kernel are insta=
lled.<br>
<br>
4.4.30-v7+ seems like a custom kernel install.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
root@ebele-desktop:~#<span class=3D""><br>
<br>
<br>
<br>
On Thu, Nov 17, 2016 at 3:00 PM, Jonathan Rajotte &lt;<a href=3D"mailto:jon=
athan.r.julien@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>=
 &lt;mailto:<a href=3D"mailto:jonathan.r.julien@gmail.com" target=3D"_blank=
">jonathan.r.julien@gmai<wbr>l.com</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 Hi,<br>
<br>
=C2=A0 =C2=A0 Could you be a bit more precise regarding which part of the<b=
r>
=C2=A0 =C2=A0 documentation does not work ?<br>
<br>
=C2=A0 =C2=A0 How did you install it ? Distribution packages ? From sources=
 ?<br>
=C2=A0 =C2=A0 Cross compiled ?<br>
<br>
=C2=A0 =C2=A0 What is your setup ? Raspian for the Pi ? Custom kernel image=
 ?<br>
<br>
=C2=A0 =C2=A0 Cheers<br>
<br>
=C2=A0 =C2=A0 On Thu, Nov 17, 2016 at 2:54 PM, Nwafor, Ebelechukwu<br>
=C2=A0 =C2=A0 &lt;<a href=3D"mailto:ebelechukwu.nwafor@bison.howard.edu" ta=
rget=3D"_blank">ebelechukwu.nwafor@bison.howa<wbr>rd.edu</a><br></span><spa=
n class=3D"">
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:ebelechukwu.nwafor@bison.howard.=
edu" target=3D"_blank">ebelechukwu.nwafor@bis<wbr>on.howard.edu</a>&gt;&gt;=
 wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hello.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I am trying to install LTTNG tracing tool on ra=
spberry pi and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 beaglebone black board.The official LTTNG docum=
entation does<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 not work on these devices. Does anyone know of =
any tutorial<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 that can help me accomplish this? Thanks.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ebelechukwu=
 Nwafor,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Graduate Student,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Howard University.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ______________________________<wbr>____________=
_____<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-dev mailing list<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.<wbr>org=
</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bi<wbr>n/mailman/listinfo/lttng-dev</a><span class=3D""><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.lttng.org/cgi-b<wbr>in/mailman/listinfo/lttng-dev</a>&gt;<br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0Jonathan Rajotte Julien<br>
<br>
<br>
<br>
<br>
-- <br>
Ebelechukwu Nwafor,<br>
Graduate Student,<br>
Howard University.<br>
<br>
<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
</span></blockquote><span class=3D"HOEnZb"><font color=3D"#888888">
<br>
-- <br>
Jonathan R. Julien<br>
Efficios</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Ebelechukwu Nwafor,<div>Graduate Student,</div><div>Howard Univers=
ity.</div></div></div>
</div>

--001a1142605c5185320541885552--

--===============9060113560005173341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9060113560005173341==--
