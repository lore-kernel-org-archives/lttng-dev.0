Return-Path: <SRS0=IW+h=DN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C8C4363D
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Oct 2020 13:16:46 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D3620782
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Oct 2020 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="lom4wC7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D3620782
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4C5Hzt46f2zS3l;
	Tue,  6 Oct 2020 09:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1601990203;
	bh=jorX75niftO2yDrmjdehAcG1TCvD38J33kBtIly5anM=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=lom4wC7KSED3G72liMSRBiDl+uzCMgBeu7stT+yawZX1LlBGCER27uLvVaVVQLM0c
	 95SfVzPhtaCGYRV44Sw4P1OOmeTpRa7OouesPfKjBD1Z/9owmi2umdWT+Nbf5N48uS
	 IcVXpqVQtnoNQZqNED8zEc+YRbo5W/8Wfm0DkOxJRVVexYfbmKxbiCBtiV/6USllw1
	 LFeg861/D38ROu71/1X7ceiziTFvDKfZnQAg3nm4OkS73kYn2bCHW1lVq35wdrDWAB
	 A+swtn0S+9f7GyaBm5zVNg6VZKP1aHVfssq9K7gpP8sNx3/CUfg9Yj6jwvSwg/C95+
	 vM51wu/RWFKZw==
Received: from west-edge.flir.com (west-edge.flir.com [208.11.40.244])
 by lists.lttng.org (Postfix) with ESMTPS id 4C5HyB1sXHzS3g
 for <lttng-dev@lists.lttng.org>; Tue,  6 Oct 2020 09:15:14 -0400 (EDT)
Received: from us-bos-mail1.flir.net (10.128.150.174) by us-pdx-mail3.flir.net
 (10.192.150.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2044.4; Tue, 6 Oct
 2020 05:59:58 -0700
Received: from us-bos-mail4.flir.net (10.128.150.252) by us-bos-mail1.flir.net
 (10.128.150.174) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 6 Oct
 2020 08:59:57 -0400
Received: from us-bos-mail4.flir.net ([fe80::c466:fd04:8ec1:9f13]) by
 us-bos-mail4.flir.net ([fe80::c466:fd04:8ec1:9f13%18]) with mapi id
 15.01.2044.004; Tue, 6 Oct 2020 08:59:57 -0400
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [barectf] Filter trace messages based on log level
Thread-Index: AQHWm+CXHG81IHBBcUO1KSlxMmKpWA==
Date: Tue, 6 Oct 2020 12:59:57 +0000
Message-ID: <1601988739.4352.32.camel@flir.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.209.10.39]
Content-ID: <1A1C7BE4D0D3F747AA4DF93AB6461682@flir.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 06 Oct 2020 09:16:41 -0400
Subject: [lttng-dev] [barectf] Filter trace messages based on log level
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
From: "Owen, Mark \(US\) via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Owen, Mark \(US\)" <Mark.Owen@flir.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

Thank you for your work on barectf!

I'm considering using it with our embedded MCUs that run on bare metal in
conjunction with other devices running embedded Linux. The barectf platform back
end would primarily be async serial that would be consumed by a device running
embedded Linux.

Our current home brew trace implementation is limited to a logging a log level
and a message string. I see great potential in being able to use the CTF format
to output much more information when events occur than just a level and a
string. My primary concern with barectf is that our current trace implementation
allows us to filter out packets based on log level. I believe this will be
necessary for us not to exceed our bandwidth limitation (the serial port may
also need to be shared for telemetry and command messaging).

My question is, do you think barectf is a good fit for filtering packets based
on a logging level? If so, where would you suggest implementing said filtering
(e.g. extending the platform API or use a custom API in the specific platform
implementation)?

I see that the platform API supports enabling or disabling tracing but I am
looking for something more granular. Is this something that make sense to be
implemented in the platform implementation? My initial thought is that we would
probably need to extend our barectf platform, back end implementation to include
methods for setting the logging filter level.

Before I moved forward I wanted to get your input. Any guidance you could
provide here would be very helpful.

Thank you,

Mark Owen



________________________________

Notice to recipient: This email is meant for only the intended recipient of the transmission, and may be a communication privileged by law, subject to export control restrictions or that otherwise contains proprietary information. If you receive this email by mistake, please notify us immediately by replying to this message and then destroy it and do not review, disclose, copy or distribute it. Thank you in advance for your cooperation.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
