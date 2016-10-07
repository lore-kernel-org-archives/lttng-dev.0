From: Aravind HT <aravind.ht@gmail.com>
Subject: lttng sessiond hash table crashes.
Date: Fri, 7 Oct 2016 16:16:00 +0530
Message-ID: <CACd+_b6tfbyesNVT-xHjb=cjjSD=6wThFRVKazs4MV11=xCo9A__24000.390576157$1475837183$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2204917730166331503=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
 [209.85.214.47])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B3358A3D46
 for <lttng-dev@lists.lttng.org>; Fri,  7 Oct 2016 10:47:39 +0000 (UTC)
Received: by mail-it0-f47.google.com with SMTP id z65so3223743itc.0
 for <lttng-dev@lists.lttng.org>; Fri, 07 Oct 2016 03:46:01 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2204917730166331503==
Content-Type: multipart/alternative; boundary=94eb2c05d0fab20e22053e441df5

--94eb2c05d0fab20e22053e441df5
Content-Type: text/plain; charset=UTF-8

Hi,

I am encountering a few crashes which are all happening around the hash
table functions, the below are from my 2.6 version for which I have
reproduced them with debug symbols enabled.

*2.6 SCENARIO 1*

(gdb) bt

Python Exception <type 'exceptions.ImportError'> No module named gdb.frames:

#0  lttng_ht_lookup (ht=0x6888f0, key=key@entry=0x4b,
iter=iter@entry=0x7f318fffeae0)
at hashtable.c:236

#1  0x0000000000429900 in ust_app_unregister (sock=sock@entry=75) at
ust-app.c:3105

#2  0x000000000043918a in thread_manage_apps (data=<optimized out>) at
main.c:1558

#3  0x00007f3197c74294 in start_thread (arg=0x7f318ffff700) at
pthread_create.c:336

#4  0x00007f31979b213d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109



*2.6 **SCENARIO 2 : Not sure why cmd_init() gets called here *

#0  0x00007f024d68fd2c in lttng_cds_lfht_lookup (ht=0x68ac90,
hash=8123239074643410387, match=0x418be2 <ht_match_reg_uid>,
key=0x7f023affb8a0, iter=0x7f023affb900) at rculfhash.c:1535

#1  0x0000000000418be2 in cmd_init () at cmd.c:3332

#2  0x00000000004191e3 in buffer_reg_uid_find (session_id=<optimized out>,
bits_per_long=64, uid=0) at buffer-registry.c:198

#3  0x000000000042df89 in ust_consumer_metadata_request
(socket=socket@entry=0x67f1f0
<ustconsumer64_data+176>) at ust-consumer.c:464

#4  0x000000000043b0e6 in thread_manage_consumer (data=0x67f140
<ustconsumer64_data>) at main.c:1353

#5  0x00007f024c4ae294 in start_thread (arg=0x7f023affd700) at
pthread_create.c:336

#6  0x00007f024c1ec13d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

(gdb)



*2.6 **SCENARIO 3*

(gdb) bt

#0  0x00007f444c017740 in ?? ()

#1  0x00007f44676a9b6b in bucket_at (index=<optimized out>,
ht=0x7f444c00d4e0) at rculfhash.c:853

#2  lookup_bucket (hash=4405530133935945645, size=<optimized out>,
ht=0x7f444c00d4e0) at rculfhash.c:861

#3  lttng_cds_lfht_lookup (ht=0x7f444c00d4e0, hash=4405530133935945645,
match=0x7f44676a7980 <match_ulong>, key=0x29, iter=iter@entry=0x7f44613d59d0)
at rculfhash.c:1542

#4  0x00007f44676a7e20 in lttng_ht_lookup (ht=<optimized out>,
key=<optimized out>, iter=iter@entry=0x7f44613d59d0) at hashtable.c:240

#5  0x0000000000412217 in consumer_find_socket (key=<optimized out>,
consumer=<optimized out>) at consumer.c:359

#6  0x0000000000000000 in ?? ()


