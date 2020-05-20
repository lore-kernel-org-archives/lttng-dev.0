Return-Path: <SRS0=9s3x=7C=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD423C433E1
	for <lttng-dev@archiver.kernel.org>; Wed, 20 May 2020 02:29:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AA62075F
	for <lttng-dev@archiver.kernel.org>; Wed, 20 May 2020 02:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="APtEVqtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AA62075F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49RcC12wQLz27Hv;
	Tue, 19 May 2020 22:29:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589941757;
	bh=nQIN/+XsqWJhijUxGKmKggh7bVSICgmDbsoTPBmcyHI=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=APtEVqtgNSG9RZgwN3vRref+4aKeeliq+j1r+ig+mYlVWyUDC8PLhzz3T1FEsIVvR
	 i+N8BjB6Q+2NzVj7EXuTFYlWAJ3CkcJDk0e0oZRCaqDn/l0+y3bnMBv7vH7Xms/vag
	 wn6uewoTXjVsLCFf1nxXOnEq188ODVYPS494V1hKqO49W/H4aDqaOhm+bc1geHlsQA
	 3WYvoFjglYOm8ZFPyJQkfxziksMFYKZ9PFwOEO8b3peXj0PZ1mtlRugn+FWgjZ5Reh
	 QwkDwjhtazQg0eYhAMJ2e6BCFmEPqOu/jkXm8FDPvNfWG3iPjRMYAC2J1ns+o5QvL0
	 rGrUKNe2UCJ3g==
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by lists.lttng.org (Postfix) with ESMTPS id 49RcBz0Q6qz26wQ
 for <lttng-dev@lists.lttng.org>; Tue, 19 May 2020 22:29:14 -0400 (EDT)
Received: by mail-qt1-f173.google.com with SMTP id c24so1436032qtw.7
 for <lttng-dev@lists.lttng.org>; Tue, 19 May 2020 19:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=rPUKGfmXkYsGP4DREqFUpS/kXUrJ3TLAO3e53uG8L+E=;
 b=Jr8wxsXyDoUW764Kh6SSVHEe5L3gsZQonq1br8z3MQ1w6oGXYJcVuS0U5Zntiz9Gzj
 CTvOaxvrOc3hhVswXp/9/eDmNrabNvJgTBvJiB8zoQGXyONI2X8GlnHvv05TWa1UsEXo
 TMiMViGBFpFxLUAE70FIRnvPKlhmK8M/VO+03jxALcvAAb7Pxxyf9vQtAnpg214qmu7U
 isWT46U3Pcq83DXhGH0A2vd6qy+3DNaB0+V77IVFrgGMOZtro1+G3k0sJZ9lxmCj5Ufe
 /KCZmUwocKmPdY1OUtEy63g51aQgUx8JdPftJXxtVyhL1C3YfJ4C4aWWJSw4fPXMjHuP
 uERQ==
X-Gm-Message-State: AOAM5324UQ4GTYbdjzrPCRGo0qPhUiueU1MiOObUAK8fu5DZC2234eb/
 ZqDrx301lPkltRXWDTssceZ2dUcz
X-Google-Smtp-Source: ABdhPJwGVFuGCjqo3bXXAzPFkGODF/nBIKCgRl0Lmx1oahPxlZPDhLYJE8yxS8cqOqxiqVejgMX+bA==
X-Received: by 2002:ac8:1604:: with SMTP id p4mr3054745qtj.260.1589941753501; 
 Tue, 19 May 2020 19:29:13 -0700 (PDT)
Received: from gmail.com (192-222-251-19.qc.cable.ebox.net. [192.222.251.19])
 by smtp.gmail.com with ESMTPSA id
 c25sm1109041qkm.119.2020.05.19.19.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 19:29:12 -0700 (PDT)
Date: Tue, 19 May 2020 22:29:10 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <20200520022910.GA117998@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.11.4 - Lafontaine
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200520022910.jQ820Y_ZP-sraZFTSBnuYejgcWqCvURe3rg9U3x6uIo@z>

Hi all,

The fourth bug-fix release of LTTng-tools 2.11 - Lafontaine has just
been released. This release addresses a number of issues listed below.

2020-05-19 lttng-tools 2.11.4 (Dinosaur Day)
	* Fix: common: abort on rotation after time manipulation
	* Fix: tests: `-Wstringop-overflow` warning
	* Fix: load: incomplete error handling for load_session_from_file

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.4.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.4.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
