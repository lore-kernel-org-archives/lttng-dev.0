From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Function Tracing Fails
Date: Mon, 30 Jul 2018 08:55:14 -0400 (EDT)
Message-ID: <1051186545.6674.1532955314188.JavaMail.zimbra__13357.511527329$1532955226$gmane$org@efficios.com>
References: <CAOG=51zc2Xu2yNd-3YWhOXZiMb7_c1xYzN_ZS1x+PHP0kRz=LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4622488728516089635=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 41fKL21Nd6znLy
 for <lttng-dev@lists.lttng.org>; Mon, 30 Jul 2018 08:55:21 -0400 (EDT)
In-Reply-To: <CAOG=51zc2Xu2yNd-3YWhOXZiMb7_c1xYzN_ZS1x+PHP0kRz=LA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: paramesh p <params16jan@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4622488728516089635==
Content-Type: multipart/alternative;
	boundary="=_e69c0b6f-9bc0-4cf6-807e-279534311874"

--=_e69c0b6f-9bc0-4cf6-807e-279534311874
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 29, 2018, at 9:29 PM, paramesh p <params16jan@gmail.com> wrote: 

> Hi,
> I am trying to use Function Tracing for my application running in 32-bit ARM
> Platform. I have added below lines in my makefile for enabling Trace Data for
> function tracing

> AM_CFLAGS += -g -O0 -finstrument-functions
> AM_CXXFLAGS += -g -O0 -finstrument-functions

> **(My App have both C && CPP files, So I added CFLAGS & CXXFLAGS).

> I am running below commands,
> $lttng create session1
> $lttng enable-event -u -a --loglevel-only TRACE_DEBUG_FUNCTION
> $lttng start
> $LD_PRELOAD=liblttng-ust-cyg-profile.so.0.0.0 my_test_app
> $lttng start
> $babeltrace /home/root/lttng-traces/session1

> Its showing nothing.

> I tried with below event-enable command also. There is no data
> $lttng enable-event -u -a --loglevel TRACE_DEBUG_FUNCTION

> But If I use the command, "lttng enable-event -u -a" for enabling the event, I
> am getting below output from babeltrace,

