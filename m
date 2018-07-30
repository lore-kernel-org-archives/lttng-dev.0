From: =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: Function Tracing Fails
Date: Mon, 30 Jul 2018 09:50:17 -0400
Message-ID: <fc0a009e-da8e-8838-399a-b646b1ae088d__38468.6795565814$1532962185$gmane$org@versatic.net>
References: <CAOG=51zc2Xu2yNd-3YWhOXZiMb7_c1xYzN_ZS1x+PHP0kRz=LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1080236379541552275=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 41fMwG1PpQznZ1
 for <lttng-dev@lists.lttng.org>; Mon, 30 Jul 2018 10:51:41 -0400 (EDT)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.91)
 (envelope-from <gbastien@versatic.net>) id 1fk8Yz-00FX2R-Tt
 for lttng-dev@lists.lttng.org; Mon, 30 Jul 2018 09:50:18 -0400
Received: from [132.207.72.9] (port=41856)
 by s056.panelboxmanager.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gbastien@versatic.net>) id 1fk8Yz-00FX2L-Mm
 for lttng-dev@lists.lttng.org; Mon, 30 Jul 2018 09:50:17 -0400
In-Reply-To: <CAOG=51zc2Xu2yNd-3YWhOXZiMb7_c1xYzN_ZS1x+PHP0kRz=LA@mail.gmail.com>
Content-Language: en-US-large
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

This is a multi-part message in MIME format.
--===============1080236379541552275==
Content-Type: multipart/alternative;
 boundary="------------39B493B723E7BD4D76D52E4C"
Content-Language: en-US-large

This is a multi-part message in MIME format.
--------------39B493B723E7BD4D76D52E4C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Paramesh,


One way to know if your app is really compiled with
-finstrument-functions is doing


$ objdump -d my_test_app | grep cyg


You would typically see something like this:

0000000000001250 <__cyg_profile_func_enter@plt>:
    1250:    ff 25 fa 2d 20 00        jmpq   *0x202dfa(%rip)        #
204050 <__cyg_profile_func_enter@GLIBC_2.2.5>
0000000000001260 <__cyg_profile_func_exit@plt>:
    1260:    ff 25 f2 2d 20 00        jmpq   *0x202df2(%rip)        #
204058 <__cyg_profile_func_exit@GLIBC_2.2.5>
    14a8:    e8 a3 fd ff ff           callq  1250
<__cyg_profile_func_enter@plt>
    16d8:    e8 83 fb ff ff           callq  1260
<__cyg_profile_func_exit@plt>
    19c5:    e8 86 f8 ff ff           callq  1250
<__cyg_profile_func_enter@plt>
    19e2:    e9 79 f8 ff ff           jmpq   1260
<__cyg_profile_func_exit@plt>
    1a0d:    e8 3e f8 ff ff           callq  1250
<__cyg_profile_func_enter@plt>

If you see nothing, as Mathieu said, you can check the individual make
commands and see what flags are being used on the command line.

Geneviève


