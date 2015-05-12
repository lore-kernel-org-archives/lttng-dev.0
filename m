From: Engel Sanchez <engel@basho.com>
Subject: lttng-modules 2.6.1 compilation error on Ubuntu 14.04
Date: Mon, 11 May 2015 20:32:24 -0400
Message-ID: <CABx-oYzx7CRvzMF52sSMJy1DQMvc-GXC+rPhgERe3TZmMZ8JtQ__24026.0009341457$1431390813$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0789342096=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <engel@basho.com>) id 1Yry7a-0004uZ-BG
 for lttng-dev@lists.lttng.org; Mon, 11 May 2015 20:32:34 -0400
Received: by oign205 with SMTP id n205so118125300oig.2
 for <lttng-dev@lists.lttng.org>; Mon, 11 May 2015 17:32:24 -0700 (PDT)
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

--===============0789342096==
Content-Type: multipart/alternative; boundary=001a11351c84daf0fa0515d7a0e2

--001a11351c84daf0fa0515d7a0e2
Content-Type: text/plain; charset=UTF-8

Hello there. I was wondering if anybody knew what is causing this
compilation error I'm getting on a new Ubuntu 14.04 VM with a 3.13.0
kernel.  It does not find the DEBIAN_API_VERSION symbol. The use of that
was introduced in 2.6.1 apparently:


http://fossies.org/diffs/lttng-modules/2.6.0_vs_2.6.1/lttng-kernel-version.h-diff.html

I'm following the instructions in the Download page to install from the PPA
:  http://lttng.org/download/#ubuntu

This the error I'm getting. Thanks in advance for any help!

In file included from
/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/wrapper/page_alloc.h:28:0,
               from
/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/lttng-events.c:27:/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/wrapper/../lttng-kernel-version.h:60:57:
error: operator '+' has no right operand  ((LINUX_VERSION_CODE *
1000000ULL) + DEBIAN_API_VERSION)

--001a11351c84daf0fa0515d7a0e2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello there. I was wondering if anybody knew what is causi=
ng this compilation error I&#39;m getting on a new Ubuntu 14.04 VM with a 3=
.13.0 kernel.=C2=A0 It does not find the DEBIAN_API_VERSION symbol. The use=
 of that was introduced in 2.6.1 apparently:<div><br><div><br><table cellpa=
dding=3D"0" class=3D"" style=3D"font-size:12.8000001907349px"><tbody><tr cl=
ass=3D""><td colspan=3D"2" class=3D"" style=3D"padding:6px 0px"><span class=
=3D""><span><a href=3D"http://fossies.org/diffs/lttng-modules/2.6.0_vs_2.6.=
1/lttng-kernel-version.h-diff.html">http://fossies.org/diffs/lttng-modules/=
2.6.0_vs_2.6.1/lttng-kernel-version.h-diff.html</a><br><br>I&#39;m followin=
g the instructions in the Download page to install from the PPA : =C2=A0<a =
href=3D"http://lttng.org/download/#ubuntu">http://lttng.org/download/#ubunt=
u</a><br><br>This the error I&#39;m getting. Thanks in advance for any help=
!<br><br></span></span></td><td colspan=3D"2" class=3D"" style=3D"padding:6=
px 0px">In file included from /var/lib/dkms/lttng-modules/2.6.x+stable+bzr7=
27+pack22+201504291801~ubuntu14.04.1/build/wrapper/page_alloc.h:28:0,</td><=
td colspan=3D"2" class=3D"" style=3D"padding:6px 0px">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /var/lib/dkms/lttng-modules/2=
.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/lttng-events.c:2=
7:</td><td colspan=3D"2" class=3D"" style=3D"padding:6px 0px">/var/lib/dkms=
/lttng-modules/2.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/=
wrapper/../lttng-kernel-version.h:60:57: error: operator &#39;+&#39; has no=
 right operand</td><td colspan=3D"2" class=3D"" style=3D"padding:6px 0px">=
=C2=A0 ((LINUX_VERSION_CODE * 1000000ULL) + DEBIAN_API_VERSION)</td></tr></=
tbody></table></div></div></div>

--001a11351c84daf0fa0515d7a0e2--


--===============0789342096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0789342096==--
