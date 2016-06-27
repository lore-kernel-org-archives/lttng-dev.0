From: Mohamad <mohamad.gebai@gmail.com>
Subject: Re: [PATCH] Fix: RHEL 7.2 kvm instrumentation
Date: Mon, 27 Jun 2016 13:40:07 -0400
Message-ID: <577164F7.3040608__36425.6941866644$1467049240$gmane$org@gmail.com>
References: <CABp_NWB7SQ9zz8F9UhKJjD_a274OBDjOvQ78Yvm-Hs1N_7zxLw@mail.gmail.com>
 <1451271429.49557.1467044037388.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6806293631659162728=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 36B5BA39B5
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2016 17:40:14 +0000 (UTC)
Received: by mail-it0-f68.google.com with SMTP id y93so11259098ita.0
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2016 10:40:14 -0700 (PDT)
In-Reply-To: <1451271429.49557.1467044037388.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============6806293631659162728==
Content-Type: multipart/alternative;
 boundary="------------050700080405080901000308"

This is a multi-part message in MIME format.
--------------050700080405080901000308
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/27/2016 12:13 PM, Mathieu Desnoyers wrote:
>
> ----- On Jun 27, 2016, at 11:26 AM, mo geb <mohamad.gebai@gmail.com> 
> wrote:
>
> Please use [PATCH lttng-modules] in the subject.
>
Got it.
>
>     Signed-off-by: Mohamad Gebai <mohamad.gebai@gmail.com>
>     ---
>      instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 3 ++-
>      1 file changed, 2 insertions(+), 1 deletion(-)
>
>     diff --git
>     a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>     b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>     index 1282bea..ef3d8aa 100644
>     --- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>     +++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>     @@ -429,7 +429,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,
>                     ctf_integer(__u8, len,
>     vcpu->arch.emulate_ctxt.decode.eip
>                                     -
>     vcpu->arch.emulate_ctxt.decode.fetch.start)
>                     ctf_array(__u8, insn,
>     vcpu->arch.emulate_ctxt.decode.fetch.data, 15)
>     -#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0))
>     +#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) \
>     +    && !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
>
>
> We don't use negation "!" in kernel version range tests. We also don't use
> "&&" typically, to make the code easier to maintain.
>
> Instead, we might want to swap the order in which ifdefs are done, and put
> newer versions at the top, e.g.:
>
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) \
>   || LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
> ...
> #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
> ...
> #else
> ...
> #endif
>
> Thanks,
>
> Mathieu
>

Thanks for the comments, I'll make those changes and resubmit. I just 
want to point out that I used a check similar to what's in 
wrapper/trace-clock.h:

#if ((LTTNG_KERNEL_RANGE(3,10,0, 3,10,14) && 
!LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,0, 3,10,14,0,0)) \
     || LTTNG_KERNEL_RANGE(3,11,0, 3,11,3))
#error "Linux kernels 3.10 and 3.11 introduce a deadlock in the 
timekeeping subsystem. Fixed by commit 
7bd36014460f793c19e7d6c94dab67b0afcfcb7f \"timekeeping: Fix HRTICK 
related deadlock from ntp lock changes\" in Linux."
#endif

Mohamad


--------------050700080405080901000308
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body smarttemplateinserted=3D"true" bgcolor=3D"#FFFFFF" text=3D"#00000=
0">
    <div class=3D"moz-cite-prefix"><br>
      On 06/27/2016 12:13 PM, Mathieu Desnoyers wrote:<br>
    </div>
    <blockquote
      cite=3D"mid:1451271429.49557.1467044037388.JavaMail.zimbra@efficios=
.com"
      type=3D"cite">
      <div style=3D"font-family: arial, helvetica, sans-serif; font-size:
        12pt; color: #000000">
        <div><br>
        </div>
        <div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Jun =
27,
            2016, at 11:26 AM, mo geb <a class=3D"moz-txt-link-rfc2396E"
              href=3D"mailto:mohamad.gebai@gmail.com">&lt;mohamad.gebai@g=
mail.com&gt;</a>
            wrote:<br>
          </span></div>
        <div data-marker=3D"__QUOTED_TEXT__">
          <div><br>
          </div>
          <div>Please use [PATCH lttng-modules] in the subject.<br
              data-mce-bogus=3D"1">
          </div>
          <div><br data-mce-bogus=3D"1">
          </div>
        </div>
      </div>
    </blockquote>
    Got it.<br>
    <blockquote
      cite=3D"mid:1451271429.49557.1467044037388.JavaMail.zimbra@efficios=