I am also trying to upgrade to 2.8.1 and see similar crashes there,
unfortunately do not have debug symbols enabled, but crashes always in one
of the hash table related functions.
I'm in the process of enabling debug symbols on 2.8.1 so that the info that
i provide applies to the current version, also trying out Valgrind.

Let me know if you can figure something out with this.

*2.8.1 SCENARIO 1*

GNU gdb (GDB) 7.8.1

Copyright (C) 2014 Free Software Foundation, Inc.

License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html
>

This is free software: you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.  Type "show copying"

and "show warranty" for details.

This GDB was configured as "x86_64-poky-linux".

Type "show configuration" for configuration details.

For bug reporting instructions, please see:

<http://www.gnu.org/software/gdb/bugs/>.

Find the GDB manual and other documentation resources online at:

<http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".

Type "apropos word" to search for commands related to "word"...

Reading symbols from /usr/bin/lttng-sessiond...(no debugging symbols
found)...done.

[New LWP 1134]

[New LWP 1090]

[New LWP 1091]

[New LWP 1092]

[New LWP 1093]

[New LWP 1095]

[New LWP 1098]

[New LWP 1102]

[New LWP 1110]

[New LWP 1096]

[New LWP 1094]

[New LWP 1097]



warning: Could not load shared library symbols for linux-vdso.so.1.

Do you need "set solib-search-path" or "set sysroot"?

[Thread debugging using libthread_db enabled]

Using host libthread_db library "/lib64/libthread_db.so.1".

Core was generated by `/usr/bin/lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consume'.

Program terminated with signal SIGSEGV, Segmentation fault.

#0  0x0000000000000000 in ?? ()

(gdb) bt

Python Exception <type 'exceptions.ImportError'> No module named
gdb.frames:

#0  0x0000000000000000 in ?? ()

#1  0x00007f1b39b1db6b in lttng_cds_lfht_lookup () from
/usr/lib64/liblttng-ctl.so.0

#2  0x0000000000412217 in ?? ()

#3  0x0000000000412263 in ?? ()

#4  0x0000000000427de8 in ?? ()

#5  0x0000000000427ed1 in ?? ()

#6  0x00000000004280d3 in ?? ()

#7  0x00007f1b398facad in ?? () from /usr/lib64/liburcu.so.2

#8  0x00007f1b3893d294 in start_thread (arg=0x7f1b1e7fc700) at
pthread_create.c:336

#9  0x00007f1b3867b13d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

(gdb) q




*2.8.1 SCENARIO 2*

GNU gdb (GDB) 7.8.1

Copyright (C) 2014 Free Software Foundation, Inc.

License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html
>

This is free software: you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.  Type "show copying"

and "show warranty" for details.

This GDB was configured as "x86_64-poky-linux".

Type "show configuration" for configuration details.

For bug reporting instructions, please see:

<http://www.gnu.org/software/gdb/bugs/>.

Find the GDB manual and other documentation resources online at:

<http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".

Type "apropos word" to search for commands related to "word"...

Reading symbols from /usr/bin/lttng-sessiond...(no debugging symbols
found)...done.

[New LWP 637]

[New LWP 610]

[New LWP 613]

[New LWP 624]

[New LWP 605]

[New LWP 608]

[New LWP 607]

[New LWP 609]

[New LWP 612]

[New LWP 606]

[New LWP 611]

[New LWP 616]



warning: Could not load shared library symbols for linux-vdso.so.1.

Do you need "set solib-search-path" or "set sysroot"?

[Thread debugging using libthread_db enabled]

Using host libthread_db library "/lib64/libthread_db.so.1".

Core was generated by `/usr/bin/lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consume'.

Program terminated with signal SIGSEGV, Segmentation fault.

#0  0x0000000000000020 in ?? ()

(gdb) bt

Python Exception <type 'exceptions.ImportError'> No module named
gdb.frames:

#0  0x0000000000000020 in ?? ()

#1  0x00007ff010197e02 in lttng_ht_lookup () from
/usr/lib64/liblttng-ctl.so.0

