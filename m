Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92539C28D13
	for <lttng-dev@archiver.kernel.org>; Mon, 22 Aug 2022 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1661201046;
	bh=dLoj3L3gPVtCLQ2E8Wdw5LiTN+Undn/Q7nFQnFJJgyU=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=SH9oBHEPIoDFNo144c0G6TGAu2uRDpR6W/bowjLxRvC4s2gQGNTquu0WEKgP9Ngy2
	 rBahubtfukTWb0+A3MET2TkNDbJ1DvJ7JeYCer/GMqKG2PVOpwyP5tv1hN82Nz2tMq
	 7xABZpjFXUTxrlezePUlI86+in1uNOhspTbMLL7rSKvyHB8HsXuOTN0glShE4fkQ/y
	 vIs2O9cZaEyVIISt0crVmibJ7Ut0A9Z39GYvyip1nGCXQV0t6G4ESnHMmyL4ZkUOQK
	 yrgUCcnySAsGU0yjtPQxforMWBmRUUUHzPzQ+uDK2AwCD9IeDzqnbaUr3Dw+6Lugae
	 KT36wE1zosEYw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MBPTw6MT1z1LYf;
	Mon, 22 Aug 2022 16:44:02 -0400 (EDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by lists.lttng.org (Postfix) with ESMTPS id 4MBPTr703Hz1M1T
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2022 16:43:55 -0400 (EDT)
Received: by mail-qk1-f169.google.com with SMTP id m5so8858968qkk.1
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2022 13:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=/E1MCv6jIqywlx2T+QjL9+2bBheMW77ZNvh3S9siNKs=;
 b=E9Ku6Ah+z7Y3rsy6/ijqUqJ7YB7i2T/RQ7/JDCehAo5V5RlAo27l96iCX1PWG1wo6L
 Bcw9mf6WsvGcOlcQq/oBObGbwKn/r/jAe4QR4e/4UhYc6i9Lojp06+6K3+myk6EB5lc6
 7J7O+8lpcSQN8fvvbpbHMB4lSckk6a1FRVfHnSmyE9UUK/LsnyZSMrVDsQBtlE9KvrjX
 O6jod8ucTq0Dxvl6Ejma3AKR8NDGNJXsFolSqKj69tZaw4sroSc9XBXogmrXJxT/7GV8
 qAmVcHOVO8++FFfOnxojyAtn9z8hCgQWt8GzD8T7jv3cwapSMjXHVt5l0N+OLEivmSbT
 xaFw==
X-Gm-Message-State: ACgBeo3v3p6UsF5gLDYDUSLzCsVDxfhwbZgKTZo9ZwJ9wsA/yeUm8ycv
 WFGPP548mvczHbApPEBvtGH/1RAMdEQ=
X-Google-Smtp-Source: AA6agR5+DFS1u1r2z0Rvahm5u+84GpI9Eg0j8+79rllj8Vgze5UDX4pQw+7BWIVmLWV2+4WVb2TmSQ==
X-Received: by 2002:a37:895:0:b0:6ba:fa6f:e50b with SMTP id
 143-20020a370895000000b006bafa6fe50bmr13893239qki.419.1661201034876; 
 Mon, 22 Aug 2022 13:43:54 -0700 (PDT)
Received: from gmail.com (192-222-180-24.qc.cable.ebox.net. [192.222.180.24])
 by smtp.gmail.com with ESMTPSA id
 k8-20020ac80748000000b0031ee918e9f9sm9028741qth.39.2022.08.22.13.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Aug 2022 13:43:54 -0700 (PDT)
Date: Mon, 22 Aug 2022 16:43:52 -0400
To: lttng-dev@lists.lttng.org
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>,
 diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Message-ID: <YwPqiLG+9vhg0Hdg@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E8_?=
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

We have just released the eighth bug-fix release of LTTng-tools 2.13 -
Nordicit=E9. This release addresses a number of issues listed below.

2022-08-22 lttng-tools 2.13.8 (National Bao Day)
    * Fix: waiter: futex wait: handle spurious futex wakeups
    * Fix: futex wait: handle spurious futex wakeups
    * Fix: utils: unhandled close return value
    * Fix: agent port file is o+w when launching as root
    * Fix: tests: don't assume sequential cpuids
    * Fix: sessiond: handle empty scheduled rotations
    * Fix: sessiond: report client list allocation failure as a fatal error
    * Fix: ust-consumerd: set `hangup_flush_done` in a locked context
    * Fix: sessiond: size-based rotations never trigger
    * Fix: lttng-snapshot: use after free of max size argument
    * Fix: lttng: snapshot: add-output: leak of max size parameter
    * Tests: fix: lttng-create: leaked command parameter
    * Fix: sessiond: rotation trigger leak
    * Tests: fix: schedule api: leak of rotation schedule list
    * Fix: lttng: enable-rotation: leak of command parameter
    * Fix: lttng: track: leaked command parameter
    * Fix: lttng: add-trigger: leak of parser context on capture
    * Tests: fix: leak of trigger in trigger listing tests
    * Fix: action error query: leak of action path
    * Fix: lttng: enable-channel: leak of popt arguments
    * Tests: clean-up: rate policy: remove stale comment
    * Tests: fix: leak of rate policy in rate policy unit tests
    * Tests: fix: leak of payload in serdes test of log level rule
    * Tests: fix: leak of some attributes of ltt_ust_session
    * Fix: liblttng-ctl: leak of payload on field listing
    * Fix: liblttng-ctl: non-packed structure used for tracker serialization
    * Fix: test: lttng kernel modules still loaded after running test_clock=
_override

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.8.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.8.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
