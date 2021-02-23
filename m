Return-Path: <SRS0=Zciu=HZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C25C433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Feb 2021 16:41:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CED64E61
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Feb 2021 16:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CED64E61
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DlPvb4yxVz4db;
	Tue, 23 Feb 2021 11:41:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614098492;
	bh=1GuQsG9Z4sMcyYUTEXFsggZmpkbtqO83cs6gYZy216M=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=wrt31MoKRSMrTF6s80+egL+0mYCblGXaql/lL7W0PlEQ8ne6l3Sy/lQmgRKWdZAZc
	 GdHTjaX7h42duQj0AXX9SNavF61kKVr1wM4G3qx3htdICjThMtbvGVagNftcaVYXtr
	 k1YHRBxjok+2W1HJJjbj58EooWIRjEwCU1lp7IOXYgl5do7GYc6cn5s8enM8Oivtk2
	 JYWHfDYuF9ZH9/Qus5Qxq0JE2xVvmwJ4Jqdq7wgmS0CBFF4VrA2uziyL8wHmz/smg8
	 DFYVC6HLisbOsxdXm79KmWQ428me90ergmqwbZYvQla3UJvFmou6bXTpznWqwi/fx+
	 gzMYWeQ4+tsYw==
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by lists.lttng.org (Postfix) with ESMTPS id 4DlPvY5vFyz4dY
 for <lttng-dev@lists.lttng.org>; Tue, 23 Feb 2021 11:41:29 -0500 (EST)
Received: by mail-qk1-f180.google.com with SMTP id q85so16734138qke.8
 for <lttng-dev@lists.lttng.org>; Tue, 23 Feb 2021 08:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=9VG1zpBMCSz829bCPbFEmOxsMCmT/agd2UxnO9sydxc=;
 b=TF+udOWNo6+H3iQBx2iW0hIN76qZvO11cFbHhlEZ2tObdiuIcI2VueAbk2UzzYsNAm
 h3NhkTeoygiopf0QnLZqN5HKUlGbywWuYI+SHCqA3roambccsifqjMMwFMqm6x1OZ/a6
 UCrcTh4uzoWPhfyVrOkSHdCkd2Z+XTPdiYHO6+DRZGKMsLmUf3ZCeETwSjyxqsH/uVZ5
 Cq5WxbgzQb2qvykdawkekNu7drsFIYVCDbTGCpK1rCW1zkd5wl55zs0Mg6Uo7cKX/DCi
 jH0kBjt/EYDR2lH9rLlvl5bZLkCPm9Zd3CaoUEWhUbEL5Sqayyzqh2M7M64pjK2TcBNO
 Qppg==
X-Gm-Message-State: AOAM531J+UXj6y3Nn3XgZqhNSvCWkUrnGSc63B3PSZPFmF493zhTYB19
 al9hXphSSFKO9RpW7GvLiSTyIZ9nrPKtFQ==
X-Google-Smtp-Source: ABdhPJzYSrumcrE8JBf/rQqJe6XZguTgvMr92feeykYwXt+enKmbDMBP+zS8EICp/nSFg2AZ2St3TQ==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr27268562qke.378.1614098488828; 
 Tue, 23 Feb 2021 08:41:28 -0800 (PST)
Received: from gmail.com ([107.159.88.171])
 by smtp.gmail.com with ESMTPSA id p25sm14840926qkh.79.2021.02.23.08.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 08:41:28 -0800 (PST)
Date: Tue, 23 Feb 2021 11:41:26 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <YDUwNj4q7yrcdpF6@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.11.6 - Lafontaine
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

The sixth bug-fix release of LTTng-tools 2.11 - Lafontaine has just
been released. This release addresses a number of issues listed below.

2021-02-22 lttng-tools 2.11.6 (National Margarita Day)
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
https://lttng.org/files/lttng-tools/lttng-tools-2.11.6.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.6.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
