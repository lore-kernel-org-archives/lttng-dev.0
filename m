Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1ECC5B555
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Jun 2025 14:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bDP7J5sFLz1CyN
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1749220687;
	b=aY6yy8fiGbqEXs50n5VWiFUTY31vHVrsPGRUH6+kMeaQaKUMb2cR7DMJjVVwNpmM22j2
	 //NrjsY5037fX8BXE0K7ouc4KYMqwAvDOX4Iw3kICwYTtpG7SX5cbCFSCgDBr4DsJXtPJ
	 mztQMOODhimhbxc0MLb+ZAbaDYriIY4eNMJAmXLCw4oPQoM5JMK2pfI0xu+8M4dnAGenN
	 61YXbUTVgPfNKN8c4ATCXVx7Y4+xrNyxlogKoKeKpn8d+DAjfKnXdaXHKgGQ7EEN8psS7
	 RG2Q9WtmA1UY0545+2/5BkB3Rtt9bPJJQ/KDg0UdThunp9cB2SC+vAQvPcbDwXQH5Wg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749220687;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=AuXqhZy1/MYG5GAmQF8NSlAoCu93YX2t8V0gFs5p2bQ=;
	b=T6TjbWPyki5plpBltXlSFS5F4/Ik2UhwrC6arrYVpd2b1cQQg0GFoUD+d453xRxyeQwm
	 cI/OR4nbT1H0yeWwFEWNtJvtTOp8Uo60K4Nm/yr5zOAkNeZgzcbV7ljVulm1XA8MP2vWf
	 ZM/xnS0nR5WIR4+A4X/lbmyyBUInzC9VUueOuDdhw5Kgl/oKBHbovcTno9bFw3Ccueleg
	 jSvcDEIfFQuUDGDX7iBmLQ1VA6tVkr00ct5V6mFtsUt027TjnwXyJvfuF7HffJPcTc8uv
	 7lBX/mUgIrZ3rawF66F9UsCLaf/FZ/O7e87zj3AuQXX4asY95u2CfiVngLoRrHePGKg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bDP7J5sFLz1CyN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749220686;
	bh=AuXqhZy1/MYG5GAmQF8NSlAoCu93YX2t8V0gFs5p2bQ=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YxkMlIAqS6CgFsh9ANbikIrREbI/dPqVg79tkt4LdHn2+a5IJhqyjyZipLd555Pi+
	 yovnIjlmihI4XvqpNRPha6ebTRgNhxSyhkG+tOQ1C1BRyRJEY4hcgyviigPiLwIKvn
	 tlRT2iIDoItMTpTIEOPG0Y9Y8xy2D8b8Zy+osm8/pjGIxrD9mg+1RRLQqX3deEUlH/
	 g9LwUf3rxgqEsuJEK1VJVFsaavNOOYPGNCC1v3rW8suwx3o6hh2sR6ERl4UkJLMg/R
	 861gxbXMT8ezSTamFJaiMyZbpUP0d4RF3bhmWg+in5hQX6dvFRvCHqSwFne5+eEihn
	 1mBFmakkXY8qg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bDP7J5sFLz1CyN;
	Fri,  6 Jun 2025 10:38:04 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bDP7H4mTLz1DZJ
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bDP7H4mTLz1DZJ
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by lists.lttng.org (Postfix) with ESMTPS id 4bDP7H4mTLz1DZJ
 for <lttng-dev@lists.lttng.org>; Fri,  6 Jun 2025 10:38:03 -0400 (EDT)
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e812ed38d02so1964342276.0
 for <lttng-dev@lists.lttng.org>; Fri, 06 Jun 2025 07:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749220682; x=1749825482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AuXqhZy1/MYG5GAmQF8NSlAoCu93YX2t8V0gFs5p2bQ=;
 b=NyVlEB82i8fRIstYJplWEk/BLGOvQlmiDr+yCQ1GH2iNyx4rG0vO00f8iSZ+ZUPlFj
 L8aI6Az7OjF9zsrjloeYZV6AF4Z6PRPVqtcpIiPZ7tmsyExcIgGX5DDLQWPTiRoFKijs
 wGY3VwGiMlKOvjQuKqT82gDW8DwcKloPh16TFt0N1OPcng7cBB4f+2WC1zYIWU2Ew2k7
 AGKAVv8es3XuvpdRTXwbnWdzAO0Dtx53w4tTW01exEBCFxdsJHGrnanvVz096qzo2tar
 zs7JA6IY52NocyHNXkJ3h5ktC01a4d0e1scZ8PSLAuNCsSnodV9anFsae5D3FPCIi80O
 hBQQ==
X-Gm-Message-State: AOJu0Yyz/z/umD8zWavgLkK7BMeiwRvoo/5JBLVKYf9Kd75HQ1vxlNJs
 6on/2xMZpULvmmTM4izlw4jU/HI/OQ3+YbP9WRhFGhA24dgQZLEnOwYKDmU6X8Y6S1vn/b36V6t
 mHQjLCbDLgSj9ysN4R6iyED8CHoy1wPQ=
X-Gm-Gg: ASbGncsfYBitoBKRqLoYKDwqtP+M8W8u1lRM0F/D0vew9z92oba9NU8eMxGu42UDhwQ
 idKU1Aw2WzWhOT6F1W/YB/TQO5PEr5hfX7/JmvRnEhBwGjhNAP3Atv7d0DaVakCBLYWVUz7mdWc
 ctP3Kxu0ZnqwuwyT1VwTXZdGY142TaHarbTQ==
X-Google-Smtp-Source: AGHT+IEX1iySquRwXSMShCS547gX2ex5K3keragaZOds6xbUg3l8CJzl3Tk113ZaH2ydrzyVNVsEsgf+T92PxVOerz4=
X-Received: by 2002:a05:6902:4911:b0:e7d:d037:c7aa with SMTP id
 3f1490d57ef6-e81a21c55f5mr5145986276.33.1749220681683; Fri, 06 Jun 2025
 07:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
 <cc6438cc-1836-4983-8f09-c569ee2cf11d@efficios.com>
 <CAJK_ieiG5yDoyg8TetipUJZNMhrpteZuY5CBv5eeUNE18AJq9Q@mail.gmail.com>
 <CAJK_iej5GwQm6pjRuMxDJeYLu+YBjp0NTjh3xzvOCvOJ8aft3Q@mail.gmail.com>
 <9e5aba04-2485-4807-92e3-980b62a29c29@efficios.com>
In-Reply-To: <9e5aba04-2485-4807-92e3-980b62a29c29@efficios.com>
Date: Fri, 6 Jun 2025 15:37:50 +0100
X-Gm-Features: AX0GCFt2uT30PeMzIhomVQ7AJsOUL321sNPYiyY_MWV76exyEu5g6iXSoR_Tars
Message-ID: <CAJK_iehv1BWCp5FOfXkrDpPoDTG1nnhAZ4iCS1rRwjQbpQQkxQ@mail.gmail.com>
Subject: Re: Function tracing not working
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Mathieu

> Indeed, You will also need to enable something like this:
>
> lttng enable-event --userspace 'lttng_ust_cyg_profile:*'
>
> See "man 3 lttng-ust-cyg-profile" for details.

Thanks for this. I used your suggested command and can now see the
Flame Chart (Incubator). However, I only see symbol addresses, not the
actual symbolic names.

I compile with:

-O3 -pg -finstrument-functions

Do I need any other compiler/linker options to resolve the symbol names?

Best regards
David
