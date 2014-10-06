From: Anand Neeli <anand.neeli@gmail.com>
Subject: sessiond and consumerd for 32 and 64 bit apps
Date: Tue, 7 Oct 2014 00:12:59 +0530
Message-ID: <CAM5kDqxA5UyHOF=6T-ZzhX2GnJ6YmELthKUpPA75BXCm5ynTug__35973.1037672192$1412621041$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0759913018=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XbDFT-0001W6-7A
 for lttng-dev@lists.lttng.org; Mon, 06 Oct 2014 14:43:10 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so5557555wib.17
 for <lttng-dev@lists.lttng.org>; Mon, 06 Oct 2014 11:42:59 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0759913018==
Content-Type: multipart/alternative; boundary=f46d043c7fbaace3890504c5730b

--f46d043c7fbaace3890504c5730b
Content-Type: text/plain; charset=UTF-8

Hi All,

I have a query running 32-bit and 64-bit apps.
i'm starting lttng with following steps

lttng-relayd -d

lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd
--consumerd32-libdir /usr/lib/ --consumerd64-path
/usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir /usr/lib64/
-b --no-kernel

lttng -no-sessiond create mysession --live 200000 -U net://localhost

lttng enable-channel mychannel --userspace --buffers-pid -s mysession
--tracefile-size 8388608 --tracefile-count 8

lttng  enable-event --channel mychannel --userspace --all -s mysession

 lttng start


My Queries:
1) Does this spawn consumerd for 32-bit and 64-bit separately?

2) i see that 2 consumerd process are launched. and the 64-bit one looks to
be correct.
root       975  0.0  0.0 404480   956 ?        Sl   11:01   0:00
lttng-consumerd --quiet -u --consumerd-cmd-sock
/var/run/lttng/ustconsumerd64/command --consumerd-err-sock
/var/run/lttng/ustconsumerd64/error --group tracing
root       983  0.0  0.0      0     0 ?        Z    11:01   0:00
[lttng-consumerd] <defunct>

3) What libraries are required by sessiond to launch consumerd. So that i
can copy only those libraries on to the target.

4) is there a way to launch sessiond so that it automatically consumes data
from 32-bit and 64-bit apps.


Thanks in advance,
Anand Neeli

--f46d043c7fbaace3890504c5730b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I have a query running 32-bit a=
nd 64-bit apps.</div><div>i&#39;m starting lttng with following steps</div>=
<div><br></div><div>lttng-relayd -d</div><div><br></div><div>lttng-sessiond=
 --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-li=
bdir /usr/lib/ --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd =
--consumerd64-libdir /usr/lib64/ -b --no-kernel<br></div><div><br></div><di=
v>lttng -no-sessiond create mysession --live 200000 -U net://localhost<br><=
/div><div><p class=3D"">lttng enable-channel mychannel --userspace --buffer=
s-pid -s mysession --tracefile-size 8388608 --tracefile-count 8</p><p class=
=3D"">lttng=C2=A0 enable-event --channel mychannel --userspace --all -s mys=
ession<br></p><p class=3D"">











</p><p class=3D"">







</p><p class=3D"">lttng start</p><p class=3D""><br></p><div>My Queries:</di=
v><div>1) Does this spawn consumerd for 32-bit and 64-bit separately?</div>=
<div><br></div><div>2) i see that 2 consumerd process are launched. and the=
 64-bit one looks to be correct.</div><div><div>root =C2=A0 =C2=A0 =C2=A0 9=
75 =C2=A00.0 =C2=A00.0 404480 =C2=A0 956 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0Sl =
=C2=A0 11:01 =C2=A0 0:00 lttng-consumerd --quiet -u --consumerd-cmd-sock /v=
ar/run/lttng/ustconsumerd64/command --consumerd-err-sock /var/run/lttng/ust=
consumerd64/error --group tracing</div><div>root =C2=A0 =C2=A0 =C2=A0 983 =
=C2=A00.0 =C2=A00.0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 ? =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Z =C2=A0 =C2=A011:01 =C2=A0 0:00 [lttng-consumerd] &lt;defunct=
&gt;</div></div><div><br></div><div>3) What libraries are required by sessi=
ond to launch consumerd. So that i can copy only those libraries on to the =
target.</div><div><br></div><div>4) is there a way to launch sessiond so th=
at it automatically consumes data from 32-bit and 64-bit apps.</div><div><b=
r></div><div><br></div><div>Thanks in advance,</div><div>Anand Neeli</div><=
div><br></div><div><br></div><p class=3D""><br></p><p class=3D""><br></p><p=
 class=3D""><br></p></div></div>

--f46d043c7fbaace3890504c5730b--


--===============0759913018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0759913018==--
