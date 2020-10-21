Return-Path: <SRS0=G+Hn=D4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F1CC388F9
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Oct 2020 15:21:59 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CB62177B
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Oct 2020 15:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Sml+W4ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CB62177B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CGZ3S1yVPz15M7;
	Wed, 21 Oct 2020 11:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603293716;
	bh=w8Wvglpxu35EIan5tperQTNZuCpWSaCn/+XbZOKEoTk=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Sml+W4ysV+Q+hvqDFivQL6x0A8n063/1NWRQ3i/jRAvXulkAbklge2NJHq4BoCBQl
	 Eoy52kK68DIpQEEQLRpjwc0zZ6OSo+yK5f2vHdLkZ64O6GLFZC5P0x9aLUDvn7O69C
	 E+EUIh5vLE8evLKzhRO5y9ic7i7+M3+np8jvUFlfqRPD96LVE8t5aQuKi/Y3iWDUPe
	 4HpkWaZFeI8Ti+ldTJulEpPW7U0upXsPEeFLUs4lok4QCLX2yzMTgHTqNVbr3akLlR
	 MB0PsQUYtIHjXQ4JhycHZMJnZypFIWwwre5HV4c4hgzlFZjyup0ftj/NMTWXmBl1uc
	 UIAbd+PH3mxcg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CGZ3R0pxLz15X9
 for <lttng-dev@lists.lttng.org>; Wed, 21 Oct 2020 11:21:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D8B822E5B8F
 for <lttng-dev@lists.lttng.org>; Wed, 21 Oct 2020 11:21:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Hpud5xmg_RCa; Wed, 21 Oct 2020 11:21:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 839BC2E5B8D;
 Wed, 21 Oct 2020 11:21:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 839BC2E5B8D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 93iNRZoCOFFg; Wed, 21 Oct 2020 11:21:48 -0400 (EDT)
Received: from [10.10.0.55] (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 6BC052E5A9C;
 Wed, 21 Oct 2020 11:21:48 -0400 (EDT)
To: "Applencourt, Thomas" <tapplencourt@anl.gov>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <SA9PR09MB57258DA2DB866F09A1950BBAC41E0@SA9PR09MB5725.namprd09.prod.outlook.com>
 <e217db77-248a-d598-e906-3091e04a0863@efficios.com>
 <255b71b0-fb0f-5548-e96b-b16c9f6662ed@efficios.com>
 <SA9PR09MB57256409CDC88BC617D5C8C2C41F0@SA9PR09MB5725.namprd09.prod.outlook.com>
 <SA9PR09MB5725EE9DD44073D9561D5A18C41F0@SA9PR09MB5725.namprd09.prod.outlook.com>
Message-ID: <1a982d6b-5be2-3b69-6c8c-1c20b6a6534f@efficios.com>
Date: Wed, 21 Oct 2020 11:21:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <SA9PR09MB5725EE9DD44073D9561D5A18C41F0@SA9PR09MB5725.namprd09.prod.outlook.com>
Content-Language: en-US
Subject: Re: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use
 PKG_CONFIG
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2020-10-20 19 h 16, Applencourt, Thomas wrote:
> I just saw the fixe 
> (https://bugs.lttng.org/projects/lttng-ust/repository/lttng-ust/revisions/ff1ee9bccaa84dd4b062387989c107eb1dafc136/diff 
> <https://bugs.lttng.org/projects/lttng-ust/repository/lttng-ust/revisions/ff1ee9bccaa84dd4b062387989c107eb1dafc136/diff>),
> 
> Thanks a lot!

This patch was queued for review for lttng-ust, a similar one for 
lttng-tools should be merged before we release 2.13.

Regards,

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
