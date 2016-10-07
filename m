From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng sessiond hash table crashes.
Date: Fri, 7 Oct 2016 14:35:15 +0000 (UTC)
Message-ID: <1733583412.50054.1475850915243.JavaMail.zimbra__40937.1330090382$1475850862$gmane$org@efficios.com>
References: <CACd+_b6tfbyesNVT-xHjb=cjjSD=6wThFRVKazs4MV11=xCo9A@mail.gmail.com>
 <23555011.49962.1475845152312.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0258220242313430145=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 91D9DA44D8
 for <lttng-dev@lists.lttng.org>; Fri,  7 Oct 2016 14:35:45 +0000 (UTC)
In-Reply-To: <23555011.49962.1475845152312.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aravind HT <aravind.ht@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0258220242313430145==
Content-Type: multipart/alternative;
	boundary="=_e581e14f-4895-406b-b70b-f44487b460b8"

--=_e581e14f-4895-406b-b70b-f44487b460b8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 7, 2016, at 8:59 AM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote: 

> ----- On Oct 7, 2016, at 6:46 AM, Aravind HT <aravind.ht@gmail.com> wrote:

>> Hi,

>> I am encountering a few crashes which are all happening around the hash table
>> functions, the below are from my 2.6 version for which I have reproduced them
>> with debug symbols enabled.

> Hi Aravind,

> We do not support LTTng 2.6 anymore. Let us know if you can reproduce with
> LTTng 2.8 or master.

Hi, 

I noticed that further down below, you reproduced with 2.8. Please 
provide backtrace with debug information, of a build without optimisation. 
If you can provide a reproducer it would also help. 

Ref. https://lttng.org/community/#bug-reporting-guidelines 

Thanks, 

Mathieu 

> Thanks,

> Mathieu

>> 2.6 SCENARIO 1

>> (gdb) bt

>> Python Exception <type 'exceptions.ImportError'> No module named gdb.frames:

>> #0 lttng_ht_lookup (ht=0x6888f0, key=key@entry=0x4b,
>> iter=iter@entry=0x7f318fffeae0) at hashtable.c:236

>> #1 0x0000000000429900 in ust_app_unregister (sock=sock@entry=75) at
>> ust-app.c:3105

>> #2 0x000000000043918a in thread_manage_apps (data=<optimized out>) at
>> main.c:1558

>> #3 0x00007f3197c74294 in start_thread (arg=0x7f318ffff700) at
>> pthread_create.c:336

>> #4 0x00007f31979b213d in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

>> 2.6 SCENARIO 2 : Not sure why cmd_init() gets called here

>> #0 0x00007f024d68fd2c in lttng_cds_lfht_lookup (ht=0x68ac90,
>> hash=8123239074643410387, match=0x418be2 <ht_match_reg_uid>,
>> key=0x7f023affb8a0, iter=0x7f023affb900) at rculfhash.c:1535

>> #1 0x0000000000418be2 in cmd_init () at cmd.c:3332

>> #2 0x00000000004191e3 in buffer_reg_uid_find (session_id=<optimized out>,
>> bits_per_long=64, uid=0) at buffer-registry.c:198

>> #3 0x000000000042df89 in ust_consumer_metadata_request
>> (socket=socket@entry=0x67f1f0 <ustconsumer64_data+176>) at ust-consumer.c:464

>> #4 0x000000000043b0e6 in thread_manage_consumer (data=0x67f140
>> <ustconsumer64_data>) at main.c:1353

>> #5 0x00007f024c4ae294 in start_thread (arg=0x7f023affd700) at
>> pthread_create.c:336

>> #6 0x00007f024c1ec13d in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

>> (gdb)

>> 2.6 SCENARIO 3

>> (gdb) bt

>> #0 0x00007f444c017740 in ?? ()

>> #1 0x00007f44676a9b6b in bucket_at (index=<optimized out>, ht=0x7f444c00d4e0) at
>> rculfhash.c:853

>> #2 lookup_bucket (hash=4405530133935945645, size=<optimized out>,
>> ht=0x7f444c00d4e0) at rculfhash.c:861

>> #3 lttng_cds_lfht_lookup (ht=0x7f444c00d4e0, hash=4405530133935945645,
>> match=0x7f44676a7980 <match_ulong>, key=0x29, iter=iter@entry=0x7f44613d59d0)
>> at rculfhash.c:1542

>> #4 0x00007f44676a7e20 in lttng_ht_lookup (ht=<optimized out>, key=<optimized
>> out>, iter=iter@entry=0x7f44613d59d0) at hashtable.c:240

>> #5 0x0000000000412217 in consumer_find_socket (key=<optimized out>,
>> consumer=<optimized out>) at consumer.c:359

>> #6 0x0000000000000000 in ?? ()

>> I am also trying to upgrade to 2.8.1 and see similar crashes there,
>> unfortunately do not have debug symbols enabled, but crashes always in one of
>> the hash table related functions.
>> I'm in the process of enabling debug symbols on 2.8.1 so that the info that i
>> provide applies to the current version, also trying out Valgrind.

