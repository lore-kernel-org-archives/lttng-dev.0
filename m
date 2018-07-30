From: paramesh p <params16jan@gmail.com>
Subject: Function Tracing Fails
Date: Sun, 29 Jul 2018 18:29:56 -0700
Message-ID: <CAOG=51zc2Xu2yNd-3YWhOXZiMb7_c1xYzN_ZS1x+PHP0kRz=LA__11102.9319269166$1532914086$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5363875180490729952=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x22b.google.com (mail-yb0-x22b.google.com
 [IPv6:2607:f8b0:4002:c09::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 41f27C2nKLz14pT
 for <lttng-dev@lists.lttng.org>; Sun, 29 Jul 2018 21:29:59 -0400 (EDT)
Received: by mail-yb0-x22b.google.com with SMTP id c10-v6so4140925ybf.9
 for <lttng-dev@lists.lttng.org>; Sun, 29 Jul 2018 18:29:59 -0700 (PDT)
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

--===============5363875180490729952==
Content-Type: multipart/alternative; boundary="000000000000359f2305722d6666"

--000000000000359f2305722d6666
Content-Type: text/plain; charset="UTF-8"

Hi,
   I am trying to use Function Tracing for my application running in 32-bit
ARM Platform. I have added below lines in my makefile for enabling Trace
Data for function tracing

AM_CFLAGS += -g -O0 -finstrument-functions
AM_CXXFLAGS += -g -O0 -finstrument-functions

**(My App have both C && CPP files, So I added CFLAGS & CXXFLAGS).

I am running below commands,
$lttng create session1
$lttng enable-event -u -a --loglevel-only TRACE_DEBUG_FUNCTION
$lttng start
$LD_PRELOAD=liblttng-ust-cyg-profile.so.0.0.0 my_test_app
$lttng start
$babeltrace /home/root/lttng-traces/session1

Its showing nothing.

I tried with below event-enable command also. There is no data
$lttng enable-event -u -a --loglevel TRACE_DEBUG_FUNCTION

But If I use the command, "lttng enable-event -u -a"  for enabling the
event, I am getting below output from babeltrace,

[22:25:30.812389281] (+?.?????????) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0xAD1A9000, sopath =
"/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size = 10004, mtime =
1532324280 }
[22:25:30.812496469] (+0.000107188) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DFF0000, sopath = "/usr/lib/xxx.so", size =
19540, mtime = 1532369202 }
[22:25:30.812604177] (+0.000107708) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4E120000, sopath = "/usr/lib/libcutils.so.0.0.0",
size = 48624, mtime = 1532323462 }
[22:25:30.812655219] (+0.000051042) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DC80000, sopath = "/lib/libpthread-2.22.so",
size = 94976, mtime = 1532322845 }
[22:25:30.812701677] (+0.000046458) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DB20000, sopath = "/lib/libc-2.22.so", size =
1304484, mtime = 1532322845 }
[22:25:30.812757927] (+0.000056250) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0xAD15B000, sopath =
"/usr/lib/liblttng-ust.so.0.0.0", size = 315248, mtime = 1532324280 }
[22:25:30.812814229] (+0.000056302) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0xAD149000, sopath =
"/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 35624, mtime =
1532324280 }
[22:25:30.812860635] (+0.000046406) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DEC0000, sopath = "/lib/librt-2.22.so", size =
28380, mtime = 1532322845 }
[22:25:30.812904438] (+0.000043803) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DCB0000, sopath = "/lib/libdl-2.22.so", size =
11236, mtime = 1532322845 }
[22:25:30.812959125] (+0.000054687) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DE10000, sopath =
"/usr/lib/liburcu-bp.so.2.0.0", size = 29052, mtime = 1532323584 }
[22:25:30.813013969] (+0.000054844) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DE00000, sopath =
"/usr/lib/liburcu-cds.so.2.0.0", size = 26152, mtime = 1532323584 }
[22:25:30.813485479] (+0.000471510) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DD60000, sopath =
"/usr/lib/liburcu-common.so.2.0.0", size = 13084, mtime = 1532323584 }
[22:25:30.813600792] (+0.000115313) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DAE0000, sopath = "/lib/ld-2.22.so", size =
139632, mtime = 1532322845 }
[22:25:30.813663656] (+0.000062864) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DFC0000, sopath = "/usr/lib/xxx.so.1.0.0", size
= 19456, mtime = 1532323510 }
[22:25:30.813720635] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4E030000, sopath = "/usr/lib/xxx.so.1.6.0", size
= 142164, mtime = 1532323441 }
[22:25:30.813776990] (+0.000056355) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4E060000, sopath = "/usr/lib/xxx.so.0.0.0", size
= 265304, mtime = 1532324468 }
[22:25:30.813843917] (+0.000066927) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DEA0000, sopath = "/usr/lib/xxx.so.0.0.0", size
= 84016, mtime = 1532324363 }
[22:25:30.813884385] (+0.000040468) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DFE0000, sopath = "/usr/lib/xxx.so", size =
34204, mtime = 1532324426 }
[22:25:30.813940479] (+0.000056094) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DFD0000, sopath = "/usr/lib/xxx.so", size =
7388, mtime = 1532324388 }
[22:25:30.813993604] (+0.000053125) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4E000000, sopath = "/usr/lib/xxx.so", size =
33152, mtime = 1532323414 }
[22:25:30.814049333] (+0.000055729) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DEE0000, sopath =
"/usr/lib/libstdc++.so.6.0.20", size = 869236, mtime = 1532323320 }
[22:25:30.814094177] (+0.000044844) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DCD0000, sopath = "/lib/libm-2.22.so", size =
441372, mtime = 1532322845 }
[22:25:30.814234177] (+0.000140000) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DE80000, sopath = "/lib/libgcc_s.so.1", size =
118608, mtime = 1532323098 }
[22:25:30.814427615] (+0.000193438) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x8000, sopath = "/usr/bin/my_test_app", size =
54540, mtime = 1532369202 }
[22:25:30.828436677] (+0.014009062) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0xAEC57000, sopath =
"/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size = 10004, mtime =
1532324280 }
[22:25:30.828634958] (+0.000198281) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 1 }, { baddr = 0x4DCD0000, sopath = "/lib/libm-2.22.so", size =
441372, mtime = 1532322845 }
[22:25:30.829786104] (+0.001151146) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0x4DB20000, sopath = "/lib/libc-2.22.so", size =
1304484, mtime = 1532322845 }
[22:25:30.829910219] (+0.000124115) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0xAEC09000, sopath =
"/usr/lib/liblttng-ust.so.0.0.0", size = 315248, mtime = 1532324280 }
[22:25:30.829996000] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0xAEBF7000, sopath =
"/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 35624, mtime =
1532324280 }
[22:25:30.830067510] (+0.000071510) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0x4DEC0000, sopath = "/lib/librt-2.22.so", size =
28380, mtime = 1532322845 }
[22:25:30.830118031] (+0.000050521) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0x4DCB0000, sopath = "/lib/libdl-2.22.so", size =
11236, mtime = 1532322845 }
[22:25:30.830175010] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0x4DE10000, sopath =
"/usr/lib/liburcu-bp.so.2.0.0", size = 29052, mtime = 1532323584 }
[22:25:30.830245271] (+0.000070261) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0x4DE00000, sopath =
"/usr/lib/liburcu-cds.so.2.0.0", size = 26152, mtime = 1532323584 }
[22:25:30.830316521] (+0.000071250) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 0 }, { baddr = 0x4DD60000, sopath =
"/usr/lib/liburcu-common.so.2.0.0", size = 13084, mtime = 1532323584 }
[22:25:34.384458499] (+3.554141978) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0xAF584000, sopath =
"/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size = 10004, mtime =
1532324280 }
[22:25:34.385048967] (+0.000590468) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0x4DCD0000, sopath = "/lib/libm-2.22.so", size =
441372, mtime = 1532322845 }
[22:25:34.385146415] (+0.000097448) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0x4DB20000, sopath = "/lib/libc-2.22.so", size =
1304484, mtime = 1532322845 }
[22:25:34.385251832] (+0.000105417) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0xAF536000, sopath =
"/usr/lib/liblttng-ust.so.0.0.0", size = 315248, mtime = 1532324280 }
[22:25:34.385354228] (+0.000102396) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0xAF524000, sopath =
"/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 35624, mtime =
1532324280 }
[22:25:34.385444384] (+0.000090156) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0x4DEC0000, sopath = "/lib/librt-2.22.so", size =
28380, mtime = 1532322845 }
[22:25:34.385530165] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0x4DCB0000, sopath = "/lib/libdl-2.22.so", size =
11236, mtime = 1532322845 }
[22:25:34.385607613] (+0.000077448) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0x4DE10000, sopath =
"/usr/lib/liburcu-bp.so.2.0.0", size = 29052, mtime = 1532323584 }
[22:25:34.385677978] (+0.000070365) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0x4DE00000, sopath =
"/usr/lib/liburcu-cds.so.2.0.0", size = 26152, mtime = 1532323584 }
[22:25:34.385773655] (+0.000095677) ZZZ ust_baddr_statedump:soinfo: {
cpu_id = 2 }, { baddr = 0x4DD60000, sopath =
"/usr/lib/liburcu-common.so.2.0.0", size = 13084, mtime = 1532323584 }

