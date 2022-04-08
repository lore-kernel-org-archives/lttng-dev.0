Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744D5C433FE
	for <lttng-dev@archiver.kernel.org>; Fri,  8 Apr 2022 15:36:36 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KZj5t4SmZz38k;
	Fri,  8 Apr 2022 11:36:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649432195;
	bh=rNRB7Wvv4DIXc+hjTqfZ3bey3x3jzsa1uvAZGPGA2x4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QXu2s2eHznOgeK32O3W37qgtmmcR2rYfMsxNakEBSKvRHXznDrxPrQrwtRYb0KQ/0
	 JLMOu1ilyuvfSoMNHni4js6fTH9Pxk63emAeebm9J++jYvsuWqHUGnDJ7VApho9UJ5
	 A+s7jkNhaBQi15gux2lXVVQlTwWcSWqIy/NjrJ945U4IKRrnT2QopWQTxRo09BGJRE
	 WhRBwvSbR0tYcPthk4M5CYY+83l+UsHhGf+6fles+qlLRWZ8BJ2zlrDcov4zJ2kCme
	 wHn8G28HzfKvVQ+184eQkjuJAS9kJYdu0KZit+xyIgeInIM6rXIpUq18fUQfqcfmHB
	 Xp8lcs/ZD69Wg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KZj5s3ntPz3CJ
 for <lttng-dev@lists.lttng.org>; Fri,  8 Apr 2022 11:36:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 214CC3D6E80;
 Fri,  8 Apr 2022 11:36:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id OVsLOWs2P0J6; Fri,  8 Apr 2022 11:36:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 868F23D6C54;
 Fri,  8 Apr 2022 11:36:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 868F23D6C54
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id JIaQwEjoB1zm; Fri,  8 Apr 2022 11:36:26 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 791DC3D6C53;
 Fri,  8 Apr 2022 11:36:26 -0400 (EDT)
Date: Fri, 8 Apr 2022 11:36:26 -0400 (EDT)
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Message-ID: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF99 (Linux)/8.8.15_GA_4257)
Thread-Index: LpIxIY9jLwbJ8q4CbGCDtwYhy2E0mA==
Thread-Topic: Unexport of kvm_x86_ops vs tracer modules
Subject: [lttng-dev] Unexport of kvm_x86_ops vs tracer modules
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, rostedt <rostedt@goodmis.org>,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Sean, Hi Paolo,

I have a question regarding a unexport of kvm_x86_ops that made its
way into 5.18-rc (commit dfc4e6ca04 ("KVM: x86: Unexport kvm_x86_ops").
This is in the context of tracing. Especially, LTTng implements probes
for x86 kvm events, e.g. x86 kvm_exit. It receives a struct kvm_vcpu *
as parameter, and uses kvm_x86_ops.get_exit_info() to translate this
into meaningful fields.

LTTng is an out of tree kernel module, which currently relies on the export.
Indeed, arch/x86/kvm/x86.c exports a set of tracepoints to kernel modules, e.g.:

EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_entry)

But any probe implementation hooking on that tracepoint would need kvm_x86_ops
to translate the struct kvm_vcpu * into meaningful tracing data.

I could work-around this on my side in ugly ways, but I would like to discuss
how kernel module tracers are expected to implement kvm events probes without
the kvm_x86_ops symbol ? Perhaps there is an alternative way to convert the
fields in this structure to meaningful information without using the
kvm_x86_ops callbacks that I am not aware of ?

The LTTng kernel tracer uses get_exit_info() and get_segment_base() callbacks
from kvm_x86_ops.

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
