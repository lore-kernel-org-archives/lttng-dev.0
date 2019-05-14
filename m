From: Zvi Vered <veredz72@gmail.com>
Subject: lttng-tools-2.10.6: Spawning consumerd failed
Date: Tue, 14 May 2019 15:20:31 +0300
Message-ID: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ__10348.0725245149$1557836696$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5042688366969712952=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw1-xc36.google.com (mail-yw1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by lists.lttng.org (Postfix) with ESMTPS id 453H1Y3DCcz1MnC
 for <lttng-dev@lists.lttng.org>; Tue, 14 May 2019 08:24:33 -0400 (EDT)
Received: by mail-yw1-xc36.google.com with SMTP id b74so13789994ywe.5
 for <lttng-dev@lists.lttng.org>; Tue, 14 May 2019 05:24:33 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5042688366969712952==
Content-Type: multipart/alternative; boundary="000000000000794dac0588d81db6"

--000000000000794dac0588d81db6
Content-Type: text/plain; charset="UTF-8"

Hello,

I ran the following command on the target (where my kernel is running):

~ # ./lttng create my-kernel-session --output=/tmp/my-kernel-trace

and then:


~ # ./lttng enable-event --kernel --syscall open,close

and got:

Error: Spawning consumerd failed
Error: Event open: Kernel consumer start failed (channel channel0,
session my-kernel-session)
PERROR - 00:25:59.397308194 [1930/1930]: listen: Invalid argument (in
lttcomm_listen_unix_sock() at unix.c:173)
PERROR - 00:25:59.397344426 [1930/1930]: sendmsg: Bad file descriptor
(in lttcomm_send_unix_sock() at unix.c:292)
Error: Failed to send data back to client
PERROR - 00:25:59.397353233 [1930/1930]: close: Bad file descriptor
(in thread_manage_clients() at main.c:4530)
Error: Event close: Kernel consumer start failed (channel channel0,
session my-kernel-session)
~ #


Can you please explain the cause to this error ?


I'm running under a 32 bit (x86) vanilla, 4.9.20 kernel with busybox
with the following lttng versions:


lttng-tools-2.10.6.tar.bz2

lttng-ust-2.10.3.tar.bz2

lttng-modules-2.10.9.tar.bz2


Thank you,

Zvika

--000000000000794dac0588d81db6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hello,<=
div><br></div><div>I ran the following command on the target (where my kern=
el is running):</div><div><br></div><div><pre class=3D"gmail-commands" styl=
e=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-variant-n=
umeric:inherit;font-variant-east-asian:inherit;font-stretch:inherit;font-si=
ze:12px;line-height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andal=
e Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quo=
t;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;=
Lucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&q=
uot;,Courier,monospace;vertical-align:baseline;background-color:transparent=
;overflow-x:auto;color:rgba(0,0,0,0.75)"><span style=3D"color:rgb(0,0,0);fo=
nt-family:&quot;Courier New&quot;,Courier,monospace,arial,sans-serif;font-s=
ize:14px;white-space:pre-wrap">~ # ./</span>lttng create my-kernel-session =
--output=3D/tmp/my-kernel-trace</pre><pre class=3D"gmail-commands" style=3D=
"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-variant-numer=
ic:inherit;font-variant-east-asian:inherit;font-stretch:inherit;font-size:1=
2px;line-height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mo=
no&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&=
quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Luci=
da Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;=
,Courier,monospace;vertical-align:baseline;background-color:transparent;ove=
rflow-x:auto;color:rgba(0,0,0,0.75)">and then:</pre><pre class=3D"gmail-com=
mands" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;fon=
t-variant-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inhe=
rit;font-size:12px;line-height:15px;font-family:&quot;Andale Mono WT&quot;,=
&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberati=
on Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Cons=
olas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Co=
urier New&quot;,Courier,monospace;vertical-align:baseline;background-color:=
transparent;overflow-x:auto;color:rgba(0,0,0,0.75)"><br></pre></div><div><p=
re class=3D"gmail-aLF-aPX-K0-aPE" style=3D"font-family:&quot;Courier New&qu=
ot;,Courier,monospace,arial,sans-serif;margin-top:0px;margin-bottom:0px;whi=
te-space:pre-wrap;color:rgb(0,0,0);font-size:14px">~ # ./lttng enable-event=
 --kernel --syscall open,close
<br></pre><pre class=3D"gmail-aLF-aPX-K0-aPE" style=3D"font-family:&quot;Co=
urier New&quot;,Courier,monospace,arial,sans-serif;margin-top:0px;margin-bo=
ttom:0px;white-space:pre-wrap;color:rgb(0,0,0);font-size:14px">and got:</pr=
e><pre class=3D"gmail-aLF-aPX-K0-aPE" style=3D"font-family:&quot;Courier Ne=
w&quot;,Courier,monospace,arial,sans-serif;margin-top:0px;margin-bottom:0px=
;white-space:pre-wrap;color:rgb(0,0,0);font-size:14px">Error: Spawning cons=
umerd failed
Error: Event open: Kernel consumer start failed (channel channel0, session =
my-kernel-session)
PERROR - 00:25:59.397308194 [1930/1930]: listen: Invalid argument (in lttco=
mm_listen_unix_sock() at unix.c:173)
PERROR - 00:25:59.397344426 [1930/1930]: sendmsg: Bad file descriptor (in l=
ttcomm_send_unix_sock() at unix.c:292)
Error: Failed to send data back to client
PERROR - 00:25:59.397353233 [1930/1930]: close: Bad file descriptor (in thr=
ead_manage_clients() at main.c:4530)
Error: Event close: Kernel consumer start failed (channel channel0, session=
 my-kernel-session)
~ #</pre><pre class=3D"gmail-aLF-aPX-K0-aPE" style=3D"font-family:&quot;Cou=
rier New&quot;,Courier,monospace,arial,sans-serif;margin-top:0px;margin-bot=
tom:0px;white-space:pre-wrap;color:rgb(0,0,0);font-size:14px"><br></pre><pr=
e class=3D"gmail-aLF-aPX-K0-aPE" style=3D"font-family:&quot;Courier New&quo=
t;,Courier,monospace,arial,sans-serif;margin-top:0px;margin-bottom:0px;whit=
e-space:pre-wrap;color:rgb(0,0,0);font-size:14px">Can you please explain th=
e cause to this error ?</pre><pre class=3D"gmail-aLF-aPX-K0-aPE" style=3D"f=
ont-family:&quot;Courier New&quot;,Courier,monospace,arial,sans-serif;margi=
n-top:0px;margin-bottom:0px;white-space:pre-wrap;color:rgb(0,0,0);font-size=
:14px"><br></pre><pre class=3D"gmail-aLF-aPX-K0-aPE" style=3D"font-family:&=
quot;Courier New&quot;,Courier,monospace,arial,sans-serif;margin-top:0px;ma=
rgin-bottom:0px;white-space:pre-wrap;color:rgb(0,0,0);font-size:14px">I&#39=
;m running under a 32 bit (x86) vanilla, 4.9.20 kernel with busybox with th=
e following lttng versions:</pre><pre class=3D"gmail-aLF-aPX-K0-aPE" style=
=3D"font-family:&quot;Courier New&quot;,Courier,monospace,arial,sans-serif;=
margin-top:0px;margin-bottom:0px;white-space:pre-wrap;color:rgb(0,0,0);font=
-size:14px"><br></pre><pre class=3D"gmail-aLF-aPX-K0-aPE" style=3D"margin-t=
op:0px;margin-bottom:0px"><font color=3D"#000000" face=3D"Courier New, Cour=
ier, monospace, arial, sans-serif"><span style=3D"font-size:14px;white-spac=
e:pre-wrap">lttng-tools-2.10.6.tar.bz2<br></span></font></pre><pre class=3D=
"gmail-aLF-aPX-K0-aPE" style=3D"margin-top:0px;margin-bottom:0px"><font col=
or=3D"#000000" face=3D"Courier New, Courier, monospace, arial, sans-serif">=
<span style=3D"font-size:14px;white-space:pre-wrap">lttng-ust-2.10.3.tar.bz=
2<br></span></font></pre><pre class=3D"gmail-aLF-aPX-K0-aPE" style=3D"margi=
n-top:0px;margin-bottom:0px"><font color=3D"#000000" face=3D"Courier New, C=
ourier, monospace, arial, sans-serif"><span style=3D"font-size:14px;white-s=
pace:pre-wrap">lttng-modules-2.10.9.tar.bz2<br></span></font></pre><pre cla=
ss=3D"gmail-aLF-aPX-K0-aPE" style=3D"font-family:&quot;Courier New&quot;,Co=
urier,monospace,arial,sans-serif;margin-top:0px;margin-bottom:0px;white-spa=
ce:pre-wrap;color:rgb(0,0,0);font-size:14px"><br></pre><pre class=3D"gmail-=
aLF-aPX-K0-aPE" style=3D"font-family:&quot;Courier New&quot;,Courier,monosp=
ace,arial,sans-serif;margin-top:0px;margin-bottom:0px;white-space:pre-wrap;=
color:rgb(0,0,0);font-size:14px">Thank you,</pre><pre class=3D"gmail-aLF-aP=
X-K0-aPE" style=3D"font-family:&quot;Courier New&quot;,Courier,monospace,ar=
ial,sans-serif;margin-top:0px;margin-bottom:0px;white-space:pre-wrap;color:=
rgb(0,0,0);font-size:14px">Zvika </pre></div></div></div></div></div>

--000000000000794dac0588d81db6--

--===============5042688366969712952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5042688366969712952==--
