Return-Path: <SRS0=Se4k=LL=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF350C2B9F4
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Jun 2021 22:13:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E3E61249
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Jun 2021 22:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3E61249
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4G5btW1HwZzJ4N;
	Thu, 17 Jun 2021 18:13:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623968036;
	bh=b3hYp6hh3fTt0feH6FWNOEqTftPz71Oz0us7SBUQS6s=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=vCqMEqyeIhnYP5OdvmH6MJRymH5hGXt0AyaDw3nFCb+3SIJxTa9pV/6G2IFh0P1j5
	 o9dD3EgG6Z71GV1WhOAKc5PZZuE06Q+zeprvMu6JywStTX1DLi39hGWI8oqnHQAizB
	 3CpGwB8pqveGYvy5fZVVTTupV3ZhasHAof7jGdY7NLOSZIr8Ff8iS85x46B5eWd1vV
	 MqU0+0+jJbVviW4tihUg16kMqgtH2NhVs27xmoR0on2KYXbUq+6L1oQt9IaN78++eS
	 aKyKmOqja9lBqOtuPAH3m2XCgBQFydJ2cGDKcLv/qMQtsk7pJKn1/+dvmKNPSfA3Ln
	 ACnukoDLJnt2A==
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by lists.lttng.org (Postfix) with ESMTPS id 4G5btT49HqzJ5N
 for <lttng-dev@lists.lttng.org>; Thu, 17 Jun 2021 18:13:53 -0400 (EDT)
Received: by mail-ot1-x32f.google.com with SMTP id
 6-20020a9d07860000b02903e83bf8f8fcso7693211oto.12
 for <lttng-dev@lists.lttng.org>; Thu, 17 Jun 2021 15:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=JF0W1fEZ1vjZl6czrPoSLj+lze1ctrs9ZOMbUPBxCkg=;
 b=rgGmJoNFFZF3tZ2OlnxprMtl1jJ7aW2HDizTN7byDvXT2eUOCAghXlp57WZBIRCJqL
 WTmcmWf++eABvbt7OSMTJiET74ZKXaFCnymnpfl0z58iCrC5mPq+xxqt8ZWDpde3jIUq
 upfU6+sgfk8pdrd+9hT5Bi/H5CSrQ+5LWnfYDZ+PLOIz7MVjIVThB0CkDrRaN5e/EL+O
 gYr1adqfDEgIZ4t7ewWWLXAxbX9V7JwWgE0vaznqoNzZ7cEuixD/E5YruAGPd7WQPXOx
 9B5BffryXJ9ZqU+gyiV8qtQk0FIlotM9Rl9MhKs9xPujXcIMGD0f51ykupXONkrSvotl
 eiBw==
X-Gm-Message-State: AOAM531ogjCZuZ3/nodZqQBgTrPt8yfiGddiurKaSiGZNWPwUFtieyYB
 zBGvViwP7obst2MeRsYcpU3/CTLU1Nu/pdd+twFv71auFGVD0A==
X-Google-Smtp-Source: ABdhPJxrWVd6lsQsmjswsOquzbrve6SesQdT4/n/sZ1+5AFrHqP4rK2KgeLluwhqcGWbxZFWDYSmpkIZufR7swle1ok=
X-Received: by 2002:a9d:5c14:: with SMTP id o20mr6205350otk.328.1623968030619; 
 Thu, 17 Jun 2021 15:13:50 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 18 Jun 2021 00:13:39 +0200
Message-ID: <CADYdroPw9Xnwqx97xQSyiFLR1s-Sb2RvtcbdRGu-VmG0Tfydgg@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Disabling sys_membarrier in lttng urcu
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

Some old topic, see
https://lists.lttng.org/pipermail/lttng-dev/2019-November/029411.html.
(I actually thought this was solved meanwhile).

With lttng 2.13 liburcu is replicated in lttng-ust so my old custom
hack aint helping.

Aside from another crude hack, I thought about doing this:

extern int lttng_ust_urcu_has_sys_membarrier;
int setup() {
  lttng_ust_urcu_has_sys_membarrier = 0;
}

this is obvious possible in my own program, but I don't know if some
lttng daemon would need to update RCU structures in shared memory that
should sync to other processes (and wont do that with sys_membarrier
in case of Xenomai threads)?

Seems safer to me to hack it out once more...

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