Note: I have changed the Target Name as 'ZZZ' and some of the library name
as 'xxx' in the above log for some confidential issues.


Please guide me where I am making mistake and Please give your input on how
to check the application compiled with function instrument information for
tracing. I verified that application compiled with debugging information,
by running gdb command. Below is the output of gdb command,

/usr/bin # gdb my_test_app
GNU gdb (GDB) 7.9.1
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html
>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-oe-linux-gnueabi".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from my_test_app...done.
(gdb)
(gdb) exit
I am not sure whether it is compiled with finstrumentation information.

Thanks in Advance,
Paramesh

--000000000000359f2305722d6666
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi,</div><div>=C2=A0 =C2=A0I am t=
rying to use Function Tracing for my application running in 32-bit ARM Plat=
form. I have added below lines in my makefile for enabling Trace Data for f=
unction tracing=C2=A0</div><div><br></div><div>AM_CFLAGS +=3D -g -O0 -finst=
rument-functions</div><div>AM_CXXFLAGS +=3D -g -O0 -finstrument-functions=
=C2=A0</div><div><br></div><div>**(My App have both C &amp;&amp; CPP files,=
 So I added CFLAGS &amp; CXXFLAGS).=C2=A0</div><div><br></div><div>I am run=
ning below commands,</div><div><span style=3D"white-space:pre">	</span>$ltt=
ng create session1</div><div><span style=3D"white-space:pre">	</span>$lttng=
 enable-event -u -a --loglevel-only TRACE_DEBUG_FUNCTION</div><div><span st=
