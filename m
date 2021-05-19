Return-Path: <SRS0=5oIU=KO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B51C433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 11:19:43 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178BD6135F
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 11:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178BD6135F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FlVl03SRBz1qcC;
	Wed, 19 May 2021 07:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621423181;
	bh=3Ea5YQZIrKRV8GJ6DPHYpbSrdp3c4ispPPDTGMrx5UY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=qtbytF38/fkCSJ9JwsVpsnTRpMzwZK4bmR9NUdKE/vFFizL35WmfXRBmejR/VWoFj
	 Qw2XNalrBrWwBPvg0Q/AHbbKhZoLTpbePeVAt8zyWc5ykexPEU8KqmpXsrguvyS6sp
	 wA4wziyRut7EoZuyiY57Obz576qpRTVYrDAUPlPXhaV6wwq9JZK8H6BOE0xme++AJY
	 amX8LvNRfdFXfvOqu3YaHKb5OZqc8sEtFm693H5i4z5CxR1FLc8W9us31CVfqsL33J
	 25xexhK9FnYg+235XsolS8cGZpJLEkGlGqHO0WmdnIHHflOKbYluIxvYjXBtNRQ/zr
	 30A1aypolMoyQ==
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by lists.lttng.org (Postfix) with ESMTPS id 4FlVkz2XPvz1r2Z
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 07:19:39 -0400 (EDT)
Received: by mail-ot1-x331.google.com with SMTP id
 80-20020a9d08560000b0290333e9d2b247so879791oty.7
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 04:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=VPFFd8HbdXsKWEwlTVttk40Z9GE8SzdSk62L53EPXwA=;
 b=CyFkicXi10xfkROZc1gn/vvKgyES0A/zr4TXCYarvCligWYjrGFLeurTo5yP0JkdVW
 PM05csXj9G0A1W8hFpheJUrvd7wkxjkkgIL90afHFLnZRgtRYtX8vzKUZqXrsK1MFX9y
 CzlZJJRdRwbaYvKL8RLdOB0k50CIO7+azOgT9fsTEhKVvoe5t4YBTNE5JB6F+uia3Y90
 MRVlraQBZN4ksUilER3ASkZBlTKj5AS0jHphzSrbs6LZhRQhIhnIEKK/Qz3s4yVnx3zu
 rbpJUq8lw5QaZRAdeY9N/UFJrBoZsdFq8rvC+iIX/P5B1uDGNG8aKOai7r3pU9iscjHO
 O3Lg==
X-Gm-Message-State: AOAM532CpEDoi5IM6Rept+2sYhdgB4zifhTpzfalUNR3kSKcFU2I2op9
 Ht3WHaydUggSPrFXQxcXr2I1++Jtjxg23gB90qJ2slP49L6o6w==
X-Google-Smtp-Source: ABdhPJzwH1e/el7PYJWKiBhMzINIyC8z4i0sdUbKxRoIeW8Greqbd1P5xZhSXF4eG7sYeJxI/9j91LGrNbIbx+Ti2BI=
X-Received: by 2002:a05:6830:51:: with SMTP id
 d17mr8560617otp.75.1621423178330; 
 Wed, 19 May 2021 04:19:38 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 19 May 2021 13:19:27 +0200
Message-ID: <CADYdroO2NR71YoQ=-PSwa-Ej2LsvfqGNWMDiytPG7ADsUuuw7A@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] tracelog / tracef feature
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

I finally got some time digging into Lttng (using it on Xenomai, see
[1] for historic reference).

Since we have a hard realtime system, I chosen to use dynamic probes.
That means only
liblttng-ust-tracepoint.so wil get pulled into the process (it its
available), no threads are spawned, etc.
This is to minimize potential issues, without dealing with compiletime
selection/macros.

(Pre-)loading the tracepoint library will then pull in
liblttng-ust.so. So far so good,
but I found out that tracepoint/tracef are unusable currently.

First you need to link with liblttng-ust.so, then you have vasprintf
doing memory allocations.
I did a custom solution with dynamic loading.

# Outlined custom solution

The own binary gets a sourcefile similar to

```c
#define TRACEPOINT_DEFINE
#define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
#include <lttng/lttng-ust-tracelog.h>
```

There is no need to add the definition to the own tracepoint library,
the binaries tracepoint library will depend on `liblttng-ust.so` and
the definitions
are pulled in if the tracepoint library is loaded.

There are a own namespaces variant of macros and wrapper functions

## Issues

Thats a short recap, easier to quote and address whether some upstream
solution is possible

### Use tracelog / tracef with dynamic probes

is there an easy solution for doing this?
is the solution of creating the stubs yourself valid?

### Allocations in the tracelog / tracef functions

Would you accept a change, where first some buffer on the stack and
vsnprintf is used,
only in case the buffer is to small a dynamic one will be allocated?

### No Include guards in lttng/lttng-ust-tracelog.h and lttng/lttng-ust-tracef.h

Some other issue is that `<lttng/lttng-ust-tracelog.h>` does not have
include guards
and including both the custom implementation and `<lttng/tracelog.h>` will
lead to duplicate definitions and compile errors.

Regards, Norbert

[1] - https://lists.lttng.org/pipermail/lttng-dev/2019-November/029410.html
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