.com"
      type=3D"cite">
      <div style=3D"font-family: arial, helvetica, sans-serif; font-size:
        12pt; color: #000000">
        <div data-marker=3D"__QUOTED_TEXT__">
          <div> </div>
          <blockquote style=3D"border-left:2px solid
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-ser=
if;font-size:12pt;">
            <div dir=3D"ltr">
              <div>Signed-off-by: Mohamad Gebai &lt;<a
                  class=3D"moz-txt-link-abbreviated"
                  href=3D"mailto:mohamad.gebai@gmail.com"><a class=3D"moz=
-txt-link-abbreviated" href=3D"mailto:mohamad.gebai@gmail.com">mohamad.ge=
bai@gmail.com</a></a>&gt;<br>
                ---<br>
                =C2=A0instrumentation/events/lttng-module/arch/x86/kvm/tr=
ace.h

                | 3 ++-<br>
                =C2=A01 file changed, 2 insertions(+), 1 deletion(-)</div=
>
              <p>diff --git
                a/instrumentation/events/lttng-module/arch/x86/kvm/trace.=
h
b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
                index 1282bea..ef3d8aa 100644<br>
                ---
                a/instrumentation/events/lttng-module/arch/x86/kvm/trace.=
h<br>
                +++
                b/instrumentation/events/lttng-module/arch/x86/kvm/trace.=
h<br>
                @@ -429,7 +429,8 @@
                LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer(__u8, len,
                vcpu-&gt;arch.emulate_ctxt.decode.eip<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
                vcpu-&gt;arch.emulate_ctxt.decode.fetch.start)<br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_array(__u8, insn,
                vcpu-&gt;arch.emulate_ctxt.decode.fetch.data, 15)<br>
                -#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0))<b=
r>
                +#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0) \<=
br>
                +=C2=A0=C2=A0=C2=A0 &amp;&amp; !LTTNG_RHEL_KERNEL_RANGE(3=
,10,0,7,2,
                3,11,0,0,0))</p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>We don't use negation "!" in kernel version range tests.
            We also don't use<br data-mce-bogus=3D"1">
          </div>
          <div>"&amp;&amp;" typically, to make the code easier to
            maintain.<br data-mce-bogus=3D"1">
          </div>
          <div><br data-mce-bogus=3D"1">
          </div>
          <div>Instead, we might want to swap the order in which ifdefs
            are done, and put<br data-mce-bogus=3D"1">
          </div>
          <div>newer versions at the top, e.g.:<br data-mce-bogus=3D"1">
          </div>
          <div><br data-mce-bogus=3D"1">
          </div>
          <div>#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,17,0)) \<=
br
              data-mce-bogus=3D"1">
          </div>
          <div>=C2=A0 || LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))=
<br
              data-mce-bogus=3D"1">
          </div>
          <div>...<br data-mce-bogus=3D"1">
          </div>
          <div>#elif (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,1,0))<b=
r
              data-mce-bogus=3D"1">
          </div>
          <div>...<br data-mce-bogus=3D"1">
          </div>
          <div>#else<br data-mce-bogus=3D"1">
          </div>
          <div>...<br data-mce-bogus=3D"1">
          </div>
          <div>#endif<br data-mce-bogus=3D"1">
          </div>
          <div><br data-mce-bogus=3D"1">
          </div>
          <div>Thanks,<br data-mce-bogus=3D"1">
          </div>
          <div><br data-mce-bogus=3D"1">
          </div>
          <div>Mathieu<br data-mce-bogus=3D"1">
          </div>
          <div><br data-mce-bogus=3D"1">
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Thanks for the comments, I'll make those changes and resubmit. I
    just want to point out that I used a check similar to what's in
    wrapper/trace-clock.h:<br>
    <br>
    #if ((LTTNG_KERNEL_RANGE(3,10,0, 3,10,14) &amp;&amp;
    !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,0, 3,10,14,0,0)) \<br>
    =C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,11,0, 3,11,3))<br>
    #error "Linux kernels 3.10 and 3.11 introduce a deadlock in the
    timekeeping subsystem. Fixed by commit
    7bd36014460f793c19e7d6c94dab67b0afcfcb7f \"timekeeping: Fix HRTICK
    related deadlock from ntp lock changes\" in Linux."<br>
    #endif<br>
    <br>
    Mohamad<br>
    <br>
  </body>
</html>

--------------050700080405080901000308--

--===============6806293631659162728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6806293631659162728==--
