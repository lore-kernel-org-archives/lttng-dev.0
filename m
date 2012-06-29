From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: notrace missing in lttng-ust
Date: Fri, 29 Jun 2012 10:28:08 +0200
Message-ID: <4FED6718.1000205__8399.26982666857$1340958509$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1SkWYa-0006OO-TX
	for lttng-dev@lists.lttng.org; Fri, 29 Jun 2012 04:28:00 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1SkWYU-0002nV-E9 from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 29 Jun 2012 01:27:54 -0700
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

Hi Mathieu,

libust 0.x uses notrace (__attribute__((no_instrument_function)) for all =

functions that are involved in event emitting.

For example:
./libust/marker.c:122:notrace void __ust_marker_empty_function(const =

struct ust_marker *mdata,
./libust/marker.c:137:notrace void ust_marker_probe_cb(const struct =

ust_marker *mdata,
./libust/marker.c:197:static notrace void =

ust_marker_probe_cb_noarg(const struct ust_marker *mdata,

I just realized that this is no more the case for lttng-ust.
Was it a conscious decision not to use notrace for LTTng 2.0 lttng-ust, =

or is it just missing ?

I would like to have notrace also in lttng-ust, at least for the =

_DECLARE_TRACEPOINT macro in tracepoint.h.
Like this for example:

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index 5bab476..71665dc 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -137,6 +137,7 @@ extern "C" {

  #define _DECLARE_TRACEPOINT(_provider, _name, ...)     \
  extern struct tracepoint __tracepoint_##_provider##___##_name;         =

     \
+static inline void =

__tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__)) =

__attribute__ ((no_instrument_function));    \
  static inline void =

__tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__)) \
  {                                            \
      struct tracepoint_probe *__tp_probe;                        \
@@ -158,12 +159,16 @@ end:     \
      tp_rcu_read_unlock_bp();                            \
  }                                            \
  static inline void __tracepoint_register_##_provider##___##_name(char =

*name,        \
+        void (*func)(void), void *data) __attribute__ =

((no_instrument_function));    \
+static inline void __tracepoint_register_##_provider##___##_name(char =

*name,        \
          void (*func)(void), void *data) \
  {                                            \
      __tracepoint_probe_register(name, func, data,     \
          __tracepoint_##_provider##___##_name.signature); \
  }                                            \
  static inline void =

__tracepoint_unregister_##_provider##___##_name(char *name,        \
+        void (*func)(void), void *data) __attribute__ =

((no_instrument_function));    \
+static inline void __tracepoint_unregister_##_provider##___##_name(char =

*name,        \
          void (*func)(void), void *data) \
  {                                            \
      __tracepoint_probe_unregister(name, func, data); \

Greetings,
Paul

-- =

Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
