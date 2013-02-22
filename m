From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Package liburcu: build for hurd-i386
Date: Fri, 22 Feb 2013 11:01:12 -0500
Message-ID: <20130222160111.GA23609__45116.8271400549$1361548983$gmane$org@Krystal>
References: <20130222140920.GA22156@Krystal>
	<20130222143032.GB8091@type.bordeaux.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U8v3l-0007Il-KY
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 11:01:17 -0500
Content-Disposition: inline
In-Reply-To: <20130222143032.GB8091@type.bordeaux.inria.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Samuel Thibault <sthibault@debian.org>, hurd-i386@buildd.debian.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Samuel Thibault (sthibault@debian.org) wrote:
> Hello,
> =

> Mathieu Desnoyers, le Fri 22 Feb 2013 09:09:20 -0500, a =E9crit :
> > I noticed a build failure on hurd-i386, and committed a fix in Userspace
> > RCU master branch to address this issue. Testing would be welcome.
> =

> Unfortunately it doesn't work, because sched_setaffinity is for now just
> a fail-stub on hurd-i386, and thus configure considers it as missing,
> and thus the CPU_SET test is disabled completely.
> =

> I however guess you could just disable defining your own cpu_set_t when
> !HAVE_SCHED_SETAFFINITY, since it is probably used only for using
> sched_setaffinity.

Either that or move the cpu_set_t, CPU_SET and CPU_ZERO tests outside of
the sched_setaffinity conditional within configure.ac. It will allow to
handle various configurations more elegantly. Here is the commit (pushed
into master), comments are welcome!


commit b3231c17e4a4e0b2d76754982eb1e1bc90da2987
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Feb 22 10:57:48 2013 -0500

    Fix hurd-i386: move cpuset tests outside of sched_setaffinity condition=
al
    =

    Comment about introduction of cpuset.h within urcu tests:
    =

    > Unfortunately it doesn't work, because sched_setaffinity is for now
    > just a fail-stub on hurd-i386, and thus configure considers it as
    > missing, and thus the CPU_SET test is disabled completely.
    >
    > I however guess you could just disable defining your own cpu_set_t
    > when !HAVE_SCHED_SETAFFINITY, since it is probably used only for using
    > sched_setaffinity.
    =

    Fix by moving cpu_set_t, CPU_SET and CPU_ZERO tests outside of the
    sched_setaffinity conditional.
    =

    Reported-by: Samuel Thibault <sthibault@debian.org>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/configure.ac b/configure.ac
index a49b39f..b6f787b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -202,6 +202,49 @@ AS_IF([test "x$def_smp_support" =3D "xyes"], [AC_DEFIN=
E([CONFIG_RCU_SMP], [1])])
 saved_CFLAGS=3D$CFLAGS
 CFLAGS=3D"$CFLAGS -D_GNU_SOURCE"
 =

+AC_CHECK_TYPES([cpu_set_t],
+	[have_cpu_set_t=3D"yes"],
+	[have_cpu_set_t=3D"no"],
+	[#include <sched.h>])
+
+# Confirm that we have CPU_ZERO, and it actually works.
+AC_MSG_CHECKING([whether CPU_ZERO works])
+AH_TEMPLATE([HAVE_CPU_ZERO], [Defined to 1 if we have CPU_ZERO and it work=
s])
+AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
+		#define _GNU_SOURCE
+		#include <sched.h>
+		int main()
+		{
+			cpu_set_t foo; CPU_ZERO(&foo);
+			return 0;
+		}
+	]])
+],[
+	AC_DEFINE(HAVE_CPU_ZERO, 1)
+	AC_MSG_RESULT([yes])
+],[
+	AC_MSG_RESULT([no])
+])
+
+# Confirm that we have CPU_SET, and it actually works.
+AC_MSG_CHECKING([whether CPU_SET works])
+AH_TEMPLATE([HAVE_CPU_SET], [Defined to 1 if we have CPU_SET and it works])
+AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
+		#define _GNU_SOURCE
+		#include <sched.h>
+		int main()
+		{
+			cpu_set_t foo, mask; CPU_SET(0, &foo);
+			return 0;
+		}
+	]])
+],[
+	AC_DEFINE(HAVE_CPU_SET, 1)
+	AC_MSG_RESULT([yes])
+],[
+	AC_MSG_RESULT([no])
+])
+
 # First check if the function is available at all.
 AC_CHECK_FUNCS([sched_setaffinity],[
 	# Okay, we have it.  Check if also have cpu_set_t.  If we don't,
@@ -210,47 +253,8 @@ AC_CHECK_FUNCS([sched_setaffinity],[
 	# version with 2 or 3 arguments.  In that case, CPU_ZERO, etc.,
 	# should also be present, but we confirm nonetheless.
 =

-	AC_CHECK_TYPES([cpu_set_t],[
-		# We do have it.  Confirm that we have CPU_ZERO, and it actually works.
-		AC_MSG_CHECKING([whether CPU_ZERO works])
-		AH_TEMPLATE([HAVE_CPU_ZERO], [Defined to 1 if we have CPU_ZERO and it wo=
rks])
-		AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
-				#define _GNU_SOURCE
-				#include <sched.h>
-				int main()
-				{
-					cpu_set_t foo; CPU_ZERO (&foo);
-					return 0;
-				}
-			]])
-		],[
-			# Works!
-			AC_DEFINE(HAVE_CPU_ZERO, 1)
-			AC_MSG_RESULT([yes])
-		],[
-			AC_MSG_RESULT([no])
-		])
-
-		# Confirm that we have CPU_SET, and it actually works.
-		AC_MSG_CHECKING([whether CPU_SET works])
-		AH_TEMPLATE([HAVE_CPU_SET], [Defined to 1 if we have CPU_SET and it work=
s])
-		AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
-				#define _GNU_SOURCE
-				#include <sched.h>
-				int main()
-				{
-					cpu_set_t foo, mask; CPU_SET (0, &foo);
-					return 0;
-				}
-			]])
-		],[
-			# Works!
-			AC_DEFINE(HAVE_CPU_SET, 1)
-			AC_MSG_RESULT([yes])
-		],[
-			AC_MSG_RESULT([no])
-		])
-
+	AS_IF([test "x$have_cpu_set_t" =3D "xyes"], [
+		# We do have it.
 		# Check how many arguments does sched_setaffinity take.
 		# Should be 3 or 2.
 		AC_MSG_CHECKING([how many arguments sched_setaffinity takes])
@@ -259,21 +263,21 @@ AC_CHECK_FUNCS([sched_setaffinity],[
 				int main()
 				{
 					cpu_set_t foo;
-					sched_setaffinity (0, sizeof (foo), &foo);
+					sched_setaffinity(0, sizeof (foo), &foo);
 					return 0;
 				}
 			]])
 		],
 		[sched_set_affinity_args=3D3],
 		[sched_set_affinity_args=3D2])
-		AC_DEFINE_UNQUOTED(SCHED_SETAFFINITY_ARGS, $sched_set_affinity_args,
+		AC_DEFINE_UNQUOTED(SCHED_SETAFFINITY_ARGS,
+			$sched_set_affinity_args,
 			[Defined to sched_setaffinity's number of arguments.])
 		AC_MSG_RESULT([$sched_set_affinity_args])
 	],[
 		# No cpu_set_t, always 3 args.
 		AC_DEFINE(SCHED_SETAFFINITY_ARGS, 3)
-    	],
-    	[#include <sched.h>])
+	])
 ])
 =

 CFLAGS=3D$saved_CFLAGS


-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
