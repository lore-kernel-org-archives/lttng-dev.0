From: mo geb <mohamad.gebai@gmail.com>
Subject: Re: [PATCH] Fix: RHEL 7.2 kvm instrumentation
Date: Tue, 28 Jun 2016 15:28:58 -0400
Message-ID: <CABp_NWDwCyA=tqK_iyr+aodxrYYLSBmT70+okrceQjoXPONx3w__25091.975721489$1467142170$gmane$org@mail.gmail.com>
References: <CABp_NWB7SQ9zz8F9UhKJjD_a274OBDjOvQ78Yvm-Hs1N_7zxLw@mail.gmail.com>
 <1950656750.49828.1467050489472.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4056409000903553007=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 941C6A2B40
 for <lttng-dev@lists.lttng.org>; Tue, 28 Jun 2016 19:29:01 +0000 (UTC)
Received: by mail-qk0-f193.google.com with SMTP id n132so5454007qka.0
 for <lttng-dev@lists.lttng.org>; Tue, 28 Jun 2016 12:29:01 -0700 (PDT)
In-Reply-To: <1950656750.49828.1467050489472.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4056409000903553007==
Content-Type: multipart/alternative; boundary=94eb2c035ffe08b2f905365ba66f

--94eb2c035ffe08b2f905365ba66f
Content-Type: text/plain; charset=UTF-8

You're right, sorry about that. I was on an experimental branch of ours
(addons) and didn't think that macro had changed. I'll resubmit based on
master.

On Mon, Jun 27, 2016 at 2:01 PM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> Hi,
>
> This patch does not seem to target master or even 2.8 since the
> LTTNG_RHEL_KERNEL_RANGE macro was modified to take 6 arguments per
> RHEL kernel version.
>
> We usually only accept patches targeted at master that are then
> backported to supported versions.
>
> Regards,
>
> Michael
>
> ----- On Jun 27, 2016, at 11:26 AM, mo geb mohamad.gebai@gmail.com wrote:
>
> > Signed-off-by: Mohamad Gebai < mohamad.gebai@gmail.com >
> > ---
> > instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >
> > diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > index 1282bea..ef3d8aa 100644
> > --- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > +++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > @@ -429,7 +429,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,
> > ctf_integer(__u8, len, vcpu->arch.emulate_ctxt.decode.eip
> > - vcpu->arch.emulate_ctxt.decode.fetch.start)
> > ctf_array(__u8, insn, vcpu->arch.emulate_ctxt.decode.fetch.data, 15)
> > -#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0))
> > +#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) \
> > + && !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
> > ctf_integer(__u64, rip, vcpu->arch.emulate_ctxt.fetch.start)
> > ctf_integer(__u32, csbase, kvm_x86_ops->get_segment_base(vcpu,
> VCPU_SREG_CS))
> > ctf_integer(__u8, len, vcpu->arch.emulate_ctxt._eip
> > --
> > 2.1.1
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--94eb2c035ffe08b2f905365ba66f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You&#39;re right, sorry about that. I was on an experiment=
al branch of ours (addons) and didn&#39;t think that macro had changed. I&#=
39;ll resubmit based on master.</div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Mon, Jun 27, 2016 at 2:01 PM, Michael Jeanson <span =
dir=3D"ltr">&lt;<a href=3D"mailto:mjeanson@efficios.com" target=3D"_blank">=
mjeanson@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Hi,<br>
<br>
This patch does not seem to target master or even 2.8 since the<br>
LTTNG_RHEL_KERNEL_RANGE macro was modified to take 6 arguments per<br>
RHEL kernel version.<br>
<br>
We usually only accept patches targeted at master that are then<br>
backported to supported versions.<br>
<br>
Regards,<br>
<br>
Michael<br>
<span class=3D"im HOEnZb"><br>
----- On Jun 27, 2016, at 11:26 AM, mo geb <a href=3D"mailto:mohamad.gebai@=
gmail.com">mohamad.gebai@gmail.com</a> wrote:<br>
<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">&gt; Signed-off-by: Mohamad =
Gebai &lt; <a href=3D"mailto:mohamad.gebai@gmail.com">mohamad.gebai@gmail.c=
om</a> &gt;<br>
&gt; ---<br>
&gt; instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 3 ++-<br>
&gt; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt;<br>
&gt; diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<=
br>
&gt; b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
&gt; index 1282bea..ef3d8aa 100644<br>
&gt; --- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
&gt; +++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
&gt; @@ -429,7 +429,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,<br>
&gt; ctf_integer(__u8, len, vcpu-&gt;arch.emulate_ctxt.decode.eip<br>
&gt; - vcpu-&gt;arch.emulate_ctxt.decode.fetch.start)<br>
&gt; ctf_array(__u8, insn, vcpu-&gt;arch.emulate_ctxt.decode.fetch.data, 15=
)<br>
&gt; -#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0))<br>
&gt; +#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0) \<br>
&gt; + &amp;&amp; !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))<br>
&gt; ctf_integer(__u64, rip, vcpu-&gt;arch.emulate_ctxt.fetch.start)<br>
&gt; ctf_integer(__u32, csbase, kvm_x86_ops-&gt;get_segment_base(vcpu, VCPU=
_SREG_CS))<br>
&gt; ctf_integer(__u8, len, vcpu-&gt;arch.emulate_ctxt._eip<br>
&gt; --<br>
&gt; 2.1.1<br>
&gt;<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">&gt; __________________=
_____________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</div></div></blockquote></div><br></div>

--94eb2c035ffe08b2f905365ba66f--

--===============4056409000903553007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4056409000903553007==--
