From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: Use $AM_CC when it is defined
 instead of gcc in demo-tracef
Date: Tue, 8 Apr 2014 14:29:48 -0400
Message-ID: <CA+jJMxvV8rA+Yi3KhBr1iRyJDQp+BKT+xpUGihjwwTyuUGWLCg__32971.5748820037$1396981855$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXamP-0002An-MH
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 14:29:59 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so677061qab.4
 for <lttng-dev@lists.lttng.org>; Tue, 08 Apr 2014 11:29:48 -0700 (PDT)
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

Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
---
 doc/examples/demo-tracef/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/examples/demo-tracef/Makefile
b/doc/examples/demo-tracef/Makefile
index 644acdc..40e9a58 100644
--- a/doc/examples/demo-tracef/Makefile
+++ b/doc/examples/demo-tracef/Makefile
@@ -15,7 +15,10 @@
 #
 # This makefile is purposefully kept simple to support GNU and BSD make.

-CC =3D gcc
+ifdef AM_CC
+       CC =3D $(AM_CC)
+endif
+
 LIBS =3D -ldl -llttng-ust        # On Linux
 #LIBS =3D -lc    # On BSD
 LOCAL_CPPFLAGS +=3D -I.
--
1.9.1
