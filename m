Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862BCC5478C
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Feb 2024 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1708707695;
	bh=op5pxP3nDvej3TblSCbEkHXMzInb538S8sb9XXhNqEw=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eDf2opsx2zk2RICrr8G6+If/SU3hbBo+NcOKks9SB//sF0+AW5ac3QDY75LJi5n+w
	 U2vaXARlQ/W5Gqk8zqOT/ila/NVRT3LM6iy35FJYzP4H59v11SkCMO3oH8Al3zzbw1
	 VlIs8SvbAQAVzNN6dz8M0qoDa47N0IuACkIXnSyr1/alFz7l1XR+nMR8Cr/mX8J9HN
	 hhoD+8hKe/TJX+zf7QOPNezVaOJ3GI+1lmB8QNC6vPt7SBUx9KdGp7Gf0C0R0l/Pwy
	 ZWmesNpyec0HjUzZ9Rcm0FWj8FWxRWZf9wWkpfeSl7qP8dGilfyTL8vqPB73ro3xRi
	 ZR8hLjkwC9qkw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ThGWL6qwhz28qL;
	Fri, 23 Feb 2024 12:01:34 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4ThGWK0cbjz28MR
 for <lttng-dev@lists.lttng.org>; Fri, 23 Feb 2024 12:01:31 -0500 (EST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 72E386357C;
 Fri, 23 Feb 2024 17:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEE6C433F1;
 Fri, 23 Feb 2024 17:01:28 +0000 (UTC)
Date: Fri, 23 Feb 2024 12:03:21 -0500
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <20240223120321.66b0d5d7@gandalf.local.home>
In-Reply-To: <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
 <20240219122825.31579a1e@gandalf.local.home>
 <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
 <20240223092630.49b9d367@gandalf.local.home>
 <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH] coredump debugging: add a tracepoint to
 report the coredumping
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
Cc: wenyang.linux@foxmail.com, Peter Zijlstra <peterz@infradead.org>,
 Karim Yaghmour <karim.yaghmour@opersys.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, lttng-dev <lttng-dev@lists.lttng.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Fri, 23 Feb 2024 11:54:30 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> So this sched_process_exit placement was actually decided
> by Karim Yaghmour back in the LTT days (2001). I don't think
> he will mind us moving it around some 23 years later. ;)

And I wonder how many people are involved in this that are younger than
that change :-p

I'm starting to feel really old.

-- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