>> Let me know if you can figure something out with this.

>> 2.8.1 SCENARIO 1

>> GNU gdb (GDB) 7.8.1

>> Copyright (C) 2014 Free Software Foundation, Inc.

>> License GPLv3+: GNU GPL version 3 or later < [ http://gnu.org/licenses/gpl.html
>> | http://gnu.org/licenses/gpl.html ] >

>> This is free software: you are free to change and redistribute it.

>> There is NO WARRANTY, to the extent permitted by law. Type "show copying"

>> and "show warranty" for details.

>> This GDB was configured as "x86_64-poky-linux".

>> Type "show configuration" for configuration details.

>> For bug reporting instructions, please see:

>> < [ http://www.gnu.org/software/gdb/bugs/ |
>> http://www.gnu.org/software/gdb/bugs/ ] >.

>> Find the GDB manual and other documentation resources online at:

>> < [ http://www.gnu.org/software/gdb/documentation/ |
>> http://www.gnu.org/software/gdb/documentation/ ] >.

>> For help, type "help".

>> Type "apropos word" to search for commands related to "word"...

>> Reading symbols from /usr/bin/lttng-sessiond...(no debugging symbols
>> found)...done.

>> [New LWP 1134]

>> [New LWP 1090]

>> [New LWP 1091]

>> [New LWP 1092]

>> [New LWP 1093]

>> [New LWP 1095]

>> [New LWP 1098]

>> [New LWP 1102]

>> [New LWP 1110]

>> [New LWP 1096]

>> [New LWP 1094]

>> [New LWP 1097]

>> warning: Could not load shared library symbols for linux-vdso.so.1.

>> Do you need "set solib-search-path" or "set sysroot"?

>> [Thread debugging using libthread_db enabled]

>> Using host libthread_db library "/lib64/libthread_db.so.1".

>> Core was generated by `/usr/bin/lttng-sessiond --consumerd32-path
>> /usr/lib/lttng/libexec/lttng-consume'.

>> Program terminated with signal SIGSEGV, Segmentation fault.

>> #0 0x0000000000000000 in ?? ()

>> (gdb) bt

>> Python Exception <type 'exceptions.ImportError'> No module named gdb.frames:

>> #0 0x0000000000000000 in ?? ()

>> #1 0x00007f1b39b1db6b in lttng_cds_lfht_lookup () from
>> /usr/lib64/liblttng-ctl.so.0

>> #2 0x0000000000412217 in ?? ()

>> #3 0x0000000000412263 in ?? ()

>> #4 0x0000000000427de8 in ?? ()

>> #5 0x0000000000427ed1 in ?? ()

>> #6 0x00000000004280d3 in ?? ()

>> #7 0x00007f1b398facad in ?? () from /usr/lib64/liburcu.so.2

>> #8 0x00007f1b3893d294 in start_thread (arg=0x7f1b1e7fc700) at
>> pthread_create.c:336

>> #9 0x00007f1b3867b13d in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

>> (gdb) q

>> 2.8.1 SCENARIO 2

>> GNU gdb (GDB) 7.8.1

>> Copyright (C) 2014 Free Software Foundation, Inc.

>> License GPLv3+: GNU GPL version 3 or later < [ http://gnu.org/licenses/gpl.html
>> | http://gnu.org/licenses/gpl.html ] >

>> This is free software: you are free to change and redistribute it.

>> There is NO WARRANTY, to the extent permitted by law. Type "show copying"

>> and "show warranty" for details.

>> This GDB was configured as "x86_64-poky-linux".

>> Type "show configuration" for configuration details.

>> For bug reporting instructions, please see:

>> < [ http://www.gnu.org/software/gdb/bugs/ |
>> http://www.gnu.org/software/gdb/bugs/ ] >.

>> Find the GDB manual and other documentation resources online at:

>> < [ http://www.gnu.org/software/gdb/documentation/ |
>> http://www.gnu.org/software/gdb/documentation/ ] >.

>> For help, type "help".

>> Type "apropos word" to search for commands related to "word"...

>> Reading symbols from /usr/bin/lttng-sessiond...(no debugging symbols
>> found)...done.

>> [New LWP 637]

>> [New LWP 610]

>> [New LWP 613]

>> [New LWP 624]

>> [New LWP 605]

>> [New LWP 608]

>> [New LWP 607]

>> [New LWP 609]

>> [New LWP 612]

>> [New LWP 606]

>> [New LWP 611]

>> [New LWP 616]

>> warning: Could not load shared library symbols for linux-vdso.so.1.

>> Do you need "set solib-search-path" or "set sysroot"?

>> [Thread debugging using libthread_db enabled]

>> Using host libthread_db library "/lib64/libthread_db.so.1".

>> Core was generated by `/usr/bin/lttng-sessiond --consumerd32-path
>> /usr/lib/lttng/libexec/lttng-consume'.

>> Program terminated with signal SIGSEGV, Segmentation fault.

>> #0 0x0000000000000020 in ?? ()

>> (gdb) bt

>> Python Exception <type 'exceptions.ImportError'> No module named gdb.frames:

>> #0 0x0000000000000020 in ?? ()

>> #1 0x00007ff010197e02 in lttng_ht_lookup () from /usr/lib64/liblttng-ctl.so.0

>> #2 0x0000000000412217 in ?? ()

>> #3 0x0000000000412263 in ?? ()

>> #4 0x0000000000427de8 in ?? ()

>> #5 0x0000000000427ed1 in ?? ()

>> #6 0x00000000004280d3 in ?? ()

>> #7 0x00007ff00ff76cad in ?? () from /usr/lib64/liburcu.so.2

>> #8 0x00007ff00efb9294 in start_thread (arg=0x7ff0096c5700) at
>> pthread_create.c:336

>> #9 0x00007ff00ecf713d in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

>> (gdb) q

>> Regards,
>> Aravind.

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_e581e14f-4895-406b-b70b-f44487b460b8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Oct 7, 2016, at 8:59 AM, Mathieu Desn=
oyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span><div data-mar=
ker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;=
margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:n=
ormal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size=
:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif; font-size:=
 12pt; color: #000000"><br><span id=3D"zwchr">----- On Oct 7, 2016, at 6:46=
 AM, Aravind HT &lt;aravind.ht@gmail.com&gt; wrote:<br></span><div><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><span s=
tyle=3D"background-color: #ffffff; color: #000000; font-family: times new r=
oman,serif;">Hi,</span><div><span style=3D"background-color: #ffffff; color=
: #000000; font-family: times new roman,serif;"><br></span></div><div><span=
 style=3D"background-color: #ffffff; color: #000000; font-family: times new=
 roman,serif;">I am encountering a few crashes which are all happening arou=
nd the hash table functions, the below are from my 2.6 version for which I =
have reproduced them with debug symbols enabled.</span></div></div></blockq=
uote><br><div>Hi Aravind,<br></div><br><div>We do not support LTTng 2.6 any=
more. Let us know if you can reproduce with<br></div><div>LTTng 2.8 or mast=
er.</div></div></div></blockquote><div><br></div><div>Hi,<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I noticed that furthe=
r down below, you reproduced with 2.8. Please<br data-mce-bogus=3D"1"></div=
><div>provide backtrace with debug information, of a build without optimisa=
tion.<br data-mce-bogus=3D"1"></div><div>If you can provide a reproducer it=
 would also help.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"=
1"></div><div>Ref. https://lttng.org/community/#bug-reporting-guidelines<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks=
,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Ma=
thieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid=
 #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fon=
t-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;=
font-size:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif; f=
ont-size: 12pt; color: #000000"><div><div><br></div><br><div>Thanks,<br></d=
iv><br><div>Mathieu<br></div><br><br><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;"><div dir=3D"ltr"><div><p class=3D"MsoNormal"><b><span =
style=3D"background-color: #ffffff; color: #000000; font-family: times new =
roman,serif;">2.6 SCENARIO
1</span></b></p><p class=3D"MsoNormal"><span style=3D"background-color: #ff=
ffff; color: #000000; font-family: times new roman,serif;">(gdb)
bt</span></p><p class=3D"MsoNormal"><span style=3D"background-color: #fffff=
f; color: #000000; font-family: times new roman,serif;">Python
Exception &lt;type 'exceptions.ImportError'&gt; No module named gdb.frames:=
</span></p><p class=3D"MsoNormal"><span style=3D"background-color: #ffffff;=
 color: #000000; font-family: times new roman,serif;">#0&nbsp;
lttng_ht_lookup (ht=3D0x6888f0, key=3Dkey@entry=3D0x4b,
iter=3Diter@entry=3D0x7f318fffeae0) at hashtable.c:236</span></p><p class=
=3D"MsoNormal"><span style=3D"background-color: #ffffff; color: #000000; fo=
nt-family: times new roman,serif;">#1&nbsp;
0x0000000000429900 in ust_app_unregister (sock=3Dsock@entry=3D75) at ust-ap=
p.c:3105</span></p><p class=3D"MsoNormal"><span style=3D"background-color: =
#ffffff; color: #000000; font-family: times new roman,serif;">#2&nbsp;
0x000000000043918a in thread_manage_apps (data=3D&lt;optimized out&gt;) at
main.c:1558</span></p><p class=3D"MsoNormal"><span style=3D"background-colo=
r: #ffffff; color: #000000; font-family: times new roman,serif;">#3&nbsp;
0x00007f3197c74294 in start_thread (arg=3D0x7f318ffff700) at pthread_create=
.c:336</span></p><p class=3D"MsoNormal"><span style=3D"background-color: #f=
fffff; color: #000000; font-family: times new roman,serif;">#4&nbsp;
0x00007f31979b213d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S=
:109</span></p><p class=3D"MsoNormal"><span style=3D"background-color: #fff=
fff; color: #000000; font-family: times new roman,serif;">&nbsp;</span></p>=
<p class=3D"MsoNormal"><span style=3D"background-color: #ffffff; color: #00=
0000; font-family: times new roman,serif;"><b>2.6&nbsp;</b><b>SCENARIO
2 : Not sure why cmd_init() gets called here&nbsp;</b></span></p><p class=
=3D"MsoNormal"><span style=3D"background-color: #ffffff; color: #000000; fo=
nt-family: times new roman,serif;">#0&nbsp;
0x00007f024d68fd2c in lttng_cds_lfht_lookup (ht=3D0x68ac90,
hash=3D8123239074643410387, match=3D0x418be2 &lt;ht_match_reg_uid&gt;,
key=3D0x7f023affb8a0, iter=3D0x7f023affb900) at rculfhash.c:1535</span></p>=
<p class=3D"MsoNormal"><span style=3D"background-color: #ffffff; color: #00=
0000; font-family: times new roman,serif;">#1&nbsp;
0x0000000000418be2 in cmd_init () at cmd.c:3332</span></p><p class=3D"MsoNo=
rmal"><span style=3D"background-color: #ffffff; color: #000000; font-family=
: times new roman,serif;">#2&nbsp;
0x00000000004191e3 in buffer_reg_uid_find (session_id=3D&lt;optimized out&g=
t;,
bits_per_long=3D64, uid=3D0) at buffer-registry.c:198</span></p><p class=3D=
"MsoNormal"><span style=3D"background-color: #ffffff; color: #000000; font-=
family: times new roman,serif;">#3&nbsp;
0x000000000042df89 in ust_consumer_metadata_request (socket=3Dsocket@entry=
=3D0x67f1f0
&lt;ustconsumer64_data+176&gt;) at ust-consumer.c:464</span></p><p class=3D=
"MsoNormal"><span style=3D"background-color: #ffffff; color: #000000; font-=
family: times new roman,serif;">#4&nbsp;
0x000000000043b0e6 in thread_manage_consumer (data=3D0x67f140
&lt;ustconsumer64_data&gt;) at main.c:1353</span></p><p class=3D"MsoNormal"=
><span style=3D"background-color: #ffffff; color: #000000; font-family: tim=
es new roman,serif;">#5&nbsp;
0x00007f024c4ae294 in start_thread (arg=3D0x7f023affd700) at pthread_create=
.c:336</span></p><p class=3D"MsoNormal"><span style=3D"background-color: #f=
fffff; color: #000000; font-family: times new roman,serif;">#6&nbsp;
0x00007f024c1ec13d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S=
:109</span></p><p class=3D"MsoNormal"><span style=3D"background-color: #fff=
fff; color: #000000; font-family: times new roman,serif;">(gdb)</span></p><=
p class=3D"MsoNormal"><span style=3D"background-color: #ffffff; color: #000=
000; font-family: times new roman,serif;">&nbsp;</span></p><p class=3D"MsoN=
ormal"><span style=3D"background-color: #ffffff; color: #000000; font-famil=
y: times new roman,serif;"><b>2.6&nbsp;</b><b>SCENARIO
3</b></span></p><p class=3D"MsoNormal"><span style=3D"background-color: #ff=
ffff; color: #000000; font-family: times new roman,serif;">(gdb)
bt</span></p><p class=3D"MsoNormal"><span style=3D"background-color: #fffff=
f; color: #000000; font-family: times new roman,serif;">#0&nbsp;
0x00007f444c017740 in ?? ()</span></p><p class=3D"MsoNormal"><span style=3D=
"background-color: #ffffff; color: #000000; font-family: times new roman,se=
rif;">#1&nbsp;
0x00007f44676a9b6b in bucket_at (index=3D&lt;optimized out&gt;,
ht=3D0x7f444c00d4e0) at rculfhash.c:853</span></p><p class=3D"MsoNormal"><s=
pan style=3D"background-color: #ffffff; color: #000000; font-family: times =
new roman,serif;">#2&nbsp;
lookup_bucket (hash=3D4405530133935945645, size=3D&lt;optimized out&gt;,
ht=3D0x7f444c00d4e0) at rculfhash.c:861</span></p><p class=3D"MsoNormal"><s=
pan style=3D"background-color: #ffffff; color: #000000; font-family: times =
new roman,serif;">#3&nbsp;
lttng_cds_lfht_lookup (ht=3D0x7f444c00d4e0, hash=3D4405530133935945645,
match=3D0x7f44676a7980 &lt;match_ulong&gt;, key=3D0x29,
iter=3Diter@entry=3D0x7f44613d59d0) at rculfhash.c:1542</span></p><p class=
=3D"MsoNormal"><span style=3D"background-color: #ffffff; color: #000000; fo=
nt-family: times new roman,serif;">#4&nbsp;
0x00007f44676a7e20 in lttng_ht_lookup (ht=3D&lt;optimized out&gt;,
key=3D&lt;optimized out&gt;, iter=3Diter@entry=3D0x7f44613d59d0) at hashtab=
le.c:240</span></p><p class=3D"MsoNormal"><span style=3D"background-color: =
#ffffff; color: #000000; font-family: times new roman,serif;">#5&nbsp;
0x0000000000412217 in consumer_find_socket (key=3D&lt;optimized out&gt;,
consumer=3D&lt;optimized out&gt;) at consumer.c:359</span></p><p class=3D"M=
soNormal"><span style=3D"background-color: #ffffff; color: #000000; font-fa=
mily: times new roman,serif;">#6&nbsp;
0x0000000000000000 in ?? ()</span></p><p class=3D"MsoNormal"><span style=3D=
"background-color: #ffffff; color: #000000; font-family: times new roman,se=
rif;"><br></span></p><p class=3D"MsoNormal"><span style=3D"background-color=
: #ffffff; color: #000000; font-family: times new roman,serif;">I am also t=
rying to upgrade to 2.8.1 and see similar crashes there, unfortunately do n=
ot have debug symbols enabled, but crashes always in one of the hash table =
related functions.</span></p><div><span style=3D"background-color: #ffffff;=
 color: #000000; font-family: times new roman,serif;">I'm in the process of=
 enabling debug symbols on 2.8.1 so that the info that i provide applies to=
 the current version, also trying out Valgrind.</span></div><div><span styl=
e=3D"background-color: #ffffff; color: #000000; font-family: times new roma=
n,serif;"><br></span></div><div><span style=3D"background-color: #ffffff; c=
olor: #000000; font-family: times new roman,serif;">Let me know if you can =
figure something out with this.</span></div><div><span style=3D"background-=
color: #ffffff; color: #000000; font-family: times new roman,serif;"><br></=
span></div><p class=3D"MsoNormal"><span style=3D"background-color: #ffffff;=
 color: #000000; font-family: times new roman,serif;"><b>2.8.1 SCENARIO 1</=
b>&nbsp;</span></p><p class=3D"MsoNormal"><span style=3D"background-color:r=
gb(255,255,255)"><span style=3D"color: #000000; font-family: times new roma=
n,serif;">GNU gdb (GDB) 7.8.1</span></span></p><p class=3D"MsoNormal"><span=
 style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000;=
 font-family: times new roman,serif;">Copyright (C) 2014 Free Software Foun=
dation, Inc.</span></span></p><p class=3D"MsoNormal"><span style=3D"backgro=
und-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: tim=
es new roman,serif;">License GPLv3+: GNU GPL version 3 or later &lt;<a href=
=3D"http://gnu.org/licenses/gpl.html" target=3D"_blank">http://gnu.org/lice=
nses/gpl.html</a>&gt;</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">This is free software: you are free to chan=
ge and redistribute
it.</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color=
:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times new ro=
man,serif;">There is NO WARRANTY, to the extent permitted by law.&nbsp; Typ=
e
"show copying"</span></span></p><p class=3D"MsoNormal"><span style=3D"backg=
round-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: t=
imes new roman,serif;">and "show warranty" for details.</span></span></p><p=
 class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><spa=
n style=3D"color: #000000; font-family: times new roman,serif;">This GDB wa=
s configured as "x86_64-poky-linux".</span></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #=
000000; font-family: times new roman,serif;">Type "show configuration" for =
configuration details.</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">For bug reporting instructions, please see:=
</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rg=
b(255,255,255)"><span style=3D"color: #000000; font-family: times new roman=
,serif;">&lt;<a href=3D"http://www.gnu.org/software/gdb/bugs/" target=3D"_b=
lank">http://www.gnu.org/software/gdb/bugs/</a>&gt;.</span></span></p><p cl=
ass=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span s=
tyle=3D"color: #000000; font-family: times new roman,serif;">Find the GDB m=
anual and other documentation resources online at:</span></span></p><p clas=
s=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span sty=
le=3D"color: #000000; font-family: times new roman,serif;">&lt;<a href=3D"h=
ttp://www.gnu.org/software/gdb/documentation/" target=3D"_blank">http://www=
.gnu.org/software/gdb/documentation/</a>&gt;.</span></span></p><p class=3D"=
MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D=
"color: #000000; font-family: times new roman,serif;">For help, type "help"=
.</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:r=
gb(255,255,255)"><span style=3D"color: #000000; font-family: times new roma=
n,serif;">Type "apropos word" to search for commands related to
"word"...</span></span></p><p class=3D"MsoNormal"><span style=3D"background=
-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times =
new roman,serif;">Reading symbols from /usr/bin/lttng-sessiond...(no debugg=
ing
symbols found)...done.</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">[New LWP 1134]</span></span></p><p class=3D=
"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=
=3D"color: #000000; font-family: times new roman,serif;">[New LWP 1090]</sp=
an></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(25=
5,255,255)"><span style=3D"color: #000000; font-family: times new roman,ser=
if;">[New LWP 1091]</span></span></p><p class=3D"MsoNormal"><span style=3D"=
background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-fami=
ly: times new roman,serif;">[New LWP 1092]</span></span></p><p class=3D"Mso=
Normal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"co=
lor: #000000; font-family: times new roman,serif;">[New LWP 1093]</span></s=
pan></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,=
255)"><span style=3D"color: #000000; font-family: times new roman,serif;">[=
New LWP 1095]</span></span></p><p class=3D"MsoNormal"><span style=3D"backgr=
ound-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: ti=
mes new roman,serif;">[New LWP 1098]</span></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #=
000000; font-family: times new roman,serif;">[New LWP 1102]</span></span></=
p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)">=
<span style=3D"color: #000000; font-family: times new roman,serif;">[New LW=
P 1110]</span></span></p><p class=3D"MsoNormal"><span style=3D"background-c=
olor:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times ne=
w roman,serif;">[New LWP 1096]</span></span></p><p class=3D"MsoNormal"><spa=
n style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000=
; font-family: times new roman,serif;">[New LWP 1094]</span></span></p><p c=
lass=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span =
style=3D"color: #000000; font-family: times new roman,serif;">[New LWP 1097=
]</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:r=
gb(255,255,255)"><span style=3D"color: #000000; font-family: times new roma=
n,serif;">&nbsp;</span></span></p><p class=3D"MsoNormal"><span style=3D"bac=
kground-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family:=
 times new roman,serif;">warning: Could not load shared library symbols for