#2  0x0000000000412217 in ?? ()

#3  0x0000000000412263 in ?? ()

#4  0x0000000000427de8 in ?? ()

#5  0x0000000000427ed1 in ?? ()

#6  0x00000000004280d3 in ?? ()

#7  0x00007ff00ff76cad in ?? () from /usr/lib64/liburcu.so.2

#8  0x00007ff00efb9294 in start_thread (arg=0x7ff0096c5700) at
pthread_create.c:336

#9  0x00007ff00ecf713d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

(gdb) q



Regards,
Aravind.

--94eb2c05d0fab20e22053e441df5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"times new roman, serif" style=3D"background-=
color:rgb(255,255,255)" color=3D"#000000">Hi,</font><div><font face=3D"time=
s new roman, serif" style=3D"background-color:rgb(255,255,255)" color=3D"#0=
00000"><br></font></div><div><font face=3D"times new roman, serif" style=3D=
"background-color:rgb(255,255,255)" color=3D"#000000">I am encountering a f=
ew crashes which are all happening around the hash table functions, the bel=
ow are from my 2.6 version for which I have reproduced them with debug symb=
ols enabled.</font></div><div><font face=3D"times new roman, serif" style=
=3D"background-color:rgb(255,255,255)" color=3D"#000000"><br></font></div><=
div><p class=3D"MsoNormal"><b><font face=3D"times new roman, serif" style=
=3D"background-color:rgb(255,255,255)" color=3D"#000000">2.6 SCENARIO
1<span></span></font></b></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">(gdb)
bt<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">Python
Exception &lt;type &#39;exceptions.ImportError&#39;&gt; No module named gdb=
.frames:<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#0=C2=A0
lttng_ht_lookup (ht=3D0x6888f0, key=3Dkey@entry=3D0x4b,
iter=3Diter@entry=3D0x7f318fffeae0) at hashtable.c:236<span></span></font><=
/p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#1=C2=A0
0x0000000000429900 in ust_app_unregister (sock=3Dsock@entry=3D75) at ust-ap=
p.c:3105<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#2=C2=A0
0x000000000043918a in thread_manage_apps (data=3D&lt;optimized out&gt;) at
main.c:1558<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#3=C2=A0
0x00007f3197c74294 in start_thread (arg=3D0x7f318ffff700) at pthread_create=
.c:336<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#4=C2=A0
0x00007f31979b213d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S=
:109<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">=C2=A0</font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000"><b>2.6=C2=A0</b><b>SCENARIO
2 : Not sure why cmd_init() gets called here=C2=A0<span></span></b></font><=
/p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#0=C2=A0
0x00007f024d68fd2c in lttng_cds_lfht_lookup (ht=3D0x68ac90,
hash=3D8123239074643410387, match=3D0x418be2 &lt;ht_match_reg_uid&gt;,
key=3D0x7f023affb8a0, iter=3D0x7f023affb900) at rculfhash.c:1535<span></spa=
n></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#1=C2=A0
0x0000000000418be2 in cmd_init () at cmd.c:3332<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#2=C2=A0
0x00000000004191e3 in buffer_reg_uid_find (session_id=3D&lt;optimized out&g=
t;,
bits_per_long=3D64, uid=3D0) at buffer-registry.c:198<span></span></font></=
p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#3=C2=A0
0x000000000042df89 in ust_consumer_metadata_request (socket=3Dsocket@entry=
=3D0x67f1f0
&lt;ustconsumer64_data+176&gt;) at ust-consumer.c:464<span></span></font></=
p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#4=C2=A0
0x000000000043b0e6 in thread_manage_consumer (data=3D0x67f140
&lt;ustconsumer64_data&gt;) at main.c:1353<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#5=C2=A0
0x00007f024c4ae294 in start_thread (arg=3D0x7f023affd700) at pthread_create=
.c:336<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#6=C2=A0
0x00007f024c1ec13d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S=
:109<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">(gdb)<span></span></font></=
p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">=C2=A0</font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000"><b>2.6=C2=A0</b><b>SCENARIO
3<span></span></b></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">(gdb)
bt<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#0=C2=A0
0x00007f444c017740 in ?? ()<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#1=C2=A0
0x00007f44676a9b6b in bucket_at (index=3D&lt;optimized out&gt;,
ht=3D0x7f444c00d4e0) at rculfhash.c:853<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#2=C2=A0
lookup_bucket (hash=3D4405530133935945645, size=3D&lt;optimized out&gt;,
ht=3D0x7f444c00d4e0) at rculfhash.c:861<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#3=C2=A0
lttng_cds_lfht_lookup (ht=3D0x7f444c00d4e0, hash=3D4405530133935945645,
match=3D0x7f44676a7980 &lt;match_ulong&gt;, key=3D0x29,
iter=3Diter@entry=3D0x7f44613d59d0) at rculfhash.c:1542<span></span></font>=
</p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#4=C2=A0
0x00007f44676a7e20 in lttng_ht_lookup (ht=3D&lt;optimized out&gt;,
key=3D&lt;optimized out&gt;, iter=3Diter@entry=3D0x7f44613d59d0) at hashtab=
le.c:240<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#5=C2=A0
0x0000000000412217 in consumer_find_socket (key=3D&lt;optimized out&gt;,
consumer=3D&lt;optimized out&gt;) at consumer.c:359<span></span></font></p>