On 2018-07-29 09:29 PM, paramesh p wrote:
> Hi,
>    I am trying to use Function Tracing for my application running in
> 32-bit ARM Platform. I have added below lines in my makefile for
> enabling Trace Data for function tracing 
>
> AM_CFLAGS += -g -O0 -finstrument-functions
> AM_CXXFLAGS += -g -O0 -finstrument-functions 
>
> **(My App have both C && CPP files, So I added CFLAGS & CXXFLAGS). 
>
> I am running below commands,
> $lttng create session1
> $lttng enable-event -u -a --loglevel-only TRACE_DEBUG_FUNCTION
> $lttng start
> $LD_PRELOAD=liblttng-ust-cyg-profile.so.0.0.0 my_test_app 
> $lttng start
> $babeltrace /home/root/lttng-traces/session1
>
> Its showing nothing.
>
> I tried with below event-enable command also. There is no data
> $lttng enable-event -u -a --loglevel TRACE_DEBUG_FUNCTION 
>
> But If I use the command, "lttng enable-event -u -a"  for enabling the
> event, I am getting below output from babeltrace,
>
> [22:25:30.812389281] (+?.?????????) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0xAD1A9000, sopath =
> "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size = 10004, mtime =
> 1532324280 }
> [22:25:30.812496469] (+0.000107188) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DFF0000, sopath = "/usr/lib/xxx.so", size =
> 19540, mtime = 1532369202 }
> [22:25:30.812604177] (+0.000107708) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4E120000, sopath =
> "/usr/lib/libcutils.so.0.0.0", size = 48624, mtime = 1532323462 }
> [22:25:30.812655219] (+0.000051042) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DC80000, sopath = "/lib/libpthread-2.22.so
> <http://libpthread-2.22.so>", size = 94976, mtime = 1532322845 }
> [22:25:30.812701677] (+0.000046458) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DB20000, sopath = "/lib/libc-2.22.so
> <http://libc-2.22.so>", size = 1304484, mtime = 1532322845 }
> [22:25:30.812757927] (+0.000056250) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0xAD15B000, sopath =
> "/usr/lib/liblttng-ust.so.0.0.0", size = 315248, mtime = 1532324280 }
> [22:25:30.812814229] (+0.000056302) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0xAD149000, sopath =
> "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 35624, mtime =
> 1532324280 }
> [22:25:30.812860635] (+0.000046406) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DEC0000, sopath = "/lib/librt-2.22.so
> <http://librt-2.22.so>", size = 28380, mtime = 1532322845 }
> [22:25:30.812904438] (+0.000043803) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DCB0000, sopath = "/lib/libdl-2.22.so
> <http://libdl-2.22.so>", size = 11236, mtime = 1532322845 }
> [22:25:30.812959125] (+0.000054687) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DE10000, sopath =
> "/usr/lib/liburcu-bp.so.2.0.0", size = 29052, mtime = 1532323584 }
> [22:25:30.813013969] (+0.000054844) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DE00000, sopath =
> "/usr/lib/liburcu-cds.so.2.0.0", size = 26152, mtime = 1532323584 }
> [22:25:30.813485479] (+0.000471510) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DD60000, sopath =
> "/usr/lib/liburcu-common.so.2.0.0", size = 13084, mtime = 1532323584 }
> [22:25:30.813600792] (+0.000115313) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DAE0000, sopath = "/lib/ld-2.22.so
> <http://ld-2.22.so>", size = 139632, mtime = 1532322845 }
> [22:25:30.813663656] (+0.000062864) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DFC0000, sopath = "/usr/lib/xxx.so.1.0.0",
> size = 19456, mtime = 1532323510 }
> [22:25:30.813720635] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4E030000, sopath = "/usr/lib/xxx.so.1.6.0",
> size = 142164, mtime = 1532323441 }
> [22:25:30.813776990] (+0.000056355) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4E060000, sopath = "/usr/lib/xxx.so.0.0.0",
> size = 265304, mtime = 1532324468 }
> [22:25:30.813843917] (+0.000066927) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DEA0000, sopath = "/usr/lib/xxx.so.0.0.0",
> size = 84016, mtime = 1532324363 }
> [22:25:30.813884385] (+0.000040468) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DFE0000, sopath = "/usr/lib/xxx.so", size =
> 34204, mtime = 1532324426 }
> [22:25:30.813940479] (+0.000056094) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DFD0000, sopath = "/usr/lib/xxx.so", size =
> 7388, mtime = 1532324388 }
> [22:25:30.813993604] (+0.000053125) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4E000000, sopath = "/usr/lib/xxx.so", size =
> 33152, mtime = 1532323414 }
> [22:25:30.814049333] (+0.000055729) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DEE0000, sopath =
> "/usr/lib/libstdc++.so.6.0.20", size = 869236, mtime = 1532323320 }
> [22:25:30.814094177] (+0.000044844) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DCD0000, sopath = "/lib/libm-2.22.so
> <http://libm-2.22.so>", size = 441372, mtime = 1532322845 }
> [22:25:30.814234177] (+0.000140000) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DE80000, sopath = "/lib/libgcc_s.so.1",
> size = 118608, mtime = 1532323098 }
> [22:25:30.814427615] (+0.000193438) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x8000, sopath = "/usr/bin/my_test_app", size
> = 54540, mtime = 1532369202 }
> [22:25:30.828436677] (+0.014009062) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0xAEC57000, sopath =
> "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size = 10004, mtime =
> 1532324280 }
> [22:25:30.828634958] (+0.000198281) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 1 }, { baddr = 0x4DCD0000, sopath = "/lib/libm-2.22.so
> <http://libm-2.22.so>", size = 441372, mtime = 1532322845 }
> [22:25:30.829786104] (+0.001151146) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0x4DB20000, sopath = "/lib/libc-2.22.so
> <http://libc-2.22.so>", size = 1304484, mtime = 1532322845 }
> [22:25:30.829910219] (+0.000124115) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0xAEC09000, sopath =
> "/usr/lib/liblttng-ust.so.0.0.0", size = 315248, mtime = 1532324280 }
> [22:25:30.829996000] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0xAEBF7000, sopath =
> "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 35624, mtime =
> 1532324280 }
> [22:25:30.830067510] (+0.000071510) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0x4DEC0000, sopath = "/lib/librt-2.22.so
> <http://librt-2.22.so>", size = 28380, mtime = 1532322845 }
> [22:25:30.830118031] (+0.000050521) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0x4DCB0000, sopath = "/lib/libdl-2.22.so
> <http://libdl-2.22.so>", size = 11236, mtime = 1532322845 }
> [22:25:30.830175010] (+0.000056979) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0x4DE10000, sopath =
> "/usr/lib/liburcu-bp.so.2.0.0", size = 29052, mtime = 1532323584 }
> [22:25:30.830245271] (+0.000070261) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0x4DE00000, sopath =
> "/usr/lib/liburcu-cds.so.2.0.0", size = 26152, mtime = 1532323584 }
> [22:25:30.830316521] (+0.000071250) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 0 }, { baddr = 0x4DD60000, sopath =
> "/usr/lib/liburcu-common.so.2.0.0", size = 13084, mtime = 1532323584 }
> [22:25:34.384458499] (+3.554141978) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0xAF584000, sopath =
> "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size = 10004, mtime =
> 1532324280 }
> [22:25:34.385048967] (+0.000590468) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0x4DCD0000, sopath = "/lib/libm-2.22.so
> <http://libm-2.22.so>", size = 441372, mtime = 1532322845 }
> [22:25:34.385146415] (+0.000097448) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0x4DB20000, sopath = "/lib/libc-2.22.so
> <http://libc-2.22.so>", size = 1304484, mtime = 1532322845 }
> [22:25:34.385251832] (+0.000105417) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0xAF536000, sopath =
> "/usr/lib/liblttng-ust.so.0.0.0", size = 315248, mtime = 1532324280 }
> [22:25:34.385354228] (+0.000102396) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0xAF524000, sopath =
> "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 35624, mtime =
> 1532324280 }
> [22:25:34.385444384] (+0.000090156) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0x4DEC0000, sopath = "/lib/librt-2.22.so
> <http://librt-2.22.so>", size = 28380, mtime = 1532322845 }
> [22:25:34.385530165] (+0.000085781) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0x4DCB0000, sopath = "/lib/libdl-2.22.so
> <http://libdl-2.22.so>", size = 11236, mtime = 1532322845 }
> [22:25:34.385607613] (+0.000077448) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0x4DE10000, sopath =
> "/usr/lib/liburcu-bp.so.2.0.0", size = 29052, mtime = 1532323584 }
> [22:25:34.385677978] (+0.000070365) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0x4DE00000, sopath =
> "/usr/lib/liburcu-cds.so.2.0.0", size = 26152, mtime = 1532323584 }
> [22:25:34.385773655] (+0.000095677) ZZZ ust_baddr_statedump:soinfo: {
> cpu_id = 2 }, { baddr = 0x4DD60000, sopath =
> "/usr/lib/liburcu-common.so.2.0.0", size = 13084, mtime = 1532323584 }
>
> Note: I have changed the Target Name as 'ZZZ' and some of the library
> name as 'xxx' in the above log for some confidential issues.
>
>
> Please guide me where I am making mistake and Please give your input
> on how to check the application compiled with function instrument
> information for tracing. I verified that application compiled with
> debugging information, by running gdb command. Below is the output of
> gdb command,
>
> /usr/bin # gdb my_test_app
> GNU gdb (GDB) 7.9.1
> Copyright (C) 2015 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
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
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------39B493B723E7BD4D76D52E4C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
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
    0000000000001250 &lt;__cyg_profile_func_enter@plt&gt;:<br>
        1250:    ff 25 fa 2d 20 00        jmpq   *0x202dfa(%rip)       
    # 204050 <a class="moz-txt-link-rfc2396E" href="mailto:__cyg_profile_func_enter@GLIBC_2.2.5">&lt;__cyg_profile_func_enter@GLIBC_2.2.5&gt;</a><br>
    0000000000001260 &lt;__cyg_profile_func_exit@plt&gt;:<br>
        1260:    ff 25 f2 2d 20 00        jmpq   *0x202df2(%rip)       
    # 204058 <a class="moz-txt-link-rfc2396E" href="mailto:__cyg_profile_func_exit@GLIBC_2.2.5">&lt;__cyg_profile_func_exit@GLIBC_2.2.5&gt;</a><br>
        14a8:    e8 a3 fd ff ff           callq  1250
    &lt;__cyg_profile_func_enter@plt&gt;<br>
        16d8:    e8 83 fb ff ff           callq  1260
    &lt;__cyg_profile_func_exit@plt&gt;<br>
        19c5:    e8 86 f8 ff ff           callq  1250
    &lt;__cyg_profile_func_enter@plt&gt;<br>
        19e2:    e9 79 f8 ff ff           jmpq   1260
    &lt;__cyg_profile_func_exit@plt&gt;<br>
        1a0d:    e8 3e f8 ff ff           callq  1250
    &lt;__cyg_profile_func_enter@plt&gt;<br>
    <br>
    If you see nothing, as Mathieu said, you can check the individual
    make commands and see what flags are being used on the command line.<br>
    <br>
    Geneviève<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2018-07-29 09:29 PM, paramesh p
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAOG=51zc2Xu2yNd-3YWhOXZiMb7_c1xYzN_ZS1x+PHP0kRz=LA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div>
          <div>
            <div>
              <div>
                <div>Hi,</div>
                <div>   I am trying to use Function Tracing for my
                  application running in 32-bit ARM Platform. I have
                  added below lines in my makefile for enabling Trace
                  Data for function tracing </div>
                <div><br>
                </div>
                <div>AM_CFLAGS += -g -O0 -finstrument-functions</div>
                <div>AM_CXXFLAGS += -g -O0 -finstrument-functions </div>
                <div><br>
                </div>
                <div>**(My App have both C &amp;&amp; CPP files, So I
                  added CFLAGS &amp; CXXFLAGS). </div>
                <div><br>
                </div>
                <div>I am running below commands,</div>
                <div><span style="white-space:pre">	</span>$lttng create
                  session1</div>
                <div><span style="white-space:pre">	</span>$lttng
                  enable-event -u -a --loglevel-only
                  TRACE_DEBUG_FUNCTION</div>
                <div><span style="white-space:pre">	</span>$lttng start</div>
                <div><span style="white-space:pre">	</span>$LD_PRELOAD=liblttng-ust-cyg-profile.so.0.0.0
                  my_test_app </div>
                <div><span style="white-space:pre">	</span>$lttng start</div>
                <div><span style="white-space:pre">	</span>$babeltrace
                  /home/root/lttng-traces/session1</div>
                <div><br>
                </div>
                <div>Its showing nothing.</div>
                <div><br>
                </div>
                <div>I tried with below event-enable command also. There
                  is no data</div>
                <div><span style="white-space:pre">	</span>$lttng
                  enable-event -u -a --loglevel TRACE_DEBUG_FUNCTION </div>
                <div><br>
                </div>
                <div>But If I use the command, "lttng enable-event -u
                  -a"  for enabling the event, I am getting below output
                  from babeltrace,</div>
                <div><br>
                </div>
                <div>[22:25:30.812389281] (+?.?????????) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0xAD1A9000, sopath =
                  "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size =
                  10004, mtime = 1532324280 }</div>
                <div>[22:25:30.812496469] (+0.000107188) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DFF0000, sopath = "/usr/lib/xxx.so", size = 19540,
                  mtime = 1532369202 }</div>
                <div>[22:25:30.812604177] (+0.000107708) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4E120000, sopath = "/usr/lib/libcutils.so.0.0.0",
                  size = 48624, mtime = 1532323462 }</div>
                <div>[22:25:30.812655219] (+0.000051042) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DC80000, sopath = "/lib/<a
                    href="http://libpthread-2.22.so"
                    moz-do-not-send="true">libpthread-2.22.so</a>", size
                  = 94976, mtime = 1532322845 }</div>
                <div>[22:25:30.812701677] (+0.000046458) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DB20000, sopath = "/lib/<a
                    href="http://libc-2.22.so" moz-do-not-send="true">libc-2.22.so</a>",
                  size = 1304484, mtime = 1532322845 }</div>
                <div>[22:25:30.812757927] (+0.000056250) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0xAD15B000, sopath = "/usr/lib/liblttng-ust.so.0.0.0",
                  size = 315248, mtime = 1532324280 }</div>
                <div>[22:25:30.812814229] (+0.000056302) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0xAD149000, sopath =
                  "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size =
                  35624, mtime = 1532324280 }</div>
                <div>[22:25:30.812860635] (+0.000046406) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DEC0000, sopath = "/lib/<a
                    href="http://librt-2.22.so" moz-do-not-send="true">librt-2.22.so</a>",
                  size = 28380, mtime = 1532322845 }</div>
                <div>[22:25:30.812904438] (+0.000043803) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DCB0000, sopath = "/lib/<a
                    href="http://libdl-2.22.so" moz-do-not-send="true">libdl-2.22.so</a>",
                  size = 11236, mtime = 1532322845 }</div>
                <div>[22:25:30.812959125] (+0.000054687) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DE10000, sopath = "/usr/lib/liburcu-bp.so.2.0.0",
                  size = 29052, mtime = 1532323584 }</div>
                <div>[22:25:30.813013969] (+0.000054844) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DE00000, sopath = "/usr/lib/liburcu-cds.so.2.0.0",
                  size = 26152, mtime = 1532323584 }</div>
                <div>[22:25:30.813485479] (+0.000471510) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DD60000, sopath =
                  "/usr/lib/liburcu-common.so.2.0.0", size = 13084,
                  mtime = 1532323584 }</div>
                <div>[22:25:30.813600792] (+0.000115313) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DAE0000, sopath = "/lib/<a href="http://ld-2.22.so"
                    moz-do-not-send="true">ld-2.22.so</a>", size =
                  139632, mtime = 1532322845 }</div>
                <div>[22:25:30.813663656] (+0.000062864) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DFC0000, sopath = "/usr/lib/xxx.so.1.0.0", size =
                  19456, mtime = 1532323510 }</div>
                <div>[22:25:30.813720635] (+0.000056979) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4E030000, sopath = "/usr/lib/xxx.so.1.6.0", size =
                  142164, mtime = 1532323441 }</div>
                <div>[22:25:30.813776990] (+0.000056355) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4E060000, sopath = "/usr/lib/xxx.so.0.0.0", size =
                  265304, mtime = 1532324468 }</div>
                <div>[22:25:30.813843917] (+0.000066927) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DEA0000, sopath = "/usr/lib/xxx.so.0.0.0", size =
                  84016, mtime = 1532324363 }</div>
                <div>[22:25:30.813884385] (+0.000040468) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DFE0000, sopath = "/usr/lib/xxx.so", size = 34204,
                  mtime = 1532324426 }</div>
                <div>[22:25:30.813940479] (+0.000056094) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DFD0000, sopath = "/usr/lib/xxx.so", size = 7388,
                  mtime = 1532324388 }</div>
                <div>[22:25:30.813993604] (+0.000053125) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4E000000, sopath = "/usr/lib/xxx.so", size = 33152,
                  mtime = 1532323414 }</div>
                <div>[22:25:30.814049333] (+0.000055729) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DEE0000, sopath = "/usr/lib/libstdc++.so.6.0.20",
                  size = 869236, mtime = 1532323320 }</div>
                <div>[22:25:30.814094177] (+0.000044844) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DCD0000, sopath = "/lib/<a
                    href="http://libm-2.22.so" moz-do-not-send="true">libm-2.22.so</a>",
                  size = 441372, mtime = 1532322845 }</div>
                <div>[22:25:30.814234177] (+0.000140000) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DE80000, sopath = "/lib/libgcc_s.so.1", size =
                  118608, mtime = 1532323098 }</div>
                <div>[22:25:30.814427615] (+0.000193438) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x8000, sopath = "<span
                    style="background-color:rgb(255,255,0)">/usr/bin/my_test_app</span>",
                  size = 54540, mtime = 1532369202 }</div>
                <div>[22:25:30.828436677] (+0.014009062) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0xAEC57000, sopath =
                  "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size =
                  10004, mtime = 1532324280 }</div>
                <div>[22:25:30.828634958] (+0.000198281) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 1 }, { baddr =
                  0x4DCD0000, sopath = "/lib/<a
                    href="http://libm-2.22.so" moz-do-not-send="true">libm-2.22.so</a>",
                  size = 441372, mtime = 1532322845 }</div>
                <div>[22:25:30.829786104] (+0.001151146) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0x4DB20000, sopath = "/lib/<a
                    href="http://libc-2.22.so" moz-do-not-send="true">libc-2.22.so</a>",
                  size = 1304484, mtime = 1532322845 }</div>
                <div>[22:25:30.829910219] (+0.000124115) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0xAEC09000, sopath = "/usr/lib/liblttng-ust.so.0.0.0",
                  size = 315248, mtime = 1532324280 }</div>
                <div>[22:25:30.829996000] (+0.000085781) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0xAEBF7000, sopath =
                  "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size =
                  35624, mtime = 1532324280 }</div>
                <div>[22:25:30.830067510] (+0.000071510) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0x4DEC0000, sopath = "/lib/<a
                    href="http://librt-2.22.so" moz-do-not-send="true">librt-2.22.so</a>",
                  size = 28380, mtime = 1532322845 }</div>
                <div>[22:25:30.830118031] (+0.000050521) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0x4DCB0000, sopath = "/lib/<a
                    href="http://libdl-2.22.so" moz-do-not-send="true">libdl-2.22.so</a>",
                  size = 11236, mtime = 1532322845 }</div>
                <div>[22:25:30.830175010] (+0.000056979) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0x4DE10000, sopath = "/usr/lib/liburcu-bp.so.2.0.0",
                  size = 29052, mtime = 1532323584 }</div>
                <div>[22:25:30.830245271] (+0.000070261) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0x4DE00000, sopath = "/usr/lib/liburcu-cds.so.2.0.0",
                  size = 26152, mtime = 1532323584 }</div>
                <div>[22:25:30.830316521] (+0.000071250) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 0 }, { baddr =
                  0x4DD60000, sopath =
                  "/usr/lib/liburcu-common.so.2.0.0", size = 13084,
                  mtime = 1532323584 }</div>
                <div>[22:25:34.384458499] (+3.554141978) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0xAF584000, sopath =
                  "/usr/lib/liblttng-ust-cyg-profile.so.0.0.0", size =
                  10004, mtime = 1532324280 }</div>
                <div>[22:25:34.385048967] (+0.000590468) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0x4DCD0000, sopath = "/lib/<a
                    href="http://libm-2.22.so" moz-do-not-send="true">libm-2.22.so</a>",
                  size = 441372, mtime = 1532322845 }</div>
                <div>[22:25:34.385146415] (+0.000097448) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0x4DB20000, sopath = "/lib/<a
                    href="http://libc-2.22.so" moz-do-not-send="true">libc-2.22.so</a>",
                  size = 1304484, mtime = 1532322845 }</div>
                <div>[22:25:34.385251832] (+0.000105417) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0xAF536000, sopath = "/usr/lib/liblttng-ust.so.0.0.0",
                  size = 315248, mtime = 1532324280 }</div>
                <div>[22:25:34.385354228] (+0.000102396) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0xAF524000, sopath =
                  "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size =
                  35624, mtime = 1532324280 }</div>
                <div>[22:25:34.385444384] (+0.000090156) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0x4DEC0000, sopath = "/lib/<a
                    href="http://librt-2.22.so" moz-do-not-send="true">librt-2.22.so</a>",
                  size = 28380, mtime = 1532322845 }</div>
                <div>[22:25:34.385530165] (+0.000085781) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0x4DCB0000, sopath = "/lib/<a
                    href="http://libdl-2.22.so" moz-do-not-send="true">libdl-2.22.so</a>",
                  size = 11236, mtime = 1532322845 }</div>
                <div>[22:25:34.385607613] (+0.000077448) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0x4DE10000, sopath = "/usr/lib/liburcu-bp.so.2.0.0",
                  size = 29052, mtime = 1532323584 }</div>
                <div>[22:25:34.385677978] (+0.000070365) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0x4DE00000, sopath = "/usr/lib/liburcu-cds.so.2.0.0",
                  size = 26152, mtime = 1532323584 }</div>
                <div>[22:25:34.385773655] (+0.000095677) ZZZ
                  ust_baddr_statedump:soinfo: { cpu_id = 2 }, { baddr =
                  0x4DD60000, sopath =
                  "/usr/lib/liburcu-common.so.2.0.0", size = 13084,
                  mtime = 1532323584 }</div>
                <div><br>
                </div>
                <div>Note: I have changed the Target Name as 'ZZZ' and
                  some of the library name as 'xxx' in the above log for
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
                <div><span style="white-space:pre">	</span>/usr/bin #
                  gdb <span style="background-color:rgb(255,255,0)">my_test_app</span></div>
                <div><span style="white-space:pre">	</span>GNU gdb (GDB)
                  7.9.1</div>
                <div><span style="white-space:pre">	</span>Copyright (C)
                  2015 Free Software Foundation, Inc.</div>
                <div><span style="white-space:pre">	</span>License
                  GPLv3+: GNU GPL version 3 or later &lt;<a
                    href="http://gnu.org/licenses/gpl.html"
                    moz-do-not-send="true">http://gnu.org/licenses/gpl.html</a>&gt;</div>
                <div><span style="white-space:pre">	</span>This is free
                  software: you are free to change and redistribute it.</div>
                <div><span style="white-space:pre">	</span>There is NO
                  WARRANTY, to the extent permitted by law.  Type "show
                  copying"</div>
                <div><span style="white-space:pre">	</span>and "show
                  warranty" for details.</div>
                <div><span style="white-space:pre">	</span>This GDB was
                  configured as "arm-oe-linux-gnueabi".</div>
                <div><span style="white-space:pre">	</span>Type "show
                  configuration" for configuration details.</div>
                <div><span style="white-space:pre">	</span>For bug
                  reporting instructions, please see:</div>
                <div><span style="white-space:pre">	</span>&lt;<a
                    href="http://www.gnu.org/software/gdb/bugs/"
                    moz-do-not-send="true">http://www.gnu.org/software/gdb/bugs/</a>&gt;.</div>
                <div><span style="white-space:pre">	</span>Find the GDB
                  manual and other documentation resources online at:</div>
                <div><span style="white-space:pre">	</span>&lt;<a
                    href="http://www.gnu.org/software/gdb/documentation/"
                    moz-do-not-send="true">http://www.gnu.org/software/gdb/documentation/</a>&gt;.</div>
                <div><span style="white-space:pre">	</span>For help,
                  type "help".</div>
                <div><span style="white-space:pre">	</span>Type "apropos
                  word" to search for commands related to "word"...</div>
                <div><span style="white-space:pre">	</span>Reading
                  symbols from <span
                    style="background-color:rgb(255,255,0)">my_test_app</span>...done.</div>
                <div><span style="white-space:pre">	</span>(gdb)</div>
                <div><span style="white-space:pre">	</span>(gdb) exit</div>
                <div><span style="white-space:pre">	</span></div>
                <div>I am not sure whether it is compiled with
                  finstrumentation information.</div>
                <div><br>
                </div>
                <div>Thanks in Advance,</div>
                <div>Paramesh </div>
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
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------39B493B723E7BD4D76D52E4C--

--===============1080236379541552275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1080236379541552275==--
