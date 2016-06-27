From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: RHEL 7.2 kvm instrumentation
Date: Mon, 27 Jun 2016 17:59:12 +0000 (UTC)
Message-ID: <396292907.49801.1467050352624.JavaMail.zimbra__30196.6271749281$1467050380$gmane$org@efficios.com>
References: <CABp_NWB7SQ9zz8F9UhKJjD_a274OBDjOvQ78Yvm-Hs1N_7zxLw@mail.gmail.com>
 <1451271429.49557.1467044037388.JavaMail.zimbra@efficios.com>
 <577164F7.3040608@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4363959859742877976=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E9865A36B6
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2016 17:59:17 +0000 (UTC)
In-Reply-To: <577164F7.3040608@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mohamad <mohamad.gebai@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4363959859742877976==
Content-Type: multipart/alternative;
	boundary="----=_Part_49800_1748172901.1467050352623"

------=_Part_49800_1748172901.1467050352623
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

---- On Jun 27, 2016, at 1:40 PM, Mohamad <mohamad.gebai@gmail.com> wrote: 

> On 06/27/2016 12:13 PM, Mathieu Desnoyers wrote:

>> ----- On Jun 27, 2016, at 11:26 AM, mo geb <mohamad.gebai@gmail.com> wrote:

>> Please use [PATCH lttng-modules] in the subject.

> Got it.

>>> Signed-off-by: Mohamad Gebai < mohamad.gebai@gmail.com >
>>> ---
>>> instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)

>>> diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>>> b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>>> index 1282bea..ef3d8aa 100644
>>> --- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>>> +++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
>>> @@ -429,7 +429,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,
>>> ctf_integer(__u8, len, vcpu->arch.emulate_ctxt.decode.eip
>>> - vcpu->arch.emulate_ctxt.decode.fetch.start)
>>> ctf_array(__u8, insn, vcpu->arch.emulate_ctxt.decode.fetch.data, 15)
>>> -#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0))
>>> +#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) \
>>> + && !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))

>> We don't use negation "!" in kernel version range tests. We also don't use
>> "&&" typically, to make the code easier to maintain.

>> Instead, we might want to swap the order in which ifdefs are done, and put
>> newer versions at the top, e.g.:

>> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) \
>> || LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
>> ...
>> #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
>> ...
>> #else
>> ...
>> #endif

>> Thanks,

>> Mathieu

> Thanks for the comments, I'll make those changes and resubmit. I just want to
> point out that I used a check similar to what's in wrapper/trace-clock.h:

> #if ((LTTNG_KERNEL_RANGE(3,10,0, 3,10,14) &&
> !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,0, 3,10,14,0,0)) \
> || LTTNG_KERNEL_RANGE(3,11,0, 3,11,3))
> #error "Linux kernels 3.10 and 3.11 introduce a deadlock in the timekeeping
> subsystem. Fixed by commit 7bd36014460f793c19e7d6c94dab67b0afcfcb7f
> \"timekeeping: Fix HRTICK related deadlock from ntp lock changes\" in Linux."
> #endif
This is OK for a single #if/endif that surrounds an error condition. For the instrumentation, 
we tend to end up having multiple #if #elif #elif #elif #endif that accumulate over time. 
In order to keep this maintainable, I try to avoid having && and ! there. 

Thanks, 

Mathieu 

