From: paramesh p <params16jan@gmail.com>
Subject: Re: Function Tracing Fails
Date: Tue, 7 Aug 2018 14:20:14 -0700
Message-ID: <CAOG=51wKyQN6Q1F=Qn_JYfu4aPjK1PnD79S0NJuxKei8o1e+HA__344.853886827146$1533676702$gmane$org@mail.gmail.com>
References: <CAOG=51zc2Xu2yNd-3YWhOXZiMb7_c1xYzN_ZS1x+PHP0kRz=LA@mail.gmail.com>
 <fc0a009e-da8e-8838-399a-b646b1ae088d@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000c540e50572def549"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x235.google.com (mail-yb0-x235.google.com
 [IPv6:2607:f8b0:4002:c09::235])
 by lists.lttng.org (Postfix) with ESMTPS id 41lS8w6LsXz14lr
 for <lttng-dev@lists.lttng.org>; Tue,  7 Aug 2018 17:20:16 -0400 (EDT)
Received: by mail-yb0-x235.google.com with SMTP id c10-v6so25320ybf.9
 for <lttng-dev@lists.lttng.org>; Tue, 07 Aug 2018 14:20:16 -0700 (PDT)
In-Reply-To: <fc0a009e-da8e-8838-399a-b646b1ae088d@versatic.net>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?Genevi=C3=A8ve_Bastien?= <gbastien@versatic.net>, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--000000000000c540e50572def549
Content-Type: multipart/alternative; boundary="000000000000c540e10572def547"

--000000000000c540e10572def547
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delayed response,

@Mathieu,
    I have attached the build log.  The Project I am working is Yocto
Project based build system. My App uses the shared object "libhw.so". So,
it built first. As I said before,below are the flag I added

AM_CFLAGS +=3D -g -O0 -finstrument-functions
AM_CXXFLAGS +=3D -g -O0 -finstrument-functions


  From the log I found that "-finstrument-functions" flag included in
compiling all the source files, ' libhw.la'  file and  'my_test_app'
binary, but not included for compiling  'libhw.so'. I am not sure why? My
question is, as you see my shared object and binary includes following so's
"libtinyalsa.so libexpat.so libbinder.so libutils.so libhwwrapper.so
libhardware.so libcutils.so liblog.so". Are all these need to be compiled
with finstrument flag. In that case, it will increase my workload, since
some of them are custom build and some from the libs and each of them might
have their own dependents.


@gen,
    objdump doesn't support arm architecture. So, I used
"arm-linux-gnueabi-objdump" tool. I could see cyg information to all my
object files but I could not see for "libhw.so" and "my_test_app" files.
    cyg information of one of my source file,

$ arm-linux-gnueabi-objdump -d libhw_la-hw_api.o | grep cyg

      20:       ebfffffe        bl      0 <__cyg_profile_func_enter>

      30:       eafffffe        b       0 <__cyg_profile_func_exit>

      64:       ebfffffe        bl      0 <__cyg_profile_func_enter>

      a4:       ebfffffe        bl      0 <__cyg_profile_func_exit>

      .....................

      .....................

      2548:       ebfffffe        bl      0 <__cyg_profile_func_exit>

      258c:       ebfffffe        bl      0 <__cyg_profile_func_enter>

      25d0:       ebfffffe        bl      0 <__cyg_profile_func_exit>

      25e8:       ebfffffe        bl      0 <__cyg_profile_func_exit>



Please help me.

Thanks in Advance,
Paramesh





On Mon, Jul 30, 2018 at 6:50 AM, Genevi=C3=A8ve Bastien <gbastien@versatic.=
net>
wrote:

