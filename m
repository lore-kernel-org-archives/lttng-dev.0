Return-Path: <SRS0=jDl3=DC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE6C4727E
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Sep 2020 19:17:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C17221EC
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Sep 2020 19:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="JSRgOTsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C17221EC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ByhWM13V7zLJX;
	Fri, 25 Sep 2020 15:17:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1601061455;
	bh=3FJzSnkwHEVILHf1RFQezSCh+PeaF/OBAwCrL3HFC+A=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=JSRgOTsVbhYJM91ks11Qb43ZT8ATqOjUvbivzAamZv06Z+9duZ/LgLgH7WETYufK9
	 V7vaJ1wKzT7QQNep3Q4xPW76ToxJhx73qJRwH+NsCitNNpqlyjYqMTd/l9otlLTlhN
	 wcZI3pgjPNIMiJpVlf1SLrW3M0ZXLPz4ttiznZB39hwfOvBrVOVwy2XvH6HsWthMHX
	 Qk8n3ans+nn0Mwf4x5GO1nDxKjJkdC/BnCx2DlduSF72bCNaBug87Jjtj5n4EG0SRf
	 ePFbPP7PY5jIMLuKh6Mvx0yY/ot/tK+2QoBUxvNqCFTyU0HJ8sdfb8Fe2lbfGMPK+z
	 y7GHy+oDdUYOw==
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by lists.lttng.org (Postfix) with ESMTPS id 4ByhWH5jdGzKwm
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2020 15:17:31 -0400 (EDT)
Received: by mail-yb1-xb29.google.com with SMTP id 133so2726563ybg.11
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2020 12:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=AMszHZ++jBlictckd8yLVyVD/OXzWoEaB0C24EJqXE8=;
 b=gFLxlORAXNJ7GiZpXGQy/D5RXfQdmIU0/d6nX2VDmsRqej7ofNstRFMcv11cVGdUE7
 Fm+NDE+wO2QgHArvx4387JenuHIFZdHFKq9633PRMp49DuQOHz9LG9ewmUfV3t/Xml0G
 p9QOqopoAunU/cGxLCpbScrB3rO6QYCzy0X85+W7vfqKB/1cyalofXl3vSQ7U/v9XhkK
 FTU6u2nwHJ+HJ2762qBL+GEiSwQpXVEWvjfCrqY7refPU5ZhBGz9u97tcEX562Aorx/P
 YUUNoaoBZVVCS8O68bJL3MxPUZsXgsfYdtdTX6JcRbHRwtwAoSYPxOkbB4iPSfG0kQl/
 BjHQ==
X-Gm-Message-State: AOAM5326N9TN84RfNGiKGenhgmY1jrR+prv2+4HTHM3t4S4vwhSeB4le
 WAOypCUf48Ey0gdRkay/LTeIj5Uf46uXzcM/wkrCLmXUViA=
X-Google-Smtp-Source: ABdhPJyB6eQMYFOSdUyK8HnFIhbaC/Z16ZVdTdBnQL3H/odHWLTBJrLWmIPZzSfDrh4FfONaDrBZF1MVH1S1lZtrDe4=
X-Received: by 2002:a25:244a:: with SMTP id k71mr1052359ybk.504.1601061450720; 
 Fri, 25 Sep 2020 12:17:30 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 25 Sep 2020 15:17:04 -0400
Message-ID: <CAB4xu_1t7p4LVyimbWropLcvC=k6nEVDFFpM65btCVHgr+Chtw@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Subject: [lttng-dev] [RELEASE] barectf 3.0.0
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi everybody.

Today EfficiOS announces the release of barectf 3.0.0.

barectf 3 is a major upgrade of the project which brings important
additions and changes such as:

* Support for static and dynamic array field types.
* A reworked Python API.
* A new YAML configuration schema.
* An upgraded `barectf` CLI tool with a Git-like interface.
* Improved generated ANSI C code.

Rest assured that the `barectf` CLI tool is backward compatible with its
barectf 2 counterpart, and that barectf 3 can still process a barectf 2
YAML configuration.

Learn more about the barectf 3 changes on its new documentation
website [1].

This documentation project also shows how to install barectf 3
using pip [2].

We wish you a good day.

Philippe Proulx
EfficiOS Inc.
https://www.efficios.com/

[1]: https://barectf.org/docs/barectf/3.0/whats-new.html
[2]: https://barectf.org/docs/barectf/3.0/install.html
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
