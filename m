From: Vijay Anand <vjanandr85@gmail.com>
Subject: 32bit consumerd and UST with 64 bit lttng tools
Date: Tue, 5 Apr 2016 12:59:34 +0530
Message-ID: <CAHxF_R9AQ_x-9V9Ohuc2bg04scO_adg1rXMyW103kBn8PskmpQ__36209.3018404723$1459902687$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7173796221432993052=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 82E1EA2FC9
 for <lttng-dev@lists.lttng.org>; Tue,  5 Apr 2016 07:29:35 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id n3so9188948wmn.0
 for <lttng-dev@lists.lttng.org>; Tue, 05 Apr 2016 00:29:35 -0700 (PDT)
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

--===============7173796221432993052==
Content-Type: multipart/alternative; boundary=089e0122f05493a024052fb7ce4c

--089e0122f05493a024052fb7ce4c
Content-Type: text/plain; charset=UTF-8

Hi,

I am trying to instrument a 32 bit application with lttng. I am running
this on a 64 bit Ubuntu14.04 x86_64 VM. I am following the steps as
provided @
https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system

The application is a simple application with tracef tracing. The
application can be found at
https://gist.github.com/vjanandr/ea1a60350c0a96ef44bc8417a903de49

I first installed the dependent 32 bit packages, namely: urcu
sudo apt-get install libxml2-dev
sudo apt-get install libpopt-dev:i386

I was able to install the 32 bit UST libraries.

I then tried building 32 bit consumerd and was able to build it
successfully.

lttng64_32@lttng6432-vm:/usr/lib32$ ls liblttng-ust-ctl.so
liblttng-ust-ctl.so

again installed 64 bit popt dependent libraries.

sudo apt-get install libpopt-dev
make clean

and
./configure --prefix=/usr --with-consumerd32-libdir=/usr/lib32
--with-consumerd32-bin=/usr/lib32/lttng/libexec/lttng-consumerd
--with-lttng-ust-prefix=/usr/lib32 LDFLAGS="-L/usr/lib32
-L/usr/lib/i386-linux-gnu"

gave me an error.

checking for ustctl_recv_channel_from_consumer in -llttng-ust-ctl... no
configure: error: Cannot find LTTng-UST >= 2.2.x. Use
--with-lttng-ust-prefix=PREFIX to specify its location, or specify
--disable-lttng-ust to build lttng-tools without LTTng-UST support.

Further more when I looked at the config.log file I see below...


configure:6320: result: no
configure:6367: checking for ustctl_recv_channel_from_consumer in
-llttng-ust-ctl
configure:6393: gcc -o conftest -g -O2  -I/usr/lib32/include -L/usr/lib32
-L/usr/lib/i386-linux-gnu -L/usr/lib32/lib64 -L/usr/lib32/lib conftest.c
-llttng-ust-ctl -lurcu-common -lurcu-bp -lurcu-cds -lrt -ldl
     -lpopt -lpthread  >&5
/usr/bin/ld: skipping incompatible /usr/lib32/liblttng-ust-ctl.so when
searching for -llttng-ust-ctl
/usr/bin/ld: skipping incompatible /usr/lib32/liblttng-ust-ctl.a when
searching for -llttng-ust-ctl
/usr/bin/ld: cannot find -llttng-ust-ctl
/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-common.so when
searching for -lurcu-common
/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-common.a when
searching for -lurcu-common
/usr/bin/ld: cannot find -lurcu-common
/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-bp.so when
searching for -lurcu-bp
/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-bp.a when
searching for -lurcu-bp
/usr/bin/ld: cannot find -lurcu-bp
/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-cds.so when
searching for -lurcu-cds
/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-cds.a when
searching for -lurcu-cds
/usr/bin/ld: cannot find -lurcu-cds

The complete config.log file is available @
https://gist.github.com/vjanandr/a38bef9d5b8ff7089e12da844ffbd4bc.

could anyone please let me know if I have to build a 64 bit UST library as
well  and then link the 32 bit UST library with the application using
LD_PRELOAD ? or build the rest of the tools binaries ignoring UST support.

Regards,
Vijay

--089e0122f05493a024052fb7ce4c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D""><div class=3D"gmai=
l_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">=
Hi,</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#000=
0ff" face=3D"verdana, sans-serif"><br></font></div><div class=3D"gmail_defa=
ult" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">I am t=
rying to instrument a 32 bit application with lttng. I am running this on a=
 64 bit Ubuntu14.04 x86_64 VM. I am following the steps as provided @ <a hr=