linux-vdso.so.1.</span></span></p><p class=3D"MsoNormal"><span style=3D"bac=
kground-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family:=
 times new roman,serif;">Do you need "set solib-search-path" or "set
sysroot"?</span></span></p><p class=3D"MsoNormal"><span style=3D"background=
-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times =
new roman,serif;">[Thread debugging using libthread_db enabled]</span></spa=
n></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,25=
5)"><span style=3D"color: #000000; font-family: times new roman,serif;">Usi=
ng host libthread_db library
"/lib64/libthread_db.so.1".</span></span></p><p class=3D"MsoNormal"><span s=
tyle=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; f=
ont-family: times new roman,serif;">Core was generated by `/usr/bin/lttng-s=
essiond
--consumerd32-path /usr/lib/lttng/libexec/lttng-consume'.</span></span></p>=
<p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><s=
pan style=3D"color: #000000; font-family: times new roman,serif;">Program t=
erminated with signal SIGSEGV, Segmentation fault.</span></span></p><p clas=
s=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span sty=
le=3D"color: #000000; font-family: times new roman,serif;">#0&nbsp; 0x00000=
00000000000 in ?? ()</span></span></p><p class=3D"MsoNormal"><span style=3D=
"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-fam=
ily: times new roman,serif;">(gdb) bt</span></span></p><p class=3D"MsoNorma=
l"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"color: =
#000000; font-family: times new roman,serif;">Python Exception &lt;type 'ex=
ceptions.ImportError'&gt; No module
named gdb.frames: </span></span></p><p class=3D"MsoNormal"><span style=3D"b=
ackground-color:rgb(255,255,255)"><span style=3D"color: #000000; font-famil=
y: times new roman,serif;">#0&nbsp; 0x0000000000000000 in ?? ()</span></spa=
n></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,25=
5)"><span style=3D"color: #000000; font-family: times new roman,serif;">#1&=
nbsp; 0x00007f1b39b1db6b in lttng_cds_lfht_lookup () from
/usr/lib64/liblttng-ctl.so.0</span></span></p><p class=3D"MsoNormal"><span =
style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; =
font-family: times new roman,serif;">#2&nbsp; 0x0000000000412217 in ?? ()</=
span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(=
255,255,255)"><span style=3D"color: #000000; font-family: times new roman,s=
erif;">#3&nbsp; 0x0000000000412263 in ?? ()</span></span></p><p class=3D"Ms=
oNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"c=
olor: #000000; font-family: times new roman,serif;">#4&nbsp; 0x000000000042=
7de8 in ?? ()</span></span></p><p class=3D"MsoNormal"><span style=3D"backgr=
ound-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: ti=
mes new roman,serif;">#5&nbsp; 0x0000000000427ed1 in ?? ()</span></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
span style=3D"color: #000000; font-family: times new roman,serif;">#6&nbsp;=
 0x00000000004280d3 in ?? ()</span></span></p><p class=3D"MsoNormal"><span =
