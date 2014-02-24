From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Comments fix: lttngerr.h -> error.h
 (./Changelog:754)
Date: Sun, 23 Feb 2014 19:50:52 -0500
Message-ID: <20140224005050.GA27035__33073.8993980505$1393203127$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WHjl6-0007ZB-EB
	for lttng-dev@lists.lttng.org; Sun, 23 Feb 2014 19:51:05 -0500
Received: by mail-ig0-f172.google.com with SMTP id h3so3575477igd.5
	for <lttng-dev@lists.lttng.org>; Sun, 23 Feb 2014 16:50:54 -0800 (PST)
Received: from gmail.com (Sansfil-Securise-Etudiants-Poly-253-230.polymtl.ca.
	[132.207.253.230])
	by mx.google.com with ESMTPSA id r6sm20882588igg.10.2014.02.23.16.50.54
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Sun, 23 Feb 2014 16:50:54 -0800 (PST)
Content-Disposition: inline
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


Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
---
 tests/unit/test_kernel_data.c             |    2 +-
 tests/unit/test_session.c                 |    2 +-
 tests/unit/test_uri.c                     |    2 +-
 tests/unit/test_ust_data.c                |    2 +-
 tests/unit/test_utils_expand_path.c       |    2 +-
 tests/unit/test_utils_parse_size_suffix.c |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test_kernel_data.c b/tests/unit/test_kernel_data.c
index 16d4f7b..e2182e9 100644
--- a/tests/unit/test_kernel_data.c
+++ b/tests/unit/test_kernel_data.c
@@ -35,7 +35,7 @@
 /* Number of TAP tests in this file */
 #define NUM_TESTS 10
 =

-/* For lttngerr.h */
+/* For error.h */
 int lttng_opt_quiet =3D 1;
 int lttng_opt_verbose;
 =

diff --git a/tests/unit/test_session.c b/tests/unit/test_session.c
index 7242edd..a0e84e9 100644
--- a/tests/unit/test_session.c
+++ b/tests/unit/test_session.c
@@ -43,7 +43,7 @@
 =

 static struct ltt_session_list *session_list;
 =

-/* For lttngerr.h */
+/* For error.h */
 int lttng_opt_quiet =3D 1;
 int lttng_opt_verbose =3D 0;
 =

diff --git a/tests/unit/test_uri.c b/tests/unit/test_uri.c
index ef852c0..7cac95d 100644
--- a/tests/unit/test_uri.c
+++ b/tests/unit/test_uri.c
@@ -22,7 +22,7 @@
 =

 #include <common/uri.h>
 =

-/* For lttngerr.h */
+/* For error.h */
 int lttng_opt_quiet =3D 1;
 int lttng_opt_verbose =3D 3;
 =

diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
index c52a71b..bc3154c 100644
--- a/tests/unit/test_ust_data.c
+++ b/tests/unit/test_ust_data.c
@@ -41,7 +41,7 @@
 /* Number of TAP tests in this file */
 #define NUM_TESTS 10
 =

-/* For lttngerr.h */
+/* For error.h */
 int lttng_opt_quiet =3D 1;
 int lttng_opt_verbose;
 =

diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_utils_ex=
pand_path.c
index 1e0863f..fe709ac 100644
--- a/tests/unit/test_utils_expand_path.c
+++ b/tests/unit/test_utils_expand_path.c
@@ -28,7 +28,7 @@
 =

 #include <src/common/utils.h>
 =

-/* For lttngerr.h */
+/* For error.h */
 int lttng_opt_quiet =3D 1;
 int lttng_opt_verbose =3D 3;
 =

diff --git a/tests/unit/test_utils_parse_size_suffix.c b/tests/unit/test_ut=
ils_parse_size_suffix.c
index 3b9c68c..990aa1b 100644
--- a/tests/unit/test_utils_parse_size_suffix.c
+++ b/tests/unit/test_utils_parse_size_suffix.c
@@ -23,7 +23,7 @@
 =

 #include <src/common/utils.h>
 =

-/* For lttngerr.h */
+/* For error.h */
 int lttng_opt_quiet =3D 1;
 int lttng_opt_verbose =3D 3;
 =

-- =

1.7.9.5


-- =

Jonathan Rajotte Julien
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