> Mohamad

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_49800_1748172901.1467050352623
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body><div style="font-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000000"><div><span id="zwchr" data-marker="__DIVIDER__">---- On Jun 27, 2016, at 1:40 PM, Mohamad &lt;mohamad.gebai@gmail.com&gt; wrote:<br></span></div><div data-marker="__QUOTED_TEXT__"><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class="moz-cite-prefix"><br>
      On 06/27/2016 12:13 PM, Mathieu Desnoyers wrote:<br></div><blockquote cite="mid:1451271429.49557.1467044037388.JavaMail.zimbra@efficios.com"><div style="font-family: arial, helvetica, sans-serif; font-size:
        12pt; color: #000000"><div><br></div><div><span id="zwchr">----- On Jun 27,
            2016, at 11:26 AM, mo geb <a class="moz-txt-link-rfc2396E" href="mailto:mohamad.gebai@gmail.com" target="_blank">&lt;mohamad.gebai@gmail.com&gt;</a>
            wrote:<br>
          </span></div><div><div><br></div><div>Please use [PATCH lttng-modules] in the subject.<br></div><div><br></div></div></div></blockquote>
    Got it.<br><blockquote cite="mid:1451271429.49557.1467044037388.JavaMail.zimbra@efficios.com"><div style="font-family: arial, helvetica, sans-serif; font-size:
        12pt; color: #000000"><div><blockquote style="border-left:2px solid
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir="ltr"><div>Signed-off-by: Mohamad Gebai &lt;<a class="moz-txt-link-abbreviated" href="mailto:mohamad.gebai@gmail.com" target="_blank">mohamad.gebai@gmail.com</a>&gt;<br>
                ---<br>
                &nbsp;instrumentation/events/lttng-module/arch/x86/kvm/trace.h

                | 3 ++-<br>
                &nbsp;1 file changed, 2 insertions(+), 1 deletion(-)</div><p>diff --git
                a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
                index 1282bea..ef3d8aa 100644<br>
                ---
                a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
                +++
                b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
                @@ -429,7 +429,8 @@
                LTTNG_TRACEPOINT_EVENT(kvm_emulate_insn,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(__u8, len,
                vcpu-&gt;arch.emulate_ctxt.decode.eip<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
                vcpu-&gt;arch.emulate_ctxt.decode.fetch.start)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_array(__u8, insn,
                vcpu-&gt;arch.emulate_ctxt.decode.fetch.data, 15)<br>
                -#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0))<br>
                +#elif (LINUX_VERSION_CODE &lt; KERNEL_VERSION(3,17,0) \<br>
                +&nbsp;&nbsp;&nbsp; &amp;&amp; !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2,
                3,11,0,0,0))</p></div></blockquote><div><br></div><div>We don't use negation "!" in kernel version range tests.
            We also don't use<br></div><div>"&amp;&amp;" typically, to make the code easier to
            maintain.<br></div><div><br></div><div>Instead, we might want to swap the order in which ifdefs
            are done, and put<br></div><div>newer versions at the top, e.g.:<br></div><div><br></div><div>#if (LINUX_VERSION_CODE &gt;= KERNEL_VERSION(3,17,0)) \<br></div><div>&nbsp; || LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))<br></div><div>...<br></div><div>#elif (LINUX_VERSION_CODE &gt;= KERNEL_VERSION(3,1,0))<br></div><div>...<br></div><div>#else<br></div><div>...<br></div><div>#endif<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div></div></div></blockquote><br>
    Thanks for the comments, I'll make those changes and resubmit. I
    just want to point out that I used a check similar to what's in
    wrapper/trace-clock.h:<br><br>
    #if ((LTTNG_KERNEL_RANGE(3,10,0, 3,10,14) &amp;&amp;
    !LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,0, 3,10,14,0,0)) \<br>
    &nbsp;&nbsp;&nbsp; || LTTNG_KERNEL_RANGE(3,11,0, 3,11,3))<br>
    #error "Linux kernels 3.10 and 3.11 introduce a deadlock in the
    timekeeping subsystem. Fixed by commit
    7bd36014460f793c19e7d6c94dab67b0afcfcb7f \"timekeeping: Fix HRTICK
    related deadlock from ntp lock changes\" in Linux."<br>
    #endif</blockquote><div><br></div><div>This is OK for a single #if/endif that surrounds an error condition. For the instrumentation,<br data-mce-bogus="1"></div><div>we tend to end up having multiple #if #elif #elif #elif #endif that accumulate over time.<br data-mce-bogus="1"></div><div>In order to keep this maintainable, I try to avoid having &amp;&amp; and ! there.<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><div>Thanks,<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><div>Mathieu<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><br><b
 r>
    Mohamad<br><br><br>_______________________________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker="__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_49800_1748172901.1467050352623--

--===============4363959859742877976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4363959859742877976==--
