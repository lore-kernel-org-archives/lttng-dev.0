Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D553C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 25 Apr 2022 16:03:03 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Kn8tZ24zKzDTl;
	Mon, 25 Apr 2022 12:03:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1650902582;
	bh=6lU6Z9uT+7IkR7Asr5LhM+6I1owTFcNFhq0G1VRJq5o=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=r8NdY+nWuxKNM07skMLk4Gs3XmEOCygEdCJS5aGGNNX6NxYmd6Mip8C42LpLoq2cP
	 Pns2CrxrhHF4TzeRi8B7ORrrvUkhuG0ztah/aZfvOUnjtW3+IAHaVSUSmZuTMHeARr
	 gRxXk3eN7hO4JariqZF57otMsP/XjdDJs7H+qMAFXJhW2AMaXiyysIYQkO7gEC9Fr3
	 uMcbEG126GXQrsgb3RglZkd8EbD7ela/lc0FqbOt1vXsbheNyVjAsGqo/2t4FtQ63o
	 uM+ES3dwzVgBA1XkN1TJ2cjCwnfjbU/vgqswC0M+pQvO4VeHUCNCbzl+cfieJ/27AR
	 v9uVI/J1NA9UQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Kn8tX4MppzDTf
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2022 12:02:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1CB8F3CF1E0;
 Mon, 25 Apr 2022 12:02:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id nUJgFl7voe_k; Mon, 25 Apr 2022 12:02:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 767C43CF469;
 Mon, 25 Apr 2022 12:02:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 767C43CF469
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id GlP_LFzoRsYa; Mon, 25 Apr 2022 12:02:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 684F43CF1DF;
 Mon, 25 Apr 2022 12:02:52 -0400 (EDT)
Date: Mon, 25 Apr 2022 12:02:52 -0400 (EDT)
To: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <892959086.34940.1650902572304.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220425100434.2f5d18bb@gandalf.local.home>
References: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
 <3c11308e-006a-a7e9-8482-c6b341690530@redhat.com>
 <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
 <20220425100434.2f5d18bb@gandalf.local.home>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF99 (Linux)/8.8.15_GA_4257)
Thread-Topic: Unexport of kvm_x86_ops vs tracer modules
Thread-Index: gjp2UP+GQzqompjQk+kWzrxYc4diFA==
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, lttng-dev <lttng-dev@lists.lttng.org>,
 KVM list <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Apr 25, 2022, at 10:04 AM, Steven Rostedt rostedt@goodmis.org wrote:

> On Fri, 8 Apr 2022 14:06:53 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> 
>> Indeed, the fact that the TP_fast_assign snippets are embedded in the
>> trace_event_raw_event_* symbols is an issue for LTTng. This ties those
>> to ftrace.
> 
> Not just ftrace, perf does it too.
> 
> Now another solution is to make the fast assigns available to anyone, and
> to allow you to simply pass in a pointer and size to have the data written
> into it. That is, you get the results of the TRACE_EVENT and not have to
> depend on internal data from the tracepoint.

If the fast assign can then be used on a field-per-field basis, maybe this
could work, but AFAIK the fast-assign macro is open-coded C, which makes this
not straightforward.

If it's a all-or-nothing approach where the fast-assign needs to serialize all
fields, this would require that lttng copies the data into a temporary area,
which is something I want to avoid for filtering and event notification per-field
payload capture purposes.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
