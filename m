Return-Path: <SRS0=Psgs=MH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A32EC07E96
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Jul 2021 11:21:42 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2ED613BA
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Jul 2021 11:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2ED613BA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GQX500N48z12Qw;
	Thu, 15 Jul 2021 07:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1626348100;
	bh=BJARxsIKL3jdsdygeOJ4QYP33UaqzZqkTd8eT08Lzus=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=daDrFS9C041hwF48DbZ/kxtQFYJMDNMG+LWN3+ar+4Ius19YUgkIIauzI2Sao2Tjc
	 OSKxsWbX4uPvW7Ho+Kiq4oCNgntAZ6s8TW0ey7RW70KBAw9kOMTbSNkvIO0J4uA6f8
	 sGYp9ZJmmLb05UGc3r2zPdApcO6dzzbZi1Sho18YMvOa5bJ6HQ91f7rszA20FYmyel
	 XhRQoeHnT95Wi59HyMIrYoltzhL28MRxNHq23ng+Ln+IlPIFHw/pfRsG++QN7ty1eN
	 LHa4ljDBqm7qcKj0XkK2AdAXcFCCWI/huYY39VRODHMT6MFP6BRXvenKQs371GTLo0
	 rVYz9yBwQMJGw==
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by lists.lttng.org (Postfix) with ESMTPS id 4GQX4x6gmgz12Hk
 for <lttng-dev@lists.lttng.org>; Thu, 15 Jul 2021 07:21:37 -0400 (EDT)
Received: by mail-ot1-x32b.google.com with SMTP id
 7-20020a9d0d070000b0290439abcef697so5789877oti.2
 for <lttng-dev@lists.lttng.org>; Thu, 15 Jul 2021 04:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Rohek1ImF0JQHy9yeMYC9yCmFLBSt7f7e8+ZHU/w6UQ=;
 b=B6FSxPOSmDc/zWssK3nmH/WrI0ql9Gt7DOyHQe+3Zmc0UF5yKrnacVLppZ3PIskobd
 Bwk9bjTUnIdCwy7s2oCySSy4qS0sR2Ftuv0xh4I0/yJk0vT9JdWwjxoSo3gMzOPxeZV8
 dL0ow4cIOynudkJhyjUl74GJBKVHgF1yEm58ph8vUbaKIuHYWRf1tDp9Xk1wE4AXmM19
 X9K/hNko4GSRYcX03ladyss7E1RsxHn3RFk4PqSxkK0xj51Oq7c/IZsLNhvkAWz/g1L8
 KATMUXakXjyBvc0YKGqBB775h+Gs3x8VBVQYafnqIgvqX2ZoXB9eEacEbo3dIm9l/IQq
 Rd4Q==
X-Gm-Message-State: AOAM5329tyOTK0U3EZ2OQkLkaRSdUNL2nqohhjdU1GUORTpybSaJKIKS
 NrWvMuzjQ35FKZ/2SAMCKbhHF6WEDYBuNhkFo28XEl0Cl/w5Zw==
X-Google-Smtp-Source: ABdhPJzPNw8OlnUfBPvVwfrK3QBwkIybTUAn1DqrFskSRy+ZdBHPkMY2zav6GoPtDHjnLGgyWyLCCcGNmfO0ORJPOLk=
X-Received: by 2002:a9d:5603:: with SMTP id e3mr3312453oti.178.1626348096802; 
 Thu, 15 Jul 2021 04:21:36 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 15 Jul 2021 13:21:25 +0200
Message-ID: <CADYdroMJgt=bMGWmxFV8YAKWouBJeL5244_RM1S-D0SDF+tkzg@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Feature request: dynamically load from prefix
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

The production rootfs should be untouched, ideally read-only,
for development/tests a subdirectory can be mounted (eg. /usr/local).
Idea is that the contents of that directory alone (and at most some
env variables)
should allow enabling development features.

For lttng I would have wanted to add a library
'/usr/local/lib/libmyservice-tracepoints.so' with runpath
'/usr/local/lib' that would activate lttng tracing,
pulling in lttng libraries (ust, ust-tracepoint) from /usr/local/lib.

There is a caveat though, unless 'libmyservice-tracepoints.so'' is
preloaded, the code in lttng/tracepoint.h will run constructor functions
to register the tracepoint probes, trying to dlopen the lttng-ust-tracepoint
library and fail at that because this is not in the library search paths.

At a later time,  'libmyservice-tracepoints.so'' will be loaded, and
lttng-ust-tracepoint (along with lttng-ust) can be resolved. but the
tracepoints are not registered.

So I guess what I would need is to either retrigger the registration
of tracepoints
(likely complicated with static and weak symbols potentially causing a mess), or
redirect the dlopen function.
Useful would be either try to find the library in /usr/local/lib or
use '/usr/local/lib/libmyservice-tracepoints.so''
instead of  lttng-ust-tracepoint (both have (dis)advantages).

At any rate, I would welcome some customization macro.

For illustration the current hack-around is following

Norbert Lange

#define TRACEPOINT_DEFINE
#define TRACEPOINT_PROBE_DYNAMIC_LINKAGE

#include <dlfcn.h>

static inline void *s_remap_dlopen(const char *localfilename, int
flags, unsigned prelen) {
    void *md = (dlopen)(localfilename + prelen, flags);
    return md ? md : (dlopen)(localfilename, flags);
}

# ideally this would be LTTNG_TRACEPOINT_PROBE_DLOPEN instead of the dlopen mess
#define dlopen(x, y) s_remap_dlopen("/usr/local/lib/" x, y,
(unsigned)sizeof("/usr/local/lib/") - 1U)

#include "trace_mytracepoints.h"
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
