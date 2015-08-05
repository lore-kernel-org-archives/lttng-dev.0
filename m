From: Joe VanAndel <vanandel@ucar.edu>
Subject: Re: custom probe for loadable device driver - no output?
Date: Wed, 5 Aug 2015 13:13:05 -0600
Message-ID: <CAJrJ9eEVKUDm+BpZ7nm8J-qjsvA=DXWoALjqne7vRUE-ZaXziQ__7234.76217031038$1438802065$gmane$org@mail.gmail.com>
References: <CAJrJ9eH0F=AiiwjmC5QacBomDMUF_jTjeuoauyavFQUpiTQkVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0509049322=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <vanandel@ucar.edu>) id 1ZN48C-0007R7-Dv
 for lttng-dev@lists.lttng.org; Wed, 05 Aug 2015 15:13:41 -0400
Received: by obbfr1 with SMTP id fr1so2492614obb.1
 for <lttng-dev@lists.lttng.org>; Wed, 05 Aug 2015 12:13:35 -0700 (PDT)
In-Reply-To: <CAJrJ9eH0F=AiiwjmC5QacBomDMUF_jTjeuoauyavFQUpiTQkVg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0509049322==
Content-Type: multipart/alternative; boundary=089e0112cd4afea54f051c953281

--089e0112cd4afea54f051c953281
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sorry, I=E2=80=99m answering my own question:

When I built a new kernel with =E2=80=9CCONFIG_MODULE_SIG=E2=80=9D disabled=
, the probes in
my loadable driver started working.

It would be helpful to have this documented in the tutorial on kernel
tracing.

On Tue, Aug 4, 2015 at 3:46 PM, Joe VanAndel <vanandel@ucar.edu> wrote:

