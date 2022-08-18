Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF9C32772
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Aug 2022 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660853257;
	bh=6GcNEWkPdITcallTTeHTIduAv9vKhqHY8QnYo/xvsS0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=vPDerdMfl+f8bIkSeEksorsDuPrkj3qJISL2ikGBXP7FZi7RP2/6l9FV6ImI71suq
	 Rvk/+zboB0k0GheESo3821rI1gKFb7kyhrAtfIHRfqwTmJVe3FclKkIAe+EhjlDi3s
	 0j/A62edIrF3UYo2iFY5h5mXxQB2ej2Uc358diPv5iHOhRXduFuQejARdNK25BXHWR
	 LSFN2xlUiQHcm9DM65d76jnWvAnAJx9ogMAovo9HTxlVMcGOPzQOJSoBaaZ2iUbGrS
	 8zp4KR36uCe7FH6IYRvIa/1WTpaau5FRCGT2VIxdUDpy9eVi2ld6RHImjLVz8CBFBa
	 1k6SV5ohiLKuQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M7wsj1XG8z1J6C;
	Thu, 18 Aug 2022 16:07:37 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M7wsg1L0sz1Jc0
 for <lttng-dev@lists.lttng.org>; Thu, 18 Aug 2022 16:07:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CCEB7397077
 for <lttng-dev@lists.lttng.org>; Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gsVIAdTyPiF4; Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3C466397074;
 Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3C466397074
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fyzT_UDvwwWd; Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2EEC3397694;
 Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Date: Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
To: linux-kernel <linux-kernel@vger.kernel.org>, 
 lttng-dev <lttng-dev@lists.lttng.org>, rp <rp@svcs.cs.pdx.edu>
Cc: paulmck <paulmck@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, lwn <lwn@lwn.net>
Message-ID: <1089391319.15796.1660853254177.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103
 (Linux)/8.8.15_GA_4372)
Thread-Index: bwIKiKBCPmydWVq5CpBZdRA1UQ0RxA==
Thread-Topic: Userspace RCU 0.12.4 and 0.13.2
Subject: [lttng-dev] [RELEASE] Userspace RCU 0.12.4 and 0.13.2
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

[ re-sending without html headers. My email client managed to add those without me realizing it. ]

Hi,

This is stable release announcement for the Userspace RCU project.
It covers the two currently maintained stable branches: 0.12 and 0.13,
respectively with releases v0.12.4 and v0.13.2.

Especially for the spurious futex wakeup fix, users of the 0.12 and 0.13 (or older)
liburcu branches are recommended to upgrade.

* Noteworthy in these releases:

- Handle spurious futex wakeups in urcu-qsbr, urcu, urcu-wait, defer_rcu, call_rcu,
  and workqueue code. This has been known to cause issues where the workqueue
  worker thread spuriously takes nearly 100% of CPU time.

- Change method used by _rcu_dereference ot strip type constness.
  Rather than using pointer arithmetic (which does not work with opaque types),
  rely on a statement expression trick.

- Fix support for Linux systems where sysconf(_SC_NPROCESSORS_CONF) can
  return a value less than max cpu id.

Project website: https://liburcu.org

Feedback is welcome!

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
