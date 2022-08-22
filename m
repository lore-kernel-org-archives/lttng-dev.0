Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97944C28D13
	for <lttng-dev@archiver.kernel.org>; Mon, 22 Aug 2022 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1661201189;
	bh=9f8j23pCFaPnip99UXig4mtptpdhOOQROM2bmn0TZB0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HAk3OwIO+K18yHXx71bCQQmqk35S35vFx9UZWz8sLt0W4ExmyxTcxDGJHm77lq/Ns
	 wgxgBfMKwSu9kio9i5ic36TQCR7OxF6gt2HvXR1++Yrh/U5AAAf2y+cF23X8+UmON6
	 tj0k6+n6NgUEgUu0iXk/W+1FxEfSqpRJpn7Sh6W+q/g0eNt6cX5MYOfQ2PvNKss9B0
	 bGH0GYLWcFR9dgkNo5oUSZgfykmqu7VNIGOn/LxLyIoANbP3NPub+yNjiL5mZZoo8P
	 RfodBk6/ZpDJl+G2uodvEGdY/x6VdYKVSp7Vxt9UdLRAoppFqCUCH/9PpekF8ev7g7
	 p+AUtBO9uzAYA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MBPXj4S5Sz1Lbs;
	Mon, 22 Aug 2022 16:46:29 -0400 (EDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by lists.lttng.org (Postfix) with ESMTPS id 4MBPXh6pNkz1M1X
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2022 16:46:28 -0400 (EDT)
Received: by mail-qk1-f182.google.com with SMTP id g16so8847905qkl.11
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2022 13:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=YqRGoWKRja1SQkOgrrKfisoM2LDriMkSLJA55cdQ3N4=;
 b=SFxt+aSgYzmnZ3OTiwaBx+aGjLQ3Zk1rLYkrsPGAjlAv7GQJwr9YmLvoH3v4fMnqvg
 cDcz4no5HvVL09zmrXQ7D3s++3LWqXXdUafIQp7jPDCOc2dcGib2/0eY+O5asWunMacl
 a8YfzUvS1fcH+rgZD+Jel+2cK0/e8xGXRjxqKujsJcz4TuMdnUS3nRKLdS3yMGTWQlNj
 1w8xxtmQCEZ7DL6yCWXJG/MKAsOiz6KGdAHyT13oB8A+igcPu52Ioe8pP++ryWfD0OcV
 xJ/ZjiTL46GjwnZJY8QTQJpvmQCZmi77co4+8ssvbFeCbKhy9dYg6BfeYDNYOUtmUsRM
 jp9w==
X-Gm-Message-State: ACgBeo1rA4dQMeybY7/GkYI/yqiwNB94mHamb+A76kSzUh5q1NcY0+1/
 VwXbRCSUw6WStrGgoSY88U/qtBIGGsY=
X-Google-Smtp-Source: AA6agR4JpkSSTKKiP/Aw0mgHulZSwVAVuWTjxQ4tErmZ86QEu+BmPg2u1RBFZYoT/DEhqY7n13DSlg==
X-Received: by 2002:a05:620a:56d:b0:6bb:af44:3d6b with SMTP id
 p13-20020a05620a056d00b006bbaf443d6bmr13931531qkp.517.1661201187932; 
 Mon, 22 Aug 2022 13:46:27 -0700 (PDT)
Received: from gmail.com (192-222-180-24.qc.cable.ebox.net. [192.222.180.24])
 by smtp.gmail.com with ESMTPSA id
 bi32-20020a05620a31a000b006bc192d277csm3614843qkb.10.2022.08.22.13.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Aug 2022 13:46:27 -0700 (PDT)
Date: Mon, 22 Aug 2022 16:46:26 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <YwPrIh/pVjwcqrqU@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.12 - (Ta) Meilleure
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the twelfth bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2022-08-22 lttng-tools 2.12.12 (National Bao Day)
    * Fix: waiter: futex wait: handle spurious futex wakeups
    * Fix: futex wait: handle spurious futex wakeups
    * Fix: utils: unhandled close return value
    * Fix: agent port file is o+w when launching as root
    * Fix: tests: don't assume sequential cpuids
    * Fix: ust-consumerd: set `hangup_flush_done` in a locked context
    * Revert "Fix: sessiond: rotation trigger leak"
    * Fix: lttng-snapshot: use after free of max size argument
    * Fix: lttng: snapshot: add-output: leak of max size parameter
    * Tests: fix: lttng-create: leaked command parameter
    * Fix: sessiond: rotation trigger leak
    * Tests: fix: schedule api: leak of rotation schedule list
    * Fix: lttng: enable-rotation: leak of command parameter
    * Fix: lttng: track: leaked command parameter
    * Fix: lttng: enable-channel: leak of popt arguments
    * Tests: fix: leak of some attributes of ltt_ust_session
    * Fix: liblttng-ctl: non-packed structure used for tracker serialization
    * Fix: test: lttng kernel modules still loaded after running test_clock_override

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.12.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.12.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