yle=3D"white-space:pre">	</span>$lttng start</div><div><span style=3D"white=
-space:pre">	</span>$LD_PRELOAD=3Dliblttng-ust-cyg-profile.so.0.0.0 my_test=
_app=C2=A0</div><div><span style=3D"white-space:pre">	</span>$lttng start</=
div><div><span style=3D"white-space:pre">	</span>$babeltrace /home/root/ltt=
ng-traces/session1</div><div><br></div><div>Its showing nothing.</div><div>=
<br></div><div>I tried with below event-enable command also. There is no da=
ta</div><div><span style=3D"white-space:pre">	</span>$lttng enable-event -u=
 -a --loglevel TRACE_DEBUG_FUNCTION=C2=A0</div><div><br></div><div>But If I=
 use the command, &quot;lttng enable-event -u -a&quot;=C2=A0 for enabling t=
he event, I am getting below output from babeltrace,</div><div><br></div><d=
iv>[22:25:30.812389281] (+?.?????????) ZZZ ust_baddr_statedump:soinfo: { cp=
u_id =3D 1 }, { baddr =3D 0xAD1A9000, sopath =3D &quot;/usr/lib/liblttng-us=
t-cyg-profile.so.0.0.0&quot;, size =3D 10004, mtime =3D 1532324280 }</div><=
div>[22:25:30.812496469] (+0.000107188) ZZZ ust_baddr_statedump:soinfo: { c=
pu_id =3D 1 }, { baddr =3D 0x4DFF0000, sopath =3D &quot;/usr/lib/xxx.so&quo=
t;, size =3D 19540, mtime =3D 1532369202 }</div><div>[22:25:30.812604177] (=
+0.000107708) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D=
 0x4E120000, sopath =3D &quot;/usr/lib/libcutils.so.0.0.0&quot;, size =3D 4=