> Hi Paramesh,
>
>
> One way to know if your app is really compiled with -finstrument-function=
s
> is doing
>
>
> $ objdump -d my_test_app | grep cyg
>
> You would typically see something like this:
>
> 0000000000001250 <__cyg_profile_func_enter@plt>:
>     1250:    ff 25 fa 2d 20 00        jmpq   *0x202dfa(%rip)        #
> 204050 <__cyg_profile_func_enter@GLIBC_2.2.5>
> <__cyg_profile_func_enter@GLIBC_2.2.5>
> 0000000000001260 <__cyg_profile_func_exit@plt>:
>     1260:    ff 25 f2 2d 20 00        jmpq   *0x202df2(%rip)        #
> 204058 <__cyg_profile_func_exit@GLIBC_2.2.5>
> <__cyg_profile_func_exit@GLIBC_2.2.5>
>     14a8:    e8 a3 fd ff ff           callq  1250
> <__cyg_profile_func_enter@plt>
>     16d8:    e8 83 fb ff ff           callq  1260
> <__cyg_profile_func_exit@plt>
>     19c5:    e8 86 f8 ff ff           callq  1250
> <__cyg_profile_func_enter@plt>
>     19e2:    e9 79 f8 ff ff           jmpq   1260
> <__cyg_profile_func_exit@plt>
>     1a0d:    e8 3e f8 ff ff           callq  1250
> <__cyg_profile_func_enter@plt>
>
> If you see nothing, as Mathieu said, you can check the individual make
> commands and see what flags are being used on the command line.
>
> Genevi=C3=A8ve
>
>
>
> On 2018-07-29 09:29 PM, paramesh p wrote:
>
> Hi,
>    I am trying to use Function Tracing for my application running in
> 32-bit ARM Platform. I have added below lines in my makefile for enabling
> Trace Data for function tracing
>
> AM_CFLAGS +=3D -g -O0 -finstrument-functions
> AM_CXXFLAGS +=3D -g -O0 -finstrument-functions
>
> **(My App have both C && CPP files, So I added CFLAGS & CXXFLAGS).
>
> I am running below commands,
> $lttng create session1
> $lttng enable-event -u -a --loglevel-only TRACE_DEBUG_FUNCTION
> $lttng start
> $LD_PRELOAD=3Dliblttng-ust-cyg-profile.so.0.0.0 my_test_app
> $lttng start
> $babeltrace /home/root/lttng-traces/session1
>
> Its showing nothing.
>
> I tried with below event-enable command also. There is no data
> $lttng enable-event -u -a --loglevel TRACE_DEBUG_FUNCTION
>
> But If I use the command, "lttng enable-event -u -a"  for enabling the
> event, I am getting below output from babeltrace,
>
> [22:25:30.812389281] (+?.?????????) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0xAD1A9000, sopath =3D "/usr/lib/liblttng-ust=
-cyg-profile.so.0.0.0",
> size =3D 10004, mtime =3D 1532324280 }
> [22:25:30.812496469] (+0.000107188) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DFF0000, sopath =3D "/usr/lib/xxx.so", siz=
e =3D
> 19540, mtime =3D 1532369202 }
> [22:25:30.812604177] (+0.000107708) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4E120000, sopath =3D "/usr/lib/libcutils.so=
.0.0.0",
> size =3D 48624, mtime =3D 1532323462 }
> [22:25:30.812655219] (+0.000051042) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DC80000, sopath =3D "/lib/libpthread-2.22.=
so",
> size =3D 94976, mtime =3D 1532322845 }
> [22:25:30.812701677] (+0.000046458) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DB20000, sopath =3D "/lib/libc-2.22.so", s=
ize =3D
> 1304484, mtime =3D 1532322845 }
> [22:25:30.812757927] (+0.000056250) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0xAD15B000, sopath =3D "/usr/lib/liblttng-ust=
.so.0.0.0",
> size =3D 315248, mtime =3D 1532324280 }
> [22:25:30.812814229] (+0.000056302) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0xAD149000, sopath =3D "/usr/lib/liblttng-ust=
-tracepoint.so.0.0.0",
> size =3D 35624, mtime =3D 1532324280 }
> [22:25:30.812860635] (+0.000046406) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DEC0000, sopath =3D "/lib/librt-2.22.so", =
size =3D
> 28380, mtime =3D 1532322845 }
> [22:25:30.812904438] (+0.000043803) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DCB0000, sopath =3D "/lib/libdl-2.22.so", =
size =3D
> 11236, mtime =3D 1532322845 }
> [22:25:30.812959125] (+0.000054687) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DE10000, sopath =3D "/usr/lib/liburcu-bp.s=
o.2.0.0",
> size =3D 29052, mtime =3D 1532323584 }
> [22:25:30.813013969] (+0.000054844) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DE00000, sopath =3D "/usr/lib/liburcu-cds.=
so.2.0.0",
> size =3D 26152, mtime =3D 1532323584 }
> [22:25:30.813485479] (+0.000471510) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DD60000, sopath =3D "/usr/lib/liburcu-comm=
on.so.2.0.0",
> size =3D 13084, mtime =3D 1532323584 }
> [22:25:30.813600792] (+0.000115313) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DAE0000, sopath =3D "/lib/ld-2.22.so", siz=
e =3D
> 139632, mtime =3D 1532322845 }
> [22:25:30.813663656] (+0.000062864) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DFC0000, sopath =3D "/usr/lib/xxx.so.1.0.0=
", size
> =3D 19456, mtime =3D 1532323510 }
> [22:25:30.813720635] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4E030000, sopath =3D "/usr/lib/xxx.so.1.6.0=
", size
> =3D 142164, mtime =3D 1532323441 }
> [22:25:30.813776990] (+0.000056355) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4E060000, sopath =3D "/usr/lib/xxx.so.0.0.0=
", size
> =3D 265304, mtime =3D 1532324468 }
> [22:25:30.813843917] (+0.000066927) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DEA0000, sopath =3D "/usr/lib/xxx.so.0.0.0=
", size
> =3D 84016, mtime =3D 1532324363 }
> [22:25:30.813884385] (+0.000040468) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DFE0000, sopath =3D "/usr/lib/xxx.so", siz=
e =3D
> 34204, mtime =3D 1532324426 }
> [22:25:30.813940479] (+0.000056094) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DFD0000, sopath =3D "/usr/lib/xxx.so", siz=
e =3D
> 7388, mtime =3D 1532324388 }
> [22:25:30.813993604] (+0.000053125) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4E000000, sopath =3D "/usr/lib/xxx.so", siz=
e =3D
> 33152, mtime =3D 1532323414 }
> [22:25:30.814049333] (+0.000055729) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DEE0000, sopath =3D "/usr/lib/libstdc++.so=
.6.0.20",
> size =3D 869236, mtime =3D 1532323320 }
> [22:25:30.814094177] (+0.000044844) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DCD0000, sopath =3D "/lib/libm-2.22.so", s=
ize =3D
> 441372, mtime =3D 1532322845 }
> [22:25:30.814234177] (+0.000140000) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DE80000, sopath =3D "/lib/libgcc_s.so.1", =
size =3D
> 118608, mtime =3D 1532323098 }
> [22:25:30.814427615] (+0.000193438) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x8000, sopath =3D "/usr/bin/my_test_app", si=
ze =3D
> 54540, mtime =3D 1532369202 }
> [22:25:30.828436677] (+0.014009062) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0xAEC57000, sopath =3D "/usr/lib/liblttng-ust=
-cyg-profile.so.0.0.0",
> size =3D 10004, mtime =3D 1532324280 }
> [22:25:30.828634958] (+0.000198281) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 1 }, { baddr =3D 0x4DCD0000, sopath =3D "/lib/libm-2.22.so", s=
ize =3D
> 441372, mtime =3D 1532322845 }
> [22:25:30.829786104] (+0.001151146) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0x4DB20000, sopath =3D "/lib/libc-2.22.so", s=
ize =3D
> 1304484, mtime =3D 1532322845 }
> [22:25:30.829910219] (+0.000124115) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0xAEC09000, sopath =3D "/usr/lib/liblttng-ust=
.so.0.0.0",
> size =3D 315248, mtime =3D 1532324280 }
> [22:25:30.829996000] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0xAEBF7000, sopath =3D "/usr/lib/liblttng-ust=
-tracepoint.so.0.0.0",
> size =3D 35624, mtime =3D 1532324280 }
> [22:25:30.830067510] (+0.000071510) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0x4DEC0000, sopath =3D "/lib/librt-2.22.so", =
size =3D
> 28380, mtime =3D 1532322845 }
> [22:25:30.830118031] (+0.000050521) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0x4DCB0000, sopath =3D "/lib/libdl-2.22.so", =
size =3D
> 11236, mtime =3D 1532322845 }
> [22:25:30.830175010] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0x4DE10000, sopath =3D "/usr/lib/liburcu-bp.s=
o.2.0.0",
> size =3D 29052, mtime =3D 1532323584 }
> [22:25:30.830245271] (+0.000070261) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0x4DE00000, sopath =3D "/usr/lib/liburcu-cds.=
so.2.0.0",
> size =3D 26152, mtime =3D 1532323584 }
> [22:25:30.830316521] (+0.000071250) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 0 }, { baddr =3D 0x4DD60000, sopath =3D "/usr/lib/liburcu-comm=
on.so.2.0.0",
> size =3D 13084, mtime =3D 1532323584 }
> [22:25:34.384458499] (+3.554141978) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0xAF584000, sopath =3D "/usr/lib/liblttng-ust=
-cyg-profile.so.0.0.0",
> size =3D 10004, mtime =3D 1532324280 }
> [22:25:34.385048967] (+0.000590468) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0x4DCD0000, sopath =3D "/lib/libm-2.22.so", s=
ize =3D
> 441372, mtime =3D 1532322845 }
> [22:25:34.385146415] (+0.000097448) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0x4DB20000, sopath =3D "/lib/libc-2.22.so", s=
ize =3D
> 1304484, mtime =3D 1532322845 }
> [22:25:34.385251832] (+0.000105417) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0xAF536000, sopath =3D "/usr/lib/liblttng-ust=
.so.0.0.0",
> size =3D 315248, mtime =3D 1532324280 }
> [22:25:34.385354228] (+0.000102396) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0xAF524000, sopath =3D "/usr/lib/liblttng-ust=
-tracepoint.so.0.0.0",
> size =3D 35624, mtime =3D 1532324280 }
> [22:25:34.385444384] (+0.000090156) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0x4DEC0000, sopath =3D "/lib/librt-2.22.so", =
size =3D
> 28380, mtime =3D 1532322845 }
> [22:25:34.385530165] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0x4DCB0000, sopath =3D "/lib/libdl-2.22.so", =
size =3D
> 11236, mtime =3D 1532322845 }
> [22:25:34.385607613] (+0.000077448) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0x4DE10000, sopath =3D "/usr/lib/liburcu-bp.s=
o.2.0.0",
> size =3D 29052, mtime =3D 1532323584 }
> [22:25:34.385677978] (+0.000070365) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0x4DE00000, sopath =3D "/usr/lib/liburcu-cds.=
so.2.0.0",
> size =3D 26152, mtime =3D 1532323584 }
> [22:25:34.385773655] (+0.000095677) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id =3D 2 }, { baddr =3D 0x4DD60000, sopath =3D "/usr/lib/liburcu-comm=
on.so.2.0.0",
> size =3D 13084, mtime =3D 1532323584 }
>
> Note: I have changed the Target Name as 'ZZZ' and some of the library nam=
e
> as 'xxx' in the above log for some confidential issues.
>
>
> Please guide me where I am making mistake and Please give your input on
> how to check the application compiled with function instrument informatio=
n
> for tracing. I verified that application compiled with debugging
> information, by running gdb command. Below is the output of gdb command,
>
> /usr/bin # gdb my_test_app
> GNU gdb (GDB) 7.9.1
> Copyright (C) 2015 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h
> tml>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying=
"
> and "show warranty" for details.
> This GDB was configured as "arm-oe-linux-gnueabi".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
> <http://www.gnu.org/software/gdb/documentation/>.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from my_test_app...done.
> (gdb)
> (gdb) exit
> I am not sure whether it is compiled with finstrumentation information.
>
> Thanks in Advance,
> Paramesh
>
>
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttps://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--000000000000c540e10572def547
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry for the delayed response,<div><br></div><div>

<span style=3D"font-size:12.8px;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial;float:none;display:inlin=
e">@Mathieu,</span><br></div><div><span style=3D"font-size:12.8px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial;float:none;display:inline">=C2=A0 =C2=A0 I have attached the buil=
d log.=C2=A0

<span style=3D"font-size:small;text-decoration-style:initial;text-decoratio=
n-color:initial;float:none;display:inline">The Project I am working is Yoct=
o Project based build system. My App uses the shared object &quot;libhw.so&=
quot;. So, it built first. As I said before,below are the flag I added=C2=
=A0</span></span></div><blockquote style=3D"margin:0px 0px 0px 40px;border:=
none;padding:0px"><div><span style=3D"font-size:12.8px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline"><span style=3D"font-size:small;text-decoration-st=
yle:initial;text-decoration-color:initial;float:none;display:inline"><div s=
tyle=3D"font-size:12.8px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">AM_CFLAGS +=3D -g -O0 -finstru=
ment-functions</div></span></span></div><div><span style=3D"font-size:12.8p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline"><span style=3D"font-size:sm=
all;text-decoration-style:initial;text-decoration-color:initial;float:none;=
display:inline"><div style=3D"font-size:12.8px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">AM_CXXFL=
AGS +=3D -g -O0 -finstrument-functions</div></span></span></div></blockquot=
e><div style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"><br></sp=
an></div><span style=3D"font-size:12.8px">=C2=A0 From the log I found that =
&quot;</span><span style=3D"font-size:12.8px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial;float:none;=
display:inline">-finstrument-functions</span><span style=3D"font-size:12.8p=
x">&quot; flag included in compiling all the source files, &#39;</span>

<span style=3D"font-size:small;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
"><a href=3D"http://libhw.la">libhw.la</a>&#39;</span><span style=3D"font-s=
ize:12.8px">=C2=A0 file and=C2=A0 &#39;my_test_app&#39; binary, but not inc=
luded for compiling=C2=A0</span>

