Return-Path: <SRS0=Fgvg=HU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6AFC433DB
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Feb 2021 22:14:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F9B64E77
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Feb 2021 22:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F9B64E77
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DhTX822Hpz2bx;
	Thu, 18 Feb 2021 17:14:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613686473;
	bh=B5T46AAmqQUkrYHi7a+uZbUrwJBXBmlyaY0pfHrvTsY=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=oRIpfspAYKKBmlYqTZbs/7RqnnibWIvYM8TNriQ2XOjiHJ3v9nf271Bh7tIA/l2SL
	 w0cR0kjs7IAVnXnPl/yFpRslZRTJU+TC114uwWsWnP3cIMDxakLXJCWpHqAz3pvAi3
	 hynzA5weQdrOEO47ruFDmkEyuGwrp+agCmIn4WrvtUJH3iAkFTt1YUPaxiOcHxjCB4
	 KGuQUBK3LmU1RbIKPBXLmZcyZ8kiSMZ6CL9ReENeeKPl8VzpAi4G/Aoa8IzAYuB2NH
	 LWOfEseAM0ibV4qcanH0hWnORKAPopw3bAO9jrKUGkWw1u8syxpo6sQb0YF9SEJdMB
	 QprE8Gy76kcWg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DhTX70LR2z2l7
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2021 17:14:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8C27629EC9D
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ouFG5lUhns2P; Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3778729EC9C;
 Thu, 18 Feb 2021 17:14:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3778729EC9C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id kR94IUP1C6jg; Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2B9FC29EC9A;
 Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Date: Thu, 18 Feb 2021 17:14:24 -0500 (EST)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2137653784.27421.1613686464160.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Index: Lfx1OD8Hxjqn+78W97ARTlbDOIKMug==
Thread-Topic: lttng-trace: a new strace-alike LTTng command
Subject: [lttng-dev] lttng-trace: a new strace-alike LTTng command
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi there!

I just pushed a new command line tool named `lttng-trace`, which allows tracing a
specific command and its sub-processes using the LTTng system call tracer. It focuses
on simplicity. It can be found here:

  Git website: http://git.lttng.org/?p=lttng-trace.git

Clone with:

  git clone https://git.lttng.org/lttng-trace.git

For instance, tracing the command "date" is as simple as:

  lttng-trace date

The tracing session can be optionally configured by using the usual lttng control
interfaces after this message appears:

[lttng-trace] Tracing session `date-20210218-170545` created. It can be customized using the `lttng` command.
[lttng-trace] Press <ENTER> key when ready to run the child process.

After execution of the command, the following message details how to view the trace:

[lttng-trace] Sub-process hierarchy traced successfully. View trace with `babeltrace2 /tmp/lttng-trace/date-20210218-170906`

See `lttng-trace --help` for more options.

This new command is in early alpha stage. Feedback is welcome! For instance, we are wondering whether
the default behavior should just be tracing system calls, or if some level of user-space tracing should
be enabled by default as well. Or if some new options should enable "typical" usage scenarios.

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