> [22:25:30.812389281] (+?.?????????) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0xAD1A9000, sopath = "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0",
> size = 10004, mtime = 1532324280 }
> [22:25:30.812496469] (+0.000107188) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DFF0000, sopath = "/usr/lib/xxx.so", size = 19540, mtime =
> 1532369202 }
> [22:25:30.812604177] (+0.000107708) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4E120000, sopath = "/usr/lib/libcutils.so.0.0.0", size = 48624,
> mtime = 1532323462 }
> [22:25:30.812655219] (+0.000051042) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DC80000, sopath = "/lib/ [ http://libpthread-2.22.so/ |
> libpthread-2.22.so ] ", size = 94976, mtime = 1532322845 }
> [22:25:30.812701677] (+0.000046458) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DB20000, sopath = "/lib/ [ http://libc-2.22.so/ | libc-2.22.so
> ] ", size = 1304484, mtime = 1532322845 }
> [22:25:30.812757927] (+0.000056250) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0xAD15B000, sopath = "/usr/lib/liblttng-ust.so.0.0.0", size =
> 315248, mtime = 1532324280 }
> [22:25:30.812814229] (+0.000056302) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0xAD149000, sopath = "/usr/lib/liblttng-ust-tracepoint.so.0.0.0",
> size = 35624, mtime = 1532324280 }
> [22:25:30.812860635] (+0.000046406) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DEC0000, sopath = "/lib/ [ http://librt-2.22.so/ |
> librt-2.22.so ] ", size = 28380, mtime = 1532322845 }
> [22:25:30.812904438] (+0.000043803) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DCB0000, sopath = "/lib/ [ http://libdl-2.22.so/ |
> libdl-2.22.so ] ", size = 11236, mtime = 1532322845 }
> [22:25:30.812959125] (+0.000054687) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DE10000, sopath = "/usr/lib/liburcu-bp.so.2.0.0", size = 29052,
> mtime = 1532323584 }
> [22:25:30.813013969] (+0.000054844) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DE00000, sopath = "/usr/lib/liburcu-cds.so.2.0.0", size =
> 26152, mtime = 1532323584 }
> [22:25:30.813485479] (+0.000471510) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DD60000, sopath = "/usr/lib/liburcu-common.so.2.0.0", size =
> 13084, mtime = 1532323584 }
> [22:25:30.813600792] (+0.000115313) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DAE0000, sopath = "/lib/ [ http://ld-2.22.so/ | ld-2.22.so ] ",
> size = 139632, mtime = 1532322845 }
> [22:25:30.813663656] (+0.000062864) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DFC0000, sopath = "/usr/lib/xxx.so.1.0.0", size = 19456, mtime
> = 1532323510 }
> [22:25:30.813720635] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4E030000, sopath = "/usr/lib/xxx.so.1.6.0", size = 142164, mtime
> = 1532323441 }
> [22:25:30.813776990] (+0.000056355) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4E060000, sopath = "/usr/lib/xxx.so.0.0.0", size = 265304, mtime
> = 1532324468 }
> [22:25:30.813843917] (+0.000066927) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DEA0000, sopath = "/usr/lib/xxx.so.0.0.0", size = 84016, mtime
> = 1532324363 }
> [22:25:30.813884385] (+0.000040468) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DFE0000, sopath = "/usr/lib/xxx.so", size = 34204, mtime =
> 1532324426 }
> [22:25:30.813940479] (+0.000056094) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DFD0000, sopath = "/usr/lib/xxx.so", size = 7388, mtime =
> 1532324388 }
> [22:25:30.813993604] (+0.000053125) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4E000000, sopath = "/usr/lib/xxx.so", size = 33152, mtime =
> 1532323414 }
> [22:25:30.814049333] (+0.000055729) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DEE0000, sopath = "/usr/lib/libstdc++.so.6.0.20", size =
> 869236, mtime = 1532323320 }
> [22:25:30.814094177] (+0.000044844) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DCD0000, sopath = "/lib/ [ http://libm-2.22.so/ | libm-2.22.so
> ] ", size = 441372, mtime = 1532322845 }
> [22:25:30.814234177] (+0.000140000) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DE80000, sopath = "/lib/libgcc_s.so.1", size = 118608, mtime =
> 1532323098 }
> [22:25:30.814427615] (+0.000193438) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x8000, sopath = " /usr/bin/my_test_app ", size = 54540, mtime =
> 1532369202 }
> [22:25:30.828436677] (+0.014009062) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0xAEC57000, sopath = "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0",
> size = 10004, mtime = 1532324280 }
> [22:25:30.828634958] (+0.000198281) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 1
> }, { baddr = 0x4DCD0000, sopath = "/lib/ [ http://libm-2.22.so/ | libm-2.22.so
> ] ", size = 441372, mtime = 1532322845 }
> [22:25:30.829786104] (+0.001151146) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0x4DB20000, sopath = "/lib/ [ http://libc-2.22.so/ | libc-2.22.so
> ] ", size = 1304484, mtime = 1532322845 }
> [22:25:30.829910219] (+0.000124115) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0xAEC09000, sopath = "/usr/lib/liblttng-ust.so.0.0.0", size =
> 315248, mtime = 1532324280 }
> [22:25:30.829996000] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0xAEBF7000, sopath = "/usr/lib/liblttng-ust-tracepoint.so.0.0.0",
> size = 35624, mtime = 1532324280 }
> [22:25:30.830067510] (+0.000071510) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0x4DEC0000, sopath = "/lib/ [ http://librt-2.22.so/ |
> librt-2.22.so ] ", size = 28380, mtime = 1532322845 }
> [22:25:30.830118031] (+0.000050521) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0x4DCB0000, sopath = "/lib/ [ http://libdl-2.22.so/ |
> libdl-2.22.so ] ", size = 11236, mtime = 1532322845 }
> [22:25:30.830175010] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0x4DE10000, sopath = "/usr/lib/liburcu-bp.so.2.0.0", size = 29052,
> mtime = 1532323584 }
> [22:25:30.830245271] (+0.000070261) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0x4DE00000, sopath = "/usr/lib/liburcu-cds.so.2.0.0", size =
> 26152, mtime = 1532323584 }
> [22:25:30.830316521] (+0.000071250) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 0
> }, { baddr = 0x4DD60000, sopath = "/usr/lib/liburcu-common.so.2.0.0", size =
> 13084, mtime = 1532323584 }
> [22:25:34.384458499] (+3.554141978) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0xAF584000, sopath = "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0",
> size = 10004, mtime = 1532324280 }
> [22:25:34.385048967] (+0.000590468) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0x4DCD0000, sopath = "/lib/ [ http://libm-2.22.so/ | libm-2.22.so
> ] ", size = 441372, mtime = 1532322845 }
> [22:25:34.385146415] (+0.000097448) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0x4DB20000, sopath = "/lib/ [ http://libc-2.22.so/ | libc-2.22.so
> ] ", size = 1304484, mtime = 1532322845 }
> [22:25:34.385251832] (+0.000105417) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0xAF536000, sopath = "/usr/lib/liblttng-ust.so.0.0.0", size =
> 315248, mtime = 1532324280 }
> [22:25:34.385354228] (+0.000102396) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0xAF524000, sopath = "/usr/lib/liblttng-ust-tracepoint.so.0.0.0",
> size = 35624, mtime = 1532324280 }
> [22:25:34.385444384] (+0.000090156) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0x4DEC0000, sopath = "/lib/ [ http://librt-2.22.so/ |
> librt-2.22.so ] ", size = 28380, mtime = 1532322845 }
> [22:25:34.385530165] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0x4DCB0000, sopath = "/lib/ [ http://libdl-2.22.so/ |
> libdl-2.22.so ] ", size = 11236, mtime = 1532322845 }
> [22:25:34.385607613] (+0.000077448) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0x4DE10000, sopath = "/usr/lib/liburcu-bp.so.2.0.0", size = 29052,
> mtime = 1532323584 }
> [22:25:34.385677978] (+0.000070365) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0x4DE00000, sopath = "/usr/lib/liburcu-cds.so.2.0.0", size =
> 26152, mtime = 1532323584 }
> [22:25:34.385773655] (+0.000095677) ZZZ ust_baddr_statedump:soinfo: { cpu_id = 2
> }, { baddr = 0x4DD60000, sopath = "/usr/lib/liburcu-common.so.2.0.0", size =
> 13084, mtime = 1532323584 }