<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">#6=C2=A0
0x0000000000000000 in ?? ()<span></span></font></p><p class=3D"MsoNormal"><=
font face=3D"times new roman, serif" style=3D"background-color:rgb(255,255,=
255)" color=3D"#000000"><br></font></p><p class=3D"MsoNormal"><font face=3D=
"times new roman, serif" style=3D"background-color:rgb(255,255,255)" color=
=3D"#000000">I am also trying to upgrade to 2.8.1 and see similar crashes t=
here, unfortunately do not have debug symbols enabled, but crashes always i=
n one of the hash table related functions.</font></p><div><font face=3D"tim=
es new roman, serif" style=3D"background-color:rgb(255,255,255)" color=3D"#=
000000">I&#39;m in the process of enabling debug symbols on 2.8.1 so that t=
he info that i provide applies to the current version, also trying out Valg=
rind.</font></div><div><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000"><br></font></div><div><font=
 face=3D"times new roman, serif" style=3D"background-color:rgb(255,255,255)=
" color=3D"#000000">Let me know if you can figure something out with this.<=
/font></div><div><font face=3D"times new roman, serif" style=3D"background-=
color:rgb(255,255,255)" color=3D"#000000"><br></font></div><p class=3D"MsoN=
ormal"><font face=3D"times new roman, serif" style=3D"background-color:rgb(=
255,255,255)" color=3D"#000000"><b>2.8.1 SCENARIO 1</b>=C2=A0</font></p><p =
class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font=
 face=3D"times new roman, serif" color=3D"#000000">GNU gdb (GDB) 7.8.1<span=
></span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-=
color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000=
000">Copyright (C) 2014 Free Software Foundation, Inc.<span></span></font><=
/span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,25=
5,255)"><font face=3D"times new roman, serif" color=3D"#000000">License GPL=
v3+: GNU GPL version 3 or later &lt;<a href=3D"http://gnu.org/licenses/gpl.=
html">http://gnu.org/licenses/gpl.html</a>&gt;<span></span></font></span></=
p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)">=
<font face=3D"times new roman, serif" color=3D"#000000">This is free softwa=
re: you are free to change and redistribute
it.<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"bac=
kground-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=
=3D"#000000">There is NO WARRANTY, to the extent permitted by law.=C2=A0 Ty=
pe
&quot;show copying&quot;<span></span></font></span></p><p class=3D"MsoNorma=
l"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times ne=
w roman, serif" color=3D"#000000">and &quot;show warranty&quot; for details=
.<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"backg=
round-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=
=3D"#000000">This GDB was configured as &quot;x86_64-poky-linux&quot;.<span=
></span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-=
color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000=
000">Type &quot;show configuration&quot; for configuration details.<span></=
span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-col=
or:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000=
">For bug reporting instructions, please see:<span></span></font></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
font face=3D"times new roman, serif" color=3D"#000000">&lt;<a href=3D"http:=
//www.gnu.org/software/gdb/bugs/">http://www.gnu.org/software/gdb/bugs/</a>=
&gt;.<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"b=
ackground-color:rgb(255,255,255)"><font face=3D"times new roman, serif" col=
or=3D"#000000">Find the GDB manual and other documentation resources online=
 at:<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"ba=
