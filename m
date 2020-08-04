Return-Path: <SRS0=h30u=BO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A149C433DF
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:58:15 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AC12086A
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="aipm6WyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AC12086A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BLbts2WdQz1nTv;
	Tue,  4 Aug 2020 09:58:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596549493;
	bh=Yd4N1XCBZmwAJI9xY9CVK1de13aujFNMA9O3Cw5hNJY=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=aipm6WyKuFhwC0o+WGeGTAcsu0/IG9NT/OqC1MvNX9aY12IytKYIZ3FtVh8dyvrRG
	 l44oKCbKkP4wgCqURzeicawMMbxFmKDAmLgHMUeTnIWVWZW0M1lKCw/dcl0LWe4ssK
	 vw21pDaUOCX7UgP2wuSPf3MdHMnsO6YH0izPq8y1wPwIc6FKm2+zyJTbGuRa2Ntr2E
	 RoLGQXkkpjXkZWaMJP2OiomP5MRRVGzpYPWJZoUGyzvAPJhi5sPvYgAZl8vyG7DV7e
	 /3upU/Ywdp0DyZKTgW4tpk59pacjlKbwPe6nSHTNFSpXrviElvwQUCqAnqwCh5LSb9
	 F9qOtP0pgqEzA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BLbtq3yfVz1nxH
 for <lttng-dev@lists.lttng.org>; Tue,  4 Aug 2020 09:58:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F32762D769C
 for <lttng-dev@lists.lttng.org>; Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tybkGbFx1mbR; Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C4D352D769A;
 Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C4D352D769A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Tb47rpLt7jds; Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id B7E2C2D7698;
 Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Date: Tue, 4 Aug 2020 09:58:04 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <1934497535.39785.1596549484739.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Index: gVJiywk8vItU5cAGlFsCDw6PIbTDhQ==
Thread-Topic: LTTng-modules 2.11.5 and 2.12.2 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.11.5 and 2.12.2 (Linux kernel
 tracer)
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

Hi,

The releases 2.11.5 and 2.12.2 of LTTng-modules are bug fix releases, which
also add support for the recently released Linux kernel 5.8.

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

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
