Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F690C5AD49
	for <lttng-dev@archiver.kernel.org>; Fri, 30 May 2025 15:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b860p5bWkz26gV
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1748617355;
	b=aeoEesf0f6+p94/W1MZ/YWCIwjNEvArsCOO+Wsh+Zr0Fpdkxn01+m+znAoNPq2NimcyZ
	 sB1Uyu05BrvY6hGzsJ7I6utGsZxtGCsj/CtQbDDoYpk/p2Mn2mSrObkuEwPfEDCsv7IPo
	 Oc3RSjsd2TV2QHdZ9Z/1uF8mTkO/EOUbn5IplNf6eC2OnkKtPfpr6VL7Xle8+6xweUfuO
	 jEVb92skTP3LXWNxoHQJHojzGtI217zUBQOQL4+TP9RFWAbMi5y/OCbvLc4aRs7DpJ9Sm
	 Y0ga4nuUFqUbi5c1KO99hNkN5YE5l8TMmMFGZmCqJBKullHHAGKjugTyN42W46A/Bhg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1748617355;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=EXuiDbY9754NncHTIKa3IP17wpNQQ9aE/DgGDjKN6Vw=;
	b=WB3v+Ze+h0haQRaXlnO7BD5KFQXe//IR4rPZA/JxMYg9SnFnaqI2iTh5KMeIOhIvQ4TM
	 IfcneQszTOhF0RPBYAGhhY5xjf69/OaY6NowEJY6hqa5MIFckfTJfqXX97gYQIId0YFMj
	 IrGxFjshMcA7wF0BhrN0rsFXtuB1CO69xqLYaWBAlTeY/aZ/SDSLZon4KHym0EBICRlEq
	 CmXZHW5SSIg3eY7lGQj5Av5aYlIn4t75xWtOL95KdGZg1J3j+wTUIK796jMgfgLgf1Dhs
	 Q7ziITCsDJ6x17GZu5qWrdM7XEYR1NwGzyH//FYsaoJQQl+rl/kGXLU5EWsIVlCtWlA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b860p5bWkz26gV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1748617355;
	bh=EXuiDbY9754NncHTIKa3IP17wpNQQ9aE/DgGDjKN6Vw=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RUDurcbs0AYG/bGTqWrbXSuPDUop49Aue2cILwgnPM3U3c8BLt3UKevzxHCKcuWxi
	 c9txbYAx/Okbe8KZPewYIPx5RhXdBXLWNe0sN13655Wxneucbw+Q8eUFd/wwnZ7tFT
	 xq5QYrg/PxSFHlpNEHHFLvAnrXMP8OA3qcaDT+R2vT9YaSr717Pn5vcc2G9zN1ZjJ8
	 i/eapahjpgUXM/gtQ3s3iuHxzmDqhSX1ZeJA7R3GdDhLDD0D3Hth+GM0+XBDtPp3JS
	 AY2jb2fEkR6DLLIe3cHqacySPyigL0rWr0soA81atZExdBmAaB6XNVcwh8uYa4REOl
	 pWIW1AU4AptgA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4b860p5bWkz26gV;
	Fri, 30 May 2025 11:02:34 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b85yW27hWz270Q
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b85yW27hWz270Q
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by lists.lttng.org (Postfix) with ESMTPS id 4b85yW27hWz270Q
 for <lttng-dev@lists.lttng.org>; Fri, 30 May 2025 11:00:34 -0400 (EDT)
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e803de44b3bso601520276.1
 for <lttng-dev@lists.lttng.org>; Fri, 30 May 2025 08:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748617234; x=1749222034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXuiDbY9754NncHTIKa3IP17wpNQQ9aE/DgGDjKN6Vw=;
 b=SPtG+fMIsnc8WKWsZhQ6D9wZShOcHZFttitQZ03SWkAzm/ydCNSKowRgdxCqbWr/W5
 eCaH1oRd7FIdNx9/jTEBFalV4w7D6RevSikGM5xWHEl5GAXJqCCIrTN09KZt3mLNvhAV
 Gic01p7AilZzAFE4Euzk/J3wnLxq3jemrxjibHn8hkONsXr6Ly7vREn3NBvMUqtvhCUX
 w41aNkwJWw6Pf0v8cAABC5B/1wiZqQcvsk9tMBA2JmIgaILZu2yho4meAnNm74i6uXko
 kfwCWipGKTTNsvKR+0yEgsbmle1JTdRVv44827wssIRa87inp19NnK7bUYdIW+Op9qHR
 HmIw==
X-Gm-Message-State: AOJu0YwB7EZeH2U+gE1Hm0Bid9ae2jt40/w7E44Or5ACL2jJzxe+ZCXS
 TeCG/Csw3gwO3NIXqVkfEOIZZmDBY9hcviT7nyGOyMO/zZev8GfnuBzhg6345DKY5bOeUB1tqBk
 WJ1N6uTU7ZW5a+zOD3LO7TYDPd/lPBxQ=
X-Gm-Gg: ASbGncuXTKEmhQ6Jx2TLMoGOW6tEtvoHrTjqYdeqF2dBAEaepaukcsHbzllcNLgglr/
 IbIf0y07SQXuhayXQG/22WPFK7MQwWxPa61RhoPmitO+58KA4M2uogIUuJ/NIaAW7W+M+PdoYby
 CvHm8OoRsna+WxnXxVmu1Pe7yeil7pStPTTkMLaGm8DILp
X-Google-Smtp-Source: AGHT+IEB+mKrmC3W3V/EmZvWyj/1kss93zFMEs445EUS43uro4msqFvgznty1VJyir+ya4z/VgV3rQ3g16RpoyYgKlA=
X-Received: by 2002:a05:6902:f8a:b0:e7d:bf67:4688 with SMTP id
 3f1490d57ef6-e7ff611dd43mr2476989276.23.1748617233842; Fri, 30 May 2025
 08:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJK_iej1UnwTBaJCY0WwP2g=zqEMtphgM2DUJhtKmHxNceD3yw@mail.gmail.com>
 <93e83ed5-bcf3-4a5e-b713-4f9612ff7a6d@efficios.com>
In-Reply-To: <93e83ed5-bcf3-4a5e-b713-4f9612ff7a6d@efficios.com>
Date: Fri, 30 May 2025 16:00:23 +0100
X-Gm-Features: AX0GCFsCqZPn0wD19btFcuUJvqFbqOy72kp-BPzIVHnG-QNLvH6z3A8F26mvAHo
Message-ID: <CAJK_iehAs4seOuTxxrGtUmh92jA_kbwuphb=dcWm1DSDfpxEBw@mail.gmail.com>
Subject: Re: A question regarding isolated cpus and software interrupts
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 30 May 2025 11:02:32 -0400
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

Thanks for your reply.

> How are the cores isolated on your system (exact kernel command line
> options or commands issued) ? There are various degree of fine-tuning
> to prevent disturbance from the tick (nohz full), scheduling, and
> irqs that can be done explicitly. So depending on your specific
> configuration, you may be missing isolation options that would
> prevent the softirq from running on your isolated cpus.

Our kernel parameters are:

ro skew_tick=1 rcu_nocb_poll rcu_nocbs=4-31 nohz=on nohz_full=4-31
kthread_cpus=0-3 irqaffinity=0-3 isolcpus=managed_irq,domain,4-31
intel_pstate=passive nosoftlockup tsc=nowatchdog intel_iommu=on
iommu=pt default_hugepagesz=1G hugepagesz=1G hugepages=4
vfio_pci.enable_sriov=1 vfio_pci.disable_idle_d3=1

(the affected thread runs on core 4).

Best regards
David
