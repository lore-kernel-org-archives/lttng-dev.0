From: kumar s <skumar.m226@gmail.com>
Subject: lib_ring_buffer_align error bit-field '<anonymous>'
 width not an integer constant
Date: Tue, 3 Dec 2013 13:50:02 +0530
Message-ID: <CAO_Arvrp4GwhVr_c170hD3eQ8F77WSmsY4wsCOpg3Xdg23jjKw__8611.16017117656$1386058846$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1929097239=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1VnlDE-0006aW-Bo
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 03:20:09 -0500
Received: by mail-vc0-f178.google.com with SMTP id lh4so9647343vcb.9
	for <lttng-dev@lists.lttng.org>; Tue, 03 Dec 2013 00:20:02 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1929097239==
Content-Type: multipart/alternative; boundary=001a11c1eb4495063004ec9cf60f

--001a11c1eb4495063004ec9cf60f
Content-Type: text/plain; charset=ISO-8859-1

Hello,

When trying to build lttng modules i am getting this error. Cross compiler
for mips and Arch = mips is used in makefile.

Linux kernel version 2.6.32.27


make -C
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux
M=/home/shkumar/lttng-tools/lttngmod/lttng-modules modules ARCH=mips
CROSS_COMPILE=mips64-octeon-linux-gnu-
make[1]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
  CC [M]
 /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o
In file included from
/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/config.h:1,
                 from
/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer-core.h:35,
                 from
/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer.h:39,
                 from
/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.c:24:
/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:
In function 'lib_ring_buffer_align':
/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:266:
error: bit-field '<anonymous>' width not an integer constant
make[2]: ***
[/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o]
Error 1
make[1]: *** [_module_/home/shkumar/lttng-tools/lttngmod/lttng-modules]
Error 2
make[1]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
make: *** [default] Error 2

How do i fix this?

Skumar.

--001a11c1eb4495063004ec9cf60f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>When trying to build lttng modul=
es i am getting this error. Cross compiler for mips and Arch =3D mips is us=
ed in makefile.</div><div><br></div><div>Linux kernel version 2.6.32.27</di=
v>
<div><br></div><div><br></div><div><div>make -C /home/shkumar/Development_M=
erge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux M=3D/ho=
me/shkumar/lttng-tools/lttngmod/lttng-modules modules ARCH=3Dmips CROSS_COM=
PILE=3Dmips64-octeon-linux-gnu-</div>
<div>make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/OC=
TEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux&#39;</div><div>=A0 CC=
 [M] =A0/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-=
client-discard.o</div>
<div>In file included from /home/shkumar/lttng-tools/lttngmod/lttng-modules=
/wrapper/ringbuffer/config.h:1,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0from /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer-core.=
h:35,</div><div>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from /home/shkumar/lttng-tools/lttngmod/=
lttng-modules/lttng-tracer.h:39,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0from /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-=
client-discard.c:24:</div><div>/home/shkumar/lttng-tools/lttngmod/lttng-mod=
ules/wrapper/ringbuffer/../../lib/ringbuffer/config.h: In function &#39;lib=
_ring_buffer_align&#39;:</div>
<div>/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/..=
/../lib/ringbuffer/config.h:266: error: bit-field &#39;&lt;anonymous&gt;&#3=
9; width not an integer constant</div><div>make[2]: *** [/home/shkumar/lttn=
g-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o] Error 1<=
/div>
<div>make[1]: *** [_module_/home/shkumar/lttng-tools/lttngmod/lttng-modules=
] Error 2</div><div>make[1]: Leaving directory `/home/shkumar/Development_M=
erge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux&#39;</d=
iv>
<div>make: *** [default] Error 2</div></div><div><br></div><div>How do i fi=
x this?</div><div><br></div><div>Skumar.</div></div>

--001a11c1eb4495063004ec9cf60f--


--===============1929097239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1929097239==--
