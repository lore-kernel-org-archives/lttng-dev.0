Return-Path: <SRS0=8qW8=DF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DD8C2D0A8
	for <lttng-dev@archiver.kernel.org>; Mon, 28 Sep 2020 15:00:24 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C32F21974
	for <lttng-dev@archiver.kernel.org>; Mon, 28 Sep 2020 15:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="VmVScpJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C32F21974
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4C0Qg90ySszMNn;
	Mon, 28 Sep 2020 11:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1601305221;
	bh=LKHHonKv1Zy5PZPIaUs+Bm4TJUNbhHxjcgkLq8aH8ic=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VmVScpJrC/x8i05TthGum5Wn+M56wxkS0qKYvt/oytfRMpLZeEFNMYjGjmIXsU98N
	 dLooA88C1kN4DqCMKbdmgWJ5G0j6xgVtPN4qE3pilJJEeBo19cEUo03baig15LC4df
	 UaSk7VJtFkIVfoKodi72pBZ4gygOp4pnuH4p4ai8VyDPhtLDVci9FML0LkilSq9aVH
	 sIpEv7bz0XQnRsPYL99W4iT8fIia+5u3J8cLF2Q5uyXu75zsp9UH6+u8N4pj77iaLR
	 boVCu9Le2MVTaajobuxXdelD4qlIraFmxF9Cp96EK5rfBs8t7GXsbD0f8xsp35y+MW
	 IzaUNx1ieVHOg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4C0Qg704hhzMWx
 for <lttng-dev@lists.lttng.org>; Mon, 28 Sep 2020 11:00:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B51602E78B4
 for <lttng-dev@lists.lttng.org>; Mon, 28 Sep 2020 11:00:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5qgGR8bja7KS; Mon, 28 Sep 2020 11:00:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7BBBF2E7A02;
 Mon, 28 Sep 2020 11:00:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7BBBF2E7A02
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id I227ctPfLPlj; Mon, 28 Sep 2020 11:00:12 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 703B42E74D9;
 Mon, 28 Sep 2020 11:00:12 -0400 (EDT)
Date: Mon, 28 Sep 2020 11:00:12 -0400 (EDT)
To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1671900523.71319.1601305212339.JavaMail.zimbra@efficios.com>
In-Reply-To: <CABhb4uvWv1ewuK0Eq_UMBq2qY4kS-AUHqytYa_jMN2xvfF21dQ@mail.gmail.com>
References: <CABhb4uvWv1ewuK0Eq_UMBq2qY4kS-AUHqytYa_jMN2xvfF21dQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: LTTng packages
Thread-Index: oVARdcLJ9JJ9ZG76A0WmVrhEEbiYzA==
Subject: Re: [lttng-dev] LTTng packages
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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

----- On Sep 27, 2020, at 9:54 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hello!
> Is it planned to publish LTTng 2.12 packages for Linux distributives except
> Ubuntu and Debian. Packages for RedHat / CentOS, Fedora, Arch, etc are
> available for previous versions.

Hi,

Packaging is a commercial service offered by EfficiOS to its customers. We
then publish the packages to all interested parties.

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
