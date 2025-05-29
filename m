Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EB2C5B543
	for <lttng-dev@archiver.kernel.org>; Fri, 30 May 2025 14:22:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b855z616Hz26f3
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1748614922;
	b=FJRlNwGuiRVkWhS6vJI42lQ1jyu+csLoltA4WOCFWQj1kfd4xBsxh2ksMSovrE1T6Mu3
	 D9S2u8T6bGt8tW2PgbkCICb7WxOk2+OI/S4Sgk57PWXF5y76qIn3+rY82Fj7+iQNt1dd2
	 qyj6KRfQB88a34XF0Dz/87cZXW1Zf3/O8l6+vFsnYCgfc48gsHGpLvnJpC+1VUoGpNfUl
	 02WFUad8MDuDUG90KY1dlGPm0rexKLQFY/KPVnCZWcx5Zfp51kxSX++P1kMhjjn4YRcYs
	 i653UkpiIDcWPxSaqUJLyL941ZPqit1MHBvy9gscRbuOeUQIGX4gdApdBR5GnFTWF3A==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1748614922;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=edW3MF5I12Ac0hJpaTD/ihcva8Es7npvjkXnr/9mhWk=;
	b=HthSnjtfhgHSo+pq2mkHOHo0F/b0GvPi5ugjCC1bccMK6/DVhw0/unkLhj4Iou0oyn9P
	 bcgzq91CU86CpBDCof3S98LMxxDibsr/d8FiblqWRxcVYh2tEDTYYfRNR4LdnMK7zJgY3
	 l9zup4GXvr+oBiWTqcBHdlaq6Lk7J2WS/f2FrvdfiwwlWPfzoDYdxqCjzImPFwHSnv2r8
	 TkyNHvL3EpGPQE74UDiPKMA0PmDBHSPTb+0mMUabsn6wf1mWyLEN9L4YU79P+od+iYVBM
	 F5+iBEDT6Rlg+WLxrIi4dcTwdcQqBeTfAnls9SGMeCvqq1Pj3zm3pfa3gRxDY0XDLWg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b855z616Hz26f3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1748614922;
	bh=edW3MF5I12Ac0hJpaTD/ihcva8Es7npvjkXnr/9mhWk=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=XzoHxQHdWaeCwQTNf8FFinpKhuhQdMNoGcxyzaFnegIe0LxfVm4evhjWgQy9Pd+De
	 5X79R51cqsllRdWrs/gIbJKb0Um80tkZS8b5hu1RQcZupmP/IKithCNNQvAzM/8pcV
	 8npLciJ+p8/nznFj0uyj3f/8fLMefNyP0C6zuPI8y8JX/Dr/6eSnxOgK69wR15SOwZ
	 GtUvQvAg//FjqmT5ISJcEgJYsH61Tiqk987eHJ7maBWDeMWZkzFAgzecEKI1x6SWd+
	 vWKpYqT+nDugCHGRydLTrb2rhhtZzHe15FABoDuWpLA96DgjGNClwaGOFEU1PlUCCP
	 jJziJI5Fqkr0A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4b855z616Hz26f3;
	Fri, 30 May 2025 10:21:59 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b7Z7m504cz1fP5
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b7Z7m504cz1fP5
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by lists.lttng.org (Postfix) with ESMTPS id 4b7Z7m504cz1fP5
 for <lttng-dev@lists.lttng.org>; Thu, 29 May 2025 14:06:44 -0400 (EDT)
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e7da3180098so1236366276.1
 for <lttng-dev@lists.lttng.org>; Thu, 29 May 2025 11:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748542003; x=1749146803;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=edW3MF5I12Ac0hJpaTD/ihcva8Es7npvjkXnr/9mhWk=;
 b=fWnDMmLh8KLF+2M5IbEJhFjUgStsf5M+1ZTnBPiZuNjtVcySzuib6GRHdSqWBSB1MQ
 7xgLL4TPFb8R+2+NmHsUZx4NUDxUH8/HeU0VynbowpcQ8Jqqx+Abp8+3xtM9abp5ahwW
 tsAXgehlzbVkhJsD+AngN6vbeIFJDqWcBE43iFvLAwnqEQEzQe5Px8I5410W0Rnx+wLB
 mg0HYpS4RTV2EKUh+nW4WhZT7Xd5LMnTT/EOWL7AMnuxmRKhQxOTroc3wWDDD69vaYU3
 gPDKgb3UqoonHHVvL6O/IawzTYP+W0JKGGyTnec+TK62v/rfsS3htHx/czYqIxXJo4Yl
 SSqQ==
X-Gm-Message-State: AOJu0Yy7YvQcD8yc9fopqTdPe2DN2vWTQGb95iaC88gHdZj03oYfRBO5
 dln5u75TG+dYLcXmFTpJ9wCTvmhCQoq2Yr+aztAVTVbO6zjAbJTf8mS1RMQzegy9KyaFy5umNfc
 7lPdLPLw+fikCQCg1wus7Tgi6eRQzw233Nwv/
X-Gm-Gg: ASbGncuepkkBwkQahh5ygn/alKkiiiSvKbSSRRPIDiFfJFLhhjrPJ5d+DJYAthDZboU
 CqpTUFTS40CxBxLGIOmzfwIHUV+U0GWBgm2i2fTByeWnChr2RrA4ockNr50ad/ft1WVjn/1kr0X
 tW6pAGT1WFzNdnZd4xWf/UPO0hMzUeA38OxA==
X-Google-Smtp-Source: AGHT+IHE+ygd7IxW0AlkbSZUagp8kWTu5SDiQLw20/UCpAgclyfoZ2sw98PILfUPUCFOWnaJLrUfowLPiAHSp8V5/Yg=
X-Received: by 2002:a05:6902:1028:b0:e7d:6fe3:fc81 with SMTP id
 3f1490d57ef6-e7f81ee2da7mr852770276.30.1748542002703; Thu, 29 May 2025
 11:06:42 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 May 2025 19:06:31 +0100
X-Gm-Features: AX0GCFuLx1ebg1um-Wvw2yLKxLULT9vBQmKSGIdGNhtG4ZD2f7z9axswg2Z8rqk
Message-ID: <CAJK_iej1UnwTBaJCY0WwP2g=zqEMtphgM2DUJhtKmHxNceD3yw@mail.gmail.com>
Subject: A question regarding isolated cpus and software interrupts
To: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 30 May 2025 10:21:58 -0400
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
From: David Aldrich via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Aldrich <david.aldrich.ntml@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi

My question isn't directly related to lttng but I would welcome some advice.

Our Linux application is showing 'blips' whereby there are occasional
increases in processing times. This is for a user process that runs on
an isolated core. Using lttng and TraceCompass I have found that the
'blip' sometimes coincides with a TIMER_SOFTIRQ event on the isolated
core.

I was surprised that software interrupts may run on isolated cores. Is
there a way of preventing this?

Are there any techniques using lttng to gain more information related
to the interrupt (e.g. what is causing it)?

Best regards
David