style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; =
font-family: times new roman,serif;">#7&nbsp; 0x00007f1b398facad in ?? () f=
rom
/usr/lib64/liburcu.so.2</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">#8&nbsp; 0x00007f1b3893d294 in start_thread=
 (arg=3D0x7f1b1e7fc700)
at pthread_create.c:336</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">#9&nbsp; 0x00007f1b3867b13d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109</span></span></p><p class=3D"=
MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D=
"color: #000000; font-family: times new roman,serif;">(gdb) q</span></span>=
</p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)=
"><span style=3D"color: #000000; font-family: times new roman,serif;"><br><=
/span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb=
(255,255,255)"><span style=3D"color: #000000; font-family: times new roman,=
serif;"><br></span></span></p><p class=3D"MsoNormal"><span style=3D"backgro=
und-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: tim=
es new roman,serif;"><br></span></span></p><p class=3D"MsoNormal"><span sty=
le=3D"color: #000000; font-family: times new roman,serif;"><b style=3D"back=
ground-color:rgb(255,255,255)">2.8.1 SCENARIO 2</b></span></p><div><span st=
yle=3D"background-color: #ffffff; color: #000000; font-family: times new ro=
man,serif;"><br></span></div><p class=3D"MsoNormal"><span style=3D"backgrou=
nd-color: #ffffff; color: #000000; font-family: times new roman,serif;">GNU=
 gdb (GDB) 7.8.1<br></span></p><p class=3D"MsoNormal"><span style=3D"backgr=
