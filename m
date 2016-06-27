From: mo geb <mohamad.gebai@gmail.com>
Subject: [PATCH] Fix: RHEL 7.2 kvm instrumentation
Date: Mon, 27 Jun 2016 11:26:18 -0400
Message-ID: <CABp_NWB7SQ9zz8F9UhKJjD_a274OBDjOvQ78Yvm-Hs1N_7zxLw__43522.0375228257$1467041196$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0225622204806904425=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9F426A385D
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2016 15:26:19 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id r136so11683733qke.3
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2016 08:26:19 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0225622204806904425==
Content-Type: multipart/alternative; boundary=001a114388d8533d040536442458

--001a114388d8533d040536442458
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Mohamad Gebai <mohamad.gebai@gmail.com>
---
 instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
index 1282bea..ef3d8aa 100644
--- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
+++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
@@ -429,7 +429,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,
                ctf_integer(__u8, len, vcpu->arch.emulate_ctxt.decode.eip
                                -
vcpu->arch.emulate_ctxt.decode.fetch.start)
                ctf_array(__u8, insn,
vcpu->arch.emulate_ctxt.decode.fetch.data, 15)
-#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0))
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) \
+    && !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
                ctf_integer(__u64, rip, vcpu->arch.emulate_ctxt.fetch.start)
                ctf_integer(__u32, csbase,
kvm_x86_ops->get_segment_base(vcpu, VCPU_SREG_CS))
                ctf_integer(__u8, len, vcpu->arch.emulate_ctxt._eip
-- 
2.1.1

--001a114388d8533d040536442458
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>=C2=A0</div><div>Signed-off-by: Mohamad Gebai &lt;<a =
href=3D"mailto:mohamad.gebai@gmail.com">mohamad.gebai@gmail.com</a>&gt;<br>=
---<br>=C2=A0instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 3 +=
+-<br>=C2=A01 file changed, 2 insertions(+), 1 deletion(-)</div><p>diff --g=
it a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h b/instrumenta=
tion/events/lttng-module/arch/x86/kvm/trace.h<br>index 1282bea..ef3d8aa 100=
644<br>--- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>++=
+ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>@@ -429,7 +=
429,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_i=
nteger(__u8, len, vcpu-&gt;arch.emulate_ctxt.decode.eip<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 - vcpu-&gt;arch.emulate_ctxt.decode.fetch.start)<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ctf_array(__u8, insn, vcpu-&gt;arch.emulate_ctxt.decode.fet=
ch.data, 15)<br>-#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0))<br>=
+#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0) \<br>+=C2=A0=C2=A0=
=C2=A0 &amp;&amp; !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ctf_integer(__u64, rip, vcpu-&gt;arch.emulate_ctxt.fetch.start=
)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ctf_integer(__u32, csbase, kvm_x86_ops-&gt;get_segmen=
t_base(vcpu, VCPU_SREG_CS))<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer(__u8, len, vcp=
u-&gt;arch.emulate_ctxt._eip<br>-- <br>2.1.1<br></p></div>

--001a114388d8533d040536442458--

--===============0225622204806904425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0225622204806904425==--
