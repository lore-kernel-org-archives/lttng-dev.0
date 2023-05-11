Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608CAC7EE22
	for <lttng-dev@archiver.kernel.org>; Thu, 11 May 2023 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683820457;
	bh=8DBtQVjPgWXiHYO0fCyPYIi0zF9uREzahytIstqTQCI=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Z+Zkg/cYOEnfRGcUI53R8gCFV8/lVWimhQ767uNR2+pthDmdPQvjDPvMrmdCqlt/o
	 CZEjWwEsEA5KtKDeeygRe76O/OTLQq7S0xuf/gXRhuKUdB3UXlBHN6NhTIDaDt3em7
	 vMQ5Q1PbOlHp/k8UtDNQk/IxtHcCz78fP2WWJQ8hseeYgn0NpQYlgSbe1dBsJc5mB8
	 3llQW/KpEDzM1G/j1jERPB3+miPfMNo5yWMVCM3wjFIEpc1K7/EcvCuKbFdyXiZM7e
	 8bIz8WtV+5qi9m8wSJtWoeMkmUBMv8pfz4uDtx/j4Tw4HGhWMVMAtL2EXO/+HTnhoe
	 XQJ9A9JO5KBuA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QHGfc1b2ZzS7h;
	Thu, 11 May 2023 11:54:16 -0400 (EDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by lists.lttng.org (Postfix) with ESMTPS id 4QHGfZ326lzS7f
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 11:54:14 -0400 (EDT)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-9659f452148so1569095966b.1
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 08:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683820393; x=1686412393;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RSJAcBDvd9Ni3Cj+2Unx+fZTmm3S4bowtyx7WpssPyY=;
 b=DjUClmo3ALJtJh+seB4dFByUnojfeqOY04lnapYXl+wSrafraHju+Cvk28mag83u5U
 ij6vSL8+f//sC/eAuPfKwC6J3ngJcxYN7WtBBI13E+mDKF8coDJ/tRbW7LdeIc8CFpX2
 CxR5GruUNdrFTUaQdk43wh7FyJoL3SWU2vEv3hFts9ZGUWIhxDe7cdVIn8vh6sn9JQkf
 AtB9Onsz6PppSGW7D8nZQ1qZlwtBOTwxvgzKyP4yuvNGF5HZElXVrmTUsG0gje1UJR0W
 BXaxdZ/2FBbhLXxRhdCeoBkqHpU6UhcYv/M+7gcC2lISbPonKVSyc+T8+hUA5PjTi9Al
 6VwA==
X-Gm-Message-State: AC+VfDxCg7s92J4dLjFOt5IB33Ri7udyyyMZ2utrumNF65XTl0OwPQDy
 ZXIZK96ogmBb2ox0pwAmMhr17Bb/Nd1kFfraGuimHDSXEaA=
X-Google-Smtp-Source: ACHHUZ7/5xUy2ZQAqiRVIdCgJS0FeFvgXCPY5oYyKranwnpqy/daWCCLdTQ3JrgtIPtirgY9Z/A1CAhXOs104nbmgIs=
X-Received: by 2002:a17:906:4fd6:b0:94e:116:8581 with SMTP id
 i22-20020a1709064fd600b0094e01168581mr21200538ejw.5.1683820392661; Thu, 11
 May 2023 08:53:12 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 11 May 2023 11:53:01 -0400
Message-ID: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] I'm still getting empty ust traces using tracef
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
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

I posted a while ago (thread - Using lttng 2.11 and UST doesn't appear
to work - getting empty trace files) about this problem I'm having
with getting empty trace logs.

I've since upgraded to lttng v2.13 and while I can do a simple hello
world program with tracef and get events in the log files, my more
complicated large multi-threaded app I'm trying to debug is still
getting empty log file traces.

I can list the user space events in my app.

Next I do:

lttng enable-event --userspace 'lttng_ust_tracef:*'

... to enable the events, start lttng, start my app, .... and I get a
trace directory structure that's empty.

I feel like I've read every thread in the archives about people having
the same problem.

I did try using LD_PRELOAD with various libs thinking that was the
problem but so far I'm still getting empty traces.

So far I've tried:

LD_PRELOAD=liblttng-ust-libc-wrapper.so.1:liblttng-ust-pthread-wrapper.so.1:liblttng-ust-dl.so.1:liblttng-ust-fork.so.1:liblttng-ust-fd.so.1
/usr/local/bin/my_app

I guess one question I have is how do I determine which "helper libs"
I need to preload?

The application I'm working on is made up of a bunch of smaller static
libs linked together into one big executable and that is linked with
-llttng-ust and -ldl.

I'm pretty stuck at the moment.  Anyone have any wisdom on what I
might be doing wrong or how I can tell why I'm not getting events in
the logs?

Thanks,

Brian
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
