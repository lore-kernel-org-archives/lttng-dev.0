From: bhanu kiran chaluvadi <nthdimensionalreality@gmail.com>
Subject: lttng-tools - 2.11 failed: checking for _cds_lfht_new
 in -lurcu-cds... no configure: error: Userspace RCU (liburcu) >= 0.9.0 is
 needed
Date: Mon, 13 Jan 2020 23:47:35 +0100
Message-ID: <CAJYn_wgCq43GDRmiaZHrT5vvax6-nD=aWpuxiKXLSZEA4H_TZw__15580.2334354789$1578955698$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7168508974529865510=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by lists.lttng.org (Postfix) with ESMTPS id 47xTJ46dTMz1hh4
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jan 2020 17:47:48 -0500 (EST)
Received: by mail-wm1-x342.google.com with SMTP id d139so923455wmd.0
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jan 2020 14:47:48 -0800 (PST)
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

--===============7168508974529865510==
Content-Type: multipart/alternative; boundary="000000000000a6a134059c0d43a7"

--000000000000a6a134059c0d43a7
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to cross compile lttng-tools to host: i686-pc-linux-gnu(dedian
8 - jessie )  from build: x86_64-pc-linux-gnu (ubuntu - 18.04).


export PATH=/opt/x-tools/bin:$PATH
export SYSROOT=/opt/x-tools/i686-pc-linux-gnu/sysroot

export PKG_CONFIG_PATH=${SYSROOT}/usr/local/lib/pkgconfig
export ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes
export HOST=i686-pc-linux-gnu

export CPPFLAGS="-I$SYSROOT/usr/local/include"
export LDFLAGS="-L$SYSROOT/usr/local/lib -Wl,-rpath-link=$SYSROOT/usr/local
/lib"

$ wget http://lttng.org/files/lttng-tools/lttng-tools-latest-2.11.tar.bz2
&&
tar -xf lttng-tools-latest-2.11.tar.bz2 &&
cd lttng-tools-2.11.* &&
./configure --prefix=/opt/x-tools/i686-pc-linux-gnu/sysroot/usr/local
--host= i686-pc-linux-gnu

Terminal Print:
checking whether cds_list_add is declared... yes
checking whether cds_wfcq_init is declared... yes
checking whether cds_wfcq_dequeue_blocking is declared... yes
checking whether futex_async is declared... yes
checking whether rcu_thread_offline is declared... yes
checking whether rcu_thread_online is declared... yes
checking whether caa_likely is declared... yes
checking for _cds_lfht_new in -lurcu-cds... no
configure: error: Userspace RCU (liburcu) >= 0.9.0 is needed
make: *** No targets specified and no makefile found.  Stop.
make: *** No rule to make target 'install'.  Stop.

$ cd $SYSROOT/usr/local/lib
$ ll | grep urcu-cds
-rw-r--r-- 1 ach ach  178748 Jan 13 22:31 liburcu-cds.a
-rwxr-xr-x 1 ach ach    1380 Jan 13 22:31 liburcu-cds.la*
lrwxrwxrwx 1 ach ach      20 Jan 13 22:31 liburcu-cds.so ->
liburcu-cds.so.6.1.0*
lrwxrwxrwx 1 ach ach      20 Jan 13 22:31 liburcu-cds.so.6 ->
liburcu-cds.so.6.1.0*
-rwxr-xr-x 1 ach ach  162240 Jan 13 22:31 liburcu-cds.so.6.1.0*

$ objdump -TC liburcu-cds.so | grep _cds_lfht_new
000046f0 g    DF .text 000004c7  Base        _cds_lfht_new


liburcu is present in "$SYSROOT/usr/local/lib" and the liburcu-cds.so
has "_cds_lfht_new" not sure why this is failing.





-- 
Bhanu Kiran . Chaluvadi ,
Mechanical Engineering ,
National Institute of Technology,Warangal,
India