8624, mtime =3D 1532323462 }</div><div>[22:25:30.812655219] (+0.000051042) =
ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DC80000, s=
opath =3D &quot;/lib/<a href=3D"http://libpthread-2.22.so">libpthread-2.22.=
so</a>&quot;, size =3D 94976, mtime =3D 1532322845 }</div><div>[22:25:30.81=
2701677] (+0.000046458) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, {=
 baddr =3D 0x4DB20000, sopath =3D &quot;/lib/<a href=3D"http://libc-2.22.so=
">libc-2.22.so</a>&quot;, size =3D 1304484, mtime =3D 1532322845 }</div><di=
v>[22:25:30.812757927] (+0.000056250) ZZZ ust_baddr_statedump:soinfo: { cpu=
_id =3D 1 }, { baddr =3D 0xAD15B000, sopath =3D &quot;/usr/lib/liblttng-ust=
.so.0.0.0&quot;, size =3D 315248, mtime =3D 1532324280 }</div><div>[22:25:3=
0.812814229] (+0.000056302) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 =
}, { baddr =3D 0xAD149000, sopath =3D &quot;/usr/lib/liblttng-ust-tracepoin=
t.so.0.0.0&quot;, size =3D 35624, mtime =3D 1532324280 }</div><div>[22:25:3=
0.812860635] (+0.000046406) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 =
}, { baddr =3D 0x4DEC0000, sopath =3D &quot;/lib/<a href=3D"http://librt-2.=
22.so">librt-2.22.so</a>&quot;, size =3D 28380, mtime =3D 1532322845 }</div=
><div>[22:25:30.812904438] (+0.000043803) ZZZ ust_baddr_statedump:soinfo: {=
 cpu_id =3D 1 }, { baddr =3D 0x4DCB0000, sopath =3D &quot;/lib/<a href=3D"h=
ttp://libdl-2.22.so">libdl-2.22.so</a>&quot;, size =3D 11236, mtime =3D 153=
2322845 }</div><div>[22:25:30.812959125] (+0.000054687) ZZZ ust_baddr_state=
dump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DE10000, sopath =3D &quot;/us=
r/lib/liburcu-bp.so.2.0.0&quot;, size =3D 29052, mtime =3D 1532323584 }</di=
v><div>[22:25:30.813013969] (+0.000054844) ZZZ ust_baddr_statedump:soinfo: =
{ cpu_id =3D 1 }, { baddr =3D 0x4DE00000, sopath =3D &quot;/usr/lib/liburcu=
-cds.so.2.0.0&quot;, size =3D 26152, mtime =3D 1532323584 }</div><div>[22:2=
5:30.813485479] (+0.000471510) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D=
 1 }, { baddr =3D 0x4DD60000, sopath =3D &quot;/usr/lib/liburcu-common.so.2=
.0.0&quot;, size =3D 13084, mtime =3D 1532323584 }</div><div>[22:25:30.8136=
00792] (+0.000115313) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { b=
addr =3D 0x4DAE0000, sopath =3D &quot;/lib/<a href=3D"http://ld-2.22.so">ld=
-2.22.so</a>&quot;, size =3D 139632, mtime =3D 1532322845 }</div><div>[22:2=
5:30.813663656] (+0.000062864) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D=
 1 }, { baddr =3D 0x4DFC0000, sopath =3D &quot;/usr/lib/xxx.so.1.0.0&quot;,=
 size =3D 19456, mtime =3D 1532323510 }</div><div>[22:25:30.813720635] (+0.=
000056979) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x=
4E030000, sopath =3D &quot;/usr/lib/xxx.so.1.6.0&quot;, size =3D 142164, mt=
ime =3D 1532323441 }</div><div>[22:25:30.813776990] (+0.000056355) ZZZ ust_=
baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4E060000, sopath =
=3D &quot;/usr/lib/xxx.so.0.0.0&quot;, size =3D 265304, mtime =3D 153232446=
8 }</div><div>[22:25:30.813843917] (+0.000066927) ZZZ ust_baddr_statedump:s=
oinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DEA0000, sopath =3D &quot;/usr/lib/=
xxx.so.0.0.0&quot;, size =3D 84016, mtime =3D 1532324363 }</div><div>[22:25=
:30.813884385] (+0.000040468) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D =
1 }, { baddr =3D 0x4DFE0000, sopath =3D &quot;/usr/lib/xxx.so&quot;, size =
=3D 34204, mtime =3D 1532324426 }</div><div>[22:25:30.813940479] (+0.000056=
094) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DFD00=
00, sopath =3D &quot;/usr/lib/xxx.so&quot;, size =3D 7388, mtime =3D 153232=
4388 }</div><div>[22:25:30.813993604] (+0.000053125) ZZZ ust_baddr_statedum=
p:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4E000000, sopath =3D &quot;/usr/l=
ib/xxx.so&quot;, size =3D 33152, mtime =3D 1532323414 }</div><div>[22:25:30=
.814049333] (+0.000055729) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }=
, { baddr =3D 0x4DEE0000, sopath =3D &quot;/usr/lib/libstdc++.so.6.0.20&quo=
t;, size =3D 869236, mtime =3D 1532323320 }</div><div>[22:25:30.814094177] =
(+0.000044844) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =
=3D 0x4DCD0000, sopath =3D &quot;/lib/<a href=3D"http://libm-2.22.so">libm-=
2.22.so</a>&quot;, size =3D 441372, mtime =3D 1532322845 }</div><div>[22:25=
:30.814234177] (+0.000140000) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D =
1 }, { baddr =3D 0x4DE80000, sopath =3D &quot;/lib/libgcc_s.so.1&quot;, siz=
e =3D 118608, mtime =3D 1532323098 }</div><div>[22:25:30.814427615] (+0.000=
193438) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x800=
0, sopath =3D &quot;<span style=3D"background-color:rgb(255,255,0)">/usr/bi=
n/my_test_app</span>&quot;, size =3D 54540, mtime =3D 1532369202 }</div><di=
v>[22:25:30.828436677] (+0.014009062) ZZZ ust_baddr_statedump:soinfo: { cpu=
_id =3D 1 }, { baddr =3D 0xAEC57000, sopath =3D &quot;/usr/lib/liblttng-ust=
-cyg-profile.so.0.0.0&quot;, size =3D 10004, mtime =3D 1532324280 }</div><d=
iv>[22:25:30.828634958] (+0.000198281) ZZZ ust_baddr_statedump:soinfo: { cp=
u_id =3D 1 }, { baddr =3D 0x4DCD0000, sopath =3D &quot;/lib/<a href=3D"http=
://libm-2.22.so">libm-2.22.so</a>&quot;, size =3D 441372, mtime =3D 1532322=
845 }</div><div>[22:25:30.829786104] (+0.001151146) ZZZ ust_baddr_statedump=
:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4DB20000, sopath =3D &quot;/lib/<a=
 href=3D"http://libc-2.22.so">libc-2.22.so</a>&quot;, size =3D 1304484, mti=
