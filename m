From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: Building URCU in a Cygwin 64 environment
Date: Wed, 1 Jun 2016 10:01:50 -0400
Message-ID: <574EEACE.2060207__25368.2479648434$1464789712$gmane$org@gydle.com>
References: <574D93FE.7000703@gydle.com> <574DA411.3000603@efficios.com>
 <1907475198.24545.1464731555921.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050802070701060706070807"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 59E38A366F
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jun 2016 14:01:21 +0000 (UTC)
In-Reply-To: <1907475198.24545.1464731555921.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------050802070701060706070807
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Mathieu,

At home (in Cygwin 64), I have a patch for urcu 0.9.2 to fix compilation =
issues.
This patch is however unrelated to building shared libraries (.dll files)=
 in Cygwin.

Here is a patch (inline and attached) to build shared libraries on Cygwin=
 (the one that you
requested). This patch is based on userspace-rcu 613086f69b4c8e6cc1b73b4e=
93d6d0497825d1ee.

I tested it on Ubuntu 14.04 ("behavior on non-cygwin builds"), but not on=
 Cygwin as I don't have a Cygwin system at work.

Commands used to test the patch:

git clone https://github.com/urcu/userspace-rcu.git
cd userspace-rcu/
patch -p1 < ~/patches/0001-Port-build-shared-libraries-in-Cygwin.patch=20
./bootstrap=20
./configure --prefix=3D$HOME/builds/userspace-rcu/613086f69b4c8e6cc1b73b4=
e93d6d0497825d1ee/`date -Iseconds`
make -j 4
cd tests/
make check
cd ..
make install

Output of the test:

./run.sh unit_tests
./test_uatomic ................... ok    =20
./test_urcu_multiflavor .......... ok  =20
./test_urcu_multiflavor_dynlink .. ok  =20
All tests successful.
Files=3D3, Tests=3D78,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.03 cus=
r  0.01 csys =3D  0.07 CPU)
Result: PASS


So, the Result is PASS, which is good.

Tonight, I will combine my 2 patches (the one that enables shared librari=
es in Cygwin, and the one that fixes various compilation issues in Cygwin=
)
and send it to the mailing list for review (along with the output of unit=
 tests in Cygwin).

Z1$ cat ~/patches/0001-Port-build-shared-libraries-in-Cygwin.patch=20
From 1b4f39afc781c1a431b9f52adf25aa0856c86142 Mon Sep 17 00:00:00 2001
From: Sebastien Boisvert <sboisvert@gydle.com>
Date: Wed, 1 Jun 2016 09:53:36 -0400
Subject: [PATCH] Port: build shared libraries in Cygwin

Link: https://lists.lttng.org/pipermail/lttng-dev/2016-May/026081.html
Signed-off-by: Sebastien Boisvert <sboisvert@gydle.com>
---
 Makefile.am  | 3 +++
 configure.ac | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 672beec..8e25fd9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -8,6 +8,9 @@ AM_LDFLAGS=3D-version-info $(URCU_LIBRARY_VERSION)
 if !LIBC_INCLUDES_PTHREAD
 AM_LDFLAGS+=3D-lpthread
 endif
+if USE_CYGWIN
+AM_LDFLAGS+=3D-no-undefined
+endif
 AM_CFLAGS=3D-Wall
=20
 SUBDIRS =3D . doc tests
diff --git a/configure.ac b/configure.ac
index fe1c55d..b3096c6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -134,6 +134,11 @@ AS_CASE([$host],[*-*-linux-androideabi],
 	[AM_CONDITIONAL(TARGET_IS_ANDROID, false)]
 )
=20
+AS_CASE([$host],[*-cygwin*],
+	[AM_CONDITIONAL(USE_CYGWIN, true)],
+	[AM_CONDITIONAL(USE_CYGWIN, false)]
+)
+
 AC_SUBST(ARCHTYPE)
 AC_SUBST(SUBARCHTYPE)
=20
--=20
1.9.1



