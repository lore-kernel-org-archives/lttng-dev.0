Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F64C32771
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Aug 2022 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660941535;
	bh=Jj7wlB/bPPHqHuu4CNFQwjsSeLLEyjI8VAFLOMpf9tg=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=qei7b4XD5mZXujFYIITaweZJ9PHIMHx6Fix9/xmEBvWA9uGzfnjm0KzBvNaxbwVGR
	 TKayHEK/gtaECAt7rVfydeJypzYTyM9y/3r9ozTASgHkjZ2nudCymCLoXN/HdobHxZ
	 lSg2XGL2OE9/xPkx9guvka4vaguStFsqpCTu/1atsXoDxh/BOetViE5dsN+tgd+ysB
	 MsBQxP3gtYdMhSu2xOE5HE7fi43HM4ht9AYZSTgnlyGew3LrxdNUzw3tszHwOfMYPP
	 3GV1g8Sx7RDQInaLdVVvsMKN7UGzlxCd7lSqU1HzhWORQFQBgv2vRFMvxBV3Hb1ZF9
	 wr+DBLyJBk1kg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M8YWL3QWyz1Jyc;
	Fri, 19 Aug 2022 16:38:54 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M8YWJ0r4jz1Jyb
 for <lttng-dev@lists.lttng.org>; Fri, 19 Aug 2022 16:38:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9A81C3C0A56
 for <lttng-dev@lists.lttng.org>; Fri, 19 Aug 2022 16:38:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EQnzhJTjtQtC; Fri, 19 Aug 2022 16:38:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E96DD3C0A54;
 Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E96DD3C0A54
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id s-DeMP4_bKJx; Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id DB6DE3C0A53;
 Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
Date: Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, lwn <lwn@lwn.net>
Message-ID: <1557496534.17909.1660941530779.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103
 (Linux)/8.8.15_GA_4372)
Thread-Index: BBsWiGWbzxfD3y6w1mw3EXGTI3mZlw==
Thread-Topic: LTTng-ust 2.12.6 and 2.13.4 (Linux user-space tracer)
Subject: [lttng-dev] [RELEASE] LTTng-ust 2.12.6 and 2.13.4 (Linux user-space
 tracer)
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

This is a release announcement for the currently maintained stable
branches of the LTTng-UST project. Versions 2.12.6 and 2.13.4 are
now available.

* New in these releases:

In 2.13.4, a compile-time check that disallows using types other
than integer or pointer for tracepoint array and sequence fields
has been removed in C. This is because the check relies on pointer
arithmetic, which does not support opaque pointer types, which was
therefore a regression.

In both 2.12.6 and 2.13.4, the mechanism to get the maximum cpu
number value has been changed to not rely on sysconf(3)
_SC_NPROCESSORS_CONF, but rather use /sys/devices/system/cpu/possible
on Linux. This fixes an issue observed with recent lxc, which
caused scenarios where holes in the configured CPU list causes
the returned value to be lower than the maximum cpu number + 1.

In both 2.12.6 and 2.13.4, the function lttng_ust_ctl_duplicate_ust_object_data
now returns a negative error value, fixing a segmentation fault on error
in lttng-tools.

In both 2.12.6 and 2.13.4, spurious futex wakeups are now handled
correctly. Failure to do so did not cause any user-observable issues
other than using slightly more CPU time than strictly needed, because
this spurious wakeup would only cause an additional connection attempt
to the session daemon to fail.

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
