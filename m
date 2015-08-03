From: jamie explorer <jamieexplorer@gmail.com>
Subject: 32-bit application crash
Date: Mon, 3 Aug 2015 16:19:47 +0530
Message-ID: <CACh_V55XxDDx3rRyGr53XVgqav66SyyJU21YiezyXeUS_p6vKg__21939.5391796299$1438599068$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2031482391=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jamieexplorer@gmail.com>) id 1ZMDJY-0007KI-LM
 for lttng-dev@lists.lttng.org; Mon, 03 Aug 2015 06:49:59 -0400
Received: by oibv126 with SMTP id v126so10443453oib.3
 for <lttng-dev@lists.lttng.org>; Mon, 03 Aug 2015 03:49:47 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2031482391==
Content-Type: multipart/alternative; boundary=001a113ccf0699e745051c65ed77

--001a113ccf0699e745051c65ed77
Content-Type: text/plain; charset=UTF-8

Hi,
i am trying to run 32-bit application and see crash at the the line where
"tracepoint" is used.
i am using sample application given in lttng-ust-2.6.0/doc/examples/gen-tp/
Not able to understand why the problem is seen only with 32-bit apps? Can
experts here pls help me fix this.

Have tried using ELF 32-bit app on Intel 80386 and PowerPC and see the
crash. Where as 64-bit applications have no problem.

following is the code where it crashes
        for (i = 0; i < 100000; i++) {
                tracepoint(sample_tracepoint, message,  "Hello World\n");
 <<<< Crash here
                usleep(1);
        }

GDB output:

#0  0x00000000 in ?? ()
#1  0x10001e54 in __event_probe__sample_tracepoint___message (
    __tp_data=0x10015420, text=0x100034a4 "Hello World\n")
    at /build/home/jam/gentp/sample_tracepoint.h:13
#2  0x10000b9c in __tracepoint_cb_sample_tracepoint___message (
    text=0x100034a4 "Hello World\n")
    at //build/home/jam/gentp/sample_tracepoint.h:13
#3  main (argc=<optimized out>, argv=<optimized out>)
    at /build/home/jam/gentp/sample.c:115


i am running 32-bit version of lttng-sessiond
root@host:~# ps aux | grep lttng
root      4224  0.0  0.0  92212  1648 ?        Ssl  00:42   0:00
/usr/bin/lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ -b
--no-kernel
root      4243  0.0  0.0  64212   956 ?        Sl   00:42   0:00
lttng-consumerd  -u --consumerd-cmd-sock
/var/run/lttng/ustconsumerd32/command --consumerd-err-sock
/var/run/lttng/ustconsumerd32/error --group tracing



/Jam

--001a113ccf0699e745051c65ed77
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>i am trying to run 32-bit application and see cras=
h at the the line where &quot;tracepoint&quot; is used.</div><div>i am usin=
g sample application given in lttng-ust-2.6.0/doc/examples/gen-tp/</div><di=
v>Not able to understand why the problem is seen only with 32-bit apps? Can=
 experts here pls help me fix this.</div><div><br></div><div>Have tried usi=
ng=C2=A0ELF 32-bit app on Intel 80386 and PowerPC and see the crash. Where =
as 64-bit applications have no problem.</div><div><br></div><div>following =
is the code where it crashes</div><div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 for=
 (i =3D 0; i &lt; 100000; i++) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tracepoint(sample_tracepoint, message, =C2=A0&quot=
;Hello World\n&quot;); =C2=A0&lt;&lt;&lt;&lt; Crash here</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(1);=C2=A0</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div></div><div><br></div><div>GDB output:</=
div><div><br></div><div><div><div class=3D"gmail_signature"><div dir=3D"ltr=
">#0 =C2=A00x00000000 in ?? ()<br>#1 =C2=A00x10001e54 in __event_probe__sam=
ple_tracepoint___message (<br>=C2=A0 =C2=A0 __tp_data=3D0x10015420, text=3D=
0x100034a4 &quot;Hello World\n&quot;)<br>=C2=A0 =C2=A0 at /build/home/jam/g=
entp/sample_tracepoint.h:13<br>#2 =C2=A00x10000b9c in __tracepoint_cb_sampl=
e_tracepoint___message (<br>=C2=A0 =C2=A0 text=3D0x100034a4 &quot;Hello Wor=
ld\n&quot;)<br>=C2=A0 =C2=A0 at //build/home/jam/gentp/sample_tracepoint.h:=
13<br>#3 =C2=A0main (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized out=
&gt;)<br>=C2=A0 =C2=A0 at=C2=A0/build/home/jam/gentp/sample.c:115<br><div d=
ir=3D"ltr"><br></div><div dir=3D"ltr"><br></div><div>i am running 32-bit ve=
rsion of lttng-sessiond</div><div dir=3D"ltr"><div dir=3D"ltr">root@host:~#=
 ps aux | grep lttng</div><div dir=3D"ltr">root =C2=A0 =C2=A0 =C2=A04224 =
=C2=A00.0 =C2=A00.0 =C2=A092212 =C2=A01648 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0Ssl=
 =C2=A000:42 =C2=A0 0:00 /usr/bin/lttng-sessiond --consumerd32-path /usr/li=
b/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ -b --no-kern=
el</div><div dir=3D"ltr">root =C2=A0 =C2=A0 =C2=A04243 =C2=A00.0 =C2=A00.0 =
=C2=A064212 =C2=A0 956 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0Sl =C2=A0 00:42 =C2=A0 =
0:00 lttng-consumerd =C2=A0-u --consumerd-cmd-sock /var/run/lttng/ustconsum=
erd32/command --consumerd-err-sock /var/run/lttng/ustconsumerd32/error --gr=
oup tracing</div><div><br></div></div><div dir=3D"ltr"><br></div><div dir=
=3D"ltr"><br></div><div dir=3D"ltr">/Jam</div></div></div></div>
</div></div>

--001a113ccf0699e745051c65ed77--


--===============2031482391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2031482391==--
