From: Jon Bernard <jbernard@tuxion.com>
Subject: Re: babeltrace test failures on some architectures
Date: Fri, 13 Jun 2014 11:14:41 -0400
Message-ID: <20140613151441.GA16857__22121.1565695286$1402672557$gmane$org@helmut>
References: <20140604184126.GA26877@helmut>
 <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
 <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ@mail.gmail.com>
 <20140609145201.GB25766@helmut>
 <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@tuxion.com>) id 1WvTBn-0002jZ-P2
 for lttng-dev@lists.lttng.org; Fri, 13 Jun 2014 11:14:56 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6771020F64
 for <lttng-dev@lists.lttng.org>; Fri, 13 Jun 2014 11:14:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id s5DFFKSU032264

* J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com> wrote:
> The build logs only seem to contain the "prove" output (invoked by run.=
sh).
>=20
> Could you run tests/bin/test_trace_read and
> tests/lib/test_seek_empty_packet on armel and sparc? The output of
> both of these tests and the coredumps (if any) should give me
> something to work with.

With the attached patch applied for kfreebsd, I see these failures:

    make[3]: Entering directory '/home/jbernard/babeltrace/tests'
    ./run.sh tests
    bin/test_trace_read ........... ok
    lib/test_bitfield ............. ok
    lib/test_seek_empty_packet .... ok
    lib/test_seek_big_trace ....... ok
    lib/test_ctf_writer_complete ..
    Dubious, test returned 139 (wstat 35584, 0x8b00)
    All 77 subtests passed

    Test Summary Report
    -------------------
    lib/test_ctf_writer_complete (Wstat: 35584 Tests: 77 Failed: 0)
    Non-zero exit status: 139
    Parse errors: No plan found in TAP output
    Files=3D5, Tests=3D178, 26 wallclock secs ( 0.00 usr +  0.00 sys =3D =
 0.00 CPU)
    Result: FAIL
    Makefile:662: recipe for target 'check-am' failed

I'll submit a proper patch for HOST_NAME_MAX to the list.

Cheers,

--=20
Jon

--7AUc2qLy4jB3hD7Z
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="handle-missing-hostnamemax.diff"

diff --git a/configure.ac b/configure.ac
index 80eba33..248044e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -50,6 +50,17 @@ AC_C_INLINE
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
 
+# FreeBSD does not define HOST_NAME_MAX
+AC_CHECK_DECL(HOST_NAME_MAX,,
+	[
+	 AC_CHECK_DECL(_POSIX_HOST_NAME_MAX,
+		       AC_DEFINE(HOST_NAME_MAX, _POSIX_HOST_NAME_MAX, []),
+		       AC_DEFINE(HOST_NAME_MAX, 256, [Define to 256 if neither have HOST_NAME_MAX nor _POSIX_HOST_NAME_MAX]),
+		       [[#include <limits.h>]])
+	],
+	[[#include <limits.h>]]
+)
+
 # Checks for library functions.
 AC_FUNC_MALLOC
 AC_FUNC_MMAP

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--7AUc2qLy4jB3hD7Z--
