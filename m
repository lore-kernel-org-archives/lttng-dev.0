From: Francis Rivest <francis.rivest13@gmail.com>
Subject: (no subject)
Date: Thu, 14 May 2015 15:33:10 -0400
Message-ID: <CAG4vvd49JfNUgN9p9vW0bQXoRkBjER74zVbTAg-CmtETZeDn2Q__41467.1227605597$1431632074$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1687645225=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.rivest13@gmail.com>) id 1Ysysd-0000Pe-Sy
 for lttng-dev@lists.lttng.org; Thu, 14 May 2015 15:33:20 -0400
Received: by yhom41 with SMTP id m41so25389337yho.1
 for <lttng-dev@lists.lttng.org>; Thu, 14 May 2015 12:33:10 -0700 (PDT)
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

--===============1687645225==
Content-Type: multipart/alternative; boundary=001a113a8cea3e0bec05160fcc21

--001a113a8cea3e0bec05160fcc21
Content-Type: text/plain; charset=UTF-8

Hello again,

We tried to install the lttng-modules-dkms package using apt and the
"ppa:lttng/ppa" repository, but we get the following information and error:

Unpacking lttng-modules-dkms (from .../lttng-modules-dkms_2.6.x+
stable+bzr727+pack22+201504291801~ubuntu12.04.1_all.deb) ...
Setting up lttng-modules-dkms
(2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1)
...
Loading new lttng-modules-2.6.x+stable+bzr727+pack22+201504291801~ubuntu
12.04.1
DKMS files...
First Installation: checking all kernels...
Building only for 3.13.0-32-generic
Building initial module for 3.13.0-32-generic
Error! Bad return status for module build on kernel: 3.13.0-32-generic
(x86_64)
Consult /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/make.log for more information.


The contain of the make.log file is the following:

DKMS make.log for
lttng-modules-2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1
for kernel 3.13.0-32-generic (x86_64)
Thu May 14 15:00:16 EDT 2015
make: Entering directory `/usr/src/linux-headers-3.13.0-32-generic'
/bin/sh: 1: /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/abi-debian-version.sh: not found
/bin/sh: 1: /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/abi-debian-version.sh: not found
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-discard.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-overwrite.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-ring-buffer-metadata-client.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-mmap-discard.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-mmap-overwrite.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-ring-buffer-metadata-mmap-client.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-statedump-impl.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/wrapper/irqdesc.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/wrapper/fdtable.o
   CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-events.o
In file included from /var/lib/dkms/lttng-modules/2.
6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1/
build/lttng-events.c:27:0:
/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/wrapper/page_alloc.h:36:58: error:
operator '+' has no right operand
make[1]: *** [/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
201504291801~ubuntu12.04.1/build/lttng-events.o] Error 1
make: *** [_module_/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+
pack22+201504291801~ubuntu12.04.1/build] Error 2
make: Leaving directory `/usr/src/linux-headers-3.13.0-32-generic'


We know that "abi-debian-version.sh" isn't found and that might be the
cause of our problem but it is supposed to be in the package...

In addition we tried to include manually this file but it didn't work.

Thanks again for helping me out.

-Francis R