On 05/31/2016 05:52 PM, Mathieu Desnoyers wrote:
> ----- On May 31, 2016, at 4:47 PM, Jonathan Rajotte Julien Jonathan.raj=
otte-julien@efficios.com wrote:
>=20
>> Hi Sebastien,
>>
>> I'll simply move the conversation here (from IRC) to have an archive o=
f it.
>>
>> On 2016-05-31 09:39 AM, Sebastien Boisvert wrote:
>>> Hi,
>>>
>>> I am in the process of writing a blog article on the use of the LTTng=
-UST
>>> userspace event tracer on Windows.
>>>
>>> I am building urcu and LTTng-UST in a Cygwin 64 environment. Then, I =
plan to use
>>> LTTng in Visual Studio Community, so I mostly need headers (.h) and s=
hared
>>> libraries (.dll).
>>
>> Nice!
>>
>>>
>>> When I am building urcu (0.9.2), I get this message:
>>>
>>> libtool: link: warning: undefined symbols not allowed in x86_64-unkno=
wn-cygwin
>>> shared libraries
>>
>> This seems related to a Windows restriction regarding inter-library
>> dependencies [1], the relevant part:
>>
>> "Some platforms, such as Windows, do not even allow you this
>> flexibility. In order to build a shared library, it must be entirely
>> self-contained or it must have dependencies known at link time (that i=
s,
>> have references only to symbols that are found in the .lo files or the
>> specified =E2=80=98-l=E2=80=99 libraries), and you need to specify the=
 -no-undefined
>> flag. By default, libtool builds only static libraries on these kinds =
of
>> platforms."
>>
>> Looks like the -no-undefined might be a good start judging from this
>> patch I found for the urcu cygwin port in yacp [2].
>>
>> Cheers!
>>
>> [1]
>> https://www.gnu.org/software/libtool/manual/libtool.html#Inter_002dlib=
rary-dependencies
>> [2]
>> https://github.com/fd00/yacp/blob/master/userspace-rcu/userspace-rcu-0=
.8.7-1bl1.src.patch
>=20
> Is there a way we could adapt this patch to urcu upstream without chang=
ing
> the behavior on non-cygwin builds ?
>=20
> Thanks,
>=20
> Mathieu
>=20
>>>
>>> The immediate consequence seems to be the absence of .dll files in th=
e urcu
>>> build that I am generating. Otherwise, the build contains static libr=
ary files
>>> and headers.
>>>
>>> However, I suppose that the .a static library files also have undefin=
ed symbols
>>> as I am getting linking issues when building LTTng-UST.
>>>
>>> Do you have a clue of what may be the issue here ? Otherwise, I will =
continue my
>>> investigation and get around the issue eventually.
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>> --
>> Jonathan R. Julien
>> Efficios
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20

--------------050802070701060706070807
Content-Type: text/x-patch;
 name="0001-Port-build-shared-libraries-in-Cygwin.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-Port-build-shared-libraries-in-Cygwin.patch"

=46rom 1b4f39afc781c1a431b9f52adf25aa0856c86142 Mon Sep 17 00:00:00 2001
From: Sebastien Boisvert <sboisvert@gydle.com>
Date: Wed, 1 Jun 2016 09:53:36 -0400
Subject: [PATCH] Port: build shared libraries in Cygwin

Link: https://lists.lttng.org/pipermail/lttng-dev/2016-May/026081.html
Signed-off-by: Sebastien Boisvert <sboisvert@gydle.com>
---
 Makefile.am  | 3 +++
 configure.ac | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 672beec..8e25fd9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -8,6 +8,9 @@ AM_LDFLAGS=3D-version-info $(URCU_LIBRARY_VERSION)
 if !LIBC_INCLUDES_PTHREAD
 AM_LDFLAGS+=3D-lpthread
 endif
+if USE_CYGWIN
+AM_LDFLAGS+=3D-no-undefined
+endif
 AM_CFLAGS=3D-Wall
=20
 SUBDIRS =3D . doc tests
diff --git a/configure.ac b/configure.ac
index fe1c55d..b3096c6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -134,6 +134,11 @@ AS_CASE([$host],[*-*-linux-androideabi],
 	[AM_CONDITIONAL(TARGET_IS_ANDROID, false)]
 )
=20
+AS_CASE([$host],[*-cygwin*],
+	[AM_CONDITIONAL(USE_CYGWIN, true)],
+	[AM_CONDITIONAL(USE_CYGWIN, false)]
+)
+
 AC_SUBST(ARCHTYPE)
 AC_SUBST(SUBARCHTYPE)
=20
--=20
1.9.1


--------------050802070701060706070807
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--------------050802070701060706070807--