> Note: I have changed the Target Name as 'ZZZ' and some of the library name as
> 'xxx' in the above log for some confidential issues.

> Please guide me where I am making mistake and Please give your input on how to
> check the application compiled with function instrument information for
> tracing. I verified that application compiled with debugging information, by
> running gdb command. Below is the output of gdb command,

> /usr/bin # gdb my_test_app
> GNU gdb (GDB) 7.9.1
> Copyright (C) 2015 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later < [ http://gnu.org/licenses/gpl.html
> | http://gnu.org/licenses/gpl.html ] >
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law. Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "arm-oe-linux-gnueabi".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> < [ http://www.gnu.org/software/gdb/bugs/ |
> http://www.gnu.org/software/gdb/bugs/ ] >.
> Find the GDB manual and other documentation resources online at:
> < [ http://www.gnu.org/software/gdb/documentation/ |
> http://www.gnu.org/software/gdb/documentation/ ] >.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from my_test_app ...done.
> (gdb)
> (gdb) exit
> I am not sure whether it is compiled with finstrumentation information.

We would need the output of 

make clean 
make V=1 

when you compile your project, so we can effectively see how the compiler is invoked. 

Thanks, 

Mathieu 

> Thanks in Advance,
> Paramesh

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_e69c0b6f-9bc0-4cf6-807e-279534311874
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 29, 2018, at 9:29 PM, paramesh p &lt;params16jan@gmail.com=
&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div=
><div><div><div>Hi,</div><div>&nbsp; &nbsp;I am trying to use Function Trac=
ing for my application running in 32-bit ARM Platform. I have added below l=
ines in my makefile for enabling Trace Data for function tracing&nbsp;</div=
><br><div>AM_CFLAGS +=3D -g -O0 -finstrument-functions</div><div>AM_CXXFLAG=
S +=3D -g -O0 -finstrument-functions&nbsp;</div><br><div>**(My App have bot=
h C &amp;&amp; CPP files, So I added CFLAGS &amp; CXXFLAGS).&nbsp;</div><br=
><div>I am running below commands,</div><div>$lttng create session1</div><d=
iv>$lttng enable-event -u -a --loglevel-only TRACE_DEBUG_FUNCTION</div><div=
>$lttng start</div><div>$LD_PRELOAD=3Dliblttng-ust-cyg-profile.so.0.0.0 my_=
test_app&nbsp;</div><div>$lttng start</div><div>$babeltrace /home/root/lttn=
g-traces/session1</div><br><div>Its showing nothing.</div><br><div>I tried =
with below event-enable command also. There is no data</div><div>$lttng ena=
ble-event -u -a --loglevel TRACE_DEBUG_FUNCTION&nbsp;</div><br><div>But If =
I use the command, "lttng enable-event -u -a"&nbsp; for enabling the event,=
 I am getting below output from babeltrace,</div><br><div>[22:25:30.8123892=
81] (+?.?????????) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { badd=
r =3D 0xAD1A9000, sopath =3D "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", =
size =3D 10004, mtime =3D 1532324280 }</div><div>[22:25:30.812496469] (+0.0=
00107188) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4=
DFF0000, sopath =3D "/usr/lib/xxx.so", size =3D 19540, mtime =3D 1532369202=
 }</div><div>[22:25:30.812604177] (+0.000107708) ZZZ ust_baddr_statedump:so=
info: { cpu_id =3D 1 }, { baddr =3D 0x4E120000, sopath =3D "/usr/lib/libcut=
ils.so.0.0.0", size =3D 48624, mtime =3D 1532323462 }</div><div>[22:25:30.8=
12655219] (+0.000051042) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, =
{ baddr =3D 0x4DC80000, sopath =3D "/lib/<a href=3D"http://libpthread-2.22.=
so" target=3D"_blank">libpthread-2.22.so</a>", size =3D 94976, mtime =3D 15=
32322845 }</div><div>[22:25:30.812701677] (+0.000046458) ZZZ ust_baddr_stat=
edump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DB20000, sopath =3D "/lib/<a=
 href=3D"http://libc-2.22.so" target=3D"_blank">libc-2.22.so</a>", size =3D=
 1304484, mtime =3D 1532322845 }</div><div>[22:25:30.812757927] (+0.0000562=
50) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0xAD15B00=
0, sopath =3D "/usr/lib/liblttng-ust.so.0.0.0", size =3D 315248, mtime =3D =
1532324280 }</div><div>[22:25:30.812814229] (+0.000056302) ZZZ ust_baddr_st=
atedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0xAD149000, sopath =3D "/usr/=
lib/liblttng-ust-tracepoint.so.0.0.0", size =3D 35624, mtime =3D 1532324280=
 }</div><div>[22:25:30.812860635] (+0.000046406) ZZZ ust_baddr_statedump:so=