me =3D 1532322845 }</div><div>[22:25:30.829910219] (+0.000124115) ZZZ ust_b=
addr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0xAEC09000, sopath =3D=
 &quot;/usr/lib/liblttng-ust.so.0.0.0&quot;, size =3D 315248, mtime =3D 153=
2324280 }</div><div>[22:25:30.829996000] (+0.000085781) ZZZ ust_baddr_state=
dump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0xAEBF7000, sopath =3D &quot;/us=
r/lib/liblttng-ust-tracepoint.so.0.0.0&quot;, size =3D 35624, mtime =3D 153=
2324280 }</div><div>[22:25:30.830067510] (+0.000071510) ZZZ ust_baddr_state=
dump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4DEC0000, sopath =3D &quot;/li=
b/<a href=3D"http://librt-2.22.so">librt-2.22.so</a>&quot;, size =3D 28380,=
 mtime =3D 1532322845 }</div><div>[22:25:30.830118031] (+0.000050521) ZZZ u=
st_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4DCB0000, sopath=
 =3D &quot;/lib/<a href=3D"http://libdl-2.22.so">libdl-2.22.so</a>&quot;, s=
ize =3D 11236, mtime =3D 1532322845 }</div><div>[22:25:30.830175010] (+0.00=
0056979) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4D=
E10000, sopath =3D &quot;/usr/lib/liburcu-bp.so.2.0.0&quot;, size =3D 29052=
, mtime =3D 1532323584 }</div><div>[22:25:30.830245271] (+0.000070261) ZZZ =
ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4DE00000, sopat=
h =3D &quot;/usr/lib/liburcu-cds.so.2.0.0&quot;, size =3D 26152, mtime =3D =
1532323584 }</div><div>[22:25:30.830316521] (+0.000071250) ZZZ ust_baddr_st=
atedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4DD60000, sopath =3D &quot;=
/usr/lib/liburcu-common.so.2.0.0&quot;, size =3D 13084, mtime =3D 153232358=
4 }</div><div>[22:25:34.384458499] (+3.554141978) ZZZ ust_baddr_statedump:s=
oinfo: { cpu_id =3D 2 }, { baddr =3D 0xAF584000, sopath =3D &quot;/usr/lib/=
liblttng-ust-cyg-profile.so.0.0.0&quot;, size =3D 10004, mtime =3D 15323242=
80 }</div><div>[22:25:34.385048967] (+0.000590468) ZZZ ust_baddr_statedump:=
soinfo: { cpu_id =3D 2 }, { baddr =3D 0x4DCD0000, sopath =3D &quot;/lib/<a =
href=3D"http://libm-2.22.so">libm-2.22.so</a>&quot;, size =3D 441372, mtime=
 =3D 1532322845 }</div><div>[22:25:34.385146415] (+0.000097448) ZZZ ust_bad=
