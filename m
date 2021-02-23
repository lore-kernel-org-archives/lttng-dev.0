Return-Path: <SRS0=Zciu=HZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5771AC433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Feb 2021 16:37:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E6964D99
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Feb 2021 16:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E6964D99
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DlPqP6Ynwz6lQ;
	Tue, 23 Feb 2021 11:37:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614098274;
	bh=lty8UFofdX95j8lEx2bV+hsv4N9pTX5OzBJ5OD547Ts=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=0wxqiWfcgtLO8q5yYYP90FTc0OFjB0QY63SxeHMii8w0p5wyHIug+l5l1ViX6AnyV
	 mHflIHDhRIsTCWvYnDD03+nJAF9mCMtyVtICvngBXlCT+9QnPB3NolNguzVv88YbUk
	 hC3FErw/VEuApF2e3cJis59JeedyDKRGoGS1ZuN5hDRigwz3AJTIEMn0M+U/bXPtHz
	 HWCRfn/gA0g+zYoTPws6kR2KZWUJXPrgiHXrmV9VXj63PLxf49Qu5SYLYckeffHN8q
	 8NnkV00XF+BPUIRedYflFrF8MY8dgzBbz0uR7c52zxaxuSo5nbP8mSPaTX4ZJJM5Ar
	 BRnFXuTPGk0ug==
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by lists.lttng.org (Postfix) with ESMTPS id 4DlPqN4VPJz6lN
 for <lttng-dev@lists.lttng.org>; Tue, 23 Feb 2021 11:37:51 -0500 (EST)
Received: by mail-qk1-f179.google.com with SMTP id x14so16787386qkm.2
 for <lttng-dev@lists.lttng.org>; Tue, 23 Feb 2021 08:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=UX/X/vH/Rv/KiVqanLd+P6xK64cOj5zDqL0/qwd1fvg=;
 b=o3kzfOJzJZGGXfBPLLT4V3MWF4UekOjEWYMXsiBZnRN0hCZaF0I6W/R7P02CKybAs7
 IIgbiO6/TcrqEnkT7jJY3olnnDkGHDMmnAi50kLGzi4thaPm2TEuvZRF8mYCIgEsh3VU
 nq+7sxIan2XvKaO/eZFKaIsRqRmlNBRBE8F3gfNpECjTsrMxz5pI6tPXZsnkBQhHqlL3
 CFlg7V6enMou1/j8F5NtVp71os8UwBxhR4SqYlxPPP49qF7lh6q9Hrp8mIIqrcHjsQNR
 FWS6vFulXWsXjYC1mJEo3yE3KRyr28/01m3VkVAEnEXHNHNHBbgTkfUjG/fgGfpGmsD6
 qwNQ==
X-Gm-Message-State: AOAM532p8cnm+eEBb+A1hQDsJIBYjf8Css8B1M2g68HTXpCbRDIiD3/A
 Ck0B3MtqjA2XyQZFU1FXPFW59a+bd75xhw==
X-Google-Smtp-Source: ABdhPJwg3liWOqNnENbHGUcZKllujr+qmCLfcFdaF7jTIG+Ul02TDaAYQKklFAGhfhvomtpMTZZ0kA==
X-Received: by 2002:a37:7245:: with SMTP id n66mr27585113qkc.374.1614098270535; 
 Tue, 23 Feb 2021 08:37:50 -0800 (PST)
Received: from gmail.com ([107.159.88.171])
 by smtp.gmail.com with ESMTPSA id d1sm12878649qtq.94.2021.02.23.08.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 08:37:50 -0800 (PST)
Date: Tue, 23 Feb 2021 11:37:48 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <YDUvXIaalnJkYYId@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng 2.12.3 - (Ta) Meilleure
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

The third bug-fix release of LTTng-tools 2.12 - (Ta) Meilleure has just been
released. This release addresses a number of issues listed below.

2021-02-22 lttng-tools 2.12.3 (National Margarita Day)
        * Fix: ust-consumer: metadata thread not woken-up after version change
        * Clean-up: ust-consumer: simplify metadata cache unlock on error path
        * Fix: sessiond: timer: unitiliazed sigevent fields
        * Fix: sessiond: ust-registry: dereference of NULL pointer on allocation failure
        * Fix: ust-consumer: metadata cache lock not taken when sampling max offset
        * Fix: use MT-safe strtok_r in multithreaded context
        * Fix: liblttng-ctl: unreported truncations when copying strings
        * Fix: configure: support Autoconf 2.70
        * Fix: sessiond: metadata not created on app unregistration during start
        * Cleanup: use `modprobe --remove` rather than `rmmod`
        * Tests: Fix: 99% fill ratio for high buffer usage is too high for larger events
        * Fix: common: poll: compat_poll_wait never finishes
        * Build fix: implicit declaration of function 'PERROR' on Solaris
        * Fix: PERROR spam when `tracing` group does not exist
        * Fix: memcpy used on potentially overlapping regions

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.3.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.3.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