--000000000000a6a134059c0d43a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am trying to cross compile lttng-=
tools to host: i686-pc-linux-gnu(dedian 8 - jessie )=C2=A0 from build:=C2=
=A0x86_64-pc-linux-gnu (ubuntu - 18.04).</div><div><br></div><div><br></div=
><div><div style=3D"background-color:rgb(30,30,30);font-family:&quot;Droid =
Sans Mono&quot;,monospace,monospace,&quot;Droid Sans Fallback&quot;;font-si=
ze:14px;line-height:19px;white-space:pre"><div style=3D"color:rgb(212,212,2=
12)"><span style=3D"color:rgb(86,156,214)">export</span> PATH=3D/opt/x-tool=
s/bin:<span style=3D"color:rgb(156,220,254)">$PATH</span></div><div style=
=3D"color:rgb(212,212,212)"><span style=3D"color:rgb(86,156,214)">export</s=
pan> SYSROOT=3D/opt/x-tools/i686-pc-linux-gnu/sysroot</div><font color=3D"#=
d4d4d4"><br></font><div style=3D"color:rgb(212,212,212)"><span style=3D"col=
or:rgb(86,156,214)">export</span> PKG_CONFIG_PATH=3D<span style=3D"color:rg=
b(156,220,254)">${SYSROOT}</span>/usr/local/lib/pkgconfig</div><div style=
=3D"color:rgb(212,212,212)"><span style=3D"color:rgb(86,156,214)">export</s=
pan> ac_cv_func_malloc_0_nonnull=3Dyes ac_cv_func_realloc_0_nonnull=3Dyes</=
div><div style=3D"color:rgb(212,212,212)"><span style=3D"color:rgb(86,156,2=
14)">export</span> HOST=3Di686-pc-linux-gnu</div><div style=3D"color:rgb(21=
2,212,212)"><br></div><div style=3D""><div style=3D"line-height:19px"><div =
style=3D""><span style=3D"color:rgb(86,156,214)">export</span><font color=
=3D"#d4d4d4"> CPPFLAGS=3D</font><span style=3D"color:rgb(206,145,120)">&quo=
t;-I</span><span style=3D"color:rgb(156,220,254)">$SYSROOT</span><span styl=
e=3D"color:rgb(206,145,120)">/usr/</span><font color=3D"#9cdcfe">local</fon=
t><span style=3D"color:rgb(206,145,120)">/include&quot;</span></div><div st=
yle=3D""><span style=3D"color:rgb(86,156,214)">export</span><font color=3D"=
#d4d4d4"> LDFLAGS=3D</font><span style=3D"color:rgb(206,145,120)">&quot;-L<=
/span><span style=3D"color:rgb(156,220,254)">$SYSROOT</span><span style=3D"=
color:rgb(206,145,120)">/</span><font color=3D"#9cdcfe">usr/local</font><sp=
an style=3D"color:rgb(206,145,120)">/lib -Wl,-rpath-link=3D</span><span sty=
le=3D"color:rgb(156,220,254)">$SYSROOT</span><span style=3D"color:rgb(206,1=
45,120)">/</span><font color=3D"#9cdcfe">usr/local</font><span style=3D"col=
or:rgb(206,145,120)">/lib&quot;</span></div><div style=3D"color:rgb(212,212=
,212)"><span style=3D"color:rgb(206,145,120)"><br></span></div><div style=
=3D"color:rgb(212,212,212)"><span style=3D"color:rgb(206,145,120)">$ </span=
>wget <a href=3D"http://lttng.org/files/lttng-tools/lttng-tools-latest-2.11=
.tar.bz2">http://lttng.org/files/lttng-tools/lttng-tools-latest-2.11.tar.bz=
2</a> &amp;&amp; </div><div style=3D"color:rgb(212,212,212)">tar -xf lttng-=
tools-latest-2.11.tar.bz2 &amp;&amp;<br></div><div style=3D"color:rgb(212,2=
12,212)">cd lttng-tools-2.11.* &amp;&amp;<br></div><div style=3D"color:rgb(=
212,212,212)">./configure --prefix=3D/opt/x-tools/i686-pc-linux-gnu/sysroot=
/usr/local --host=3D i686-pc-linux-gnu<br></div><div style=3D"color:rgb(212=
,212,212)"><br></div><div style=3D"color:rgb(212,212,212)">Terminal Print:<=
/div><div style=3D"color:rgb(212,212,212)">checking whether cds_list_add is=
 declared... yes<br>checking whether cds_wfcq_init is declared... yes<br>ch=
