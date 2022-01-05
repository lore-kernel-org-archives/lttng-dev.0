Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC0C433F5
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jan 2022 19:12:06 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JTfHT2bXnz8lY;
	Wed,  5 Jan 2022 14:12:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1641409926;
	bh=z0hJLNJeZp6hco5d/+PsDNgHjkQx7yGwRexoAohNi0M=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=nIyBMIM3yfrxdJY0UoK4DtrzPQR1lzMxSF9hBpMRybmwq9jGx6NmqinzaJ29c4ep9
	 BhggP0Rrm640IjbmdFWo46GOuW4no84ADi9M1XOXA5VHmGLM3A6Iqo5xr1sQG0BlQ2
	 CPgOtooe5gRUxsqCtGQen2SfGvfGAfSBAVpazuNqz7iw9gRrJBuftgRuZ2bftzRKY3
	 3aKYahsQHibMCKknLLQnsVISBWR/FHL5zThTPFRZfTLNpFFRrxllqzqiWA+QajJqvd
	 Uh9Dha8X3aFKz75UDMfeAFE4+lGZhjZYAAr9uVvg+ctNY8qOhQzyA+ols3ACKDOIKT
	 vGBk90Baw7rfQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JTfHS0pjZz81Y
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 14:12:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 91CBA3C88FC
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 9oNEJfGvcF-Y; Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 13C5E3C887C;
 Wed,  5 Jan 2022 14:11:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 13C5E3C887C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 93rxNQm326DQ; Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 08E483C8AE4;
 Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Date: Wed, 5 Jan 2022 14:11:56 -0500 (EST)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1275248080.2857.1641409916909.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Index: 7cLqhylIvorgVNK6xQZrdmHTvto22w==
Thread-Topic: LTTng-modules 2.12.7 and 2.13.1 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.12.7 and 2.13.1 (Linux kernel
 tracer)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

This is a release announcement for the LTTng Linux kernel tracer 2.12.7 and
2.13.1 releases. Both are bug fix releases in the lttng-modules stable branches.
They also enable support for the most recent Linux kernel releases.

LTTng-modules 2.12.7 contains instrumentation fixes for the 5.14, 5.15 and
5.16-rc Linux kernels. Kernel version ranges were adjusted for instrumentation
of the RHEL 8.4 kernel.

LTTng-modules 2.13.1 fixes scenarios where trigger actions are missing:

    There is an issue when associating multiple actions to a single system
    call, where the first action is effectively added, but the following
    actions are silently ignored.

The affected on-event trigger is a feature newly introduced in 2.13.

This 2.13.1 release also contains instrumentation fixes for the 5.15 and 5.16-rc
Linux kernels. It now emits a warning in the kernel console whenever registration
of events internally fails within LTTng-modules, for example in case of
out-of-memory error.

As always, feedback is welcome!

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