<span style=3D"font-size:12.8px;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial;float:none;display:inlin=
e">&#39;</span><span style=3D"text-decoration-style:initial;text-decoration=
-color:initial;background-color:rgb(255,255,255);float:none;display:inline"=
>libhw.so&#39;. I am not sure why? My question is, as you see my shared obj=
ect and binary includes following=C2=A0so&#39;s &quot;libtinyalsa.so libexp=
at.so libbinder.so libutils.so libhwwrapper.so libhardware.so libcutils.so =
liblog.so&quot;. Are all these need to be compiled with finstrument flag. I=
n that case, it will increase my workload, since some of them are custom bu=
ild and some from the libs and each of them might have their own dependents=
.</span><div><br></div><div><div><br></div><div>@gen,</div><div>=C2=A0 =C2=
=A0 objdump doesn&#39;t support arm architecture. So, I used &quot;arm-linu=
x-gnueabi-objdump&quot; tool. I could see cyg information to all my object =
files but I could not see for &quot;<span style=3D"background-color:rgb(255=
,255,0)">libhw.so</span>&quot; and &quot;<span style=3D"background-color:rg=
b(255,255,0)">my_test_app</span>&quot; files.=C2=A0</div><div>=C2=A0 =C2=A0=
 cyg information of one of my source file,</div></div><blockquote style=3D"=
margin:0 0 0 40px;border:none;padding:0px"><blockquote style=3D"margin:0 0 =
0 40px;border:none;padding:0px"><div><div><div>$ arm-linux-gnueabi-objdump =
-d libhw_la-hw_api.o | grep cyg</div></div></div></blockquote><blockquote s=
tyle=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div>=C2=A0 =C2=A0 =
=C2=A0 20:=C2=A0 =C2=A0 =C2=A0 =C2=A0ebfffffe=C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=
=C2=A0 =C2=A0 =C2=A0 0 &lt;__cyg_profile_func_enter&gt;</div></div></blockq=
uote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><=
div>=C2=A0 =C2=A0 =C2=A0 30:=C2=A0 =C2=A0 =C2=A0 =C2=A0eafffffe=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 b=C2=A0 =C2=A0 =C2=A0 =C2=A00 &lt;__cyg_profile_func_exit=
&gt;</div></div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:=
none;padding:0px"><div><div>=C2=A0 =C2=A0 =C2=A0 64:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0ebfffffe=C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=C2=A0 =C2=A0 =C2=A0 0 &lt;__cy=
g_profile_func_enter&gt;</div></div></blockquote><blockquote style=3D"margi=
n:0 0 0 40px;border:none;padding:0px"><div><div>=C2=A0 =C2=A0 =C2=A0 a4:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0ebfffffe=C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=C2=A0 =C2=A0=
 =C2=A0 0 &lt;__cyg_profile_func_exit&gt;</div></div></blockquote><blockquo=
te style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div>=C2=A0 =C2=
=A0 =C2=A0 .....................</div></div></blockquote><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div>=C2=A0 =C2=A0 =C2=
=A0 .....................</div></div></blockquote><blockquote style=3D"marg=
in:0 0 0 40px;border:none;padding:0px"><div><div>=C2=A0 =C2=A0 =C2=A0 2548:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0ebfffffe=C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=C2=A0 =C2=
=A0 =C2=A0 0 &lt;__cyg_profile_func_exit&gt;</div></div></blockquote><block=
quote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div>=C2=A0 =
=C2=A0 =C2=A0 258c:=C2=A0 =C2=A0 =C2=A0 =C2=A0ebfffffe=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bl=C2=A0 =C2=A0 =C2=A0 0 &lt;__cyg_profile_func_enter&gt;</div></div=
></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0p=
x"><div><div>=C2=A0 =C2=A0 =C2=A0 25d0:=C2=A0 =C2=A0 =C2=A0 =C2=A0ebfffffe=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=C2=A0 =C2=A0 =C2=A0 0 &lt;__cyg_profile_func=
_exit&gt;</div></div></blockquote><blockquote style=3D"margin:0 0 0 40px;bo=
rder:none;padding:0px"><div><div>=C2=A0 =C2=A0 =C2=A0 25e8:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0ebfffffe=C2=A0 =C2=A0 =C2=A0 =C2=A0 bl=C2=A0 =C2=A0 =C2=A0 0 &=
lt;__cyg_profile_func_exit&gt;</div></div></blockquote></blockquote><div><d=
iv><br></div><div><br></div><div>Please help me.</div><div><br></div><div>T=
hanks in Advance,</div><div>Paramesh</div><div><br></div><div><br></div><di=
v><br></div><div><br></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Mon, Jul 30, 2018 at 6:50 AM, Genevi=C3=A8ve Bastien <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gbastien@versatic.net" target=3D"_blank">gba=
stien@versatic.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <p>Hi Paramesh,</p>
    <p><br>
    </p>
    <p>One way to know if your app is really compiled with
      -finstrument-functions is doing</p>
    <p><br>
    </p>
    <p>$ objdump -d my_test_app | grep cyg<br>
    </p>
    <br>
    You would typically see something like this: <br>
    <br>
    0000000000001250 &lt;__cyg_profile_func_enter@plt&gt;<wbr>:<br>
    =C2=A0=C2=A0=C2=A0 1250:=C2=A0=C2=A0=C2=A0 ff 25 fa 2d 20 00=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 jmpq=C2=A0=C2=A0 *0x202dfa(%rip)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
    # 204050 <a class=3D"gmail-m_-789035653171103869m_5184037771414379857mo=
z-txt-link-rfc2396E" href=3D"mailto:__cyg_profile_func_enter@GLIBC_2.2.5" t=
arget=3D"_blank">&lt;__cyg_profile_func_enter@GLIB<wbr>C_2.2.5&gt;</a><br>
    0000000000001260 &lt;__cyg_profile_func_exit@plt&gt;:<br>
    =C2=A0=C2=A0=C2=A0 1260:=C2=A0=C2=A0=C2=A0 ff 25 f2 2d 20 00=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 jmpq=C2=A0=C2=A0 *0x202df2(%rip)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
    # 204058 <a class=3D"gmail-m_-789035653171103869m_5184037771414379857mo=
z-txt-link-rfc2396E" href=3D"mailto:__cyg_profile_func_exit@GLIBC_2.2.5" ta=
rget=3D"_blank">&lt;__cyg_profile_func_exit@GLIBC<wbr>_2.2.5&gt;</a><br>
    =C2=A0=C2=A0=C2=A0 14a8:=C2=A0=C2=A0=C2=A0 e8 a3 fd ff ff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 callq=C2=A0 1250
    &lt;__cyg_profile_func_enter@plt&gt;<br>
    =C2=A0=C2=A0=C2=A0 16d8:=C2=A0=C2=A0=C2=A0 e8 83 fb ff ff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 callq=C2=A0 1260
    &lt;__cyg_profile_func_exit@plt&gt;<br>
    =C2=A0=C2=A0=C2=A0 19c5:=C2=A0=C2=A0=C2=A0 e8 86 f8 ff ff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 callq=C2=A0 1250
    &lt;__cyg_profile_func_enter@plt&gt;<br>
    =C2=A0=C2=A0=C2=A0 19e2:=C2=A0=C2=A0=C2=A0 e9 79 f8 ff ff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 jmpq=C2=A0=C2=A0 1260
    &lt;__cyg_profile_func_exit@plt&gt;<br>
    =C2=A0=C2=A0=C2=A0 1a0d:=C2=A0=C2=A0=C2=A0 e8 3e f8 ff ff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 callq=C2=A0 1250
    &lt;__cyg_profile_func_enter@plt&gt;<br>
    <br>
    If you see nothing, as Mathieu said, you can check the individual
    make commands and see what flags are being used on the command line.<sp=
an class=3D"gmail-m_-789035653171103869HOEnZb"><font color=3D"#888888"><br>
    <br>
    Genevi=C3=A8ve</font></span><div><div class=3D"gmail-m_-789035653171103=
869h5"><br>
    <br>
    <br>
    <div class=3D"gmail-m_-789035653171103869m_5184037771414379857moz-cite-=
prefix">On 2018-07-29 09:29 PM, paramesh p
      wrote:<br>
    </div>
    </div></div><blockquote type=3D"cite"><div><div class=3D"gmail-m_-78903=
5653171103869h5">
     =20
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div>
                <div>Hi,</div>
                <div>=C2=A0 =C2=A0I am trying to use Function Tracing for m=
y
                  application running in 32-bit ARM Platform. I have
                  added below lines in my makefile for enabling Trace
                  Data for function tracing=C2=A0</div>
                <div><br>
                </div>
                <div>AM_CFLAGS +=3D -g -O0 -finstrument-functions</div>
                <div>AM_CXXFLAGS +=3D -g -O0 -finstrument-functions=C2=A0</=
div>
                <div><br>
                </div>
                <div>**(My App have both C &amp;&amp; CPP files, So I
                  added CFLAGS &amp; CXXFLAGS).=C2=A0</div>
                <div><br>
                </div>
                <div>I am running below commands,</div>
                <div><span style=3D"white-space:pre-wrap">	</span>$lttng cr=
eate
                  session1</div>
                <div><span style=3D"white-space:pre-wrap">	</span>$lttng
                  enable-event -u -a --loglevel-only
                  TRACE_DEBUG_FUNCTION</div>
                <div><span style=3D"white-space:pre-wrap">	</span>$lttng st=
