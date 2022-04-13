Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF20C433EF
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Apr 2022 20:42:08 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Kdvf71TZ1z526;
	Wed, 13 Apr 2022 16:42:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649882528;
	bh=DZRHn9SAJ1DK2z7i6I3pxo4V33f7coiN+wVtBwLtlug=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=bYD5ky50F5WqlokmY5ch8mqzo0McSnkKjI31HcV1+xpqAiG2DujJ8t2uTf35DW9F/
	 WOohN4M8GtX8hAurvlewkzWo61uZDlpzVF/dNRwZ0pDOk1H8iKoX69UjVgjUjll77q
	 cj18ouvH08i9iSLXeNY4SDwsHazKCUKDpSAq65mVW9PpICBuO6+bJoh25SPYslz9UB
	 eM0ETpk5CttVee+8uUg0udwSYOQIfpPZEIcQZH0pDRrerQ5+DoLVLeZRrSR25V7Go0
	 lPNL5PAtd2UatLQdW6TX6bJV8N066ROxpPSwOGVcJ9qau1cdhr/H6Y0/9cQtYaHNKV
	 bB3wM47iQCPBQ==
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by lists.lttng.org (Postfix) with ESMTPS id 4Kdvf549Xkz50T
 for <lttng-dev@lists.lttng.org>; Wed, 13 Apr 2022 16:42:05 -0400 (EDT)
Received: by mail-qt1-f169.google.com with SMTP id bb38so2264946qtb.3
 for <lttng-dev@lists.lttng.org>; Wed, 13 Apr 2022 13:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=BJxa92HvKHPb8ETwFORtqSnwEirugxeKIDKbbsKFKvk=;
 b=VNgK2UfYN2oSY8UBdJftex/qXFCxvjWKWX/+MCa14dPnew789eHd1xWKmdyY+FXwGi
 Rqt8HdppUygNCs5zomiykUQHHpzKk5OMZOyUYoiIfvcoZ581xMo/p6oZ2gRGY8YuTotH
 zPV3WiVks5x8LZ2T2yYSdBb3Vfzdec9XBTcleWHbhoESmwN45z7qLEReRlresI0QmqpC
 oEYltEnnaSewx4OMD+yyTlJBEJMM07qBgje8KJUiQFqCmQvmTByzJjIQvPo6/R/V4K2n
 9LCTeYpiZdN86AbV9Z7A4n96RXzkgb6WUn2BVOg5cXTBc4XMAj9ixwLYGNeH8b++5vVo
 wtrA==
X-Gm-Message-State: AOAM532PF1XqHZPt61bgK2AgzJ+Ltptc2nwMEKAbSkx6TER0ovs4zPFY
 MYiR7L2ILZweGsg4t/4WZl00O1wHekHZDg==
X-Google-Smtp-Source: ABdhPJxV+vndoKvSeAvxg7YMtMA8E4zjVbjUC76uURsAqlB6VN6ZvE0hwW8SGzjjo2KQegoGEYAXvw==
X-Received: by 2002:ac8:5b86:0:b0:2e2:72c:9e06 with SMTP id
 a6-20020ac85b86000000b002e2072c9e06mr8565168qta.113.1649882523942; 
 Wed, 13 Apr 2022 13:42:03 -0700 (PDT)
Received: from gmail.com (192-222-180-24.qc.cable.ebox.net. [192.222.180.24])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a05620a12b400b0069bf14f11d9sm9143126qki.134.2022.04.13.13.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 13:42:03 -0700 (PDT)
Date: Wed, 13 Apr 2022 16:42:01 -0400
To: lttng-dev@lists.lttng.org
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>,
 diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Message-ID: <Ylc1mZ6XoPvmFdwo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E7_?=
 =?iso-8859-1?q?-_Nordicit=E9?=
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the seventh bug-fix release of LTTng-tools 2.13 -
Nordicit=E9. This release addresses a number of issues listed below.

2022-04-13 lttng-tools 2.13.7 (International Day of Pink)
	* Fix: sessiond: assert on empty payload when handling client out event
	* Fix: Revert of 814b4934e2604a419bcb8eec57c0450dbb47e2c3
	* Fix: sessiond: inverted condition checking for empty hash table
	* Fix: notification: kernel: consumption of event notification stalls
	* Fix: notification: assert on len > 0 for dropped notification message
	* Fix: example: print_notification is called on status all returned status
	* Fix: sessiond: assertion hit in ltt_sessions_ht_empty
	* Fix: tests: missing _GNU_SOURCE for F_GETPIPE_SZ
	* Fix: compat: 'LTTNG_UST_ABI_PROCNAME_LEN' is undeclared
	* Fix: sessiond: cmd_enable_channel: negative error code used

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.7.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.7.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