info: { cpu_id =3D 1 }, { baddr =3D 0x4DEC0000, sopath =3D "/lib/<a href=3D=
"http://librt-2.22.so" target=3D"_blank">librt-2.22.so</a>", size =3D 28380=
, mtime =3D 1532322845 }</div><div>[22:25:30.812904438] (+0.000043803) ZZZ =
ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DCB0000, sopat=
h =3D "/lib/<a href=3D"http://libdl-2.22.so" target=3D"_blank">libdl-2.22.s=
o</a>", size =3D 11236, mtime =3D 1532322845 }</div><div>[22:25:30.81295912=
5] (+0.000054687) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr=
 =3D 0x4DE10000, sopath =3D "/usr/lib/liburcu-bp.so.2.0.0", size =3D 29052,=
 mtime =3D 1532323584 }</div><div>[22:25:30.813013969] (+0.000054844) ZZZ u=
st_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DE00000, sopath=
 =3D "/usr/lib/liburcu-cds.so.2.0.0", size =3D 26152, mtime =3D 1532323584 =
}</div><div>[22:25:30.813485479] (+0.000471510) ZZZ ust_baddr_statedump:soi=
nfo: { cpu_id =3D 1 }, { baddr =3D 0x4DD60000, sopath =3D "/usr/lib/liburcu=
-common.so.2.0.0", size =3D 13084, mtime =3D 1532323584 }</div><div>[22:25:=
30.813600792] (+0.000115313) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1=
 }, { baddr =3D 0x4DAE0000, sopath =3D "/lib/<a href=3D"http://ld-2.22.so" =
target=3D"_blank">ld-2.22.so</a>", size =3D 139632, mtime =3D 1532322845 }<=
/div><div>[22:25:30.813663656] (+0.000062864) ZZZ ust_baddr_statedump:soinf=
o: { cpu_id =3D 1 }, { baddr =3D 0x4DFC0000, sopath =3D "/usr/lib/xxx.so.1.=
0.0", size =3D 19456, mtime =3D 1532323510 }</div><div>[22:25:30.813720635]=
 (+0.000056979) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =
=3D 0x4E030000, sopath =3D "/usr/lib/xxx.so.1.6.0", size =3D 142164, mtime =
=3D 1532323441 }</div><div>[22:25:30.813776990] (+0.000056355) ZZZ ust_badd=
r_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4E060000, sopath =3D "/=
usr/lib/xxx.so.0.0.0", size =3D 265304, mtime =3D 1532324468 }</div><div>[2=
2:25:30.813843917] (+0.000066927) ZZZ ust_baddr_statedump:soinfo: { cpu_id =
=3D 1 }, { baddr =3D 0x4DEA0000, sopath =3D "/usr/lib/xxx.so.0.0.0", size =
=3D 84016, mtime =3D 1532324363 }</div><div>[22:25:30.813884385] (+0.000040=
468) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4DFE00=
00, sopath =3D "/usr/lib/xxx.so", size =3D 34204, mtime =3D 1532324426 }</d=
iv><div>[22:25:30.813940479] (+0.000056094) ZZZ ust_baddr_statedump:soinfo:=
 { cpu_id =3D 1 }, { baddr =3D 0x4DFD0000, sopath =3D "/usr/lib/xxx.so", si=
ze =3D 7388, mtime =3D 1532324388 }</div><div>[22:25:30.813993604] (+0.0000=
53125) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D 0x4E00=
0000, sopath =3D "/usr/lib/xxx.so", size =3D 33152, mtime =3D 1532323414 }<=
/div><div>[22:25:30.814049333] (+0.000055729) ZZZ ust_baddr_statedump:soinf=
o: { cpu_id =3D 1 }, { baddr =3D 0x4DEE0000, sopath =3D "/usr/lib/libstdc++=
.so.6.0.20", size =3D 869236, mtime =3D 1532323320 }</div><div>[22:25:30.81=
4094177] (+0.000044844) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, {=
 baddr =3D 0x4DCD0000, sopath =3D "/lib/<a href=3D"http://libm-2.22.so" tar=
get=3D"_blank">libm-2.22.so</a>", size =3D 441372, mtime =3D 1532322845 }</=
div><div>[22:25:30.814234177] (+0.000140000) ZZZ ust_baddr_statedump:soinfo=
: { cpu_id =3D 1 }, { baddr =3D 0x4DE80000, sopath =3D "/lib/libgcc_s.so.1"=
, size =3D 118608, mtime =3D 1532323098 }</div><div>[22:25:30.814427615] (+=
0.000193438) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D =
0x8000, sopath =3D "<span style=3D"background-color:rgb(255,255,0)">/usr/bi=
n/my_test_app</span>", size =3D 54540, mtime =3D 1532369202 }</div><div>[22=
:25:30.828436677] (+0.014009062) ZZZ ust_baddr_statedump:soinfo: { cpu_id =
=3D 1 }, { baddr =3D 0xAEC57000, sopath =3D "/usr/lib/liblttng-ust-cyg-prof=
ile.so.0.0.0", size =3D 10004, mtime =3D 1532324280 }</div><div>[22:25:30.8=
28634958] (+0.000198281) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, =
{ baddr =3D 0x4DCD0000, sopath =3D "/lib/<a href=3D"http://libm-2.22.so" ta=
rget=3D"_blank">libm-2.22.so</a>", size =3D 441372, mtime =3D 1532322845 }<=
/div><div>[22:25:30.829786104] (+0.001151146) ZZZ ust_baddr_statedump:soinf=
o: { cpu_id =3D 0 }, { baddr =3D 0x4DB20000, sopath =3D "/lib/<a href=3D"ht=
tp://libc-2.22.so" target=3D"_blank">libc-2.22.so</a>", size =3D 1304484, m=
time =3D 1532322845 }</div><div>[22:25:30.829910219] (+0.000124115) ZZZ ust=
_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0xAEC09000, sopath =
=3D "/usr/lib/liblttng-ust.so.0.0.0", size =3D 315248, mtime =3D 1532324280=
 }</div><div>[22:25:30.829996000] (+0.000085781) ZZZ ust_baddr_statedump:so=