> I=E2=80=99m trying to add LTTng probes to a driver module, but I don=E2=
=80=99t get any
> output from my probe in the LTTng session.
>
>
> Any idea what else I need to configure to get the output from my probe?
>
>
> Kernel: 3.10.0
>
> OS:  Centos 7.1.1503
>
> LTTng tools : from EfficiOS-RHEL7-x86-64 repository
>
> lttng-modules:  2.6.2
>
>
> The running kernel has the following enabled:
>
> CONFIG_MODULES
>
> CONFIG_KALLSYMS
>
> CONFIG_HIGH_RES_TIMERS
>
> CONFIG_TRACEPOINTS
>
>
> I=E2=80=99ve defined/used tracepoints in my driver with the mainline TRAC=
E_EVENT()
> macros.  My tracepoints are on the open/close entry points of the device.
>
>
> I=E2=80=99ve added the LTTng adaptation layer for my probe in LTTng-modul=
es.
>
>
> I=E2=80=99ve started the daemon to load my custom probe
>
>  lttng-sessiond -d --extra-kmod-probes=3Ddb2k
>
>
> I=E2=80=99ve verified that my event is available, by running
>
>
> lttng list --kernel | grep db2k
>
>       db2k_hello (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>
>
> There=E2=80=99s an entry for my probe in
>
> /sys/kernel/debug/tracing/events/db2k/db2k_hello
>
>
> When I run the following as root:
>
> lttng create trace_db2k
>
> lttng enable-event --kernel --tracepoint db2k_hello --tracepoint
> kmem_kmalloc --tracepoint kmem_kfree \
>
>      --tracepoint timer_start --tracepoint timer_cancel
>
> lttng start
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
> the output is:
>
> Session trace_db2k created.
>
> Traces will be written in /root/lttng-traces/trace_db2k-20150804-193318
>
> Kernel event db2k_hello created in channel channel0
>
> Tracing started for session trace_db2k
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  I run a test program that uses the driver, and then stop the session.
>
> # lttng stop
>
> Waiting for data availability.
>
> Tracing stopped for session trace_db2k
>
> # lttng view
>
> Trace directory: /root/lttng-traces/trace_db2k-20150804-193318
>
> <No output>
>
>
> Here is the =E2=80=9Cmainline=E2=80=9D db2k.h
>
> http://pastebin.com/0i8eWF1a
>
>
> Here is the
>
> LTTng adaptation db2k.h
>
> http://pastebin.com/fXW9ppqM
>
>
> Here is the
>
> lttng-probe-db2k.c
>
> http://pastebin.com/WHuWKpPZ
>
>
> The drive contains the lines:
>
> #define CREATE_TRACE_POINTS
>
> #include "trace/events/db2k.h"
>
> static int
> db2k_open(struct inode *inode, struct file *file)
> {
>     int minor =3D MINOR(inode->i_rdev);
>     int stat =3D 0;
>     DEVICE_EXTENSION *pde =3D NULL;
>     dbg("db2k_open called");
>     trace_db2k_hello(minor, "open");
> .
> .
> }
>
> --
> Joe VanAndel
> NCAR/EOL
>



--=20
Joe VanAndel
NCAR/EOL

--089e0112cd4afea54f051c953281
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, I=E2=80=99m answering my own question:<br><br>When =
I built a new kernel with =E2=80=9CCONFIG_MODULE_SIG=E2=80=9D disabled, the=
 probes in my loadable driver started working.<br><div><br></div><div>It wo=
uld be helpful to have this documented in the tutorial on kernel tracing.</=
div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue,=
 Aug 4, 2015 at 3:46 PM, Joe VanAndel <span dir=3D"ltr">&lt;<a href=3D"mail=
to:vanandel@ucar.edu" target=3D"_blank">vanandel@ucar.edu</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><p style=3D"margin:=
0px;font-size:12px;font-family:Helvetica">I=E2=80=99m trying to add LTTng p=
robes to a driver module, but I don=E2=80=99t get any output from my probe =
in the LTTng session.</p><p style=3D"margin:0px;font-size:12px;font-family:=
Helvetica"><br></p><p style=3D"margin:0px;font-size:12px;font-family:Helvet=
ica">Any idea what else I need to configure to get the output from my probe=
?</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Kernel: 3.10.0=
</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">OS:=C2=A0 Cent=
os 7.1.1503</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">LTTng tools : =
from EfficiOS-RHEL7-x86-64 repository</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">lttng-modules:=
=C2=A0 2.6.2</p><p style=3D"margin:0px;font-size:12px;font-family:Helvetica=
"><br></p><p style=3D"margin:0px;font-size:12px;font-family:Helvetica">The =
running kernel has the following enabled:</p><p style=3D"margin:0px;font-si=
ze:12px;font-family:Helvetica">CONFIG_MODULES</p><p style=3D"margin:0px;fon=
t-size:12px;font-family:Helvetica">CONFIG_KALLSYMS</p><p style=3D"margin:0p=
x;font-size:12px;font-family:Helvetica">CONFIG_HIGH_RES_TIMERS</p><p style=
=3D"margin:0px;font-size:12px;font-family:Helvetica">CONFIG_TRACEPOINTS</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">I=E2=80=99ve d=
efined/used tracepoints in my driver with the mainline TRACE_EVENT() macros=
.=C2=A0 My tracepoints are on the open/close entry points of the device.</p=
>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">I=E2=80=99ve a=
dded the LTTng adaptation layer for my probe in LTTng-modules.=C2=A0</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">I=E2=80=99ve s=
tarted the daemon to load my custom probe</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">=C2=A0lttng-se=
ssiond -d --extra-kmod-probes=3Ddb2k</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">I=E2=80=99ve v=
erified that my event is available, by running</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">lttng list --k=
ernel | grep db2k</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">=C2=A0 =C2=A0 =
=C2=A0 db2k_hello (loglevel: TRACE_EMERG (0)) (type: tracepoint)</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">There=E2=80=99=
s an entry for my probe in=C2=A0</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">/sys/kernel/de=
bug/tracing/events/db2k/db2k_hello</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">When I run the=
 following as root:</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">lttng create t=
race_db2k</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">lttng enable-e=
vent --kernel --tracepoint db2k_hello --tracepoint kmem_kmalloc --tracepoin=
t kmem_kfree \</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">=C2=A0=C2=A0 =
=C2=A0 --tracepoint timer_start --tracepoint timer_cancel</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">lttng start</p=
>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">the output is:=
</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Session trace_=
db2k created.</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Traces will be=
 written in /root/lttng-traces/trace_db2k-20150804-193318</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Kernel event d=
b2k_hello created in channel channel0</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Tracing starte=
d for session trace_db2k</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">=C2=A0I run a =
test program that uses the driver, and then stop the session.</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica"># lttng stop</=
p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Waiting for da=
ta availability.</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Tracing stoppe=
d for session trace_db2k</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica"># lttng view</=
p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Trace director=
y: /root/lttng-traces/trace_db2k-20150804-193318</p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica">&lt;No output&=
gt;</p><p style=3D"margin:0px;font-size:12px;font-family:Helvetica"><br></p=
><p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Here is the =
=E2=80=9Cmainline=E2=80=9D db2k.h</p><p style=3D"margin:0px;font-size:12px;=
font-family:Helvetica"><a href=3D"http://pastebin.com/0i8eWF1a" target=3D"_=
blank">http://pastebin.com/0i8eWF1a</a><br></p><p style=3D"margin:0px;font-=
size:12px;font-family:Helvetica"><br></p><p style=3D"margin:0px;font-size:1=
2px;font-family:Helvetica">Here is the=C2=A0</p><p style=3D"margin:0px;font=
-family:Helvetica"><span style=3D"color:rgb(51,51,51);font-family:&#39;sego=
e ui&#39;,&#39;trebuchet MS&#39;,&#39;Lucida Sans Unicode&#39;,&#39;Lucida =
Sans&#39;,sans-serif;line-height:18px">LTTng adaptation db2k.h</span><br></=
p><p style=3D"margin:0px;font-size:12px;font-family:Helvetica"><a href=3D"h=
ttp://pastebin.com/fXW9ppqM" target=3D"_blank">http://pastebin.com/fXW9ppqM=
</a><span style=3D"color:rgb(51,51,51);font-family:&#39;segoe ui&#39;,&#39;=
trebuchet MS&#39;,&#39;Lucida Sans Unicode&#39;,&#39;Lucida Sans&#39;,sans-=
serif;font-size:15.3600006103516px;font-weight:bold;line-height:18px"><br><=
/span></p><p style=3D"margin:0px;font-size:12px;font-family:Helvetica"><br>=
</p><p style=3D"margin:0px;font-size:12px;font-family:Helvetica">Here is th=
e=C2=A0</p><p style=3D"margin:0px;font-size:12px;font-family:Helvetica">ltt=
ng-probe-db2k.c</p><p style=3D"margin:0px;font-size:12px;font-family:Helvet=
ica"><a href=3D"http://pastebin.com/WHuWKpPZ" target=3D"_blank">http://past=
ebin.com/WHuWKpPZ</a><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
"><br></p>
<p style=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px=
">The drive contains the lines:</p><p style=3D"margin:0px;font-size:12px;fo=
nt-family:Helvetica;min-height:14px">#define CREATE_TRACE_POINTS</p><p styl=
e=3D"margin:0px;font-size:12px;font-family:Helvetica;min-height:14px">#incl=
ude &quot;trace/events/db2k.h&quot;</p><div><br></div><div><div>static int<=
/div><div>db2k_open(struct inode *inode, struct file *file)</div><div>{</di=
v><div>=C2=A0 =C2=A0 int minor =3D MINOR(inode-&gt;i_rdev);</div><div>=C2=
=A0 =C2=A0 int stat =3D 0;</div><div>=C2=A0 =C2=A0 DEVICE_EXTENSION *pde =
=3D NULL;</div><div>=C2=A0 =C2=A0 dbg(&quot;db2k_open called&quot;);</div><=
div>=C2=A0 =C2=A0 trace_db2k_hello(minor, &quot;open&quot;);</div></div><di=
v>.</div><div>.</div><div>}</div><span class=3D"HOEnZb"><font color=3D"#888=
888"><div><br></div>-- <br><div><div dir=3D"ltr">Joe VanAndel<div>NCAR/EOL<=
/div></div></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr">Joe VanAndel<div>NCAR/EOL</div></div>=
</div>
</div>

--089e0112cd4afea54f051c953281--


--===============0509049322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0509049322==--