--001a113a8cea3e0bec05160fcc21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(80,0,80);font-size:12.80000019073=
49px">Hello again,</span><br style=3D"color:rgb(80,0,80);font-size:12.80000=
01907349px"><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><=
span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">We tried to =
install the lttng-modules-dkms package using apt and the</span><br style=3D=
"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(=
80,0,80);font-size:12.8000001907349px">&quot;ppa:lttng/ppa&quot; repository=
, but we get the following information and error:</span><br style=3D"color:=
rgb(80,0,80);font-size:12.8000001907349px"><br style=3D"color:rgb(80,0,80);=
font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:1=
2.8000001907349px">Unpacking lttng-modules-dkms (from .../lttng-modules-dkm=
s_2.6.x+</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px=
"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">stable+bz=
r727+pack22+201504291</span><span style=3D"color:rgb(80,0,80);font-size:12.=
8000001907349px">801~ubuntu12.04.1_all.deb) ...</span><br style=3D"color:rg=
b(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);=
font-size:12.8000001907349px">Setting up lttng-modules-dkms</span><br style=
=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:r=
gb(80,0,80);font-size:12.8000001907349px">(2.6.x+stable+bzr727+pack22+20</s=
pan><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">1504291=
801~ubuntu12.04.1)</span><br style=3D"color:rgb(80,0,80);font-size:12.80000=
01907349px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"=
>...</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><s=
pan style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">Loading new l=
ttng-modules-2.6.x+stable+bzr</span><span style=3D"color:rgb(80,0,80);font-=
size:12.8000001907349px">727+pack22+201504291801~ubuntu</span><span style=
=3D"color:rgb(80,0,80);font-size:12.8000001907349px">12.04.1</span><br styl=
e=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:=
rgb(80,0,80);font-size:12.8000001907349px">DKMS files...</span><br style=3D=
"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(=
80,0,80);font-size:12.8000001907349px">First Installation: checking all ker=
nels...</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"=
><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">Building o=
nly for 3.13.0-32-generic</span><br style=3D"color:rgb(80,0,80);font-size:1=
2.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.800000190=
7349px">Building initial module for 3.13.0-32-generic</span><br style=3D"co=
lor:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,=
0,80);font-size:12.8000001907349px">Error! Bad return status for module bui=
ld on kernel: 3.13.0-32-generic</span><br style=3D"color:rgb(80,0,80);font-=
size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.800=
0001907349px">(x86_64)</span><br style=3D"color:rgb(80,0,80);font-size:12.8=
000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.800000190734=
9px">Consult /var/lib/dkms/lttng-modules/2.</span><span style=3D"color:rgb(=
80,0,80);font-size:12.8000001907349px">6.x+stable+bzr727+pack22+</span><br =
style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"co=
lor:rgb(80,0,80);font-size:12.8000001907349px">201504291801~ubuntu12.04.1/b=
ui</span><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">ld=
/make.log for more information.</span><br style=3D"color:rgb(80,0,80);font-=
size:12.8000001907349px"><br style=3D"color:rgb(80,0,80);font-size:12.80000=
01907349px"><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><=
span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">The contain =
of the make.log file is the following:</span><br style=3D"color:rgb(80,0,80=
);font-size:12.8000001907349px"><br style=3D"color:rgb(80,0,80);font-size:1=
2.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.800000190=
7349px">DKMS make.log for</span><br style=3D"color:rgb(80,0,80);font-size:1=
2.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.800000190=
7349px">lttng-modules-2.6.x+stable+bzr</span><span style=3D"color:rgb(80,0,=
80);font-size:12.8000001907349px">727+pack22+201504291801~ubuntu</span><spa=
n style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">12.04.1</span><=
br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D=
"color:rgb(80,0,80);font-size:12.8000001907349px">for kernel 3.13.0-32-gene=
ric (x86_64)</span><br style=3D"color:rgb(80,0,80);font-size:12.80000019073=
49px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">Thu M=
ay 14 15:00:16 EDT 2015</span><br style=3D"color:rgb(80,0,80);font-size:12.=
8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.80000019073=
49px">make: Entering directory `/usr/src/linux-headers-3.13.0</span><span s=
tyle=3D"color:rgb(80,0,80);font-size:12.8000001907349px">-32-generic&#39;</=
span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span st=
yle=3D"color:rgb(80,0,80);font-size:12.8000001907349px">/bin/sh: 1: /var/li=
b/dkms/lttng-modules/2.</span><span style=3D"color:rgb(80,0,80);font-size:1=
2.8000001907349px">6.x+stable+bzr727+pack22+</span><br style=3D"color:rgb(8=
0,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);fon=
t-size:12.8000001907349px">201504291801~ubuntu12.04.1/bui</span><span style=
=3D"color:rgb(80,0,80);font-size:12.8000001907349px">ld/abi-debian-version.=
sh: not found</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907=
349px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">/bin=
/sh: 1: /var/lib/dkms/lttng-modules/2.</span><span style=3D"color:rgb(80,0,=
80);font-size:12.8000001907349px">6.x+stable+bzr727+pack22+</span><br style=
=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:r=
gb(80,0,80);font-size:12.8000001907349px">201504291801~ubuntu12.04.1/bui</s=
pan><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">ld/abi-=
debian-version.sh: not found</span><br style=3D"color:rgb(80,0,80);font-siz=
e:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.800000=
1907349px">=C2=A0 =C2=A0CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.</span><=
span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">6.x+stable+b=
zr727+pack22+</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907=
349px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">2015=
04291801~ubuntu12.04.1/bui</span><span style=3D"color:rgb(80,0,80);font-siz=
e:12.8000001907349px">ld/lttng-ring-buffer-client-</span><span style=3D"col=
or:rgb(80,0,80);font-size:12.8000001907349px">discard.o</span><br style=3D"=
color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(8=
0,0,80);font-size:12.8000001907349px">=C2=A0 =C2=A0CC [M]=C2=A0 /var/lib/dk=
ms/lttng-modules/2.</span><span style=3D"color:rgb(80,0,80);font-size:12.80=
00001907349px">6.x+stable+bzr727+pack22+</span><br style=3D"color:rgb(80,0,=
80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-si=
ze:12.8000001907349px">201504291801~ubuntu12.04.1/bui</span><span style=3D"=
color:rgb(80,0,80);font-size:12.8000001907349px">ld/lttng-ring-buffer-clien=
t-</span><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">ov=
erwrite.o</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349p=
x"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">=C2=A0 =
=C2=A0CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.</span><span style=3D"colo=
r:rgb(80,0,80);font-size:12.8000001907349px">6.x+stable+bzr727+pack22+</spa=
n><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=
=3D"color:rgb(80,0,80);font-size:12.8000001907349px">201504291801~ubuntu12.=
04.1/bui</span><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349=
px">ld/lttng-ring-buffer-metadata-</span><span style=3D"color:rgb(80,0,80);=
font-size:12.8000001907349px">client.o</span><br style=3D"color:rgb(80,0,80=
);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size=
:12.8000001907349px">=C2=A0 =C2=A0CC [M]=C2=A0 /var/lib/dkms/lttng-modules/=
2.</span><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">6.=
x+stable+bzr727+pack22+</span><br style=3D"color:rgb(80,0,80);font-size:12.=
8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.80000019073=
49px">201504291801~ubuntu12.04.1/bui</span><span style=3D"color:rgb(80,0,80=
);font-size:12.8000001907349px">ld/lttng-ring-buffer-client-</span><span st=
yle=3D"color:rgb(80,0,80);font-size:12.8000001907349px">mmap-discard.o</spa=
n><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=
=3D"color:rgb(80,0,80);font-size:12.8000001907349px">=C2=A0 =C2=A0CC [M]=C2=
=A0 /var/lib/dkms/lttng-modules/2.</span><span style=3D"color:rgb(80,0,80);=
font-size:12.8000001907349px">6.x+stable+bzr727+pack22+</span><br style=3D"=
color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(8=
0,0,80);font-size:12.8000001907349px">201504291801~ubuntu12.04.1/bui</span>=
<span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">ld/lttng-ri=
ng-buffer-client-</span><span style=3D"color:rgb(80,0,80);font-size:12.8000=
001907349px">mmap-overwrite.o</span><br style=3D"color:rgb(80,0,80);font-si=
ze:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.80000=
01907349px">=C2=A0 =C2=A0CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.</span>=
<span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">6.x+stable+=
bzr727+pack22+</span><br style=3D"color:rgb(80,0,80);font-size:12.800000190=
7349px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">201=
504291801~ubuntu12.04.1/bui</span><span style=3D"color:rgb(80,0,80);font-si=
ze:12.8000001907349px">ld/lttng-ring-buffer-metadata-</span><span style=3D"=
color:rgb(80,0,80);font-size:12.8000001907349px">mmap-client.o</span><br st=
yle=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"colo=
r:rgb(80,0,80);font-size:12.8000001907349px">=C2=A0 =C2=A0CC [M]=C2=A0 /var=
/lib/dkms/lttng-modules/2.</span><span style=3D"color:rgb(80,0,80);font-siz=
e:12.8000001907349px">6.x+stable+bzr727+pack22+</span><br style=3D"color:rg=
b(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);=
font-size:12.8000001907349px">201504291801~ubuntu12.04.1/bui</span><span st=
yle=3D"color:rgb(80,0,80);font-size:12.8000001907349px">ld/lttng-statedump-=
impl.o</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">=
<span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">=C2=A0 =C2=
=A0CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.</span><span style=3D"color:r=
gb(80,0,80);font-size:12.8000001907349px">6.x+stable+bzr727+pack22+</span><=
br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D=
"color:rgb(80,0,80);font-size:12.8000001907349px">201504291801~ubuntu12.04.=
1/bui</span><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"=
>ld/wrapper/irqdesc.o</span><br style=3D"color:rgb(80,0,80);font-size:12.80=
00001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349=
px">=C2=A0 =C2=A0CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.</span><span st=
yle=3D"color:rgb(80,0,80);font-size:12.8000001907349px">6.x+stable+bzr727+p=
ack22+</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">=
<span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">20150429180=
1~ubuntu12.04.1/bui</span><span style=3D"color:rgb(80,0,80);font-size:12.80=
00001907349px">ld/wrapper/fdtable.o</span><br style=3D"color:rgb(80,0,80);f=
ont-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12=
.8000001907349px">=C2=A0 =C2=A0CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.<=
/span><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">6.x+s=
table+bzr727+pack22+</span><br style=3D"color:rgb(80,0,80);font-size:12.800=
0001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349p=
x">201504291801~ubuntu12.04.1/bui</span><span style=3D"color:rgb(80,0,80);f=
ont-size:12.8000001907349px">ld/lttng-events.o</span><br style=3D"color:rgb=
(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);f=
ont-size:12.8000001907349px">In file included from /var/lib/dkms/lttng-modu=
les/2.</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">=
<span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">6.x+stable+=
bzr727+pack22+20150</span><span style=3D"color:rgb(80,0,80);font-size:12.80=
00001907349px">4291801~ubuntu12.04.1/</span><br style=3D"color:rgb(80,0,80)=
;font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:=
12.8000001907349px">build/lttng-events.c:27:0:</span><br style=3D"color:rgb=
(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80);f=
ont-size:12.8000001907349px">/var/lib/dkms/lttng-modules/2.</span><span sty=
le=3D"color:rgb(80,0,80);font-size:12.8000001907349px">6.x+stable+bzr727+pa=
ck22+</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><=
span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">201504291801=
~ubuntu12.04.1/bui</span><span style=3D"color:rgb(80,0,80);font-size:12.800=
0001907349px">ld/wrapper/page_alloc.h:36:58: error:</span><br style=3D"colo=
r:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,=
80);font-size:12.8000001907349px">operator &#39;+&#39; has no right operand=
</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><span =
style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">make[1]: *** [/va=
r/lib/dkms/lttng-modules/2</span><span style=3D"color:rgb(80,0,80);font-siz=
e:12.8000001907349px">.6.x+stable+bzr727+pack22+</span><br style=3D"color:r=
gb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80,0,80)=
;font-size:12.8000001907349px">201504291801~ubuntu12.04.1/bui</span><span s=
tyle=3D"color:rgb(80,0,80);font-size:12.8000001907349px">ld/lttng-events.o]=
 Error 1</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px=