ound-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: ti=
mes new roman,serif;">Copyright (C) 2014 Free Software Foundation, Inc.</sp=
an></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(25=
5,255,255)"><span style=3D"color: #000000; font-family: times new roman,ser=
if;">License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://gnu.o=
rg/licenses/gpl.html" target=3D"_blank">http://gnu.org/licenses/gpl.html</a=
>&gt;</span></span></p><p class=3D"MsoNormal"><span style=3D"background-col=
or:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times new =
roman,serif;">This is free software: you are free to change and redistribut=
e
it.</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color=
:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times new ro=
man,serif;">There is NO WARRANTY, to the extent permitted by law.&nbsp; Typ=
e
"show copying"</span></span></p><p class=3D"MsoNormal"><span style=3D"backg=
round-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: t=
imes new roman,serif;">and "show warranty" for details.</span></span></p><p=
 class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><spa=
n style=3D"color: #000000; font-family: times new roman,serif;">This GDB wa=
s configured as "x86_64-poky-linux".</span></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #=
000000; font-family: times new roman,serif;">Type "show configuration" for =
configuration details.</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">For bug reporting instructions, please see:=
</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rg=
b(255,255,255)"><span style=3D"color: #000000; font-family: times new roman=
,serif;">&lt;<a href=3D"http://www.gnu.org/software/gdb/bugs/" target=3D"_b=
lank">http://www.gnu.org/software/gdb/bugs/</a>&gt;.</span></span></p><p cl=
ass=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span s=
tyle=3D"color: #000000; font-family: times new roman,serif;">Find the GDB m=
anual and other documentation resources online at:</span></span></p><p clas=
s=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span sty=
le=3D"color: #000000; font-family: times new roman,serif;">&lt;<a href=3D"h=
ttp://www.gnu.org/software/gdb/documentation/" target=3D"_blank">http://www=
.gnu.org/software/gdb/documentation/</a>&gt;.</span></span></p><p class=3D"=
MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D=
"color: #000000; font-family: times new roman,serif;">For help, type "help"=
.</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:r=
gb(255,255,255)"><span style=3D"color: #000000; font-family: times new roma=
n,serif;">Type "apropos word" to search for commands related to
"word"...</span></span></p><p class=3D"MsoNormal"><span style=3D"background=
-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times =
new roman,serif;">Reading symbols from /usr/bin/lttng-sessiond...(no debugg=
ing
symbols found)...done.</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">[New LWP 637]</span></span></p><p class=3D"=
MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D=
"color: #000000; font-family: times new roman,serif;">[New LWP 610]</span><=
/span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,25=
5,255)"><span style=3D"color: #000000; font-family: times new roman,serif;"=
>[New LWP 613]</span></span></p><p class=3D"MsoNormal"><span style=3D"backg=
round-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: t=
imes new roman,serif;">[New LWP 624]</span></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #=
000000; font-family: times new roman,serif;">[New LWP 605]</span></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
span style=3D"color: #000000; font-family: times new roman,serif;">[New LWP=
 608]</span></span></p><p class=3D"MsoNormal"><span style=3D"background-col=
or:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times new =
roman,serif;">[New LWP 607]</span></span></p><p class=3D"MsoNormal"><span s=
tyle=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; f=
ont-family: times new roman,serif;">[New LWP 609]</span></span></p><p class=
=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span styl=
e=3D"color: #000000; font-family: times new roman,serif;">[New LWP 612]</sp=
an></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(25=
5,255,255)"><span style=3D"color: #000000; font-family: times new roman,ser=
if;">[New LWP 606]</span></span></p><p class=3D"MsoNormal"><span style=3D"b=
ackground-color:rgb(255,255,255)"><span style=3D"color: #000000; font-famil=
y: times new roman,serif;">[New LWP 611]</span></span></p><p class=3D"MsoNo=
rmal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"colo=
r: #000000; font-family: times new roman,serif;">[New LWP 616]</span></span=
></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255=
)"><span style=3D"color: #000000; font-family: times new roman,serif;">&nbs=
p;</span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:=
rgb(255,255,255)"><span style=3D"color: #000000; font-family: times new rom=
an,serif;">warning: Could not load shared library symbols for
linux-vdso.so.1.</span></span></p><p class=3D"MsoNormal"><span style=3D"bac=
kground-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family:=
 times new roman,serif;">Do you need "set solib-search-path" or "set
sysroot"?</span></span></p><p class=3D"MsoNormal"><span style=3D"background=
-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: times =
new roman,serif;">[Thread debugging using libthread_db enabled]</span></spa=
n></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,25=
5)"><span style=3D"color: #000000; font-family: times new roman,serif;">Usi=
ng host libthread_db library
"/lib64/libthread_db.so.1".</span></span></p><p class=3D"MsoNormal"><span s=
tyle=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; f=
ont-family: times new roman,serif;">Core was generated by `/usr/bin/lttng-s=
essiond
--consumerd32-path /usr/lib/lttng/libexec/lttng-consume'.</span></span></p>=
<p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><s=
pan style=3D"color: #000000; font-family: times new roman,serif;">Program t=
erminated with signal SIGSEGV, Segmentation fault.</span></span></p><p clas=
s=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span sty=
le=3D"color: #000000; font-family: times new roman,serif;">#0&nbsp; 0x00000=
00000000020 in ?? ()</span></span></p><p class=3D"MsoNormal"><span style=3D=
"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-fam=
ily: times new roman,serif;">(gdb) bt</span></span></p><p class=3D"MsoNorma=
l"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"color: =
#000000; font-family: times new roman,serif;">Python Exception &lt;type 'ex=
ceptions.ImportError'&gt; No module
named gdb.frames: </span></span></p><p class=3D"MsoNormal"><span style=3D"b=
ackground-color:rgb(255,255,255)"><span style=3D"color: #000000; font-famil=
y: times new roman,serif;">#0&nbsp; 0x0000000000000020 in ?? ()</span></spa=
n></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,25=
5)"><span style=3D"color: #000000; font-family: times new roman,serif;">#1&=
nbsp; 0x00007ff010197e02 in lttng_ht_lookup () from
/usr/lib64/liblttng-ctl.so.0</span></span></p><p class=3D"MsoNormal"><span =
style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; =
font-family: times new roman,serif;">#2&nbsp; 0x0000000000412217 in ?? ()</=
span></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(=
255,255,255)"><span style=3D"color: #000000; font-family: times new roman,s=
erif;">#3&nbsp; 0x0000000000412263 in ?? ()</span></span></p><p class=3D"Ms=
oNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D"c=
olor: #000000; font-family: times new roman,serif;">#4&nbsp; 0x000000000042=
7de8 in ?? ()</span></span></p><p class=3D"MsoNormal"><span style=3D"backgr=
ound-color:rgb(255,255,255)"><span style=3D"color: #000000; font-family: ti=
mes new roman,serif;">#5&nbsp; 0x0000000000427ed1 in ?? ()</span></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
span style=3D"color: #000000; font-family: times new roman,serif;">#6&nbsp;=
 0x00000000004280d3 in ?? ()</span></span></p><p class=3D"MsoNormal"><span =
