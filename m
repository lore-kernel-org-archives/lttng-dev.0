Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3A1C0218F
	for <lttng-dev@archiver.kernel.org>; Sun,  2 Feb 2025 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1738512073;
	bh=ycHX/fEDGRepHSJvFGJ02HOS3W2WyJW6MJ3IcpgpPkQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=BNlN7vVNIbEhZsM7wEgw/rrIF/n9K2B4gxIJslYVeEMSIYC/EYz4B8/D/8UUuHZe1
	 G0Uif4jQsxau+zdjoUydH+faiI4QU2j/zqHIQSO4hgu9kWDPKtbcZ1YixF7Il1NFgS
	 Tr1jWqud5qR28LhZgeAnONczFB8Qfe4BlXPhRTVy1tA8MXmsOqT3TfDGuKG/Rrg9/6
	 py7S/U+QN+dMAwVSBAd0mFlfLnXgMx30LB5gOefsbjRxGP+AbcU3/1u8LFEEVyYNY4
	 dWaSdV27U13AuR11+xLHSAAL+DDIma4x95ZCiAEzJNLTUiPqFbOoNj3YlW5kHo7sqk
	 5+cUgVYoPlMXg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YmDrS5Kwkz1Py9;
	Sun,  2 Feb 2025 11:01:12 -0500 (EST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by lists.lttng.org (Postfix) with ESMTPS id 4YmDrR4NDZz1Py2
 for <lttng-dev@lists.lttng.org>; Sun,  2 Feb 2025 11:01:11 -0500 (EST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 0991D13800E0
 for <lttng-dev@lists.lttng.org>; Sun,  2 Feb 2025 10:48:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 02 Feb 2025 10:48:57 -0500
X-ME-Sender: <xms:6JOfZ2qncE2ETA9SSuy5E58Ezz1mEvsJAva7kwfKnIXMr_ETetBYDw>
 <xme:6JOfZ0qgDrmycZUnRB--ePZp4qWhU6-bl-77bhwtoEDYE9DGnLRoCET5G_aehtT6R
 6LThOyh7B59lodcuGk>
X-ME-Received: <xmr:6JOfZ7MT1dYIbnbx31AAjgwckOI1Tc2i70rF5KpmkPMp6YOLHLescvE3Y74VjtLWRhxEVdglF81kM7stmtE0palTqNVTNJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurheptgfghf
 ggfffukffvofesthhqmhdthhdtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoeho
 nhgurhgvjhesshhurhihrdhorhhgqeenucggtffrrghtthgvrhhnpeehffdvueevheffhf
 euudefkeevledvvefgleetfeejteffhfeihedvleeiledvjeenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorh
 hgpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehl
 thhtnhhgqdguvghvsehlihhsthhsrdhlthhtnhhgrdhorhhg
X-ME-Proxy: <xmx:6JOfZ16hU5ChTtX628yqy9P3ppxdm0pXgJXvpPoM1P-WogFZLCs9Yw>
 <xmx:6JOfZ17tgRlJZ1o1DjrhkBdZ9JJyaYE3t3Ra0DczttyniDMrrWwoTg>
 <xmx:6JOfZ1ghI28mdzs3ku7PAGyahYaqr3wZVv9MA9Tu5fafBOs-wWb4wQ>
 <xmx:6JOfZ_7Tp2FOA54QVfjTNABYPAYUlnAmMwGGCLrqgfj-H5o05_ZYKQ>
 <xmx:6ZOfZ3Q67lsGFd_EmX0fl1VSkcs5JhezgGtBjcLy7E6T6HWVVx_weJh3>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Sun, 2 Feb 2025 10:48:56 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Sun, 2 Feb 2025 16:48:44 +0100
Subject: librseq memory allocator portability
Message-Id: <165086BD-96DA-4A95-8411-F87DB502DB23@sury.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailer: iPhone Mail (22D63)
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
From: =?utf-8?q?Ond=C5=99ej_Sur=C3=BD_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@sury.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hey Mathieu,

I=E2=80=99m actually thinking about using librseq for some more lightweight s=
tuff first - like statistic counters (especially those related to memory all=
ocations), and my first obvious question would be - how portable is the libr=
seq memory allocator?

I am not keen on having a code with ifdef spaghetti to support BSDs, so I th=
ink that it probably should provide some per-thread memory pools at the expe=
nse of just consuming more memory on platforms without rseq system call.

Ondrej
--
Ond=C5=99ej Sur=C3=BD (He/Him)=