dr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x4DB20000, sopath =3D &=
quot;/lib/<a href=3D"http://libc-2.22.so">libc-2.22.so</a>&quot;, size =3D =
1304484, mtime =3D 1532322845 }</div><div>[22:25:34.385251832] (+0.00010541=
7) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0xAF536000=
, sopath =3D &quot;/usr/lib/liblttng-ust.so.0.0.0&quot;, size =3D 315248, m=
time =3D 1532324280 }</div><div>[22:25:34.385354228] (+0.000102396) ZZZ ust=
_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0xAF524000, sopath =
=3D &quot;/usr/lib/liblttng-ust-tracepoint.so.0.0.0&quot;, size =3D 35624, =
mtime =3D 1532324280 }</div><div>[22:25:34.385444384] (+0.000090156) ZZZ us=
t_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x4DEC0000, sopath =
=3D &quot;/lib/<a href=3D"http://librt-2.22.so">librt-2.22.so</a>&quot;, si=
ze =3D 28380, mtime =3D 1532322845 }</div><div>[22:25:34.385530165] (+0.000=
085781) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x4DC=
B0000, sopath =3D &quot;/lib/<a href=3D"http://libdl-2.22.so">libdl-2.22.so=
</a>&quot;, size =3D 11236, mtime =3D 1532322845 }</div><div>[22:25:34.3856=
07613] (+0.000077448) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { b=
addr =3D 0x4DE10000, sopath =3D &quot;/usr/lib/liburcu-bp.so.2.0.0&quot;, s=
ize =3D 29052, mtime =3D 1532323584 }</div><div>[22:25:34.385677978] (+0.00=
0070365) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x4D=
E00000, sopath =3D &quot;/usr/lib/liburcu-cds.so.2.0.0&quot;, size =3D 2615=
2, mtime =3D 1532323584 }</div><div>[22:25:34.385773655] (+0.000095677) ZZZ=
 ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x4DD60000, sopa=