"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">make: ***=
 [_module_/var/lib/dkms/lttng-m</span><span style=3D"color:rgb(80,0,80);fon=
t-size:12.8000001907349px">odules/2.6.x+stable+bzr727+</span><br style=3D"c=
olor:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80=
,0,80);font-size:12.8000001907349px">pack22+201504291801~ubuntu12.0</span><=
span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">4.1/build] E=
rror 2</span><br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">=
<span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">make: Leavi=
ng directory `/usr/src/linux-headers-3.13.0</span><span style=3D"color:rgb(=
80,0,80);font-size:12.8000001907349px">-32-generic&#39;</span><br style=3D"=
color:rgb(80,0,80);font-size:12.8000001907349px"><br style=3D"color:rgb(80,=
0,80);font-size:12.8000001907349px"><br style=3D"color:rgb(80,0,80);font-si=
ze:12.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.80000=
01907349px">We know that &quot;abi-debian-version.sh&quot; isn&#39;t found =
and that might be the</span><br style=3D"color:rgb(80,0,80);font-size:12.80=
00001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349=
px">cause of our problem but it is supposed to be in the package...</span><=
br style=3D"color:rgb(80,0,80);font-size:12.8000001907349px"><br style=3D"c=
olor:rgb(80,0,80);font-size:12.8000001907349px"><span style=3D"color:rgb(80=
,0,80);font-size:12.8000001907349px">In addition we tried to include manual=
ly this file but it didn&#39;t work.</span><br style=3D"color:rgb(80,0,80);=
font-size:12.8000001907349px"><br style=3D"color:rgb(80,0,80);font-size:12.=
8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.80000019073=
49px">Thanks again for helping me out.</span><br style=3D"color:rgb(80,0,80=
);font-size:12.8000001907349px"><br style=3D"color:rgb(80,0,80);font-size:1=
2.8000001907349px"><span style=3D"color:rgb(80,0,80);font-size:12.800000190=
7349px">-Francis R</span><br></div>

--001a113a8cea3e0bec05160fcc21--


--===============1687645225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1687645225==--