info: { cpu_id =3D 0 }, { baddr =3D 0xAEBF7000, sopath =3D "/usr/lib/libltt=
ng-ust-tracepoint.so.0.0.0", size =3D 35624, mtime =3D 1532324280 }</div><d=
iv>[22:25:30.830067510] (+0.000071510) ZZZ ust_baddr_statedump:soinfo: { cp=
u_id =3D 0 }, { baddr =3D 0x4DEC0000, sopath =3D "/lib/<a href=3D"http://li=
brt-2.22.so" target=3D"_blank">librt-2.22.so</a>", size =3D 28380, mtime =
=3D 1532322845 }</div><div>[22:25:30.830118031] (+0.000050521) ZZZ ust_badd=
r_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4DCB0000, sopath =3D "/=
lib/<a href=3D"http://libdl-2.22.so" target=3D"_blank">libdl-2.22.so</a>", =
size =3D 11236, mtime =3D 1532322845 }</div><div>[22:25:30.830175010] (+0.0=
00056979) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4=
DE10000, sopath =3D "/usr/lib/liburcu-bp.so.2.0.0", size =3D 29052, mtime =
=3D 1532323584 }</div><div>[22:25:30.830245271] (+0.000070261) ZZZ ust_badd=
r_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D 0x4DE00000, sopath =3D "/=
usr/lib/liburcu-cds.so.2.0.0", size =3D 26152, mtime =3D 1532323584 }</div>=
<div>[22:25:30.830316521] (+0.000071250) ZZZ ust_baddr_statedump:soinfo: { =
cpu_id =3D 0 }, { baddr =3D 0x4DD60000, sopath =3D "/usr/lib/liburcu-common=
.so.2.0.0", size =3D 13084, mtime =3D 1532323584 }</div><div>[22:25:34.3844=
58499] (+3.554141978) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { b=
addr =3D 0xAF584000, sopath =3D "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0=
", size =3D 10004, mtime =3D 1532324280 }</div><div>[22:25:34.385048967] (+=
0.000590468) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D =
0x4DCD0000, sopath =3D "/lib/<a href=3D"http://libm-2.22.so" target=3D"_bla=
nk">libm-2.22.so</a>", size =3D 441372, mtime =3D 1532322845 }</div><div>[2=
2:25:34.385146415] (+0.000097448) ZZZ ust_baddr_statedump:soinfo: { cpu_id =
=3D 2 }, { baddr =3D 0x4DB20000, sopath =3D "/lib/<a href=3D"http://libc-2.=
22.so" target=3D"_blank">libc-2.22.so</a>", size =3D 1304484, mtime =3D 153=
2322845 }</div><div>[22:25:34.385251832] (+0.000105417) ZZZ ust_baddr_state=
dump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0xAF536000, sopath =3D "/usr/lib=
/liblttng-ust.so.0.0.0", size =3D 315248, mtime =3D 1532324280 }</div><div>=
[22:25:34.385354228] (+0.000102396) ZZZ ust_baddr_statedump:soinfo: { cpu_i=
d =3D 2 }, { baddr =3D 0xAF524000, sopath =3D "/usr/lib/liblttng-ust-tracep=
oint.so.0.0.0", size =3D 35624, mtime =3D 1532324280 }</div><div>[22:25:34.=
385444384] (+0.000090156) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 },=
 { baddr =3D 0x4DEC0000, sopath =3D "/lib/<a href=3D"http://librt-2.22.so" =
target=3D"_blank">librt-2.22.so</a>", size =3D 28380, mtime =3D 1532322845 =
}</div><div>[22:25:34.385530165] (+0.000085781) ZZZ ust_baddr_statedump:soi=
nfo: { cpu_id =3D 2 }, { baddr =3D 0x4DCB0000, sopath =3D "/lib/<a href=3D"=
http://libdl-2.22.so" target=3D"_blank">libdl-2.22.so</a>", size =3D 11236,=
 mtime =3D 1532322845 }</div><div>[22:25:34.385607613] (+0.000077448) ZZZ u=
