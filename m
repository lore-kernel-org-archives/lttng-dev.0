Return-Path: <SRS0=Ztta=BC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE91C433EB
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AE422CF7
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="pIR9uNXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AE422CF7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BC63G3gJFz1fGK;
	Thu, 23 Jul 2020 05:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595495371;
	bh=hGZbIrWejLSKURBbZ65SgCOKIAvizoSMGCDf0u/gdRE=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pIR9uNXPtGabI8NCHuZPKCTCFJMCgtguJYB9CXmv93HkLQHsjC2Usl62uoWBHDjb5
	 7ry5Bj4fCU+LZfYTSU0sRlGFSF1DEr9aam7K+FLi4Rpvrx2DA7E4+m54oHtKdUAzQ1
	 U7mfLi/HYP8teKd81DWRGMsFKVsnCv6Zk3lErp9jwEXMhqoFW8YRn7bJMlEqzMgG0A
	 mcCOdzBRp2KcTE51Z5RtzzbyCDHKi0bYhkU0CZf4slaE4UEyP+yF0rYYQqxAPCHtTO
	 8HaRn/mvj+IlVLmMkuVbIIiiMVDCgNKs1hJkr5GBF+Bgv9HR0I5eZiKzV3Dui58cTj
	 v+QFxLfEQ8oCQ==
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.114])
 by lists.lttng.org (Postfix) with ESMTP id 4BC63D2c1tz1fGH
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 05:09:27 -0400 (EDT)
Received: from [100.112.134.230] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.us-west-2.aws.symcld.net id 9D/B5-22172-7B3591F5;
 Thu, 23 Jul 2020 09:09:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRWlGSWpSXmKPExsVyqPAOq+72YMl
 4gynL5S0u3H3AbNFxvYfZgclj56y77B7vF/xhDmCKYs3MS8qvSGDNaJgxg7XgkGDFmTc7GRsY
 lwh2MXJxCAlsYZT4fn4qI5xzatkSIIcTyDnIKPFysQWIzSagK/HqwVNmEFsEyF5z/TgbiM0sY
 C1x9sZRMFtYIEVizvcGRoiaVIlpk56yQdhGEjffHmACsVkEVCV2PD4HNodXwF3i994mJojFvY
 wST7b/A2vmFAiUuPbvMzuIzSggJvH91BomiGXiEreezAezJQQEJJbsOc8MYYtKvHz8jxXCNpD
 YunQfC4QtJ7Fs+3Ogeg6gXk2J9bv0IcYoSkzpfsgOcYOgxMmZT1gg/lWWmLXiC9sERvFZSLbN
 QuiehaR7FpLuBYwsqxgtkooy0zNKchMzc3QNDQx0DQ2NdA2NjXSNTIz0Eqt0k/RKi3XLU4tLd
 IHc8mK94src5JwUvbzUkk2MwJhMKWj5tIOx4c0HvUOMkhxMSqK8F80l44X4kvJTKjMSizPii0
 pzUosPMWpwcAhcOXhkNqMUS15+XqqSBG9mEFCdYFFqempFWmYOMG3AlEpw8CiJ8NoDU4cQb3F
 BYm5xZjpE6hSjN8eEl3MXMXPsPDoPSB4Ek+9+LgaSzXeWAMkjc5cuYhYC2yAlzlsCMkIAZERG
 aR7cAlj6u8QoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHc/yJ08mXklcHe8AjqRCehE5buiI
 CeWJCKkpBqYlL5GT7gtYW/bPW1rSwnrP7brCiIX/jg27VpYv/TMXv6USKHmOZ1zbqowhzS8Lv
 kTdyfMI6xZ9MKPugOS2zxErC/2f31mffzKLJde659fVrflzribcknHf+IUpUvijEXNBpuCvtW
 XOsV7sO6J/jGd6TznEcPk/Y9yz60P4Cjq6GUJl1mdVrut2lEvw/G9+SFBvTthLZWGD+M4dZet
 tf7beGVXyCKGnTqJ1yacZSvZtf3bz2+OBSL9j8ySurQErPc2Xy+WdeFUPRJumTCxa4ZD1oeJ7
 U7+O36UhC41jD1abTSZ729zf7SkSEPNhIQfv9Q6966boPXyhKqPWu2mE8dv7XtYOftdp+x6Nn
 /Z42eUWIozEg21mIuKEwHx1nhy+gMAAA==
