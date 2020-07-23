Return-Path: <SRS0=Ztta=BC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD778C433DF
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 05:43:39 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD17207E8
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 05:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="xAc3vY9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD17207E8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BC1Tj2pgZz1fFr;
	Thu, 23 Jul 2020 01:43:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595483018;
	bh=I8GSssaal3ibUKmuhZ5CMS5RjxsI1Ymq27M1W81VqNU=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xAc3vY9m7+vHwQGF0b+HYcYwXSIuXauZbWUdM9uczIImIQ9Zd2AztDWoHvZYWyS5v
	 VQfgPlPys0qKAhzDnf1XSR2H+F6UYT2T9RTsgW+cgz+yNIfYHxbYGYj5GMS1jkza1p
	 gS+mXGvM7La6xh6pQdTVgv+ufkd2ISzd9dlsphfJU0cJmL76qVRtlrS+ann5VhiKgq
	 0CjvyrzR2F5BH/TB2dDqTRQR7f7uH28fcdvWh2U8MsTVQzaZ21XMfrIBDlODK754K7
	 Vboo0h4opINf9hZ9zYGZXed8qT1YqxDmqKV/WEQSJf997/+2Tap8aSszlL62ouCvQE
	 2uj2Yn+R+NoYQ==
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.5])
 by lists.lttng.org (Postfix) with ESMTPS id 4BC1Tg0Wf6z1fS2
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 01:43:34 -0400 (EDT)
Received: from [100.112.128.231] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-a.us-west-2.aws.symcld.net id EB/D5-15041-383291F5;
 Thu, 23 Jul 2020 05:43:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRWlGSWpSXmKPExsVyqPAOq26zsmS
 8QU87n8WFuw+YLTqu9zA7MHnsnHWX3eP9gj/MAUxRrJl5SfkVCawZS/Y9YyzoYa/4f/kxSwNj
 A3sXIxeHkMAWRonrD/4ywjlnVj+HyhxklOhcNZOti5GTg01AV+LVg6fMILYIkL3m+nGwOLOAt
 cTZG0fBbGGBNInmq9tZIGrSJeb/XsQEYRtJ7Lx9lhXEZhFQlTi7/gCYzSvgLtF6/DdYr5BAL6
 PEhAluIDanQKDEgRVXwHoZBcQkvp9awwSxS1zi1pP5YLaEgIDEkj3nmSFsUYmXj/+xQtgGElu
 X7mOBsOUklm1/DlTPAdSrKbF+lz7EGEWJKd0P2SFOEJQ4OfMJC8QJyhKzVnxhm8AoPgvJtlkI
 3bOQdM9C0r2AkWUVo3lSUWZ6RkluYmaOrqGBga6hoZGuobGhrqWhXmKVbqJeabFueWpxia6RX
 mJ5sV5xZW5yTopeXmrJJkZgRKYUNEfvYDzy+oPeIUZJDiYlUV7FxxLxQnxJ+SmVGYnFGfFFpT
 mpxYcYZTg4lCR4/ytKxgsJFqWmp1akZeYAkwNMWoKDR0mEdzVImre4IDG3ODMdInWK0ZVjwsu
 5i5g5dh6dByQPgsnmO0uA5JG5SxcxC7Hk5eelSonzvgFpFgBpzijNgxsNS2yXGGWlhHkZGRgY
 hHgKUotyM0tQ5V8xinMwKgnzqikBTeHJzCuBu+AV0HFMQMcp3xUFOa4kESEl1cAUWCfe1JksH
 6T1oU9c5eE8wR6ngsuu9Xqx0+RVZr/Y/eTDekafyQvOX/FR0Ly9XD1eXHDNdFmvHy/UHLaX93
 np7zfPiLq209L+ntAq4y0Tt3SXzJsnreXuEmTyQ9DY+sKGtNZtx+OnRewy9NeXFNRmluhoWnP
 C9t1dr8j9Ema/33f/O3vSbyfTPuMy9wM9vhXc9e86ngf3GDikGL04OHMpl9zx4x7R2bNWPLXy
 jUlhnFnlZ5Sj18ipP7dMY63h+Tk9r4UdPZIWlExw1Wor3rh3p/FaRst91xe/3NsYlv2iRDD/x
 uzPcXG3rv00e/GuSntGkO5eb3aOpnUcDN+r72n5vmjSLw/pTL8d1G0WqsRSnJFoqMVcVJwIAN
 R5AO3nAwAA
X-Env-Sender: Seongab.Kim@harman.com
X-Msg-Ref: server-9.tower-337.messagelabs.com!1595483008!46175!1
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23713 invoked from network); 23 Jul 2020 05:43:30 -0000
Received: from unknown (HELO HIMDWSMB09.ad.harman.com) (194.113.220.5)
 by server-9.tower-337.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted
 SMTP; 23 Jul 2020 05:43:30 -0000
Received: from HIMDWSMB03.ad.harman.com (10.70.50.113) by
 HIMDWSMB09.ad.harman.com (10.70.50.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 07:43:27 +0200
Received: from HIMDWSMB06.ad.harman.com (10.70.50.116) by
 HIMDWSMB03.ad.harman.com (10.70.50.113) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 07:43:27 +0200
Received: from HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452]) by
 HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452%16]) with mapi id
 15.00.1497.000; Thu, 23 Jul 2020 07:43:27 +0200
To: Philippe Proulx <eeppeliteloop@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [EXTERNAL] Re: [lttng-dev] difference of timestamp between
 babeltrace and python binding
Thread-Index: AQHWYDhvalTJyYlHDEuEfGo0T3KQNakUpb7g
Date: Thu, 23 Jul 2020 05:43:27 +0000
Message-ID: <ecb0253a30f54c1aa11b59588e89bc00@HIMDWSMB06.ad.harman.com>
References: <15ed8d31ec16483db50928860aa4a4e5@HIMDWSMB06.ad.harman.com>
 <CAB4xu_3=6yYndO-C49FQ=hXF4eC+f6WGgMQCJ9-GhbA4zQ8mCQ@mail.gmail.com>
In-Reply-To: <CAB4xu_3=6yYndO-C49FQ=hXF4eC+f6WGgMQCJ9-GhbA4zQ8mCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.70.50.4]
MIME-Version: 1.0
Subject: Re: [lttng-dev] [EXTERNAL] Re: difference of timestamp between
 babeltrace and python binding
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
Message-ID: <20200723054327.3yAt2cDH4GJ89JhBvsq5_eYu-LbjVK_jvFV9pbO5Bug@z>

> -----Original Message-----
> From: Philippe Proulx <eeppeliteloop@gmail.com>
> Sent: Wednesday, July 22, 2020 4:57 PM
> To: Kim, Seongab <Seongab.Kim@harman.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: [EXTERNAL] Re: [lttng-dev] difference of timestamp between
> babeltrace and python binding
> 
> `type(1e3)` is `float`.
> 
> You get an inaccurate floating point division operation here instead of an
> integral one.
> 
> Do:
> 
>     ns_from_origin % 1000
> 
> or
> 
>     ns_from_origin % int(1e3)
> 
> instead.
> 
> Hope this helps,
> 
> Phil
> 

Hi Phil,

Thanks. With the change, it works as expected.

Best regards,
Seongab
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
