Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410F7C32771
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Aug 2022 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660935433;
	bh=1QyCnN5c4h3CIsxdMpZlev5SNFHYvoIYDDveZODzxP8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=NOm55AOyjJTPwlNizQstAuHZzprhM6xoPhlW2xPE+CqzuWhc28hW34dIbEnCSRb/u
	 Fezi+AFlYzvTdRDqu3/0dTG/dcHAXEbRX0n27Ham3ivfCqd2uHwMN5MJRUaqzjxppz
	 2iBzr3G9uwRaK802ZKus4WmNNcYJ/SHjzXUfPpLGpvYMBjER0IMvy56w7p/yA7Czdz
	 Bmcu0F5CdJ5KnfGMeoWPNKBR4z5jjw3M78/vbhetfxN7DH+9dHR9duh8XznQt4VKis
	 FnbRa7gAUwPmLcUA4rwrVEb+GrwZAhCu4XQkkfewoR8SQqfSZvtsaCFdQn4DbwHJq+
	 L5MlYWnQmFfOQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M8WG01SC4z1KFX;
	Fri, 19 Aug 2022 14:57:12 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M8WFy3CcLz1Jn6
 for <lttng-dev@lists.lttng.org>; Fri, 19 Aug 2022 14:57:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0D5B93B7A75
 for <lttng-dev@lists.lttng.org>; Fri, 19 Aug 2022 14:57:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 3lZMkGODt-IH; Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 874613B78F5;
 Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 874613B78F5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fiECbDsY4bAE; Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7961A3B7FA6;
 Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
Date: Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>, 
 lwn <lwn@lwn.net>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1273091514.17599.1660935429453.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103
 (Linux)/8.8.15_GA_4372)
Thread-Index: njpMKIkDnXU7Voqt9NfXwqumSfFwyQ==
Thread-Topic: LTTng-modules 2.12.10 and 2.13.5 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.12.10 and 2.13.5 (Linux
 kernel tracer)
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

Hi,

This is a release announcement for the two currently maintained stable branches
of the LTTng kernel tracer.

* New in these releases:

Version 2.12.10 and 2.13.5 fix tracepoint instrumentation to support stable kernels in the
version range v5.15.58 to 5.16. They also fix incorrect stub prototypes for
CONFIG_HAVE_SYSCALL_TRACEPOINTS=n. A minor fix to tie compaction probe build to
CONFIG_COMPACTION has also been added.

Version 2.13.5 updates the tracepoint instrumentation to support Linux kernel
v5.19, and v6.0-rc1.

Feedback is welcome,

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
