From: yin sun <sunyin51@gmail.com>
Subject: lttng-tools 2.2.0-rc1 build error, librt no symbols
Date: Sun, 31 Mar 2013 10:14:29 -0700
Message-ID: <CAKPZSeDCSOBUJGuWPadVm4Q99mr_7R5PJdf9VZr_TdqP-101=g__34572.6892738186$1364750147$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1940713810=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-da0-f49.google.com ([209.85.210.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sunyin51@gmail.com>) id 1UMLqJ-0001QZ-CL
	for lttng-dev@lists.lttng.org; Sun, 31 Mar 2013 13:14:55 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so776004daj.22
	for <lttng-dev@lists.lttng.org>; Sun, 31 Mar 2013 10:14:49 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1940713810==
Content-Type: multipart/alternative; boundary=047d7bd74fd247fa5a04d93ba496

--047d7bd74fd247fa5a04d93ba496
Content-Type: text/plain; charset=ISO-8859-1

I am trying the latest git 2.2.0-rc1. seems the the librt is not resolved
correctly on my ubuntu 12.10 64bit. Don't know why.

I tried to build with static lib seems fine. here is my diff.

diff --git a/src/bin/lttng-consumerd/Makefile.am
b/src/bin/lttng-consumerd/Makefile.am
index a418eb4..1711581 100644
--- a/src/bin/lttng-consumerd/Makefile.am
+++ b/src/bin/lttng-consumerd/Makefile.am
@@ -4,7 +4,7 @@ lttnglibexec_PROGRAMS = lttng-consumerd

 lttng_consumerd_SOURCES = lttng-consumerd.c lttng-consumerd.h

-lttng_consumerd_LDADD = -lrt \
+lttng_consumerd_LDADD = /usr/lib/x86_64-linux-gnu/librt.a \
           $(top_builddir)/src/common/libconsumer.la \
           $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
           $(top_builddir)/src/common/libcommon.la

--047d7bd74fd247fa5a04d93ba496
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style>I am trying the latest git 2.2.0-rc1. seem=
s the the librt is not resolved correctly on my ubuntu 12.10 64bit. Don&#39=
;t know why.</div><div style><br></div><div style>I tried to build with sta=
tic lib seems fine. here is my diff.</div>

<div style><br></div><div>diff --git a/src/bin/lttng-consumerd/Makefile.am =
b/src/bin/lttng-consumerd/Makefile.am</div><div>index a418eb4..1711581 1006=
44</div><div>--- a/src/bin/lttng-consumerd/Makefile.am</div><div>+++ b/src/=
bin/lttng-consumerd/Makefile.am</div>

<div>@@ -4,7 +4,7 @@ lttnglibexec_PROGRAMS =3D lttng-consumerd</div><div>=
=A0</div><div>=A0lttng_consumerd_SOURCES =3D lttng-consumerd.c lttng-consum=
erd.h</div><div>=A0</div><div>-lttng_consumerd_LDADD =3D -lrt \</div><div>+=
lttng_consumerd_LDADD =3D /usr/lib/x86_64-linux-gnu/librt.a \</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0$(top_builddir)/src/common/<a href=3D"http://li=
bconsumer.la">libconsumer.la</a> \</div><div>=A0 =A0 =A0 =A0 =A0 =A0$(top_b=
uilddir)/src/common/sessiond-comm/<a href=3D"http://libsessiond-comm.la">li=
bsessiond-comm.la</a> \</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0$(top_builddir)/src/common/<a href=3D"http://li=
bcommon.la">libcommon.la</a></div></div><div><br></div></div>

--047d7bd74fd247fa5a04d93ba496--


--===============1940713810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1940713810==--
