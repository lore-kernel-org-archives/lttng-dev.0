From: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: [RFC] [PATCH] -Werror=old-style-definition and UST
	tracepoints
Date: Fri, 8 Jun 2012 11:26:23 -0700
Message-ID: <4FD243CF.60104__36666.024514898$1339180017$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hollis_Blanchard@mentor.com>) id 1Sd3tH-0002sy-QA
	for lttng-dev@lists.lttng.org; Fri, 08 Jun 2012 14:26:31 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1Sd3tA-0006yJ-OJ from Hollis_Blanchard@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 08 Jun 2012 11:26:24 -0700
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

I've defined a tracepoint without arguments:

    TRACEPOINT_EVENT(

         qemu_tb_hash,

         flushall,

         TP_ARGS(void),

         TP_FIELDS()

    )


When I build (with -Werror=3Dold-style-definition), I get this error:

    In file included from /home/hollisb/work/qemu.git/exec.c:59:0:

    /home/hollisb/work/qemu.git/tracepoints.h:24:2: error: function declara=
tion isn=92t a prototype [-Werror=3Dstrict-prototypes]

    /home/hollisb/work/qemu.git/tracepoints.h: In function =91__tracepoint_=
cb_qemu_tb_hash___flushall=92:

    /home/hollisb/work/qemu.git/tracepoints.h:24:2: error: old-style functi=
on definition [-Werror=3Dold-style-definition]

    cc1: all warnings being treated as errors


The preprocessed code looks like so:

    extern struct

    # 129 "/usr/local/include/lttng/tracepoint.h" 3

                   tracepoint

    # 24 "/home/hollisb/work/qemu.git/tracepoints.h"

      __tracepoint_qemu_tb_hash___flushall

    # 19 "/home/hollisb/work/qemu.git/tracepoints.h"

      ; static __attribute__ (( always_inline )) __inline__ void

      __tracepoint_cb_qemu_tb_hash___flushall

    # 19 "/home/hollisb/work/qemu.git/tracepoints.h"

      () { struct tracepoint_probe *__tp_probe; if (!tracepoint_dlopen.rcu_=
read_lock_sym_bp) return; tracepoint_dlopen.rcu_read_lock_sym_bp(); __tp_pr=
obe =3D ({ typeof(__tracepoint_qemu_tb_hash___flushall.probes) _________p1 =
=3D ((typeof(__tracepoint_qemu_tb_hash___flushall.probes)) (tracepoint_dlop=
en.rcu_dereference_sym_bp(((void *) (__tracepoint_qemu_tb_hash___flushall.p=
robes))))); (_________p1); }); if (__builtin_expect(!!(!__tp_probe), 0)) go=
to end; do { void *__tp_cb =3D __tp_probe->func; void *__tp_data =3D __tp_p=
robe->data; ((void (*)(void *__tp_data)) (__tp_cb)) (__tp_data); } while ((=
++__tp_probe)->func); end: tracepoint_dlopen.rcu_read_unlock_sym_bp(); } st=
atic __attribute__ (( always_inline )) __inline__ void


I believe the problem comes from -Werror=3Dold-style-definition not liking =

that empty "()", i.e. tracepoint_cb_qemu_tb_hash___flushall() { ... }. =

The following patch seems to work for me; is there a reason it isn't =

already written this way?

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h

index 4b773bb..60d8c73 100644

--- a/include/lttng/tracepoint.h

+++ b/include/lttng/tracepoint.h

@@ -88,7 +88,7 @@ extern "C" {

  #define _TP_EXDATA_VAR20(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t)      __=
tp_data,b,d,f,h,j,l,n,p,r,t

  =


  /* _TP_EXPROTO* extract tuples of type, var */

-#define _TP_EXPROTO0()

+#define _TP_EXPROTO0()                                         void

  #define _TP_EXPROTO2(a,b)                                      a b

  #define _TP_EXPROTO4(a,b,c,d)                                  a b,c d

  #define _TP_EXPROTO6(a,b,c,d,e,f)                              a b,c d,e f


If this is OK, I'm happy to resend as a proper patch.

-- =

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