ecking whether cds_wfcq_dequeue_blocking is declared... yes<br>checking whe=
ther futex_async is declared... yes<br>checking whether rcu_thread_offline =
is declared... yes<br>checking whether rcu_thread_online is declared... yes=
<br>checking whether caa_likely is declared... yes<br>checking for _cds_lfh=
t_new in -lurcu-cds... no<br>configure: error: Userspace RCU (liburcu) &gt;=
=3D 0.9.0 is needed<br>make: *** No targets specified and no makefile found=
.=C2=A0 Stop.<br>make: *** No rule to make target &#39;install&#39;.=C2=A0 =
Stop.<br></div></div></div></div></div><div><br></div><div><div style=3D"ba=
ckground-color:rgb(30,30,30);font-family:&quot;Droid Sans Mono&quot;,monosp=
ace,monospace,&quot;Droid Sans Fallback&quot;;font-size:14px;line-height:19=
px;white-space:pre"><div style=3D""><font color=3D"#569cd6">$ cd </font><sp=
an style=3D"color:rgb(156,220,254)">$SYSROOT</span><span style=3D"color:rgb=
(206,145,120)">/</span><font color=3D"#9cdcfe">usr/local</font><span style=
=3D"color:rgb(206,145,120)">/lib</span></div><div style=3D"color:rgb(212,21=
2,212)">$ ll | grep urcu-cds</div><div style=3D"color:rgb(212,212,212)">-rw=
-r--r-- 1 ach ach =C2=A0178748 Jan 13 22:31 liburcu-cds.a<br>-rwxr-xr-x 1 a=
ch ach =C2=A0 =C2=A01380 Jan 13 22:31 <a href=3D"http://liburcu-cds.la">lib=
urcu-cds.la</a>*<br>lrwxrwxrwx 1 ach ach =C2=A0 =C2=A0 =C2=A020 Jan 13 22:3=
1 liburcu-cds.so -&gt; liburcu-cds.so.6.1.0*<br>lrwxrwxrwx 1 ach ach =C2=A0=
 =C2=A0 =C2=A020 Jan 13 22:31 liburcu-cds.so.6 -&gt; liburcu-cds.so.6.1.0*<=
br>-rwxr-xr-x 1 ach ach =C2=A0162240 Jan 13 22:31 liburcu-cds.so.6.1.0*<br>=
</div><div style=3D"color:rgb(212,212,212)"><br></div><div style=3D"color:r=
gb(212,212,212)">$ objdump -TC liburcu-cds.so | grep _cds_lfht_new</div><di=
v style=3D"color:rgb(212,212,212)">000046f0 g =C2=A0 =C2=A0DF .text	000004c=
7 =C2=A0Base =C2=A0 =C2=A0 =C2=A0 =C2=A0_cds_lfht_new<br></div><div style=
=3D"color:rgb(212,212,212)"><br></div></div></div><div><div style=3D"color:=
rgb(212,212,212)"><br></div></div><div><pre class=3D"gmail-commands" style=
=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-variant-nu=
meric:inherit;font-variant-east-asian:inherit;font-stretch:inherit;font-siz=
e:12px;line-height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andale=
 Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot=
;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;L=
ucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&qu=
ot;,Courier,monospace;vertical-align:baseline;background-color:transparent;=
overflow-x:auto"><pre class=3D"gmail-commands" style=3D"margin-top:0px;marg=
in-bottom:0px;padding:0px;border:0px;font-variant-numeric:inherit;font-vari=
ant-east-asian:inherit;font-stretch:inherit;line-height:15px;font-family:&q=
uot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans =
Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubun=
tu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida Sans =
Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical-align:b=
aseline;background-color:transparent;overflow-x:auto"><font color=3D"rgba(0=
, 0, 0, 0.749019607843137)">liburcu is present in &quot;</font><font color=
=3D"#ce9178">$SYSROOT/usr/local/lib</font><font color=3D"rgba(0, 0, 0, 0.74=
9019607843137)">&quot; and the </font>liburcu-cds.so has &quot;_cds_lfht_ne=
w&quot; not sure why this is failing.</pre><pre class=3D"gmail-commands" st=
yle=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-variant=
-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inherit;line-=
height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,=
&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimb=
us Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Consol=
e&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,=
monospace;vertical-align:baseline;background-color:transparent;overflow-x:a=
uto"><br></pre><pre class=3D"gmail-commands" style=3D"margin-top:0px;margin=
-bottom:0px;padding:0px;border:0px;font-variant-numeric:inherit;font-varian=
t-east-asian:inherit;font-stretch:inherit;line-height:15px;font-family:&quo=
t;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mo=
no&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu=
 Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida Sans Ty=
pewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical-align:bas=
eline;background-color:transparent;overflow-x:auto"><br></pre></pre><pre cl=
ass=3D"gmail-commands" style=3D"margin-top:0px;margin-bottom:0px;padding:0p=
x;border:0px;font-variant-numeric:inherit;font-variant-east-asian:inherit;f=
ont-stretch:inherit;font-size:12px;line-height:15px;font-family:&quot;Andal=
e Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot=
;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&q=
uot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewrite=
r&quot;,&quot;Courier New&quot;,Courier,monospace;vertical-align:baseline;b=
ackground-color:transparent;overflow-x:auto;color:rgba(0,0,0,0.75)"><br></p=
re></div><div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re" data-smartmail=3D"gmail_signature">Bhanu Kiran . Chaluvadi ,<div>Mechan=
ical Engineering ,</div><div>National Institute of Technology,Warangal,</di=
v><div>India</div></div></div></div>

--000000000000a6a134059c0d43a7--

--===============7168508974529865510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7168508974529865510==--