X-Env-Sender: Seongab.Kim@harman.com
X-Msg-Ref: server-12.tower-343.messagelabs.com!1595495284!52066!20
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27590 invoked from network); 23 Jul 2020 09:09:11 -0000
Received: from unknown (HELO HIMDWSMB09.ad.harman.com) (194.113.220.5)
 by server-12.tower-343.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted
 SMTP; 23 Jul 2020 09:09:11 -0000
Received: from HIMDWSMB01.ad.harman.com (10.70.50.111) by
 HIMDWSMB09.ad.harman.com (10.70.50.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:08:47 +0200
Received: from HIMDWSMB06.ad.harman.com (10.70.50.116) by
 HIMDWSMB01.ad.harman.com (10.70.50.111) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:08:47 +0200
Received: from HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452]) by
 HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452%16]) with mapi id
 15.00.1497.000; Thu, 23 Jul 2020 11:08:47 +0200
To: Philippe Proulx <eeppeliteloop@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [EXTERNAL] Re: [lttng-dev] babeltrace cannot open the trace but
 Trace Compass can open
Thread-Index: AQHWYDm3OL/hzIDACUqLqy51iHMwaakU382A
Date: Thu, 23 Jul 2020 09:08:47 +0000
Message-ID: <7cb6526a78a9468e969a0fe36f42c6d7@HIMDWSMB06.ad.harman.com>
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
 <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
In-Reply-To: <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
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
Message-ID: <20200723090847.DdkeRspz9wysfu6Yx7Bzlu_BpZuIk7sGegvwuMjCw_0@z>

Hello Phil,

> -----Original Message-----
> From: Philippe Proulx <eeppeliteloop@gmail.com>
> Sent: Wednesday, July 22, 2020 5:06 PM
> To: Kim, Seongab <Seongab.Kim@harman.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: [EXTERNAL] Re: [lttng-dev] babeltrace cannot open the trace but
> Trace Compass can open
> 
> Thank you for the bug report.
> 
> Can I kindly ask you to create an official issue for this?
> 
> Go to
> <https://clicktime.symantec.com/38qgEsYhBTfCNnYpLPoAn647Vc?u=https%
> 3A%2F%2Fbugs.lttng.org%2Fprojects%2Fbabeltrace%2Fissues%2Fnew>.
> 
> I'd also like you to attach the offending CTF trace so that I can analyze it if it
> doesn't contain sensitive data and is somewhat small.

I created an account in Redmine, but I'm still waiting for the account activation mail. I tried to click the resend mail link two times without success.
Also the trace is big (1.4 GB) and it contains sensitive data.

> If it's not possible, do:
> 
>     $ babeltrace2 -o ctf-metadata /mnt/ssd/work/skim/traces/kernel | grep -
> A10 '^clock {'
> 
> and copy the output to the Redmine issue's description.

Here is the result.

skim@d54030999178:~/ssd_work/traces$ babeltrace2 -o ctf-metadata ./kernel | grep -A10 '^clock {'
clock {
        name = "monotonic";
        uuid = "e00bcef2-1ef1-4f02-a241-8561834511fd";
        description = "Monotonic Clock";
        freq = 1000000000; /* Frequency, in Hz */
        /* clock value offset from Epoch is: offset * (1/freq) */
        offset = -48;
};

typealias integer {
        size = 27; align = 1; signed = false;

> 
> BR,
> 
> Phil

Best regards,
Seongab
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
