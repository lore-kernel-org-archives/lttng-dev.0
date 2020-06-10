Return-Path: <SRS0=tt43=7X=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DDC433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Jun 2020 17:31:08 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ECB206F4
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Jun 2020 17:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="cFZlBGhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ECB206F4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49hvCt10GHz1SwR;
	Wed, 10 Jun 2020 13:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1591810266;
	bh=dwA9XyF3D705twsEkh3gnnewZ19siWYutN+hL8mHfEQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=cFZlBGhgzDIPhmElPMrnJE+puR37PU9pOGyxDk2v347TJ1iZXF119M/011ZTGw6nH
	 BovMgZa/3DKTgkDmoptte6OxAywC7gqfHtalp4n9loIMtpaf2MADC/F31+RmhLutPi
	 7JCiA/enq9lGfpkU/N55+DvZohEaW8l0riSnobPtXx6+rjZA1csw6WIVXPUjpkjzWV
	 ShH1KYE/xVc4HkrurTTZSib6nrSZ1jLiBBavr/Bn/ZrpmbNgIQm7q+5RAmqYpaA3I/
	 j05S7x1K5k5iigXst1Kuv+UeYFJPM+P9ZsMY0ryQVMBwbGueXrZgK7lut4tsr7akU9
	 5KivuxeqnIi8g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49hvCr1pD9z1T9S
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jun 2020 13:31:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8D8E4261F31;
 Wed, 10 Jun 2020 13:31:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Wit3dys0TIgI; Wed, 10 Jun 2020 13:31:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 25014261EA1;
 Wed, 10 Jun 2020 13:31:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 25014261EA1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TcFGTZeLXVYX; Wed, 10 Jun 2020 13:31:02 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 173B5261E9E;
 Wed, 10 Jun 2020 13:31:02 -0400 (EDT)
Date: Wed, 10 Jun 2020 13:31:01 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>
Message-ID: <2002526733.1676.1591810261986.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Index: ATVAWeDdtAZ9FGgAhRyALxViCDaQCA==
Thread-Topic: Common Trace Format (CTF) 1.8.3
Subject: [lttng-dev] [RELEASE] Common Trace Format (CTF) 1.8.3
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
Cc: Philippe Proulx <pproulx@efficios.com>,
 Genevieve Bastien <gbastien+lttng@versatic.net>,
 Jeremie Galarneau <jgalar@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200610173101._yayTZOvoH1jOsTHRNvfOlH6tyPkPT30t_wYIxr_vsI@z>

Hi,

This is an announcement of a patch level 1.8.3 update for the Common
Trace Format. It clarifies a few unspecified areas of CTF 1.8.2.

You can find the specification at:

https://diamon.org/ctf/

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
