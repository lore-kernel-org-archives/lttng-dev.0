Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90173C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 25 Apr 2022 14:12:59 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Kn6RY5cHlzD04;
	Mon, 25 Apr 2022 10:12:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1650895978;
	bh=gxaeqXdDUHHXtDu0OLvQNUFIGmslr1+7kkBk7vvk93M=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HO4hH+wwIf+svprZSCqog2rBZmN3rjMAf9AJZxanKvPhGi0RN1kxpZwojq42f8iab
	 qYXmHGfCTdRXGV8lK/XGcBfOVaDbFrgFhrxoG31U13ZyIy3/+k9HNexJtlMih9OhM1
	 O9PtykXfzbZD1nA015xfibfOwQIc1gpq658KbfyUPxADDD3gBoA8xvYFt+adw1GRbN
	 ENmWBIuhPnd1eKc/ibmKFFJPTtPtLtwd/S82MUuZJlzltSk3MBDAU9viwL2EeTzNxz
	 2PzMhgCI4+jBlZPJ6tY47RFQMxORTe8uy1iBiZKFBpyLMCyyUnPc25wEX2YKECKdmA
	 uh28hRZfDiiRQ==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4Kn6RX6dQ9zDJT
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2022 10:12:56 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 091D0615DC;
 Mon, 25 Apr 2022 14:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0656C385A7;
 Mon, 25 Apr 2022 14:04:35 +0000 (UTC)
Date: Mon, 25 Apr 2022 10:04:34 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <20220425100434.2f5d18bb@gandalf.local.home>
In-Reply-To: <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
References: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
 <3c11308e-006a-a7e9-8482-c6b341690530@redhat.com>
 <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
From: Steven Rostedt via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, lttng-dev <lttng-dev@lists.lttng.org>,
 KVM list <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Fri, 8 Apr 2022 14:06:53 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> Indeed, the fact that the TP_fast_assign snippets are embedded in the
> trace_event_raw_event_* symbols is an issue for LTTng. This ties those
> to ftrace.

Not just ftrace, perf does it too.

Now another solution is to make the fast assigns available to anyone, and
to allow you to simply pass in a pointer and size to have the data written
into it. That is, you get the results of the TRACE_EVENT and not have to
depend on internal data from the tracepoint.

-- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
