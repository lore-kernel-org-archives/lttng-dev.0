Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D346E92734
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Oct 2023 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696535453;
	bh=Dkcf3NhzSdw1rVpS1Qn0mOtQoIXbAxCGn6uQ1AeMwzw=;
	h=In-Reply-To:References:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=IHYbxZS0E98SDVX83to3HpSk80MIKlNOOIUNmnf+loosiJR5e+sh5yTGPA7PPqFHC
	 yAJdeOjggu9KfCZC2zUtS7SbE7sVZ6pcpdNfzQT8qHqV6ONykD9LJrab0WnTU/P0Sf
	 s+IDchfuWFv824q7xUu+XlNFk6ARD0FgD6jZuabyX7py/PAUaHlLvRZh2SnWEyOpTR
	 JWQAStPN2E4NdyFtpvmhKhQzv6qVhv40D9qXl4j0cICQ/Db6yXvIMHwg8gTMVKmWUM
	 U5KIo+M59ur7gxOcoBTZ4YvqVQF69vbCDMpBqnB7Z9vtfYbCw6u0gt+SVooFAyR+W3
	 OGut3qupjNGVA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S1hxm4hZDz2syv;
	Thu,  5 Oct 2023 15:50:52 -0400 (EDT)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by lists.lttng.org (Postfix) with ESMTPS id 4S1hxk3ZkZz2t9C
 for <lttng-dev@lists.lttng.org>; Thu,  5 Oct 2023 15:50:50 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 23B7F32009F0;
 Thu,  5 Oct 2023 15:40:50 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
 by compute2.internal (MEProxy); Thu, 05 Oct 2023 15:40:50 -0400
X-ME-Sender: <xms:QBEfZaKjIUYIoIVkD44MOWBDxaWHhPIiZD2ePmU_YeRgQWBm2COh_w>
 <xme:QBEfZSJUpLLt24TlqehbUJq7-FIa0rRst3Ud0lIz5kIW131_hrpjAFlw_XRgvIlzd
 KEgWTNa7ehgSB7-ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggddufeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
 ihhsthhophhhvghrucfjrghrvhgvhidfuceotghhrhhishestgifhhgrrhhvvgihrdgtrg
 eqnecuggftrfgrthhtvghrnhepfeelueefvdefteekveekvdfhffdvvdetfedugedvleeu
 hfeigeelfeffveetkeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomheptghhrhhishestgifhhgrrhhvvgihrdgtrg
X-ME-Proxy: <xmx:QBEfZau2RrbZBTAwfXfEMQYOiufrkZ8zRVgLT1jxw6fPJYuA2B364g>
 <xmx:QBEfZfbUwBizY9oUwnlPX837qJaEQcO8c__taDRH0gaVZm97s8PC_Q>
 <xmx:QBEfZRZ1e6x65t5ok3RSzBbCuUBiJuajS-I07CTRY9dfT3V11IkKow>
 <xmx:QREfZT0pHs4GNLlQDPOLgNaR4k079SJBzNFO4EgKteEakY9oaIvptg>
Feedback-ID: i2d19425f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 8B0B2BC007C; Thu,  5 Oct 2023 15:40:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <7619596b-4c04-47d3-91ad-da49786fcfac@app.fastmail.com>
In-Reply-To: <db8dd95b-55ca-4259-bcc6-db145e0ad05d@app.fastmail.com>
References: <0c1fcf2c-c061-4074-a20e-44b870fbeef5@app.fastmail.com>
 <2795ad9b-acbd-460a-bfcb-61f0101180d4@efficios.com>
 <db8dd95b-55ca-4259-bcc6-db145e0ad05d@app.fastmail.com>
Date: Thu, 05 Oct 2023 15:40:27 -0400
To: "Kienan Stewart" <kstewart@efficios.com>, lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] What is DEFINE_LTTNG_UST_SIGBUS_STATE for and other
 beginner questions
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
From: Christopher Harvey via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Christopher Harvey <chris@cwharvey.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

I got this one figured out. I used strace -fp <pid> -trace=connect on the target app to see why the connect was failing and it turns out there was a mismatch between sessiond's apps-socket paths and libust's.

time to review my build environment I guess. It's very possible my docker container's path environment variables are non-standard.

If I had a tiny bit of feedback to provide it would be to print out the errno and paths in the connect/bind commands in the DBG commands. I had to bust out strace to get that info. Small problem, but it could have saved me a few hours and some mailing list messages.

Thank you for making this nice looking software available for free. Looking forward to playing with it some more.

-Chris
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