art</div>
                <div><span style=3D"white-space:pre-wrap">	</span>$LD_PRELO=
AD=3Dliblttng-ust-cyg-p<wbr>rofile.so.0.0.0
                  my_test_app=C2=A0</div>
                <div><span style=3D"white-space:pre-wrap">	</span>$lttng st=
art</div>
                <div><span style=3D"white-space:pre-wrap">	</span>$babeltra=
ce
                  /home/root/lttng-traces/sessio<wbr>n1</div>
                <div><br>
                </div>
                <div>Its showing nothing.</div>
                <div><br>
                </div>
                <div>I tried with below event-enable command also. There
                  is no data</div>
                <div><span style=3D"white-space:pre-wrap">	</span>$lttng
                  enable-event -u -a --loglevel TRACE_DEBUG_FUNCTION=C2=A0<=
/div>
                <div><br>
                </div>
                <div>But If I use the command, &quot;lttng enable-event -u
                  -a&quot;=C2=A0 for enabling the event, I am getting below=
 output
                  from babeltrace,</div>
                <div><br>
                </div>
                <div>[22:25:30.812389281] (+?.?????????) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0xAD1A9000, sopath =3D
                  &quot;/usr/lib/liblttng-ust-cyg-pro<wbr>file.so.0.0.0&quo=
t;, size =3D
                  10004, mtime =3D 1532324280 }</div>
                <div>[22:25:30.812496469] (+0.000107188) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DFF0000, sopath =3D &quot;/usr/lib/xxx.so&quot;, size =
=3D 19540,
                  mtime =3D 1532369202 }</div>
                <div>[22:25:30.812604177] (+0.000107708) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4E120000, sopath =3D &quot;/usr/lib/libcutils.so.0.0.0&=
quot;,
                  size =3D 48624, mtime =3D 1532323462 }</div>
                <div>[22:25:30.812655219] (+0.000051042) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DC80000, sopath =3D &quot;/lib/<a href=3D"http://libpt=
hread-2.22.so" target=3D"_blank">libpthread-2.22.so</a>&quot;, size
                  =3D 94976, mtime =3D 1532322845 }</div>
                <div>[22:25:30.812701677] (+0.000046458) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DB20000, sopath =3D &quot;/lib/<a href=3D"http://libc-=
2.22.so" target=3D"_blank">libc-2.22.so</a>&quot;,
                  size =3D 1304484, mtime =3D 1532322845 }</div>
                <div>[22:25:30.812757927] (+0.000056250) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0xAD15B000, sopath =3D &quot;/usr/lib/liblttng-ust.so.0.0=
.<wbr>0&quot;,
                  size =3D 315248, mtime =3D 1532324280 }</div>
                <div>[22:25:30.812814229] (+0.000056302) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0xAD149000, sopath =3D
                  &quot;/usr/lib/liblttng-ust-tracepo<wbr>int.so.0.0.0&quot=
;, size =3D
                  35624, mtime =3D 1532324280 }</div>
                <div>[22:25:30.812860635] (+0.000046406) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DEC0000, sopath =3D &quot;/lib/<a href=3D"http://librt=
-2.22.so" target=3D"_blank">librt-2.22.so</a>&quot;,
                  size =3D 28380, mtime =3D 1532322845 }</div>
                <div>[22:25:30.812904438] (+0.000043803) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DCB0000, sopath =3D &quot;/lib/<a href=3D"http://libdl=
-2.22.so" target=3D"_blank">libdl-2.22.so</a>&quot;,
                  size =3D 11236, mtime =3D 1532322845 }</div>
                <div>[22:25:30.812959125] (+0.000054687) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DE10000, sopath =3D &quot;/usr/lib/liburcu-bp.so.2.0.0=
&quot;<wbr>,
                  size =3D 29052, mtime =3D 1532323584 }</div>
                <div>[22:25:30.813013969] (+0.000054844) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DE00000, sopath =3D &quot;/usr/lib/liburcu-cds.so.2.0.=
0<wbr>&quot;,
                  size =3D 26152, mtime =3D 1532323584 }</div>
                <div>[22:25:30.813485479] (+0.000471510) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DD60000, sopath =3D
                  &quot;/usr/lib/liburcu-common.so.2.<wbr>0.0&quot;, size =
=3D 13084,
                  mtime =3D 1532323584 }</div>
                <div>[22:25:30.813600792] (+0.000115313) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DAE0000, sopath =3D &quot;/lib/<a href=3D"http://ld-2.=
22.so" target=3D"_blank">ld-2.22.so</a>&quot;, size =3D
                  139632, mtime =3D 1532322845 }</div>
                <div>[22:25:30.813663656] (+0.000062864) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DFC0000, sopath =3D &quot;/usr/lib/xxx.so.1.0.0&quot;,=
 size =3D
                  19456, mtime =3D 1532323510 }</div>
                <div>[22:25:30.813720635] (+0.000056979) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4E030000, sopath =3D &quot;/usr/lib/xxx.so.1.6.0&quot;,=
 size =3D
                  142164, mtime =3D 1532323441 }</div>
                <div>[22:25:30.813776990] (+0.000056355) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4E060000, sopath =3D &quot;/usr/lib/xxx.so.0.0.0&quot;,=
 size =3D
                  265304, mtime =3D 1532324468 }</div>
                <div>[22:25:30.813843917] (+0.000066927) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DEA0000, sopath =3D &quot;/usr/lib/xxx.so.0.0.0&quot;,=
 size =3D
                  84016, mtime =3D 1532324363 }</div>
                <div>[22:25:30.813884385] (+0.000040468) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DFE0000, sopath =3D &quot;/usr/lib/xxx.so&quot;, size =
=3D 34204,
                  mtime =3D 1532324426 }</div>
                <div>[22:25:30.813940479] (+0.000056094) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DFD0000, sopath =3D &quot;/usr/lib/xxx.so&quot;, size =
=3D 7388,
                  mtime =3D 1532324388 }</div>
                <div>[22:25:30.813993604] (+0.000053125) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4E000000, sopath =3D &quot;/usr/lib/xxx.so&quot;, size =
=3D 33152,
                  mtime =3D 1532323414 }</div>
                <div>[22:25:30.814049333] (+0.000055729) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DEE0000, sopath =3D &quot;/usr/lib/libstdc++.so.6.0.20=
&quot;<wbr>,
                  size =3D 869236, mtime =3D 1532323320 }</div>
                <div>[22:25:30.814094177] (+0.000044844) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DCD0000, sopath =3D &quot;/lib/<a href=3D"http://libm-=
2.22.so" target=3D"_blank">libm-2.22.so</a>&quot;,
                  size =3D 441372, mtime =3D 1532322845 }</div>
                <div>[22:25:30.814234177] (+0.000140000) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DE80000, sopath =3D &quot;/lib/libgcc_s.so.1&quot;, si=
ze =3D
                  118608, mtime =3D 1532323098 }</div>
                <div>[22:25:30.814427615] (+0.000193438) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x8000, sopath =3D &quot;<span style=3D"background-color:=
rgb(255,255,0)">/usr/bin/my_test_app</span>&quot;,
                  size =3D 54540, mtime =3D 1532369202 }</div>
                <div>[22:25:30.828436677] (+0.014009062) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0xAEC57000, sopath =3D
                  &quot;/usr/lib/liblttng-ust-cyg-pro<wbr>file.so.0.0.0&quo=
t;, size =3D
                  10004, mtime =3D 1532324280 }</div>
                <div>[22:25:30.828634958] (+0.000198281) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 1 }, { baddr =3D
                  0x4DCD0000, sopath =3D &quot;/lib/<a href=3D"http://libm-=
2.22.so" target=3D"_blank">libm-2.22.so</a>&quot;,
                  size =3D 441372, mtime =3D 1532322845 }</div>
                <div>[22:25:30.829786104] (+0.001151146) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0x4DB20000, sopath =3D &quot;/lib/<a href=3D"http://libc-=
2.22.so" target=3D"_blank">libc-2.22.so</a>&quot;,
                  size =3D 1304484, mtime =3D 1532322845 }</div>
                <div>[22:25:30.829910219] (+0.000124115) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0xAEC09000, sopath =3D &quot;/usr/lib/liblttng-ust.so.0.0=
.<wbr>0&quot;,
                  size =3D 315248, mtime =3D 1532324280 }</div>
                <div>[22:25:30.829996000] (+0.000085781) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0xAEBF7000, sopath =3D
                  &quot;/usr/lib/liblttng-ust-tracepo<wbr>int.so.0.0.0&quot=
;, size =3D
                  35624, mtime =3D 1532324280 }</div>
                <div>[22:25:30.830067510] (+0.000071510) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0x4DEC0000, sopath =3D &quot;/lib/<a href=3D"http://librt=
-2.22.so" target=3D"_blank">librt-2.22.so</a>&quot;,
                  size =3D 28380, mtime =3D 1532322845 }</div>
                <div>[22:25:30.830118031] (+0.000050521) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0x4DCB0000, sopath =3D &quot;/lib/<a href=3D"http://libdl=
