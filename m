From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Emitting events from shared object constructors is
 (currently) not possible
Date: Thu, 22 Nov 2012 15:08:40 +0100
Message-ID: <50AE31E8.4040507__20908.9551157833$1353593324$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TbXRF-0004iG-Lu
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 09:07:33 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1TbXR9-0001VV-3h from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 06:07:27 -0800
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

I recently stumbled over the following lttng-ust limitation:

I tried to emit events from a shared objects constructor function:

__attribute__((constructor))
void func_constructor()
{
   tracepoint( foo, bar ); =

}

Unfortunately this doesn't work because the constructor functions of LTTng =
itself (__tracepoints__init and the ones from ust-tracepoint-event.h) are n=
ot yet run.

Trying to solve this problem with explicit constructor priority on my side =
alone doesn't work:

__attribute__((constructor (1111)))
void func_constructor()
{
   tracepoint( foo, bar ); =

}

That's because whatever I specify as priority is irrelevant. LTTng's constr=
uctors without priority will always come last.

After also adding priority to the lttng constructor I was able to make it w=
ork (see patch below):

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index 8b08914..532f1d2 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -261,7 +261,7 @@ int __tracepoint_registered
 struct tracepoint_dlopen tracepoint_dlopen
        __attribute__((weak, visibility("hidden")));
 =

-static void lttng_ust_notrace __attribute__((constructor))
+static void lttng_ust_notrace __attribute__((constructor (1000)))
 __tracepoints__init(void);
 static void
 __tracepoints__init(void)
@@ -300,7 +300,7 @@ __tracepoints__init(void)
                                __start___tracepoints_ptrs);
 }
 =

-static void lttng_ust_notrace __attribute__((destructor))
+static void lttng_ust_notrace __attribute__((destructor (1000)))
 __tracepoints__destroy(void);
 static void
 __tracepoints__destroy(void)
diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-trace=
point-event.h
index 74d06e1..7ad3144 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -638,7 +638,7 @@ static struct lttng_probe_desc _TP_COMBINE_TOKENS(__pro=
be_desc___, TRACEPOINT_PR
 =

 /* Reset all macros within TRACEPOINT_EVENT */
 #include <lttng/ust-tracepoint-event-reset.h>
-static void lttng_ust_notrace __attribute__((constructor))
+static void lttng_ust_notrace __attribute__((constructor (1000)))
 _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void);
 static void
 _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
@@ -649,7 +649,7 @@ _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PR=
OVIDER)(void)
        assert(!ret);
 }
 =

-static void lttng_ust_notrace __attribute__((destructor))
+static void lttng_ust_notrace __attribute__((destructor (1000)))
 _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void);
 static void
 _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void)



-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