ckground-color:rgb(255,255,255)"><font face=3D"times new roman, serif" colo=
r=3D"#000000">&lt;<a href=3D"http://www.gnu.org/software/gdb/documentation/=
">http://www.gnu.org/software/gdb/documentation/</a>&gt;.<span></span></fon=
t></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255=
,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">For help=
, type &quot;help&quot;.<span></span></font></span></p><p class=3D"MsoNorma=
l"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times ne=
w roman, serif" color=3D"#000000">Type &quot;apropos word&quot; to search f=
or commands related to
&quot;word&quot;...<span></span></font></span></p><p class=3D"MsoNormal"><s=
pan style=3D"background-color:rgb(255,255,255)"><font face=3D"times new rom=
an, serif" color=3D"#000000">Reading symbols from /usr/bin/lttng-sessiond..=
.(no debugging
symbols found)...done.<span></span></font></span></p><p class=3D"MsoNormal"=
><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times new =
roman, serif" color=3D"#000000">[New LWP 1134]<span></span></font></span></=
p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)">=
<font face=3D"times new roman, serif" color=3D"#000000">[New LWP 1090]<span=
></span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-=
color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000=
000">[New LWP 1091]<span></span></font></span></p><p class=3D"MsoNormal"><s=
pan style=3D"background-color:rgb(255,255,255)"><font face=3D"times new rom=
an, serif" color=3D"#000000">[New LWP 1092]<span></span></font></span></p><=
p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><fo=
nt face=3D"times new roman, serif" color=3D"#000000">[New LWP 1093]<span></=
span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-col=
or:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000=
">[New LWP 1095]<span></span></font></span></p><p class=3D"MsoNormal"><span=
 style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman,=
 serif" color=3D"#000000">[New LWP 1098]<span></span></font></span></p><p c=
lass=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font =
face=3D"times new roman, serif" color=3D"#000000">[New LWP 1102]<span></spa=
n></font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:=
rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">[=
New LWP 1110]<span></span></font></span></p><p class=3D"MsoNormal"><span st=
yle=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman, se=
rif" color=3D"#000000">[New LWP 1096]<span></span></font></span></p><p clas=
s=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font fac=
e=3D"times new roman, serif" color=3D"#000000">[New LWP 1094]<span></span><=
/font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb=
(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">[New=
 LWP 1097]<span></span></font></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman, serif=
" color=3D"#000000">=C2=A0</font></span></p><p class=3D"MsoNormal"><span st=
yle=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman, se=
rif" color=3D"#000000">warning: Could not load shared library symbols for
linux-vdso.so.1.<span></span></font></span></p><p class=3D"MsoNormal"><span=
 style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman,=
 serif" color=3D"#000000">Do you need &quot;set solib-search-path&quot; or =
