Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3F1C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 08:34:43 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60C960FF1
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 08:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60C960FF1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm3294pw5z1rW9;
	Thu, 20 May 2021 04:34:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621499682;
	bh=3RBxG6Ur5uTJ2wMzj/N6q8qYS7M9ltuCLuL8zGQr0Sw=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KegRlqpKDDiS+zMpHUzcdyTTcYdARUJJXi5mIJDoe/sN1kQFBnxEn1pqvxO9XRyQF
	 dxm/f1SCQ+K1sFQzKlP2CEMGuH/XDQ4m2vwsQfp+c1qTETj9zqq94TCmasWYldiVee
	 jurDcFcQ5DWZsllAwwWYyxQQvekjSkMMs4x4zO4jQxn9LgkLmWvkDyqUkDqkSo5Ezr
	 wsDqKhBRfBZhCogP1YirxXQP/Khj4JwrDR5LfpBeAjEbBUUz5q4xkZxU1vHCyulnFl
	 Jwo0Eo9Drcs15rE4xRC57ybAvjEfnudyl3KhGTOtbWBP/ys9eb7zJliS84Ib9wk93P
	 xlQ/uwjQMV8NQ==
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm32809jDz1rbc
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 04:34:39 -0400 (EDT)
Received: by mail-wm1-x330.google.com with SMTP id
 u4-20020a05600c00c4b02901774b80945cso4851835wmm.3
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 01:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=EUdA6xYsyxxVphaT/KLUMoLKUw3dDVE35lj/Nfmx4Dk=;
 b=eqS1C8oK47K5qpGhCvAh7adgb0HAI2YSSel2cAOKKTeClFSMaUEViHs/9JgSNMXI8v
 4R0yQUtduluHebPqDZ/21jRis5sRgrUrVLpi/CA2suWU0NswQCzBG2OnclFdT186s6Fe
 K2lgzExx9o/hNMly2G6u32WFT+4cwGZpajkA7ifB8FCU7z4vWN1r4dDtAzbK0c7y6H8m
 iBwW70Fb/f9FidiZp5DHl7ipUvL1ooP68XVV+m7DeEZOmhfiVxqHuz8s8T08DcVLfzxg
 +BoqNBInjtZ1wD0ubJ5FPt7k9H68w8uFvyNF0Xd7WtNx+SVutkyPRo7aSvmcdKg9fJAf
 VbXA==
X-Gm-Message-State: AOAM532QiMhHutW7SUG8rCSVOnYUUCXlDgvXlshf4FQYkhVnnHk6mpm0
 qjcHVofZ1OwGF07BC1RBP5QaDSlSZU66t5s2ROnHLttI2b0+Z1Pd4Gic+awNbKBD1zF3oVZTKwR
 lNPQYUOw+cgKHhmRpR7zL7LqzDAGHX0Eg5XN9gg==
X-Google-Smtp-Source: ABdhPJxGCGM+dmYWdr3+XW1CPq6ydqDpciGcV1FSYumaEYKs8MYofggM5XdihIapJ4Y88f7lvIo1OGgvvWEJX9Bu49Q=
X-Received: by 2002:a1c:5454:: with SMTP id p20mr2789623wmi.160.1621499678343; 
 Thu, 20 May 2021 01:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANQXvtRR1HvzQkwmzH_HMGGJjx2PP_XAiOgLZxjMWbuyhzjH6g@mail.gmail.com>
 <69a2d37a-d60d-deba-02d2-c3084f62b84f@polymtl.ca>
 <555b0ddc-fbad-82d0-c052-27006310a577@polymtl.ca>
In-Reply-To: <555b0ddc-fbad-82d0-c052-27006310a577@polymtl.ca>
Date: Thu, 20 May 2021 10:34:27 +0200
Message-ID: <CANQXvtS2mPhrJC+=SLM2f=16gKd5hC=VdysG=ow79PJrL4q7Vg@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [External] Re: Babeltrace trimmer segfaults on
 custom trace
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
From: Dimitri Scheftelowitsch via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dimitri Scheftelowitsch <dimitri.scheftelowitsch@esrlabs.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgU2ltb24sCgp0aGFua3MsIHRoYXQgaGVscGVkISBBZGRpbmcgYSBwYWNrZXQgY29udGV4dCB3
aXRoIHRpbWVzdGFtcHMgc29sdmVkIHRoZSBwcm9ibGVtLgoKS2luZCByZWdhcmRzLApEaW1pdHJp
CgotLSAKKkVTUiBMYWJzIEdtYkgqCipTaXR6IGRlciBHZXNlbGxzY2hhZnQ6KsKgQmFsYW5zdHIu
IDczLCBIYXVzIDExLCA0LiBPRywgCjgxNTQxIE3DvG5jaGVuCgoqR2VzY2jDpGZ0c2bDvGhyZXI6
ICpXb2xmZ2FuZ8KgS8O2Y2hlciwgR2VyZCBTY2jDpGZlcgoKQW10c2dlcmljaHQqwqAqTcO8bmNo
ZW4sIEhSQiAyNTc5MTksIFVTdC1JRDogREUyODIxODU4MzUKCgoKVGhpcyBtZXNzYWdlIAooaW5j
bHVkaW5nIGFueSBhdHRhY2htZW50cykgY29udGFpbnMgY29uZmlkZW50aWFsIGluZm9ybWF0aW9u
IGludGVuZGVkIGZvciAKYSBzcGVjaWZpYyBpbmRpdmlkdWFsIG9yIGVudGl0eSBhcyB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50LiBJZiB5b3UgYXJlIG5vdCAKdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
eW91IGFyZSBoZXJlYnkgbm90aWZpZWQgdGhhdCBhbnkgZGlzdHJpYnV0aW9uLCBhbnnCoApjb3B5
aW5nIG9mIHRoaXMgbWVzc2FnZSBpbiBwYXJ0IG9yIGluIHdob2xlLCBvciBhbnkgdGFraW5nIG9m
IGFjdGlvbiBiYXNlZCAKb24gaXQsIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYnkgbGF3IGFuZCBt
YXkgY2F1c2UgbGlhYmlsaXR5LiBJbiBjYXNlIHlvdSAKaGF2ZSByZWNlaXZlZCB0aGlzIG1lc3Nh
Z2UgZHVlIHRvIGFuIGVycm9yIGluIHRyYW5zbWlzc2lvbiwgd2UgYXNrIHlvdSB0byAKbm90aWZ5
IHRoZcKgc2VuZGVyIGltbWVkaWF0ZWx5LgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