ef=3D"https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system=
">https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system</a>=
=C2=A0</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#=
0000ff" face=3D"verdana, sans-serif"><br></font></div><div class=3D"gmail_d=
efault" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">The=
 application is a simple application with tracef tracing. The application c=
an be found at <a href=3D"https://gist.github.com/vjanandr/ea1a60350c0a96ef=
44bc8417a903de49">https://gist.github.com/vjanandr/ea1a60350c0a96ef44bc8417=
a903de49</a></font></div><div class=3D"gmail_default" style=3D""><font colo=
r=3D"#0000ff" face=3D"verdana, sans-serif"><br></font></div><div class=3D"g=
mail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-seri=
f">I first installed the dependent 32 bit packages, namely: urcu</font></di=
v><div class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"v=
erdana, sans-serif">sudo apt-get install libxml2-dev</font></div><div class=
=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans=
-serif">sudo apt-get install libpopt-dev:i386</font></div><div class=3D"gma=
il_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif"=
><br></font></div><div class=3D"gmail_default" style=3D""><font color=3D"#0=
000ff" face=3D"verdana, sans-serif">I was able to install the 32 bit UST li=
braries.</font></div><div class=3D"gmail_default" style=3D""><font color=3D=
"#0000ff" face=3D"verdana, sans-serif"><br></font></div><div class=3D"gmail=
_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">I=
 then tried building 32 bit consumerd and was able to build it successfully=
.</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#0000f=
f" face=3D"verdana, sans-serif"><br></font></div><div class=3D"gmail_defaul=
t" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">lttng64_=
32@lttng6432-vm:/usr/lib32$ ls liblttng-ust-ctl.so</font></div><div class=
=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans=
-serif">liblttng-ust-ctl.so</font></div><div class=3D"gmail_default" style=
=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif"><br></font></div=
><div class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"ve=
rdana, sans-serif">again installed 64 bit popt dependent libraries.</font><=
/div><div class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=
=3D"verdana, sans-serif"><br></font></div><div class=3D"gmail_default" styl=
e=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">sudo apt-get in=
stall libpopt-dev</font></div><div class=3D"gmail_default" style=3D""><font=
 color=3D"#0000ff" face=3D"verdana, sans-serif">make clean</font></div><div=
 class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana=
, sans-serif"><br></font></div><div class=3D"gmail_default" style=3D""><fon=
t color=3D"#0000ff" face=3D"verdana, sans-serif">and=C2=A0</font></div><div=
 class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana=
, sans-serif">./configure --prefix=3D/usr --with-consumerd32-libdir=3D/usr/=
lib32 --with-consumerd32-bin=3D/usr/lib32/lttng/libexec/lttng-consumerd --w=
ith-lttng-ust-prefix=3D/usr/lib32 LDFLAGS=3D&quot;-L/usr/lib32 -L/usr/lib/i=
386-linux-gnu&quot;</font></div><div class=3D"gmail_default" style=3D""><fo=
nt color=3D"#0000ff" face=3D"verdana, sans-serif"><br></font></div><div cla=
ss=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sa=
ns-serif">gave me an error.=C2=A0</font></div><div class=3D"gmail_default" =
style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif"><br></font>=
</div><div class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=
=3D"verdana, sans-serif">checking for ustctl_recv_channel_from_consumer in =
-llttng-ust-ctl... no</font></div><div class=3D"gmail_default" style=3D""><=
font color=3D"#0000ff" face=3D"verdana, sans-serif">configure: error: Canno=
t find LTTng-UST &gt;=3D 2.2.x. Use --with-lttng-ust-prefix=3DPREFIX to spe=
cify its location, or specify --disable-lttng-ust to build lttng-tools with=
out LTTng-UST support.</font></div><div class=3D"gmail_default" style=3D"">=
<font color=3D"#0000ff" face=3D"verdana, sans-serif"><br></font></div><div =
class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana,=
 sans-serif">Further more when I looked at the config.log file I see below.=
..</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#0000=
ff" face=3D"verdana, sans-serif"><br></font></div><div class=3D"gmail_defau=
lt" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif"><br></f=
ont></div><div class=3D"gmail_default" style=3D""><font color=3D"#0000ff" f=
ace=3D"verdana, sans-serif">configure:6320: result: no</font></div><div cla=
ss=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sa=
ns-serif">configure:6367: checking for ustctl_recv_channel_from_consumer in=
 -llttng-ust-ctl</font></div><div class=3D"gmail_default" style=3D""><font =