style=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; =
font-family: times new roman,serif;">#7&nbsp; 0x00007ff00ff76cad in ?? () f=
rom
/usr/lib64/liburcu.so.2</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">#8&nbsp; 0x00007ff00efb9294 in start_thread=
 (arg=3D0x7ff0096c5700)
at pthread_create.c:336</span></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color: #000000; font-=
family: times new roman,serif;">#9&nbsp; 0x00007ff00ecf713d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109</span></span></p><p class=3D"=
MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><span style=3D=
"color: #000000; font-family: times new roman,serif;">(gdb) q</span></span>=
</p><p class=3D"MsoNormal"><span style=3D"background-color: #ffffff; color:=
 #000000; font-family: times new roman,serif;"><br></span></p><p class=3D"M=
soNormal"><span style=3D"background-color: #ffffff; color: #000000; font-fa=
mily: times new roman,serif;"><br></span></p><p class=3D"MsoNormal"><span s=
tyle=3D"background-color: #ffffff; color: #000000; font-family: times new r=
oman,serif;">Regards,<br>Aravind.</span></p></div></div><br>_______________=
________________________________<br>lttng-dev mailing list<br>lttng-dev@lis=
ts.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<=
br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br>Effic=
iOS Inc.<br>http://www.efficios.com</div></div><br></blockquote></div><br><=
div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Eff=
iciOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_e581e14f-4895-406b-b70b-f44487b460b8--



--===============0258220242313430145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0258220242313430145==--