st_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x4DE10000, sopath=
 =3D "/usr/lib/liburcu-bp.so.2.0.0", size =3D 29052, mtime =3D 1532323584 }=
</div><div>[22:25:34.385677978] (+0.000070365) ZZZ ust_baddr_statedump:soin=
fo: { cpu_id =3D 2 }, { baddr =3D 0x4DE00000, sopath =3D "/usr/lib/liburcu-=
cds.so.2.0.0", size =3D 26152, mtime =3D 1532323584 }</div><div>[22:25:34.3=
85773655] (+0.000095677) ZZZ ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, =
{ baddr =3D 0x4DD60000, sopath =3D "/usr/lib/liburcu-common.so.2.0.0", size=
 =3D 13084, mtime =3D 1532323584 }</div><br><div>Note: I have changed the T=
arget Name as 'ZZZ' and some of the library name as 'xxx' in the above log =
for some confidential issues.</div><br><br><div>Please guide me where I am =
making mistake and Please give your input on how to check the application c=
ompiled with function instrument information for tracing. I verified that a=
pplication compiled with debugging information, by running gdb command. Bel=
ow is the output of gdb command,</div><br><div>/usr/bin # gdb <span style=
=3D"background-color:rgb(255,255,0)">my_test_app</span></div><div>GNU gdb (=
GDB) 7.9.1</div><div>Copyright (C) 2015 Free Software Foundation, Inc.</div=
><div>License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://gnu.=
org/licenses/gpl.html" target=3D"_blank">http://gnu.org/licenses/gpl.html</=
a>&gt;</div><div>This is free software: you are free to change and redistri=
bute it.</div><div>There is NO WARRANTY, to the extent permitted by law.&nb=
sp; Type "show copying"</div><div>and "show warranty" for details.</div><di=
v>This GDB was configured as "arm-oe-linux-gnueabi".</div><div>Type "show c=
onfiguration" for configuration details.</div><div>For bug reporting instru=
ctions, please see:</div><div>&lt;<a href=3D"http://www.gnu.org/software/gd=
b/bugs/" target=3D"_blank">http://www.gnu.org/software/gdb/bugs/</a>&gt;.</=
div><div>Find the GDB manual and other documentation resources online at:</=
div><div>&lt;<a href=3D"http://www.gnu.org/software/gdb/documentation/" tar=
get=3D"_blank">http://www.gnu.org/software/gdb/documentation/</a>&gt;.</div=
><div>For help, type "help".</div><div>Type "apropos word" to search for co=
mmands related to "word"...</div><div>Reading symbols from <span style=3D"b=
ackground-color:rgb(255,255,0)">my_test_app</span>...done.</div><div>(gdb)<=
/div><div>(gdb) exit</div><div>I am not sure whether it is compiled with fi=
nstrumentation information.</div></div></div></div></div></div></blockquote=
><div>We would need the output of<br></div><div><br data-mce-bogus=3D"1"></=
div><div>make clean<br data-mce-bogus=3D"1"></div><div>make V=3D1<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>when you comp=
ile your project, so we can effectively see how the compiler is invoked.<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks=
,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Ma=
thieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><block=
quote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div>=
<div><div><div><br><div>Thanks in Advance,</div><div>Paramesh&nbsp;</div><b=
r><br></div></div></div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_e69c0b6f-9bc0-4cf6-807e-279534311874--

--===============4622488728516089635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4622488728516089635==--
