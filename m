Return-Path: <SRS0=umfz=HT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E486FC433E6
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Feb 2021 20:50:46 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4FA64D5D
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Feb 2021 20:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4FA64D5D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Dgqjw35X3z1tV;
	Wed, 17 Feb 2021 15:50:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613595045;
	bh=BPg83cLF6HB9Nr3KKoY6iKQJ0PJwVGY7e89wb3uMRUk=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=MIuZUREnZPQx+EpCOG3U1+O/dgvEw+ptGGY8MkC+N6/KNQIxroR7X07Cf7vkoaQmH
	 vxDZJ0GnXQNXFWrz1xqpCjKbuCNI3E1wKngfjtzSWCh+1GdIw4sT0T1YWCc5L4rL6M
	 MTQUUQQXtQSKPk7HF4ym/Z6W3JYavYr3Jji7Tgytk/Xda8xrerexTtZc9WrbPK1w83
	 pZJoDHWo7SO9nY0wQt+qNXt16R8MKgR3hbzqRP4MvPAcVvFgQKDWa1FRRU2Gi2TuEs
	 aVXwW5b9M6LhSLQRfEmUq3wrmgE9qb7D9nL1sKPq3tHPz6l809FDTu9xtodbCQ9cDO
	 JNmonGrI943MQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dgqjt6VqYz1ql
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 15:50:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 30A9432479E
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 15:50:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Ttn4q-NqDxJg; Wed, 17 Feb 2021 15:50:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BA9FC3245BF;
 Wed, 17 Feb 2021 15:50:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BA9FC3245BF
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3AkUdGOzPTrv; Wed, 17 Feb 2021 15:50:35 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AEFAB3243CF;
 Wed, 17 Feb 2021 15:50:35 -0500 (EST)
Date: Wed, 17 Feb 2021 15:50:35 -0500 (EST)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, lwn@lwn.net
Message-ID: <820791812.25860.1613595035617.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Index: KlGxbtU3V1lTspKBAPQvwyaR6vsKUw==
Thread-Topic: LTTng-UST 2.11.3 and 2.12.1 (Linux user-space tracer)
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.11.3 and 2.12.1 (Linux user-space
 tracer)
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

Hi,

This is a bugfix release announcement for the currently maintained stable
branches of the LTTng user-space tracer. The new versions are respectively
2.11.3 and 2.12.1. Those new releases contain minor bug fixes. Users are
encouraged to upgrade.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

Please refer to the respective release Changelog files for details.

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
