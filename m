Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A8C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 25 Apr 2022 13:00:37 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Kn4r33ycYzCvs;
	Mon, 25 Apr 2022 09:00:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1650891636;
	bh=ksbJePMS1rN/IXYDb96dQXJMoL7YT0/0vYqDmqGWmYU=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cxwNX3V8lVVNcMFtPTpOQEvY+L7C8IOl8MPVNBvTRkAAvR97A7q3fol1aouuy4lN+
	 pA/sqmOV4JTQzCL2ertREZMmGuE0Gv/FQ1BzmPRVciN12NV+BEuvXF/66e7nhgDHJB
	 Com+EvDMk6S/xCcFjFLghl9GtNoZDJbHykeTJgKYBdXkLiE5BM0eHXofjUZ6SshDI2
	 wq7YGeIlpFEIzDsbyUAEHKJp2tz/NnaapejqxGHIHpzKkboU65oU3d1CLrCMSBYEHp
	 hQEEEU5YqbKK9jEQ4Qd8n5UhYwrG0SO/pSe7DcWy7FnE1ubfI3fmubmVeRPv3iHt+A
	 m+uWN/R+5ihjw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Kn4r247FMzCvr
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2022 09:00:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BB0063CD979;
 Mon, 25 Apr 2022 09:00:23 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id jR4M7k6F6weu; Mon, 25 Apr 2022 09:00:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 223B13CD978;
 Mon, 25 Apr 2022 09:00:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 223B13CD978
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4A6KmXiIth6A; Mon, 25 Apr 2022 09:00:23 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 10C3C3CD977;
 Mon, 25 Apr 2022 09:00:23 -0400 (EDT)
Date: Mon, 25 Apr 2022 09:00:22 -0400 (EDT)
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <358746537.34457.1650891622938.JavaMail.zimbra@efficios.com>
In-Reply-To: <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
References: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
 <3c11308e-006a-a7e9-8482-c6b341690530@redhat.com>
 <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF99 (Linux)/8.8.15_GA_4257)
Thread-Topic: Unexport of kvm_x86_ops vs tracer modules
Thread-Index: HRgc0Gw3F7w+0GLEUzyCTgfg1qIAWyO4TBSN
Subject: Re: [lttng-dev] Unexport of kvm_x86_ops vs tracer modules
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sean Christopherson <seanjc@google.com>,
 lttng-dev <lttng-dev@lists.lttng.org>, KVM list <kvm@vger.kernel.org>,
 rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Apr 8, 2022, at 2:06 PM, Mathieu Desnoyers via lttng-dev lttng-dev@lists.lttng.org wrote:

> ----- On Apr 8, 2022, at 12:24 PM, Paolo Bonzini pbonzini@redhat.com wrote:
> 
>> On 4/8/22 17:36, Mathieu Desnoyers wrote:
>>> LTTng is an out of tree kernel module, which currently relies on the export.
>>> Indeed, arch/x86/kvm/x86.c exports a set of tracepoints to kernel modules, e.g.:
>>> 
>>> EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_entry)
>>> 
>>> But any probe implementation hooking on that tracepoint would need kvm_x86_ops
>>> to translate the struct kvm_vcpu * into meaningful tracing data.
>>> 
>>> I could work-around this on my side in ugly ways, but I would like to discuss
>>> how kernel module tracers are expected to implement kvm events probes without
>>> the kvm_x86_ops symbol ?
>> 
>> The conversion is done in the TP_fast_assign snippets, which are part of
>> kvm.ko and therefore do not need the export.  As I understand it, the
>> issue is that LTTng cannot use the TP_fast_assign snippets, because they
>> are embedded in the trace_event_raw_event_* symbols?
> 
> Indeed, the fact that the TP_fast_assign snippets are embedded in the
> trace_event_raw_event_* symbols is an issue for LTTng. This ties those
> to ftrace.
> 
> AFAIK, TP_fast_assign copies directly into ftrace ring buffers, and then
> afterwards things like dynamic filters are applied, which then "uncommits" the
> events if need be (and if possible). Also, TP_fast_assign is tied to the
> ftrace ring buffer event layout. The fact that the TP_STRUCT__entry()
> (description)
> and TP_fast_assign() (open-coded C) are separate fields really focuses on a
> use-case where all data is serialized to a ring buffer.
> 
> In LTTng, the event fields are made available to a filter interpreter prior to
> being copied into LTTng's ring buffer. This is made possible by implementing
> our own LTTNG_TRACEPOINT_EVENT code generation headers. In addition, we have
> recently released an event notification mechanism (lttng 2.13) which captures
> specific event fields to send with an immediate notification (thus bypassing the
> tracer buffering). We are also currently working on a LTTng trace hit counters
> mechanism, which performs aggregation through per-cpu counters, which doesn't
> even allocate a ring buffer.
> 
> For those reasons, LTTng reimplements its own tracepoint probe callbacks. All
> those sit within LTTng kernel modules, which means we currently need the
> exported
> kvm_x86_ops callbacks.
> 
>> We cannot do the extraction before calling trace_kvm_exit, because it's
>> expensive.
> 
> I suspect that extracting relevant data prior to calling trace_kvm_exit
> is too expensive because it cannot be skipped when the tracepoint is
> disabled. This is because trace_kvm_exit() is a static inline function,
> and the check to figure out if the event is enabled is within that function.
> Unfortunately, even if the tracepoint is disabled, the side-effects of the
> parameters passed to trace_kvm_exit() must happen.
> 
> I've solved this in LTTng-UST by implementing a lttng_ust_tracepoint()
> macro, which basically "lifts" the tracepoint enabled check before the
> evaluation of the arguments.
> 
> You could achieve something similar by using trace_kvm_exit_enabled() in the
> kernel like so:
> 
>  if (trace_kvm_exit_enabled())
>      trace_kvm_exit(....);
> 
> Which would skip evaluation of the argument side-effects when the tracepoint is
> disabled.
> 
> By doing that, when multiple tracers are attached to a kvm tracepoint, the
> translation from pointer-to-internal-structure to meaningful fields would only
> need to be done once when a tracepoint is hit. And this would remove the need
> for using kvm_x86_ops callbacks from tracer probe functions.
> 
> Thoughts ?

Hi Paolo,

We are at 5.18-rc4 now. Should I expect this unexport to stay in place
for 5.18 final and go ahead with using kallsyms to find this symbol from
lttng-modules instead ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
