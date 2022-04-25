Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AFFC433F5
	for <lttng-dev@archiver.kernel.org>; Mon, 25 Apr 2022 19:13:50 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KnF6h3C6yzDPJ;
	Mon, 25 Apr 2022 15:13:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1650914029;
	bh=eyf4zx36/FD37iYxb1ziUww2zU/9qGVPmcOdaNFLT7Y=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NqElowEhn1mFrvU7wHNQYjHDKwA8ffRSJ9YAxl+5ZX6oFST3e60gUZE+hHqFei0g2
	 uxM4Y1DHWTD/ieepOfnlLyWhW4GtfRXap/t1+DEKF01uJBVbKmlDrgMm0w/QSUcKhM
	 6XKP8o7XufYzrcKo53S66Fmv7erPUGdUCpm/j9a3Ooo5vvJ6fdCS1dvegyN9w+tMd7
	 4jtDbw5kWcapWOdl8ZhKKbmZQWY6KgCreGgizbOlpJQaQlooUrgKIM2XbMSDZbq6If
	 vYGfS0zddciFN890kUrIj9q6I27226O+EEFvQNFDs28uzmx+VvIrZQN6zWRCpe5pPk
	 0k9J+MbRojM3Q==
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4KnF6g4GQnzD2M
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2022 15:13:45 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6BDCC6170D;
 Mon, 25 Apr 2022 19:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CE2C385A4;
 Mon, 25 Apr 2022 19:13:38 +0000 (UTC)
Date: Mon, 25 Apr 2022 15:13:36 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <20220425151336.21e492b5@gandalf.local.home>
In-Reply-To: <892959086.34940.1650902572304.JavaMail.zimbra@efficios.com>
References: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
 <3c11308e-006a-a7e9-8482-c6b341690530@redhat.com>
 <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
 <20220425100434.2f5d18bb@gandalf.local.home>
 <892959086.34940.1650902572304.JavaMail.zimbra@efficios.com>
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

On Mon, 25 Apr 2022 12:02:52 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> If the fast assign can then be used on a field-per-field basis, maybe this
> could work, but AFAIK the fast-assign macro is open-coded C, which makes this
> not straightforward.

Yeah, that's not going to be feasible, without changing all 1000's of
events.

> 
> If it's a all-or-nothing approach where the fast-assign needs to serialize all
> fields, this would require that lttng copies the data into a temporary area,
> which is something I want to avoid for filtering and event notification per-field
> payload capture purposes.

Right. Not sure how to fix this then.

-- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