-2.22.so" target=3D"_blank">libdl-2.22.so</a>&quot;,
                  size =3D 11236, mtime =3D 1532322845 }</div>
                <div>[22:25:30.830175010] (+0.000056979) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0x4DE10000, sopath =3D &quot;/usr/lib/liburcu-bp.so.2.0.0=
&quot;<wbr>,
                  size =3D 29052, mtime =3D 1532323584 }</div>
                <div>[22:25:30.830245271] (+0.000070261) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0x4DE00000, sopath =3D &quot;/usr/lib/liburcu-cds.so.2.0.=
0<wbr>&quot;,
                  size =3D 26152, mtime =3D 1532323584 }</div>
                <div>[22:25:30.830316521] (+0.000071250) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 0 }, { baddr =3D
                  0x4DD60000, sopath =3D
                  &quot;/usr/lib/liburcu-common.so.2.<wbr>0.0&quot;, size =
=3D 13084,
                  mtime =3D 1532323584 }</div>
                <div>[22:25:34.384458499] (+3.554141978) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0xAF584000, sopath =3D
                  &quot;/usr/lib/liblttng-ust-cyg-pro<wbr>file.so.0.0.0&quo=
t;, size =3D
                  10004, mtime =3D 1532324280 }</div>
                <div>[22:25:34.385048967] (+0.000590468) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0x4DCD0000, sopath =3D &quot;/lib/<a href=3D"http://libm-=
2.22.so" target=3D"_blank">libm-2.22.so</a>&quot;,
                  size =3D 441372, mtime =3D 1532322845 }</div>
                <div>[22:25:34.385146415] (+0.000097448) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0x4DB20000, sopath =3D &quot;/lib/<a href=3D"http://libc-=
2.22.so" target=3D"_blank">libc-2.22.so</a>&quot;,
                  size =3D 1304484, mtime =3D 1532322845 }</div>
                <div>[22:25:34.385251832] (+0.000105417) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0xAF536000, sopath =3D &quot;/usr/lib/liblttng-ust.so.0.0=
.<wbr>0&quot;,
                  size =3D 315248, mtime =3D 1532324280 }</div>
                <div>[22:25:34.385354228] (+0.000102396) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0xAF524000, sopath =3D
                  &quot;/usr/lib/liblttng-ust-tracepo<wbr>int.so.0.0.0&quot=
;, size =3D
                  35624, mtime =3D 1532324280 }</div>
                <div>[22:25:34.385444384] (+0.000090156) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0x4DEC0000, sopath =3D &quot;/lib/<a href=3D"http://librt=
-2.22.so" target=3D"_blank">librt-2.22.so</a>&quot;,
                  size =3D 28380, mtime =3D 1532322845 }</div>
                <div>[22:25:34.385530165] (+0.000085781) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0x4DCB0000, sopath =3D &quot;/lib/<a href=3D"http://libdl=
-2.22.so" target=3D"_blank">libdl-2.22.so</a>&quot;,
                  size =3D 11236, mtime =3D 1532322845 }</div>
                <div>[22:25:34.385607613] (+0.000077448) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0x4DE10000, sopath =3D &quot;/usr/lib/liburcu-bp.so.2.0.0=
&quot;<wbr>,
                  size =3D 29052, mtime =3D 1532323584 }</div>
                <div>[22:25:34.385677978] (+0.000070365) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0x4DE00000, sopath =3D &quot;/usr/lib/liburcu-cds.so.2.0.=
0<wbr>&quot;,
                  size =3D 26152, mtime =3D 1532323584 }</div>
                <div>[22:25:34.385773655] (+0.000095677) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D
                  0x4DD60000, sopath =3D
                  &quot;/usr/lib/liburcu-common.so.2.<wbr>0.0&quot;, size =
=3D 13084,
                  mtime =3D 1532323584 }</div>
                <div><br>
                </div>
                <div>Note: I have changed the Target Name as &#39;ZZZ&#39; =
and
                  some of the library name as &#39;xxx&#39; in the above lo=
g for
                  some confidential issues.</div>
                <div><br>
                </div>
                <div><br>
                </div>
                <div>Please guide me where I am making mistake and
                  Please give your input on how to check the application
                  compiled with function instrument information for
                  tracing. I verified that application compiled with
                  debugging information, by running gdb command. Below
                  is the output of gdb command,</div>
                <div><br>
                </div>
                <div><span style=3D"white-space:pre-wrap">	</span>/usr/bin =
#
                  gdb <span style=3D"background-color:rgb(255,255,0)">my_te=
st_app</span></div>
                <div><span style=3D"white-space:pre-wrap">	</span>GNU gdb (=
GDB)
                  7.9.1</div>
                <div><span style=3D"white-space:pre-wrap">	</span>Copyright=
 (C)
                  2015 Free Software Foundation, Inc.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>License
                  GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://=
gnu.org/licenses/gpl.html" target=3D"_blank">http://gnu.org/licenses/gpl.h<=
wbr>tml</a>&gt;</div>
                <div><span style=3D"white-space:pre-wrap">	</span>This is f=
ree
                  software: you are free to change and redistribute it.</di=
v>
                <div><span style=3D"white-space:pre-wrap">	</span>There is =
NO
                  WARRANTY, to the extent permitted by law.=C2=A0 Type &quo=
t;show
                  copying&quot;</div>
                <div><span style=3D"white-space:pre-wrap">	</span>and &quot=
;show
                  warranty&quot; for details.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>This GDB =
was
                  configured as &quot;arm-oe-linux-gnueabi&quot;.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>Type &quo=
t;show
                  configuration&quot; for configuration details.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>For bug
                  reporting instructions, please see:</div>
                <div><span style=3D"white-space:pre-wrap">	</span>&lt;<a hr=
ef=3D"http://www.gnu.org/software/gdb/bugs/" target=3D"_blank">http://www.g=
nu.org/software/g<wbr>db/bugs/</a>&gt;.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>Find the =
GDB
                  manual and other documentation resources online at:</div>
                <div><span style=3D"white-space:pre-wrap">	</span>&lt;<a hr=
ef=3D"http://www.gnu.org/software/gdb/documentation/" target=3D"_blank">htt=
p://www.gnu.org/software/g<wbr>db/documentation/</a>&gt;.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>For help,
                  type &quot;help&quot;.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>Type &quo=
t;apropos
                  word&quot; to search for commands related to &quot;word&q=
uot;...</div>
                <div><span style=3D"white-space:pre-wrap">	</span>Reading
                  symbols from <span style=3D"background-color:rgb(255,255,=
0)">my_test_app</span>...done.</div>
                <div><span style=3D"white-space:pre-wrap">	</span>(gdb)</di=
v>
                <div><span style=3D"white-space:pre-wrap">	</span>(gdb) exi=
t</div>
                <div><span style=3D"white-space:pre-wrap">	</span></div>
                <div>I am not sure whether it is compiled with
                  finstrumentation information.</div>
                <div><br>
                </div>
                <div>Thanks in Advance,</div>
                <div>Paramesh=C2=A0</div>
                <div><br>
                </div>
                <div><br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <br>
      <fieldset class=3D"gmail-m_-789035653171103869m_5184037771414379857mi=
meAttachmentHeader"></fieldset>
      <br>
      </div></div><span><pre>______________________________<wbr>___________=
______
lttng-dev mailing list
<a class=3D"gmail-m_-789035653171103869m_5184037771414379857moz-txt-link-ab=
breviated" href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttn=
g-dev@lists.lttng.org</a>
<a class=3D"gmail-m_-789035653171103869m_5184037771414379857moz-txt-link-fr=
eetext" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mailman/listinfo/lt=
tng-dev</a>
</pre>
    </span></blockquote>
    <br>
  </div>

<br>______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br></div></div></div>

--000000000000c540e10572def547--

--000000000000c540e50572def549
Content-Type: application/octet-stream; name="log.do_compile"
Content-Disposition: attachment; filename="log.do_compile"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jkk7klkt0

