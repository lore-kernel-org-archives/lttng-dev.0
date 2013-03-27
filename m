From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: [lttng-ust PATCH] Fix: forwarding of call_site argument
	to field
Date: Wed, 27 Mar 2013 14:53:17 +0100
Message-ID: <5152F9CD.5040809__45761.2913604409$1364392428$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1UKqmY-0005IY-Ma
	for lttng-dev@lists.lttng.org; Wed, 27 Mar 2013 09:52:50 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I ran some tests with the new function entry/exit instrumentations.

The tracepoint provider for lttng_ust_cyg_profile:func_entry and
func_exit does not properly forward the call_site argument to the
call_site field. The patch below fixes the problem.


From c2891f8d78922170175d05a03253dcd418182868 Mon Sep 17 00:00:00 2001
From: Paul Woegerer <paul_woegerer@mentor.com>
Date: Wed, 27 Mar 2013 14:34:35 +0100
Subject: [PATCH] Fix forwarding of call_site argument to field

---
 liblttng-ust-cyg-profile/lttng-ust-cyg-profile.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-cyg-profile/lttng-ust-cyg-profile.h b/liblttng-us=
t-cyg-profile/lttng-ust-cyg-profile.h
index 7629fb9..2e6dda8 100644
--- a/liblttng-ust-cyg-profile/lttng-ust-cyg-profile.h
+++ b/liblttng-ust-cyg-profile/lttng-ust-cyg-profile.h
@@ -36,7 +36,7 @@ TRACEPOINT_EVENT(lttng_ust_cyg_profile, func_entry,
 	TP_ARGS(void *, func_addr, void *, call_site),
 	TP_FIELDS(
 		ctf_integer_hex(void *, addr, func_addr)
-		ctf_integer_hex(void *, call_site, func_addr)
+		ctf_integer_hex(void *, call_site, call_site)
 	)
 )
 =

@@ -47,7 +47,7 @@ TRACEPOINT_EVENT(lttng_ust_cyg_profile, func_exit,
 	TP_ARGS(void *, func_addr, void *, call_site),
 	TP_FIELDS(
 		ctf_integer_hex(void *, addr, func_addr)
-		ctf_integer_hex(void *, call_site, func_addr)
+		ctf_integer_hex(void *, call_site, call_site)
 	)
 )
 =

-- =

1.7.10.4

-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
