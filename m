Return-Path: <SRS0=TO6l=AZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D96C433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Jul 2020 13:11:36 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259ED21D79
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Jul 2020 13:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="hC5+j6pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259ED21D79
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B5grk2fWhz1WbP;
	Tue, 14 Jul 2020 09:11:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594732295;
	bh=76iyxTUHfs3ZgfY0aLoYh30vCzS1mxES7uQDT72NFog=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hC5+j6pakOPb9PNcRmBXaK/pO8AFPH8Qwjemtm5eN8415pG1pI8yAv9C4j6plknI3
	 IJriNb+uN686lfObPIXpzWiZ9AwIj8/vM5A1fgpB8H4v252rK+FM4DsYx2LnidddTd
	 8JLwa/+JF0I0FzU+XnYcdBVVjjsdY4i7ybbfeWJ0LPek1HlP4hn+40LCP9tifTPAMB
	 7a05CmMNWkNjqJ87CVvNqcTwiHNmWUXB1pQgrHr2Lv91/hK+y8/xwoMFd7Pxn8tkOQ
	 GLKt0v6R20CRB7usfDdWfcQ47fpWMPWSVt6xRzaWbZC8y7TZChoU3OS3q6wF5unMTD
	 enlZxXUwE/3qA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4B5grh0q1Rz1WbN
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jul 2020 09:11:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A2F992BE40C
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jul 2020 09:11:25 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id HCYHQAo_Otun; Tue, 14 Jul 2020 09:11:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 57E2E2BE40B;
 Tue, 14 Jul 2020 09:11:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 57E2E2BE40B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id C_EWPz-j8YWf; Tue, 14 Jul 2020 09:11:25 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4E0172BDEDD;
 Tue, 14 Jul 2020 09:11:25 -0400 (EDT)
Date: Tue, 14 Jul 2020 09:11:25 -0400 (EDT)
To: Adel Belkhiri <adel.belkhiri@polymtl.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1479242158.11449.1594732285213.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200714025622.Horde.hxhRrc1ehcFdgXme3a70e7W@www.imp.polymtl.ca>
References: <20200714025622.Horde.hxhRrc1ehcFdgXme3a70e7W@www.imp.polymtl.ca>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: custom field support in lttng-ust ?
Thread-Index: 0JBMEYtuDbJMjKlPSEMn3/NDF/mmMQ==
Subject: Re: [lttng-dev] custom field support in lttng-ust ?
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
Message-ID: <20200714131125.Skv5qi4X3M2uC2V1qPn9j4WIURCQfqCeH7Cie_ONCfE@z>

----- On Jul 13, 2020, at 10:56 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hi all,
> 
> Does anybody know if there is a custom field support in lttng-ust (to
> export atype_struct and atype_variant data fields) like in
> lttng-modules (ctf_custom_field)?

No, there is not.

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
