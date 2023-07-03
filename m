Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F02C001B3
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Jul 2023 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688408953;
	bh=z2fIoAMMEpto/dtafEYodEOa3LmjzDun3C9I6AA66KQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=mQSmIKFuCTEvGgo1jqkVB4ppaSAvA4WYDy4Uvw1SS1vU5SQKNTTVG9Dm53qwSM2Gz
	 wrjgC23EysHxvaXAGZfsik8raMXQDU/wDyBBgmkdUzlwsJNi76kYnP0BMGaK8NLHv9
	 44IVUIvsGzbegRE2ri2aZk1frYYxHm/vxOy4UW2IdR1ukTY0B0H/wwfSftXNipVLrU
	 TXezFPPUC0m+oj9kkotO1ozzxL5zyWYP4/LtSSu+olsGMxJc3uZf2jX5cG99v8e30p
	 g9q36c5ek6IBj9/XHD1pU4qii/YRT8SqOD+Kb9IVNUknhOwk3W1ThTDKRYtwe20GIW
	 761GCBejD1ECQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QvvZw4N2zz23h3;
	Mon,  3 Jul 2023 14:29:12 -0400 (EDT)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by lists.lttng.org (Postfix) with ESMTPS id 4QvvZt3qRgz23FR
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jul 2023 14:29:10 -0400 (EDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 165923F36A
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jul 2023 18:29:01 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6a679df26so42945481fa.2
 for <lttng-dev@lists.lttng.org>; Mon, 03 Jul 2023 11:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688408940; x=1691000940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygSy9KqxG2fZwpJGF5Dt34qquTFQ7XyrHTX9aLMCBjs=;
 b=XNqryvrz9C9Ly7ZYASLWz+IGHaZu88lkpzzyIEaUloFc9JtwZfDnwCQ4QoouO2MYha
 DM+hgC7V9cN5XLsolOd5ytA/2r8FPGooqrYjHjSYWFChcIsR5kqgycJ5oExLXSKQOnfn
 w8AeOZi516BpIt16ywWkeUv40buZrUaY9jsZrmQ1jt2vlS/Ecra25CBa6VygJcRvEHqJ
 qLycgKezS672jiu4XW7Z6B2dAdVA2jLefnau61OdIhhllprxSLDgunZIx6h5s2KbB8hD
 VNIFHOtmttYrdkGJ+jYEXY4mWssOgXiFe/XstIDo7nDbnnM1ktUIzcqmARjwB7kIMAoh
 bJXg==
X-Gm-Message-State: ABy/qLa/OEC/goXY2/WtYXRaqAEmV8D//dhuN4JHB6450HknugA7PIXF
 yEaDx+tAkZH657/0+NVTIf+0yCbZR7gP4MNuK8HsuW9Nm2NoRY4IkUVisS2Vzpx5IJ7jkHfasX1
 X/7k7RMH54VNg7gIPnIS0AuFv+Mg0HdyaAQvcdAyiTVBCim3inds=
X-Received: by 2002:a2e:a172:0:b0:2b4:6f70:c390 with SMTP id
 u18-20020a2ea172000000b002b46f70c390mr6676111ljl.15.1688408940511; 
 Mon, 03 Jul 2023 11:29:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEocTaWkILv78gAoGw/SSaXbzsFDW3DeTfRaQGxYywvYa6A07kyGRBCgVBkUu3RaDXuTUH/Ng==
X-Received: by 2002:a2e:a172:0:b0:2b4:6f70:c390 with SMTP id
 u18-20020a2ea172000000b002b46f70c390mr6676103ljl.15.1688408940137; 
 Mon, 03 Jul 2023 11:29:00 -0700 (PDT)
Received: from ThinkPad.lan (77-169-125-32.fixed.kpn.net. [77.169.125.32])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b009875a6d28b0sm2460462eji.51.2023.07.03.11.28.59
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 11:28:59 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Mon,  3 Jul 2023 20:28:58 +0200
Message-Id: <20230703182859.49731-1-roxana.nicolescu@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-modules 0/1] Introduce configure script to
 describe changes in linux kernel interface
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
From: Roxana Nicolescu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Roxana Nicolescu <roxana.nicolescu@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This script described the changes in the linux kernel interface that
affect compatibility with lttng-modules.

It is introduced for a specific usecase where commit
d87a7b4c77a9: "jbd2: use the correct print format"
broke the interface between the kernel and lttng-module. 3 variables
changed their type to tid_t (transaction, head and tid) in multiple
function declarations. The lttng module was updated properly to ensure
backwards compatibility by using the version of the kernel.
But this change took into account only long term supported versions.
As an example, ubuntu 5.19 kernels picked the linux kernel change from
5.15 without actually changing the linux kernel upstream version. This
means the current tooling does not allow to fix the module for newer
ubuntu 5.19 kernels.

This script is supposed to solve the problem mentioned above, but to
also make this change easier to integrate.
We check the linux kernel header (include/trace/events/jbd2.h) if the
types of tid, transaction and head variable have changed to tid_t and
define these 3 variables in 'include/generated/config.h':
TID_IS_TID_T 1
TRANSACTION_IS_TID_T 1
HEAD_IS_TID_T 1

In 'include/instrumentation/events/jbd2.h' we then check these to define
the proper type of transaction, head and tid variables that will be
later used in the function declarations that need them.

This change is meant to remove the dependency on linux kernel version
and the outcome is a bit cleaner that before.
As with the previous implementation, this may need changes in the future
if the kernel interface changes again.

Note:
This is a proposal for a simpler way of integrating linux kernel changes
in lttng-modules. The implementation is very simple due to the fact that
tid_t was introduced everywhere in one commit in
include/trace/events/jbd2.h. 
I would like to get your opinion on this approach. If needed, it can be
improved.

Roxana Nicolescu (1):
  Introduce configure script to describe changes in linux kernel
    interface

 README.md                             |   3 +-
 configure                             |  36 +++++++++
 include/instrumentation/events/jbd2.h | 110 ++++++--------------------
 3 files changed, 61 insertions(+), 88 deletions(-)
 create mode 100755 configure

-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