REVCVUc6IFNJVEUgZmlsZXMgWydlbmRpYW4tbGl0dGxlJywgJ2JpdC0zMicsICdhcm0tY29tbW9u
JywgJ2FybS0zMicsICdjb21tb24tbGludXgnLCAnY29tbW9uLWdsaWJjJywgJ2FybS1saW51eCcs
ICdhcm0tbGludXgtZ251ZWFiaScsICdjb21tb24nXQpERUJVRzogRXhlY3V0aW5nIHNoZWxsIGZ1
bmN0aW9uIGRvX2NvbXBpbGUKTk9URTogbWFrZSAtaiAyMCBWPTEgREVGQVVMVF9JTkNMVURFUz0g
Q1BQRkxBR1M9LUkuIC1JL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAt
Z2xpYmMvd29yay1zaGFyZWQvWlpaL2tlcm5lbC1idWlsZC1hcnRpZmFjdHMvdXNyL2luY2x1ZGUg
LUkvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290
cy9aWlovdXNyL2luY2x1ZGUvc3Vycm91bmRfMyAtSS9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxl
L3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvaW5jbHVkZS94X3RyaWdnZXIg
CihDRFBBVEg9IiR7WlNIX1ZFUlNJT04rLn06IiAmJiBjZCAuICYmIC9iaW4vc2ggL2hvbWUvd29y
a2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvd29yay9aWlotb2UtbGludXgt
Z251ZWFiaS9teXRlc3RhcHAvMS4wLXIwL3Rlc3RhcHAvbWlzc2luZyBhdXRvaGVhZGVyKQpybSAt
ZiBzdGFtcC1oMQp0b3VjaCBjb25maWcuaC5pbgpjZCAuICYmIC9iaW4vc2ggLi9jb25maWcuc3Rh
dHVzIGNvbmZpZy5oCmNvbmZpZy5zdGF0dXM6IGNyZWF0aW5nIGNvbmZpZy5oCmNvbmZpZy5zdGF0
dXM6IGNvbmZpZy5oIGlzIHVuY2hhbmdlZAptYWtlICBhbGwtcmVjdXJzaXZlCm1ha2VbMV06IEVu
dGVyaW5nIGRpcmVjdG9yeSBgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90
bXAtZ2xpYmMvd29yay9aWlotb2UtbGludXgtZ251ZWFiaS9teXRlc3RhcHAvMS4wLXIwL3Rlc3Rh
cHAnCk1ha2luZyBhbGwgaW4gaHdfYXBpCm1ha2VbMl06IEVudGVyaW5nIGRpcmVjdG9yeSBgL2hv
bWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvd29yay9aWlotb2Ut
bGludXgtZ251ZWFiaS9teXRlc3RhcHAvMS4wLXIwL3Rlc3RhcHAvaHdfYXBpJwouLi9hcm0tb2Ut
bGludXgtZ251ZWFiaS1saWJ0b29sICAtLXRhZz1DWFggICAtLW1vZGU9Y29tcGlsZSBhcm0tb2Ut
bGludXgtZ251ZWFiaS1nKysgIC1tYXJjaD1hcm12Ny1hIC1tZmxvYXQtYWJpPXNvZnRmcCAtbWZw
dT1uZW9uIC0tc3lzcm9vdD0vaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3Rt
cC1nbGliYy9zeXNyb290cy9aWlogLURIQVZFX0NPTkZJR19IICAgLUkgLi4vaHdfYXBpL2luYy8g
LUkgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9v
dHMvWlpaL3Vzci9pbmNsdWRlL21tLXNlcnZlciAtSSAvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJs
ZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUvbW0tYXVkaW8v
aHcvaW5jIC1EX191bnVzZWQ9X19hdHRyaWJ1dGVfX1woXChfX3VudXNlZF9fXClcKSAtZyAtTzAg
LWZpbnN0cnVtZW50LWZ1bmN0aW9ucyAgLXN0ZD1jKysxMSAtREhBVkVfUFRIUkVBRFMgLURERUJV
R19SRUZTX0NBTExTVEFDS19FTkFCTEVEPTAgLUkuIC1JL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFi
bGUvcG9reS9idWlsZC90bXAtZ2xpYmMvd29yay1zaGFyZWQvWlpaL2tlcm5lbC1idWlsZC1hcnRp
ZmFjdHMvdXNyL2luY2x1ZGUgLUkvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxk
L3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUvc3Vycm91bmRfMyAtSS9ob21lL3dv
cmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3Iv
aW5jbHVkZS94X3RyaWdnZXIgLWcgLU8wIC1maW5zdHJ1bWVudC1mdW5jdGlvbnMgLU8yIC1mZXhw
ZW5zaXZlLW9wdGltaXphdGlvbnMgLWZyZW5hbWUtcmVnaXN0ZXJzIC1mb21pdC1mcmFtZS1wb2lu
dGVyIC1mdHJlZS12ZWN0b3JpemUgICAtV25vLWVycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWQgLWZp
bmxpbmUtZnVuY3Rpb25zIC1maW5saW5lLWxpbWl0PTY0ICAtZnZpc2liaWxpdHktaW5saW5lcy1o
aWRkZW4gLWMgLW8gbGliaHdfbGEtaHdfYXBpLmxvIGB0ZXN0IC1mICdzcmMvaHdfYXBpLmNwcCcg
fHwgZWNobyAnLi8nYHNyYy9od19hcGkuY3BwCmFybS1vZS1saW51eC1nbnVlYWJpLWxpYnRvb2w6
IGNvbXBpbGU6ICBhcm0tb2UtbGludXgtZ251ZWFiaS1nKysgLW1hcmNoPWFybXY3LWEgLW1mbG9h
dC1hYmk9c29mdGZwIC1tZnB1PW5lb24gLS1zeXNyb290PS9ob21lL3dvcmtkaXIvbHR0bmctZW5h
YmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWiAtREhBVkVfQ09ORklHX0ggLUkg
Li4vaHdfYXBpL2luYy8gLUkgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90
bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9pbmNsdWRlL21tLXNlcnZlciAtSSAvaG9tZS93b3Jr
ZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2lu
Y2x1ZGUvbW0tYXVkaW8vaHcvaW5jICItRF9fdW51c2VkPV9fYXR0cmlidXRlX18oKF9fdW51c2Vk
X18pKSIgLWcgLU8wIC1maW5zdHJ1bWVudC1mdW5jdGlvbnMgLXN0ZD1jKysxMSAtREhBVkVfUFRI
UkVBRFMgLURERUJVR19SRUZTX0NBTExTVEFDS19FTkFCTEVEPTAgLUkuIC1JL2hvbWUvd29ya2Rp
ci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvd29yay1zaGFyZWQvWlpaL2tlcm5l
bC1idWlsZC1hcnRpZmFjdHMvdXNyL2luY2x1ZGUgLUkvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJs
ZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUvc3Vycm91bmRf
MyAtSS9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jv
b3RzL1paWi91c3IvaW5jbHVkZS94X3RyaWdnZXIgLWcgLU8wIC1maW5zdHJ1bWVudC1mdW5jdGlv
bnMgLU8yIC1mZXhwZW5zaXZlLW9wdGltaXphdGlvbnMgLWZyZW5hbWUtcmVnaXN0ZXJzIC1mb21p
dC1mcmFtZS1wb2ludGVyIC1mdHJlZS12ZWN0b3JpemUgLVduby1lcnJvcj1tYXliZS11bmluaXRp
YWxpemVkIC1maW5saW5lLWZ1bmN0aW9ucyAtZmlubGluZS1saW1pdD02NCAtZnZpc2liaWxpdHkt
aW5saW5lcy1oaWRkZW4gLWMgc3JjL2h3X2FwaS5jcHAgIC1mUElDIC1EUElDIC1vIC5saWJzL2xp
Ymh3X2xhLWh3X2FwaS5vCmFybS1vZS1saW51eC1nbnVlYWJpLWxpYnRvb2w6IGNvbXBpbGU6ICBh
cm0tb2UtbGludXgtZ251ZWFiaS1nKysgLW1hcmNoPWFybXY3LWEgLW1mbG9hdC1hYmk9c29mdGZw
IC1tZnB1PW5lb24gLS1zeXNyb290PS9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVp
bGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWiAtREhBVkVfQ09ORklHX0ggLUkgLi4vaHdfYXBpL2lu
Yy8gLUkgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lz
cm9vdHMvWlpaL3Vzci9pbmNsdWRlL21tLXNlcnZlciAtSSAvaG9tZS93b3JrZGlyL2x0dG5nLWVu
YWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUvbW0tYXVk
aW8vaHcvaW5jICItRF9fdW51c2VkPV9fYXR0cmlidXRlX18oKF9fdW51c2VkX18pKSIgLWcgLU8w
IC1maW5zdHJ1bWVudC1mdW5jdGlvbnMgLXN0ZD1jKysxMSAtREhBVkVfUFRIUkVBRFMgLURERUJV
R19SRUZTX0NBTExTVEFDS19FTkFCTEVEPTAgLUkuIC1JL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFi
bGUvcG9reS9idWlsZC90bXAtZ2xpYmMvd29yay1zaGFyZWQvWlpaL2tlcm5lbC1idWlsZC1hcnRp
ZmFjdHMvdXNyL2luY2x1ZGUgLUkvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxk
L3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUvc3Vycm91bmRfMyAtSS9ob21lL3dv
cmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3Iv
aW5jbHVkZS94X3RyaWdnZXIgLWcgLU8wIC1maW5zdHJ1bWVudC1mdW5jdGlvbnMgLU8yIC1mZXhw
ZW5zaXZlLW9wdGltaXphdGlvbnMgLWZyZW5hbWUtcmVnaXN0ZXJzIC1mb21pdC1mcmFtZS1wb2lu
dGVyIC1mdHJlZS12ZWN0b3JpemUgLVduby1lcnJvcj1tYXliZS11bmluaXRpYWxpemVkIC1maW5s
aW5lLWZ1bmN0aW9ucyAtZmlubGluZS1saW1pdD02NCAtZnZpc2liaWxpdHktaW5saW5lcy1oaWRk
ZW4gLWMgc3JjL2h3X2FwaS5jcHAgLW8gbGliaHdfbGEtaHdfYXBpLm8gPi9kZXYvbnVsbCAyPiYx
Ci4uL2FybS1vZS1saW51eC1nbnVlYWJpLWxpYnRvb2wgIC0tdGFnPUNYWCAgIC0tbW9kZT1saW5r
IGFybS1vZS1saW51eC1nbnVlYWJpLWcrKyAgLW1hcmNoPWFybXY3LWEgLW1mbG9hdC1hYmk9c29m
dGZwIC1tZnB1PW5lb24gLS1zeXNyb290PS9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kv
YnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWiAtZyAtTzAgLWZpbnN0cnVtZW50LWZ1bmN0aW9u
cyAtTzIgLWZleHBlbnNpdmUtb3B0aW1pemF0aW9ucyAtZnJlbmFtZS1yZWdpc3RlcnMgLWZvbWl0
LWZyYW1lLXBvaW50ZXIgLWZ0cmVlLXZlY3Rvcml6ZSAgIC1Xbm8tZXJyb3I9bWF5YmUtdW5pbml0
aWFsaXplZCAtZmlubGluZS1mdW5jdGlvbnMgLWZpbmxpbmUtbGltaXQ9NjQgIC1mdmlzaWJpbGl0
eS1pbmxpbmVzLWhpZGRlbiAtbHRpbnlhbHNhIC1saGFyZHdhcmUgLWxleHBhdCAtbGN1dGlscyAt
bGxvZyAtbGRsIC1sYmluZGVyIC1zaGFyZWQgLWF2b2lkLXZlcnNpb24gLWxsb2cgLWxjdXRpbHMg
LWxwdGhyZWFkIC1sdXRpbHMgIC1XbCwtTzEgLVdsLC0taGFzaC1zdHlsZT1nbnUgLVdsLC0tYXMt
bmVlZGVkIC1vIGxpYmh3LmxhIC1ycGF0aCAvdXNyL2xpYiBsaWJod19sYS1od19hcGkubG8gLWxo
d3dyYXBwZXIgCmFybS1vZS1saW51eC1nbnVlYWJpLWxpYnRvb2w6IGxpbms6IGFybS1vZS1saW51
eC1nbnVlYWJpLWcrKyAgLW1hcmNoPWFybXY3LWEgLW1mbG9hdC1hYmk9c29mdGZwIC1tZnB1PW5l
b24gLS1zeXNyb290PS9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWds
aWJjL3N5c3Jvb3RzL1paWiAgLWZQSUMgLURQSUMgLXNoYXJlZCAtbm9zdGRsaWIgL2hvbWUvd29y
a2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9s
aWIvY3J0aS5vIC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJj
L3N5c3Jvb3RzL1paWi91c3IvbGliL2FybS1vZS1saW51eC1nbnVlYWJpLzQuOS4zL2NydGJlZ2lu
Uy5vICAubGlicy9saWJod19sYS1od19hcGkubyAgIC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxl
L3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvbGliL2xpYnRpbnlhbHNhLnNv
IC1ML2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9v
dHMvWlpaL3Vzci9saWIgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAt
Z2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9saWIvbGliZXhwYXQuc28gL2hvbWUvd29ya2Rpci9sdHRu
Zy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9saWIvbGliYmlu
ZGVyLnNvIC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5
c3Jvb3RzL1paWi91c3IvbGliL2xpYnV0aWxzLnNvIC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxl
L3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvbGliL2xpYmh3d3JhcHBlci5z
byAvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290
cy9aWlovdXNyL2xpYi9saWJoYXJkd2FyZS5zbyAvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9w
b2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2xpYi9saWJjdXRpbHMuc28gLWxw
dGhyZWFkIC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5
c3Jvb3RzL1paWi91c3IvbGliL2xpYmxvZy5zbyAtbGRsIC1ML2hvbWUvd29ya2Rpci9sdHRuZy1l
bmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMveDg2XzY0LWxpbnV4L3Vzci9saWIv
YXJtLW9lLWxpbnV4LWdudWVhYmkvZ2NjL2FybS1vZS1saW51eC1nbnVlYWJpLzQuOS4zIC1ML2hv
bWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpa
L2xpYiAtTC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5
c3Jvb3RzL1paWi91c3IvbGliL2FybS1vZS1saW51eC1nbnVlYWJpLzQuOS4zIC9ob21lL3dvcmtk
aXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvbGli
L2xpYnN0ZGMrKy5zbyAtbG0gLWxjIC1sZ2NjX3MgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUv
cG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9saWIvYXJtLW9lLWxpbnV4LWdu
dWVhYmkvNC45LjMvY3J0ZW5kUy5vIC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVp
bGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvbGliL2NydG4ubyAgLW1hcmNoPWFybXY3LWEg
LW1mbG9hdC1hYmk9c29mdGZwIC1tZnB1PW5lb24gLS1zeXNyb290PS9ob21lL3dvcmtkaXIvbHR0
bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWiAtZyAtTzAgLU8yIC1X
bCwtTzEgLVdsLC0taGFzaC1zdHlsZT1nbnUgLVdsLC0tYXMtbmVlZGVkICAgLVdsLC1zb25hbWUg
LVdsLGxpYmh3LnNvIC1vIC5saWJzL2xpYmh3LnNvCmFybS1vZS1saW51eC1nbnVlYWJpLWxpYnRv
b2w6IGxpbms6ICggY2QgIi5saWJzIiAmJiBybSAtZiAibGliaHcubGEiICYmIGxuIC1zICIuLi9s
aWJody5sYSIgImxpYmh3LmxhIiApCm1ha2VbMl06IExlYXZpbmcgZGlyZWN0b3J5IGAvaG9tZS93
b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy93b3JrL1paWi1vZS1saW51
eC1nbnVlYWJpL215dGVzdGFwcC8xLjAtcjAvdGVzdGFwcC9od19hcGknCk1ha2luZyBhbGwgaW4g
aHdfYXBpL3Rlc3QKbWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvaG9tZS93b3JrZGlyL2x0
dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy93b3JrL1paWi1vZS1saW51eC1nbnVlYWJp
L215dGVzdGFwcC8xLjAtcjAvdGVzdGFwcC9od19hcGkvdGVzdCcKYXJtLW9lLWxpbnV4LWdudWVh
YmktZ2NjICAtbWFyY2g9YXJtdjctYSAtbWZsb2F0LWFiaT1zb2Z0ZnAgLW1mcHU9bmVvbiAtLXN5
c3Jvb3Q9L2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lz
cm9vdHMvWlpaIC1ESEFWRV9DT05GSUdfSCAgICAtSS4gLUkvaG9tZS93b3JrZGlyL2x0dG5nLWVu
YWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy93b3JrLXNoYXJlZC9aWlova2VybmVsLWJ1aWxkLWFy
dGlmYWN0cy91c3IvaW5jbHVkZSAtSS9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVp
bGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvaW5jbHVkZS9zdXJyb3VuZF8zIC1JL2hvbWUv
d29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vz
ci9pbmNsdWRlL3hfdHJpZ2dlciAtV25vLXNpZ24tY29tcGFyZSAtV2Vycm9yIC1EX191bnVzZWQ9
X19hdHRyaWJ1dGVfX1woXChfX3VudXNlZF9fXClcKSAtSSAuLi8uLi9od19hcGkvaW5jIC1JIC9o
b21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1pa
Wi91c3IvaW5jbHVkZS9tbS1hdWRpby9ody9pbmMgLWcgLU8wIC1maW5zdHJ1bWVudC1mdW5jdGlv
bnMgLURMSU5VWF9FTkFCTEVEIC1PMiAtZmV4cGVuc2l2ZS1vcHRpbWl6YXRpb25zIC1mcmVuYW1l
LXJlZ2lzdGVycyAtZm9taXQtZnJhbWUtcG9pbnRlciAtZnRyZWUtdmVjdG9yaXplICAgLVduby1l
cnJvcj1tYXliZS11bmluaXRpYWxpemVkIC1maW5saW5lLWZ1bmN0aW9ucyAtZmlubGluZS1saW1p
dD02NCAgIC1JL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMv
c3lzcm9vdHMvWlpaL3Vzci9pbmNsdWRlL3hfdHJpZ2dlciAgLUkvaG9tZS93b3JrZGlyL2x0dG5n
LWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUvc3Vy
cm91bmRfMyAtYyAtbyBteV90ZXN0X2FwcC1od19wbGF5YmFja190ZXN0Lm8gYHRlc3QgLWYgJ2h3
X3BsYXliYWNrX3Rlc3QuYycgfHwgZWNobyAnLi8nYGh3X3BsYXliYWNrX3Rlc3QuYwphcm0tb2Ut
bGludXgtZ251ZWFiaS1nY2MgIC1tYXJjaD1hcm12Ny1hIC1tZmxvYXQtYWJpPXNvZnRmcCAtbWZw
dT1uZW9uIC0tc3lzcm9vdD0vaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3Rt
cC1nbGliYy9zeXNyb290cy9aWlogLURIQVZFX0NPTkZJR19IICAgIC1JLiAtSS9ob21lL3dvcmtk
aXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3dvcmstc2hhcmVkL1paWi9rZXJu
ZWwtYnVpbGQtYXJ0aWZhY3RzL3Vzci9pbmNsdWRlIC1JL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFi
bGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9pbmNsdWRlL3N1cnJvdW5k
XzMgLUkvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNy
b290cy9aWlovdXNyL2luY2x1ZGUveF90cmlnZ2VyIC1Xbm8tc2lnbi1jb21wYXJlIC1XZXJyb3Ig
LURfX3VudXNlZD1fX2F0dHJpYnV0ZV9fXChcKF9fdW51c2VkX19cKVwpIC1JIC4uLy4uL2h3X2Fw
aS9pbmMgLUkgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMv
c3lzcm9vdHMvWlpaL3Vzci9pbmNsdWRlL21tLWF1ZGlvL2h3L2luYyAtZyAtTzAgLWZpbnN0cnVt
ZW50LWZ1bmN0aW9ucyAtRExJTlVYX0VOQUJMRUQgLU8yIC1mZXhwZW5zaXZlLW9wdGltaXphdGlv
bnMgLWZyZW5hbWUtcmVnaXN0ZXJzIC1mb21pdC1mcmFtZS1wb2ludGVyIC1mdHJlZS12ZWN0b3Jp
emUgICAtV25vLWVycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWQgLWZpbmxpbmUtZnVuY3Rpb25zIC1m
aW5saW5lLWxpbWl0PTY0ICAgLUkvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxk
L3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUveF90cmlnZ2VyICAtSS9ob21lL3dv
cmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3Iv
aW5jbHVkZS9zdXJyb3VuZF8zIC1jIC1vIG15X3Rlc3RfYXBwLWh3X2VmZmVjdF90ZXN0Lm8gYHRl
c3QgLWYgJ2h3X2VmZmVjdF90ZXN0LmMnIHx8IGVjaG8gJy4vJ2Bod19lZmZlY3RfdGVzdC5jCi4u
Ly4uL2FybS1vZS1saW51eC1nbnVlYWJpLWxpYnRvb2wgIC0tdGFnPUNDICAgLS1tb2RlPWxpbmsg
YXJtLW9lLWxpbnV4LWdudWVhYmktZ2NjICAtbWFyY2g9YXJtdjctYSAtbWZsb2F0LWFiaT1zb2Z0
ZnAgLW1mcHU9bmVvbiAtLXN5c3Jvb3Q9L2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9i
dWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaIC1Xbm8tc2lnbi1jb21wYXJlIC1XZXJyb3IgLURf
X3VudXNlZD1fX2F0dHJpYnV0ZV9fXChcKF9fdW51c2VkX19cKVwpIC1JIC4uLy4uL2h3X2FwaS9p
bmMgLUkgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lz
cm9vdHMvWlpaL3Vzci9pbmNsdWRlL21tLWF1ZGlvL2h3L2luYyAtZyAtTzAgLWZpbnN0cnVtZW50
LWZ1bmN0aW9ucyAtRExJTlVYX0VOQUJMRUQgLU8yIC1mZXhwZW5zaXZlLW9wdGltaXphdGlvbnMg
LWZyZW5hbWUtcmVnaXN0ZXJzIC1mb21pdC1mcmFtZS1wb2ludGVyIC1mdHJlZS12ZWN0b3JpemUg
ICAtV25vLWVycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWQgLWZpbmxpbmUtZnVuY3Rpb25zIC1maW5s
aW5lLWxpbWl0PTY0ICAgLUkvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3Rt
cC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUveF90cmlnZ2VyICAtSS9ob21lL3dvcmtk
aXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvaW5j
bHVkZS9zdXJyb3VuZF8zICAtV2wsLU8xIC1XbCwtLWhhc2gtc3R5bGU9Z251IC1XbCwtLWFzLW5l
ZWRlZCAtbyBteV90ZXN0X2FwcCBteV90ZXN0X2FwcC1od19wbGF5YmFja190ZXN0Lm8gbXlfdGVz
dF9hcHAtaHdfZWZmZWN0X3Rlc3QubyAtbHV0aWxzIC4uL2xpYmh3LmxhIAphcm0tb2UtbGludXgt
Z251ZWFiaS1saWJ0b29sOiBsaW5rOiBhcm0tb2UtbGludXgtZ251ZWFiaS1nY2MgLW1hcmNoPWFy
bXY3LWEgLW1mbG9hdC1hYmk9c29mdGZwIC1tZnB1PW5lb24gLS1zeXNyb290PS9ob21lL3dvcmtk
aXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWiAtV25vLXNp
Z24tY29tcGFyZSAtV2Vycm9yICItRF9fdW51c2VkPV9fYXR0cmlidXRlX18oKF9fdW51c2VkX18p
KSIgLUkgLi4vLi4vaHdfYXBpL2luYyAtSSAvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5
L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2luY2x1ZGUvbW0tYXVkaW8vaHcvaW5j
IC1nIC1PMCAtZmluc3RydW1lbnQtZnVuY3Rpb25zIC1ETElOVVhfRU5BQkxFRCAtTzIgLWZleHBl
bnNpdmUtb3B0aW1pemF0aW9ucyAtZnJlbmFtZS1yZWdpc3RlcnMgLWZvbWl0LWZyYW1lLXBvaW50
ZXIgLWZ0cmVlLXZlY3Rvcml6ZSAtV25vLWVycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWQgLWZpbmxp
bmUtZnVuY3Rpb25zIC1maW5saW5lLWxpbWl0PTY0IC1JL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFi
bGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9pbmNsdWRlL3hfdHJpZ2dl
ciAtSS9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jv
b3RzL1paWi91c3IvaW5jbHVkZS9zdXJyb3VuZF8zIC1XbCwtTzEgLVdsLC0taGFzaC1zdHlsZT1n
bnUgLVdsLC0tYXMtbmVlZGVkIC1vIC5saWJzL215X3Rlc3RfYXBwIG15X3Rlc3RfYXBwLWh3X3Bs
YXliYWNrX3Rlc3QubyBteV90ZXN0X2FwcC1od19lZmZlY3RfdGVzdC5vICAuLi8ubGlicy9saWJo
dy5zbyAvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNy
b290cy9aWlovdXNyL2xpYi9saWJ0aW55YWxzYS5zbyAvaG9tZS93b3JrZGlyL2x0dG5nLWVuYWJs
ZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9aWlovdXNyL2xpYi9saWJleHBhdC5zbyAv
aG9tZS93b3JrZGlyL2x0dG5nLWVuYWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy9zeXNyb290cy9a
WlovdXNyL2xpYi9saWJiaW5kZXIuc28gL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9i
dWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9saWIvbGlidXRpbHMuc28gL2hvbWUvd29y
a2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9s
aWIvbGliaHd3cmFwcGVyLnNvIC9ob21lL3dvcmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQv
dG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvbGliL2xpYmhhcmR3YXJlLnNvIC9ob21lL3dvcmtk
aXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3N5c3Jvb3RzL1paWi91c3IvbGli
L2xpYmN1dGlscy5zbyAtbHB0aHJlYWQgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9i
dWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vzci9saWIvbGlibG9nLnNvIC1sZGwgL2hvbWUv
d29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvc3lzcm9vdHMvWlpaL3Vz
ci9saWIvbGlic3RkYysrLnNvIC1sbQptYWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL2hvbWUv
d29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWlsZC90bXAtZ2xpYmMvd29yay9aWlotb2UtbGlu
dXgtZ251ZWFiaS9teXRlc3RhcHAvMS4wLXIwL3Rlc3RhcHAvaHdfYXBpL3Rlc3QnCm1ha2VbMl06
IEVudGVyaW5nIGRpcmVjdG9yeSBgL2hvbWUvd29ya2Rpci9sdHRuZy1lbmFibGUvcG9reS9idWls
ZC90bXAtZ2xpYmMvd29yay9aWlotb2UtbGludXgtZ251ZWFiaS9teXRlc3RhcHAvMS4wLXIwL3Rl
c3RhcHAnCm1ha2VbMl06IExlYXZpbmcgZGlyZWN0b3J5IGAvaG9tZS93b3JrZGlyL2x0dG5nLWVu
YWJsZS9wb2t5L2J1aWxkL3RtcC1nbGliYy93b3JrL1paWi1vZS1saW51eC1nbnVlYWJpL215dGVz
dGFwcC8xLjAtcjAvdGVzdGFwcCcKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC9ob21lL3dv
cmtkaXIvbHR0bmctZW5hYmxlL3Bva3kvYnVpbGQvdG1wLWdsaWJjL3dvcmsvWlpaLW9lLWxpbnV4
LWdudWVhYmkvbXl0ZXN0YXBwLzEuMC1yMC90ZXN0YXBwJwpERUJVRzogU2hlbGwgZnVuY3Rpb24g
ZG9fY29tcGlsZSBmaW5pc2hlZAo=
--000000000000c540e50572def549
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--000000000000c540e50572def549--
