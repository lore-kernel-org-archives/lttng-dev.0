Return-Path: <SRS0=Ztta=BC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81831C433E1
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:10:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360EE20709
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="xq7WG1+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360EE20709
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BCDl10XQ2z1fYP;
	Thu, 23 Jul 2020 10:10:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595513453;
	bh=YbnIIv5wfVRAb2Ye86Bh86ePNxMqfR65AacMa4l3Fts=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xq7WG1+sBkYq7Y/i7RCGM/PB72HXIs1jich/T0k6cbnZZY0v9Y4LxfRqL0UQJYj6d
	 fhRNpLznm05KL9ojfJpezi/TnhWFMNCaQRay/vxKKFa6NxR2kjAs1CjCO2fl6stcQm
	 Cht78rDn8iTyvjzelWnb+MQ/0zmLq5KJdx8LAtKVbHhgwrMLPNVL2CgynIgkfqqqCq
	 IF0qMS0uG7+mUJJqun78ySmxHeEGp/fHrFJDJmZ3dawCtQrKO3HTvqfBGAuvDbYXtg
	 2+In9h8poB0aQqj7XH/piYozSKj5iuo2QiCWyjUAgMAOQVnXIDF+APA7xvA4Xn9Tj2
	 dbgERQo9v+sSw==
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com
 [67.219.246.116])
 by lists.lttng.org (Postfix) with ESMTPS id 4BCDky69Qtz1g3v
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 10:10:50 -0400 (EDT)
Received: from [100.112.5.167] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-c.us-east-1.aws.symcld.net id 77/2A-10081-36A991F5;
 Thu, 23 Jul 2020 14:10:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRWlGSWpSXmKPExsVyqPAOq27yLMl
 4g6WTpSwu3H3AbNFxvYfZgclj56y77B7vF/xhDmCKYs3MS8qvSGDN+LP/PVPBau6Kk4susTcw
 zuDuYuTiEBLYwihx/9gFti5GTghn2Ud2iMRBRolXx16CJdgEdCVePXjKDGKLANlrrh8HizMLW
 EucvXEUzBYWSJGY872BEaImVWLapKdsELaRxLaXTawgNouAqsSUS4eBbA4OXgF3iS/XyyB2TW
 CSON80C6yXUyBQ4s+WX+wgNqOAmMT3U2uYIHaJS9x6Mh/MlhAQkFiy5zwzhC0q8fLxP1YI20B
 i69J9LBC2nMSy7c+ZQHYxC2hKrN+lDzFGUWJK90Ow8bwCghInZz5hgfhdWWLWii9sExjFZyHZ
 NguhexaS7llIuhcwsqxiNE0qykzPKMlNzMzRNTQw0DU0NNI10TU20Uus0k3WKy3WTU0sLtE11
 EssL9YrrsxNzknRy0st2cQIjMWUAhalHYzNbz7oHWKU5GBSEuW92yQZL8SXlJ9SmZFYnBFfVJ
 qTWnyIUYODQ+DKwSOzGaVY8vLzUpUkeB/PAKoTLEpNT61Iy8wBpguYUgkOHiURXuaZQGne4oL
 E3OLMdIjUKUZXjgkv5y5i5th5dB6QPAgmm+8sAZJH5i5dxCwENltKnHceyGwBkOaM0jy40bBU
 d4lRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO9CkCk8mXklcBe8AjqOCeg45buiIMeVJCKkp
 BqY+qVqr0vMX9CQXLRb6nZbjILxjv3O6SJb3n74I77Ur3n2kcUTVUs+abHvaVrZGKZep+u4Mb
 M6atZdrR3+pYdv8e17InHbOyl/Td7JlXbFRWfnGVbuNT3f4LnkkatA9t/KWsaqYK3zHYbViu0
 MuhoXha3NnFiOH/CxSOXhmsOgzB964inL9x+N+ZbpN6qmnpyxdNpv1ihr/UkTXv1n3+hk9paf
 62tK43rtm2wa20tb1z3aGv9mjvjzg47ry54Zft69PfCnULj7tGuf8ybPWB6857b4UrY1Ry6vO
 SPB96vq4Ml3vv99nKffiec3kZl+JT7gWVZUXuyluLn285kn+d85nXbla+8Jc137Os5lBtcrlF
 iKMxINtZiLihMBXAGU6/ADAAA=
X-Env-Sender: Seongab.Kim@harman.com
X-Msg-Ref: server-21.tower-402.messagelabs.com!1595513437!655626!13
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14163 invoked from network); 23 Jul 2020 14:10:43 -0000
Received: from unknown (HELO HIMDWSMB09.ad.harman.com) (194.113.220.5)
 by server-21.tower-402.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted
 SMTP; 23 Jul 2020 14:10:43 -0000
Received: from HIMDWSMB03.ad.harman.com (10.70.50.113) by
 HIMDWSMB09.ad.harman.com (10.70.50.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 16:10:42 +0200
Received: from HIMDWSMB06.ad.harman.com (10.70.50.116) by
 HIMDWSMB03.ad.harman.com (10.70.50.113) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 16:10:42 +0200
Received: from HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452]) by
 HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452%16]) with mapi id
 15.00.1497.000; Thu, 23 Jul 2020 16:10:42 +0200
To: Philippe Proulx <eeppeliteloop@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [EXTERNAL] Re: [lttng-dev] babeltrace cannot open the trace but
 Trace Compass can open
Thread-Index: AQHWYPmxfcKcDQE0eUCPT/qVf0fXcakVM7jQ
Date: Thu, 23 Jul 2020 14:10:42 +0000
Message-ID: <1b1cfdcc72fb4cbb8a81a1a0b13c6c15@HIMDWSMB06.ad.harman.com>
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
 <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
 <7cb6526a78a9468e969a0fe36f42c6d7@HIMDWSMB06.ad.harman.com>
 <CAB4xu_1p0AYHhb1GASzOM9e-pdWmSkeTfZq2tQoyacso1MCUNA@mail.gmail.com>
In-Reply-To: <CAB4xu_1p0AYHhb1GASzOM9e-pdWmSkeTfZq2tQoyacso1MCUNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.70.50.4]
MIME-Version: 1.0
Subject: Re: [lttng-dev] [EXTERNAL] Re: babeltrace cannot open the trace but
 Trace Compass can open
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
From: "Kim, Seongab via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Kim, Seongab" <Seongab.Kim@harman.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200723141042.fcPNW7bXX0R95-2aJeijA6EZCC8E2fBlBiSomBiwdeE@z>

Hello Phil,

> -----Original Message-----
> From: Philippe Proulx <eeppeliteloop@gmail.com>
> Sent: Thursday, July 23, 2020 4:00 PM
> To: Kim, Seongab <Seongab.Kim@harman.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [EXTERNAL] Re: [lttng-dev] babeltrace cannot open the trace but
> Trace Compass can open
> > Here is the result.
> >
> > skim@d54030999178:~/ssd_work/traces$ babeltrace2 -o ctf-
> metadata ./kernel | grep -A10 '^clock {'
> > clock {
> >         name = "monotonic";
> >         uuid = "e00bcef2-1ef1-4f02-a241-8561834511fd";
> >         description = "Monotonic Clock";
> >         freq = 1000000000; /* Frequency, in Hz */
> >         /* clock value offset from Epoch is: offset * (1/freq) */
> >         offset = -48;
> 
> Thanks, this is enough for us.
> 
> When your account gets activated, could you copy this into the new issue's
> description?
> 
> This way you can receive notifications when the issue gets updated.
> 

FYI, I have created an issue, https://bugs.lttng.org/issues/1277.

Best regards,
Seongab

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