&quot;set
sysroot&quot;?<span></span></font></span></p><p class=3D"MsoNormal"><span s=
tyle=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman, s=
erif" color=3D"#000000">[Thread debugging using libthread_db enabled]<span>=
</span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-c=
olor:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#0000=
00">Using host libthread_db library
&quot;/lib64/libthread_db.so.1&quot;.<span></span></font></span></p><p clas=
s=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font fac=
e=3D"times new roman, serif" color=3D"#000000">Core was generated by `/usr/=
bin/lttng-sessiond
--consumerd32-path /usr/lib/lttng/libexec/lttng-consume&#39;.<span></span><=
/font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb=
(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">Prog=
ram terminated with signal SIGSEGV, Segmentation fault.<span></span></font>=
</span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,2=
55,255)"><font face=3D"times new roman, serif" color=3D"#000000">#0=C2=A0 0=
x0000000000000000 in ?? ()<span></span></font></span></p><p class=3D"MsoNor=
mal"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times =
new roman, serif" color=3D"#000000">(gdb) bt<span></span></font></span></p>=
<p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><f=
ont face=3D"times new roman, serif" color=3D"#000000">Python Exception &lt;=
type &#39;exceptions.ImportError&#39;&gt; No module
named gdb.frames: <span></span></font></span></p><p class=3D"MsoNormal"><sp=
an style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roma=
n, serif" color=3D"#000000">#0=C2=A0 0x0000000000000000 in ?? ()<span></spa=
n></font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:=
rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">#=
1=C2=A0 0x00007f1b39b1db6b in lttng_cds_lfht_lookup () from
/usr/lib64/liblttng-ctl.so.0<span></span></font></span></p><p class=3D"MsoN=
ormal"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"time=
s new roman, serif" color=3D"#000000">#2=C2=A0 0x0000000000412217 in ?? ()<=
span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"backgro=
und-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"=
#000000">#3=C2=A0 0x0000000000412263 in ?? ()<span></span></font></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
font face=3D"times new roman, serif" color=3D"#000000">#4=C2=A0 0x000000000=
0427de8 in ?? ()<span></span></font></span></p><p class=3D"MsoNormal"><span=
 style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman,=
 serif" color=3D"#000000">#5=C2=A0 0x0000000000427ed1 in ?? ()<span></span>=
</font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rg=
b(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">#6=
=C2=A0 0x00000000004280d3 in ?? ()<span></span></font></span></p><p class=
=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font face=
=3D"times new roman, serif" color=3D"#000000">#7=C2=A0 0x00007f1b398facad i=
n ?? () from
/usr/lib64/liburcu.so.2<span></span></font></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times new=
 roman, serif" color=3D"#000000">#8=C2=A0 0x00007f1b3893d294 in start_threa=
d (arg=3D0x7f1b1e7fc700)
at pthread_create.c:336<span></span></font></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times new=
 roman, serif" color=3D"#000000">#9=C2=A0 0x00007f1b3867b13d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109<span></span></font></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
font face=3D"times new roman, serif" color=3D"#000000">(gdb) q<span></span>=
</font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rg=
b(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000"><br=
></font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:r=
gb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000"><b=
r></font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:=
rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000"><=
br></font></span></p><p class=3D"MsoNormal"><font face=3D"times new roman, =
serif" color=3D"#000000"><b style=3D"background-color:rgb(255,255,255)">2.8=
.1 SCENARIO 2</b></font></p><div><font face=3D"times new roman, serif" styl=
e=3D"background-color:rgb(255,255,255)" color=3D"#000000"><br></font></div>=
<p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#000000">GNU gdb (GDB) 7.8.1<br></fo=
nt></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,2=
55)"><font face=3D"times new roman, serif" color=3D"#000000">Copyright (C) =
2014 Free Software Foundation, Inc.<span></span></font></span></p><p class=
=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font face=
=3D"times new roman, serif" color=3D"#000000">License GPLv3+: GNU GPL versi=
on 3 or later &lt;<a href=3D"http://gnu.org/licenses/gpl.html">http://gnu.o=
rg/licenses/gpl.html</a>&gt;<span></span></font></span></p><p class=3D"MsoN=
ormal"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"time=
s new roman, serif" color=3D"#000000">This is free software: you are free t=
o change and redistribute
it.<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"bac=
kground-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=
=3D"#000000">There is NO WARRANTY, to the extent permitted by law.=C2=A0 Ty=
pe
&quot;show copying&quot;<span></span></font></span></p><p class=3D"MsoNorma=
l"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times ne=
w roman, serif" color=3D"#000000">and &quot;show warranty&quot; for details=
.<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"backg=
round-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=
=3D"#000000">This GDB was configured as &quot;x86_64-poky-linux&quot;.<span=
></span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-=
color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000=
000">Type &quot;show configuration&quot; for configuration details.<span></=
span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-col=
or:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000=
">For bug reporting instructions, please see:<span></span></font></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
font face=3D"times new roman, serif" color=3D"#000000">&lt;<a href=3D"http:=
//www.gnu.org/software/gdb/bugs/">http://www.gnu.org/software/gdb/bugs/</a>=
&gt;.<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"b=
ackground-color:rgb(255,255,255)"><font face=3D"times new roman, serif" col=
or=3D"#000000">Find the GDB manual and other documentation resources online=
 at:<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"ba=
ckground-color:rgb(255,255,255)"><font face=3D"times new roman, serif" colo=
r=3D"#000000">&lt;<a href=3D"http://www.gnu.org/software/gdb/documentation/=
">http://www.gnu.org/software/gdb/documentation/</a>&gt;.<span></span></fon=
t></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255=
,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">For help=
, type &quot;help&quot;.<span></span></font></span></p><p class=3D"MsoNorma=
l"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times ne=
w roman, serif" color=3D"#000000">Type &quot;apropos word&quot; to search f=
or commands related to
&quot;word&quot;...<span></span></font></span></p><p class=3D"MsoNormal"><s=
pan style=3D"background-color:rgb(255,255,255)"><font face=3D"times new rom=
an, serif" color=3D"#000000">Reading symbols from /usr/bin/lttng-sessiond..=
.(no debugging
symbols found)...done.<span></span></font></span></p><p class=3D"MsoNormal"=
><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times new =
roman, serif" color=3D"#000000">[New LWP 637]<span></span></font></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
font face=3D"times new roman, serif" color=3D"#000000">[New LWP 610]<span><=
/span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-co=
lor:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#00000=
0">[New LWP 613]<span></span></font></span></p><p class=3D"MsoNormal"><span=
 style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman,=
 serif" color=3D"#000000">[New LWP 624]<span></span></font></span></p><p cl=
ass=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font f=
ace=3D"times new roman, serif" color=3D"#000000">[New LWP 605]<span></span>=
</font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rg=
b(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">[Ne=
w LWP 608]<span></span></font></span></p><p class=3D"MsoNormal"><span style=
=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman, serif=
" color=3D"#000000">[New LWP 607]<span></span></font></span></p><p class=3D=
"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font face=3D=
"times new roman, serif" color=3D"#000000">[New LWP 609]<span></span></font=
></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,=
255,255)"><font face=3D"times new roman, serif" color=3D"#000000">[New LWP =
612]<span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"ba=
ckground-color:rgb(255,255,255)"><font face=3D"times new roman, serif" colo=
r=3D"#000000">[New LWP 606]<span></span></font></span></p><p class=3D"MsoNo=
rmal"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times=
 new roman, serif" color=3D"#000000">[New LWP 611]<span></span></font></spa=
n></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,25=
5)"><font face=3D"times new roman, serif" color=3D"#000000">[New LWP 616]<s=
pan></span></font></span></p><p class=3D"MsoNormal"><span style=3D"backgrou=
nd-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#=
000000">=C2=A0</font></span></p><p class=3D"MsoNormal"><span style=3D"backg=
round-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=
=3D"#000000">warning: Could not load shared library symbols for
linux-vdso.so.1.<span></span></font></span></p><p class=3D"MsoNormal"><span=
 style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman,=
 serif" color=3D"#000000">Do you need &quot;set solib-search-path&quot; or =
&quot;set
sysroot&quot;?<span></span></font></span></p><p class=3D"MsoNormal"><span s=
tyle=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman, s=
erif" color=3D"#000000">[Thread debugging using libthread_db enabled]<span>=
</span></font></span></p><p class=3D"MsoNormal"><span style=3D"background-c=
olor:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#0000=
00">Using host libthread_db library
&quot;/lib64/libthread_db.so.1&quot;.<span></span></font></span></p><p clas=
s=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font fac=
e=3D"times new roman, serif" color=3D"#000000">Core was generated by `/usr/=
bin/lttng-sessiond
--consumerd32-path /usr/lib/lttng/libexec/lttng-consume&#39;.<span></span><=
/font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb=
(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">Prog=
ram terminated with signal SIGSEGV, Segmentation fault.<span></span></font>=
</span></p><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,2=
55,255)"><font face=3D"times new roman, serif" color=3D"#000000">#0=C2=A0 0=
x0000000000000020 in ?? ()<span></span></font></span></p><p class=3D"MsoNor=
mal"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times =
new roman, serif" color=3D"#000000">(gdb) bt<span></span></font></span></p>=
<p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><f=
ont face=3D"times new roman, serif" color=3D"#000000">Python Exception &lt;=
type &#39;exceptions.ImportError&#39;&gt; No module
named gdb.frames: <span></span></font></span></p><p class=3D"MsoNormal"><sp=
an style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roma=
n, serif" color=3D"#000000">#0=C2=A0 0x0000000000000020 in ?? ()<span></spa=
n></font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:=
rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">#=
1=C2=A0 0x00007ff010197e02 in lttng_ht_lookup () from
/usr/lib64/liblttng-ctl.so.0<span></span></font></span></p><p class=3D"MsoN=
ormal"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"time=
s new roman, serif" color=3D"#000000">#2=C2=A0 0x0000000000412217 in ?? ()<=
span></span></font></span></p><p class=3D"MsoNormal"><span style=3D"backgro=
und-color:rgb(255,255,255)"><font face=3D"times new roman, serif" color=3D"=
#000000">#3=C2=A0 0x0000000000412263 in ?? ()<span></span></font></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
font face=3D"times new roman, serif" color=3D"#000000">#4=C2=A0 0x000000000=
0427de8 in ?? ()<span></span></font></span></p><p class=3D"MsoNormal"><span=
 style=3D"background-color:rgb(255,255,255)"><font face=3D"times new roman,=
 serif" color=3D"#000000">#5=C2=A0 0x0000000000427ed1 in ?? ()<span></span>=
