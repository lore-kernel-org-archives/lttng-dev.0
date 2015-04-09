From: Charlie Brown <stieizc.33@gmail.com>
Subject: lttng-modules fails to build on linux 3.18.9
Date: Thu, 9 Apr 2015 17:33:49 +0800
Message-ID: <CAPF+gF9Z5r0-_569EYiO-jTy63yRComw=7sEjyTq6UqGNGgQyg__42766.2342357964$1428572093$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1145852806=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vn0-f51.google.com ([209.85.216.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <stieizc.33@gmail.com>) id 1Yg8qR-0003UQ-0v
 for lttng-dev@lists.lttng.org; Thu, 09 Apr 2015 05:33:57 -0400
Received: by vnbg62 with SMTP id g62so21101848vnb.7
 for <lttng-dev@lists.lttng.org>; Thu, 09 Apr 2015 02:33:49 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1145852806==
Content-Type: multipart/alternative; boundary=089e0111b4d859c604051347588d

--089e0111b4d859c604051347588d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,
lttng-modules 2.6.0 fails to build on linux 3.18.9.
It seems that the marco that defines trace_##name in
include/linux/tracepoint.h has been changed to inline type.
http://permalink.gmane.org/gmane.comp.sysutils.lttng.devel/6332 Confirms
this bug.

Thank you for making lttng!

This is my build log
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------
In file included from
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/../../../probes/define_tr=
ace.h:136:0,
                 from
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/kvm.h:381,
                 from
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/lttng-probe-kvm.c:42:
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/../../../probes/lttng-eve=
nts.h:180:6:
error: conflicting types for =E2=80=98trace_kvm_age_page=E2=80=99
 void trace_##_name(_proto);
      ^
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/../../../probes/lttng-eve=
nts.h:47:2:
note: in expansion of macro =E2=80=98LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP=E2=
=80=99
  LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PARAMS(proto),
PARAMS(args))
  ^
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/../../../probes/lttng-eve=
nts.h:107:2:
note: in expansion of macro =E2=80=98LTTNG_TRACEPOINT_EVENT_MAP=E2=80=99
  LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
  ^
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/../../../probes/../instru=
mentation/events/lttng-module/kvm.h:235:1:
note: in expansion of macro =E2=80=98LTTNG_TRACEPOINT_EVENT=E2=80=99
 LTTNG_TRACEPOINT_EVENT(kvm_age_page,
 ^
In file included from ./arch/x86/include/asm/kvm_host.h:17:0,
                 from include/linux/kvm_host.h:34,
                 from
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/lttng-probe-kvm.c:24:
include/linux/tracepoint.h:169:21: note: previous definition of
=E2=80=98trace_kvm_age_page=E2=80=99 was here
  static inline void trace_##name(proto)    \
                     ^
include/linux/tracepoint.h:325:3: note: in expansion of macro
=E2=80=98__DECLARE_TRACE=E2=80=99
   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
   ^
include/linux/tracepoint.h:459:2: note: in expansion of macro
=E2=80=98DECLARE_TRACE=E2=80=99
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^
include/trace/events/kvm.h:227:1: note: in expansion of macro =E2=80=98TRAC=
E_EVENT=E2=80=99
 TRACE_EVENT(kvm_age_page,
 ^
  CC [M]
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/lib/ringbuffer/ring_buffer_mmap.o
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------

Sincerely,
=E7=8E=8B=E6=96=87=E9=91=AB
Charlie

--089e0111b4d859c604051347588d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi all,<br></div>lttng-modules 2.6.0 fails =
to build on linux 3.18.9.<br></div>It seems that the marco that defines tra=
ce_##name in include/linux/tracepoint.h has been changed to inline type.<br=
><a href=3D"http://permalink.gmane.org/gmane.comp.sysutils.lttng.devel/6332=
">http://permalink.gmane.org/gmane.comp.sysutils.lttng.devel/6332</a> Confi=
rms this bug.<br></div><br>Thank you for making lttng!<br><div><div><br>Thi=
s is my build log<br>------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------<br>In
 file included from=20
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/../../../probes/define_tr=
ace.h:136:0,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
 from=20
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/../instrumentation/events/lttng-module/kvm.h:381,<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
 from=20
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/lttng-probe-kvm.c:42:<br>/var/tmp/portage/dev-util/lttng-modules=
-2.6.0_rc1/work/lttng-modules-2.6.0-rc1/probes/../instrumentation/events/lt=
tng-module/../../../probes/lttng-events.h:180:6:
 error: conflicting types for =E2=80=98trace_kvm_age_page=E2=80=99<br>=C2=
=A0void trace_##_name(_proto);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<br>/var/=
tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-rc1/p=
robes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h=
:47:2:
 note: in expansion of macro =E2=80=98LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP=
=E2=80=99<br>=C2=A0 LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PAR=
AMS(proto), PARAMS(args))<br>=C2=A0 ^<br>/var/tmp/portage/dev-util/lttng-mo=
dules-2.6.0_rc1/work/lttng-modules-2.6.0-rc1/probes/../instrumentation/even=
ts/lttng-module/../../../probes/lttng-events.h:107:2:
 note: in expansion of macro =E2=80=98LTTNG_TRACEPOINT_EVENT_MAP=E2=80=99<b=
r>=C2=A0 LTTNG_TRACEPOINT_EVENT_MAP(name, name,=C2=A0=C2=A0=C2=A0 \<br>=C2=
=A0 ^<br>/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modul=
es-2.6.0-rc1/probes/../instrumentation/events/lttng-module/../../../probes/=
../instrumentation/events/lttng-module/kvm.h:235:1:
 note: in expansion of macro =E2=80=98LTTNG_TRACEPOINT_EVENT=E2=80=99<br>=
=C2=A0LTTNG_TRACEPOINT_EVENT(kvm_age_page,<br>=C2=A0^<br>In file included f=
rom ./arch/x86/include/asm/kvm_host.h:17:0,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from =
include/linux/kvm_host.h:34,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
 from=20
/var/tmp/portage/dev-util/lttng-modules-2.6.0_rc1/work/lttng-modules-2.6.0-=
rc1/probes/lttng-probe-kvm.c:24:<br>include/linux/tracepoint.h:169:21: note=
: previous definition of =E2=80=98trace_kvm_age_page=E2=80=99 was here<br>=
=C2=A0 static inline void trace_##name(proto)=C2=A0=C2=A0=C2=A0 \<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<br>include/linux/tracepoint.h:325=
:3: note: in expansion of macro =E2=80=98__DECLARE_TRACE=E2=80=99<br>=C2=A0=
=C2=A0 __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \<br>=C2=A0=C2=
=A0 ^<br>include/linux/tracepoint.h:459:2: note: in expansion of macro =E2=
=80=98DECLARE_TRACE=E2=80=99<br>=C2=A0 DECLARE_TRACE(name, PARAMS(proto), P=
ARAMS(args))<br>=C2=A0 ^<br>include/trace/events/kvm.h:227:1: note: in expa=
nsion of macro =E2=80=98TRACE_EVENT=E2=80=99<br>=C2=A0TRACE_EVENT(kvm_age_p=
age,<br>=C2=A0^<br>=C2=A0 CC [M]=C2=A0 /var/tmp/portage/dev-util/lttng-modu=
les-2.6.0_rc1/work/lttng-modules-2.6.0-rc1/lib/ringbuffer/ring_buffer_mmap.=
o<br>----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------<br><br clear=3D"all"><div><div><div><div class=3D"gmail_sig=
nature"><div dir=3D"ltr">Sincerely,<br>=E7=8E=8B=E6=96=87=E9=91=AB<br><div>=
Charlie</div></div></div></div>
</div></div></div></div></div>

--089e0111b4d859c604051347588d--


--===============1145852806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1145852806==--
