Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B5BC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:52:42 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA40560FE5
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40560FE5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmB543fMjz1rtn;
	Thu, 20 May 2021 09:52:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621518760;
	bh=ZfDktKMniSOSXsK7IYpTAYMpQaaxBTlPWlsnHpSXfpI=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=p7iJtZbERRY6KfEYISGvpOi7LGeP3xAb9VWKxcWFJXnbnL3ufMsaxU22III7DDxsW
	 w5G160Adud1RixOWiykxcYt15VA5XHvIuUiDF0Jrw2/Aw5GaeyNPXEx0Ih0NwbLg7V
	 XmLMcv5dxZZdysKBKbPzGnu0LtPmyLWGMnFSCVVagzS90/exRvZciyj1tCHCvxnuyh
	 tF4WA/mj8ffdswFwpqaxXmyoR8RJhyl+NDQ8Y1IcGqptfradSac6Rlt9MI2lgSmCTo
	 yxWcVostedtbKnmgCVZKLk09F/Aim4XbdhxLKvh+fzgTe1TQICh/k+VlX8kEwHiURG
	 id6k7adm8kXJw==
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmB530vfMz1rtl
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:52:38 -0400 (EDT)
Received: by mail-oi1-x234.google.com with SMTP id j75so16406501oih.10
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 06:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XsmXAzQSF/EbyCVosI2LbDwyTyPUDLcT2A8alz6nu6o=;
 b=bED3g9Qp3PQ1BA9Wxac8AxTpmTV5mPziuemjZOgg8FWatXeBZgLkm4nTEDagssELBn
 MjarKkn7kBuY5Z6nZ5uh4MnUkqoA8ng+YZGfexTFZwhhzdEHMjkpKmrgRwROxJwuvyWi
 EiYFk024wona4siBIrIjOGgCvOLsRI7VaZTN9jYSvQiZ11wl7bmdcktsojFIS+EaesUb
 0oq+zaFGcVthArnkr66liThgb5oSkJwubOtm8kdsXqEe2bdmRqFUbgRFgTmXc+YozT6E
 WqVUEruWqj2mcy420IXupHxUja6KucqqHHKOZ7ag9BSnuc9wabDXDl/uf4fnI3O3oXq4
 gboQ==
X-Gm-Message-State: AOAM531GEPPNbZ4WPhP/hlxItkowJXATlKvOmNig+4pWkw0lxRv5uWTm
 s8GzAwn9L9wL0GU4CVi7lvxO2LcB+uPInOkNNDTp3C4JDsKWUw==
X-Google-Smtp-Source: ABdhPJykIQbe9QKfp3FPDae6PEAmHxMOE5zXyW8aE7D4X975nZVxxXsNQWqz7BgjLpaorE2UIHPzJO+fLUrBJVFWbcY=
X-Received: by 2002:aca:acc7:: with SMTP id v190mr3414035oie.28.1621518758438; 
 Thu, 20 May 2021 06:52:38 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 20 May 2021 15:52:27 +0200
Message-ID: <CADYdroPf5mcRMvfewsT6SQsWG0RKg6GcV8=T8BupxbooHT2=aA@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] 2.13-rc2 fails to build with buildroot crosscompiler
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

many tests fail to build, apparently because transitive dependencies
are not found.
I managed to patch out building the test sub-directory, at which
points the errors are gone,
I dont know how to fix it with automake, seems like
/tmp/ZBuild/build/lttng-libust-2.13.0-rc2/src/lib/lttng-ust/.libs
should be added to library search paths.

Norbert

bin/bash ../../../../libtool  --tag=CC   --mode=link
/tmp/ZBuild/host/bin/x86_64-linux-gnu-gcc -Werror=old-style-definition
-DLTTNG_UST_COMPAT_API_VERSION=1 -fno-strict-aliasing -Wall -Wextra
-Wmissing-prototypes -Wmissing-declarations -Wnull-dereference -Wundef
-Wshadow -Wjump-misses-init -Wsuggest-attribute=format
-Wnested-externs -Wwrite-strings -Wformat=2 -Wstrict-aliasing
-Wmissing-noreturn -Winit-self -Wduplicated-cond -Wduplicated-branches
-Wlogical-op -Wno-sign-compare -Wno-missing-field-initializers
-Wno-null-dereference -Wold-style-definition -Wstrict-prototypes
-pthread -D_FILE_OFFSET_BITS=64  -Os  -D_FORTIFY_SOURCE=1    -o
ust-fields-compatapi1 ust_fields_compatapi1-ust-fields.o
ust_fields_compatapi1-tp.o
../../../../src/lib/lttng-ust/liblttng-ust.la -ldl
libtool: link: /tmp/ZBuild/host/bin/x86_64-linux-gnu-gcc
-Werror=old-style-definition -DLTTNG_UST_COMPAT_API_VERSION=1
-fno-strict-aliasing -Wall -Wextra -Wmissing-prototypes
-Wmissing-declarations -Wnull-dereference -Wundef -Wshadow
-Wjump-misses-init -Wsuggest-attribute=format -Wnested-externs
-Wwrite-strings -Wformat=2 -Wstrict-aliasing -Wmissing-noreturn
-Winit-self -Wduplicated-cond -Wduplicated-branches -Wlogical-op
-Wno-sign-compare -Wno-missing-field-initializers
-Wno-null-dereference -Wold-style-definition -Wstrict-prototypes
-pthread -D_FILE_OFFSET_BITS=64 -Os -D_FORTIFY_SOURCE=1 -o
ust-fields-compatapi1 ust_fields_compatapi1-ust-fields.o
ust_fields_compatapi1-tp.o
../../../../src/lib/lttng-ust/.libs/liblttng-ust.so -ldl -pthread
-Wl,-rpath -Wl,/tmp/ZBuild/build/lttng-libust-2.13.0-rc2/src/lib/lttng-ust/.libs

x86_64-linux-gnu/bin/ld: warning: liblttng-ust-common.so.1, needed by
../../../src/lib/lttng-ust/.libs/liblttng-ust.so, not found (try using
-rpath or -rpath-link)
x86_64-linux-gnu/bin/ld: warning: liblttng-ust-tracepoint.so.1, needed
by ../../../src/lib/lttng-ust/.libs/liblttng-ust.so, not found (try
using -rpath or -rpath-link)
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