</font></span></p><p class=3D"MsoNormal"><span style=3D"background-color:rg=
b(255,255,255)"><font face=3D"times new roman, serif" color=3D"#000000">#6=
=C2=A0 0x00000000004280d3 in ?? ()<span></span></font></span></p><p class=
=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><font face=
=3D"times new roman, serif" color=3D"#000000">#7=C2=A0 0x00007ff00ff76cad i=
n ?? () from
/usr/lib64/liburcu.so.2<span></span></font></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times new=
 roman, serif" color=3D"#000000">#8=C2=A0 0x00007ff00efb9294 in start_threa=
d (arg=3D0x7ff0096c5700)
at pthread_create.c:336<span></span></font></span></p><p class=3D"MsoNormal=
"><span style=3D"background-color:rgb(255,255,255)"><font face=3D"times new=
 roman, serif" color=3D"#000000">#9=C2=A0 0x00007ff00ecf713d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109<span></span></font></span></p=
><p class=3D"MsoNormal"><span style=3D"background-color:rgb(255,255,255)"><=
font face=3D"times new roman, serif" color=3D"#000000">(gdb) q<span></span>=
</font></span></p><p class=3D"MsoNormal"><font face=3D"times new roman, ser=
if" style=3D"background-color:rgb(255,255,255)" color=3D"#000000"><br></fon=
t></p><p class=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D=
"background-color:rgb(255,255,255)" color=3D"#000000"><br></font></p><p cla=
ss=3D"MsoNormal"><font face=3D"times new roman, serif" style=3D"background-=
color:rgb(255,255,255)" color=3D"#000000">Regards,<br>Aravind.</font></p></=
div></div>

--94eb2c05d0fab20e22053e441df5--

--===============2204917730166331503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2204917730166331503==--