color=3D"#0000ff" face=3D"verdana, sans-serif">configure:6393: gcc -o conft=
est -g -O2 =C2=A0-I/usr/lib32/include -L/usr/lib32 -L/usr/lib/i386-linux-gn=
u -L/usr/lib32/lib64 -L/usr/lib32/lib conftest.c -llttng-ust-ctl -lurcu-com=
mon -lurcu-bp -lurcu-cds -lrt -ldl</font></div><div class=3D"gmail_default"=
 style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">=C2=A0 =C2=
=A0 =C2=A0-lpopt -lpthread =C2=A0&gt;&amp;5</font></div><div class=3D"gmail=
_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">/=
usr/bin/ld: skipping incompatible /usr/lib32/liblttng-ust-ctl.so when searc=
hing for -llttng-ust-ctl</font></div><div class=3D"gmail_default" style=3D"=
"><font color=3D"#0000ff" face=3D"verdana, sans-serif">/usr/bin/ld: skippin=
g incompatible /usr/lib32/liblttng-ust-ctl.a when searching for -llttng-ust=
-ctl</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#00=
00ff" face=3D"verdana, sans-serif">/usr/bin/ld: cannot find -llttng-ust-ctl=
</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#0000ff=
" face=3D"verdana, sans-serif">/usr/bin/ld: skipping incompatible //usr/loc=
al/lib/liburcu-common.so when searching for -lurcu-common</font></div><div =
class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana,=
 sans-serif">/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-com=
mon.a when searching for -lurcu-common</font></div><div class=3D"gmail_defa=
ult" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">/usr/b=
in/ld: cannot find -lurcu-common</font></div><div class=3D"gmail_default" s=
tyle=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">/usr/bin/ld:=
 skipping incompatible //usr/local/lib/liburcu-bp.so when searching for -lu=
rcu-bp</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#=
0000ff" face=3D"verdana, sans-serif">/usr/bin/ld: skipping incompatible //u=
sr/local/lib/liburcu-bp.a when searching for -lurcu-bp</font></div><div cla=
ss=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sa=
ns-serif">/usr/bin/ld: cannot find -lurcu-bp</font></div><div class=3D"gmai=
l_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">=
/usr/bin/ld: skipping incompatible //usr/local/lib/liburcu-cds.so when sear=
ching for -lurcu-cds</font></div><div class=3D"gmail_default" style=3D""><f=
ont color=3D"#0000ff" face=3D"verdana, sans-serif">/usr/bin/ld: skipping in=
compatible //usr/local/lib/liburcu-cds.a when searching for -lurcu-cds</fon=
t></div><div class=3D"gmail_default" style=3D""><font color=3D"#0000ff" fac=
e=3D"verdana, sans-serif">/usr/bin/ld: cannot find -lurcu-cds</font></div><=
div class=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verd=
ana, sans-serif"><br></font></div><div class=3D"gmail_default" style=3D""><=
font color=3D"#0000ff" face=3D"verdana, sans-serif">The complete config.log=
 file is available @ <a href=3D"https://gist.github.com/vjanandr/a38bef9d5b=
8ff7089e12da844ffbd4bc">https://gist.github.com/vjanandr/a38bef9d5b8ff7089e=
12da844ffbd4bc</a>.</font></div><div class=3D"gmail_default" style=3D""><fo=
nt color=3D"#0000ff" face=3D"verdana, sans-serif"><br></font></div><div cla=
ss=3D"gmail_default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sa=
ns-serif">could anyone please let me know if I have to build a 64 bit UST l=
ibrary as well =C2=A0a</font><span style=3D"color:rgb(0,0,255);font-family:=
verdana,sans-serif">nd then link the 32 bit UST library with the applicatio=
n using LD_PRELOAD ? or build the rest of the tools binaries ignoring UST s=
upport.</span></div><div class=3D"gmail_default" style=3D""><font color=3D"=
#0000ff" face=3D"verdana, sans-serif"><br></font></div><div class=3D"gmail_=
default" style=3D""><font color=3D"#0000ff" face=3D"verdana, sans-serif">Re=
gards,</font></div><div class=3D"gmail_default" style=3D""><font color=3D"#=
0000ff" face=3D"verdana, sans-serif">Vijay</font></div></div>
</div>

--089e0122f05493a024052fb7ce4c--

--===============7173796221432993052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7173796221432993052==--