th =3D &quot;/usr/lib/liburcu-common.so.2.0.0&quot;, size =3D 13084, mtime =
=3D 1532323584 }</div><div><br></div><div>Note: I have changed the Target N=
ame as &#39;ZZZ&#39; and some of the library name as &#39;xxx&#39; in the a=
bove log for some confidential issues.</div><div><br></div><div><br></div><=
div>Please guide me where I am making mistake and Please give your input on=
 how to check the application compiled with function instrument information=
 for tracing. I verified that application compiled with debugging informati=
on, by running gdb command. Below is the output of gdb command,</div><div><=
br></div><div><span style=3D"white-space:pre">	</span>/usr/bin # gdb <span =
style=3D"background-color:rgb(255,255,0)">my_test_app</span></div><div><spa=
n style=3D"white-space:pre">	</span>GNU gdb (GDB) 7.9.1</div><div><span sty=
le=3D"white-space:pre">	</span>Copyright (C) 2015 Free Software Foundation,=
 Inc.</div><div><span style=3D"white-space:pre">	</span>License GPLv3+: GNU=
 GPL version 3 or later &lt;<a href=3D"http://gnu.org/licenses/gpl.html">ht=
tp://gnu.org/licenses/gpl.html</a>&gt;</div><div><span style=3D"white-space=
:pre">	</span>This is free software: you are free to change and redistribut=
e it.</div><div><span style=3D"white-space:pre">	</span>There is NO WARRANT=
Y, to the extent permitted by law.=C2=A0 Type &quot;show copying&quot;</div=
><div><span style=3D"white-space:pre">	</span>and &quot;show warranty&quot;=
 for details.</div><div><span style=3D"white-space:pre">	</span>This GDB wa=
s configured as &quot;arm-oe-linux-gnueabi&quot;.</div><div><span style=3D"=
white-space:pre">	</span>Type &quot;show configuration&quot; for configurat=
ion details.</div><div><span style=3D"white-space:pre">	</span>For bug repo=
rting instructions, please see:</div><div><span style=3D"white-space:pre">	=
</span>&lt;<a href=3D"http://www.gnu.org/software/gdb/bugs/">http://www.gnu=
.org/software/gdb/bugs/</a>&gt;.</div><div><span style=3D"white-space:pre">=
	</span>Find the GDB manual and other documentation resources online at:</d=
iv><div><span style=3D"white-space:pre">	</span>&lt;<a href=3D"http://www.g=
nu.org/software/gdb/documentation/">http://www.gnu.org/software/gdb/documen=
tation/</a>&gt;.</div><div><span style=3D"white-space:pre">	</span>For help=
, type &quot;help&quot;.</div><div><span style=3D"white-space:pre">	</span>=
Type &quot;apropos word&quot; to search for commands related to &quot;word&=
quot;...</div><div><span style=3D"white-space:pre">	</span>Reading symbols =
from <span style=3D"background-color:rgb(255,255,0)">my_test_app</span>...d=
one.</div><div><span style=3D"white-space:pre">	</span>(gdb)</div><div><spa=
n style=3D"white-space:pre">	</span>(gdb) exit</div><div><span style=3D"whi=
te-space:pre">	</span></div><div>I am not sure whether it is compiled with =
finstrumentation information.</div><div><br></div><div>Thanks in Advance,</=
div><div>Paramesh=C2=A0</div><div><br></div><div><br></div></div></div></di=
v></div></div>

--000000000000359f2305722d6666--

--===============5363875180490729952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5363875180490729952==--
