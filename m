Return-Path: <SRS0=HL3W=AH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF28BC433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Jun 2020 14:27:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857C12067D
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Jun 2020 14:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Ld5UpKSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857C12067D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49tfNk1N4Bz1514;
	Fri, 26 Jun 2020 10:27:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593181654;
	bh=6aiiGfzI7WO21S7/WylnW1wMB+e+u2fp1znVDX7ozIM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ld5UpKSjx7D0NKS6hPS2fqRGZ4sUBi50N7xCFPSH9XR/msF2Q6Uaz1Us4NnJJ+1Lj
	 9OEatHRAgswW9+Wcc/NJRuidarHR+gqRt738m5t/6prC+gXtZOznt3w9RfnrPGBWvu
	 7566gHLnUjhhAAeRPdprtMY3/Gamy+N8zrfhMGczPuFWH0R/ynw93EbKVCgEdWk7JO
	 cqVxsqqZ8y4CiMsalQwKTv1Im1sFd5RwwgRws34zr/8dQiyvnf3DW3uukd1GpgouHb
	 2mcPqfn4CwDiFj035PtnoBRL2zBwH57hIkjdbs5kviQwuH4S0SALSbe5El2CLV5x59
	 jCct4GXwdiwCA==
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by lists.lttng.org (Postfix) with ESMTPS id 49tfNh1805z1513
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 10:27:31 -0400 (EDT)
IronPort-SDR: g6U+GCdsDXrPfVVKtwyZE4k/gBf0GbB4mXZB/0xGYCoxpaXQuEa/SwizgGrqSkCEDCR5gcFh1w
 DuhYGc0vmZAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="210413021"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; d="scan'208";a="210413021"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 07:26:17 -0700
IronPort-SDR: 5jDDVZxjS6xGQFbmxM/jqZ39LynbLwig2vueoIeQ0zsSSFVh91zzHB4DUp1cagzTkOm4cg0WHm
 BxnPzvU1Nl7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; d="scan'208";a="280162501"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.121])
 by orsmga006.jf.intel.com with ESMTP; 26 Jun 2020 07:26:15 -0700
Date: Fri, 26 Jun 2020 22:22:27 +0800
To: Christophe =?utf-8?Q?B=C3=A9dard?= <bedard.christophe@gmail.com>
Message-ID: <20200626142227.GA12325@jerryopenix>
References: <20200623143758.GB4160129@jerryopenix>
 <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
 <CAAS9doZNif9Cw=kmo0hvKuF_qVBiqX_233JWFr4fTc5A72eLvw@mail.gmail.com>
 <20200624014141.GA4166707@jerryopenix>
 <CAAS9dob7WzAXX+bqca24ELTbAHkMwQvmgmk_r5ci9FVpO4BQYw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAS9dob7WzAXX+bqca24ELTbAHkMwQvmgmk_r5ci9FVpO4BQYw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Subject: Re: [lttng-dev] get function names with lttng-ust-cyg-profile
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
From: "Liu, Changcheng via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200626142227.DDJ7pk1mLJKg0SN73GnXN9BUoXEQlbMTuB0H-J5jQ0I@z>

T24gMTA6MTkgRnJpIDI2IEp1biwgQ2hyaXN0b3BoZSBCw6lkYXJkIHdyb3RlOgo+ICAgIEhpLAo+
ICAgIE9uIFR1ZSwgMjMgSnVuIDIwMjAgYXQgMjE6NDUsIExpdSwgQ2hhbmdjaGVuZwo+ICAgIDxb
MV1jaGFuZ2NoZW5nLmxpdUBpbnRlbC5jb20+IHdyb3RlOgo+IAo+ICAgICAgRG8geW91IGtub3cg
aG93IHRvIHByaW50IHRoZSBjYWxsIHNpdGUgZnVuY3Rpb25fbmFtZS9vZmZzZXQ/Cj4gICAgICBG
b3IgZXhhbXBsZToKPiAgICAgICAgICAgICAgICAgIDExICAgICBnZXRjaGFyKCk7Cj4gICAgICAg
ICAgICAgICAgICAxMgo+ICAgICAgICAgICAgICAgICAgMTMgICAgIHggPSBhZGQzKHgpOwo+ICAg
ICAgQ3VycmVudGx5LCBpdCBvbmx5IHNob3dzIGNhbGxfc2l0ZSBhZGRyZXNzIGluc3RlYWQgb2Yg
ZnVuY3Rpb24gbmFtZQo+ICAgICAgd2l0aCBvZmZzZXQuCj4gICAgICBmdW5jX2VudHJ5OiB7IGNw
dV9pZCA9IDIgfSwgeyBpcCA9IDB4NTVDRkE0RjVDMUVFLCBkZWJ1Z19pbmZvID0gewo+ICAgICAg
YmluID0gImluc3RydW1lbnQrMHgxMWVlIiwgZnVuYyA9ICJtYWluKzAiLCBzcmMgPSAiaW5zdHJ1
bWVudC5jOjciCj4gICAgICB9LCB2cGlkID0gODUyMyB9LCB7IGFkZHIgPSAweDU1Q0ZBNEY1QzFF
RSwgY2FsbF9zaXRlID0KPiAgICAgIDB4N0YyN0M0QjFFMEIzIH0KPiAgICAgIGZ1bmNfZW50cnk6
IHsgY3B1X2lkID0gMSB9LCB7IGlwID0gMHg1NUNGQTRGNUMxQTksIGRlYnVnX2luZm8gPSB7Cj4g
ICAgICBiaW4gPSAiaW5zdHJ1bWVudCsweDExYTkiLCBmdW5jID0gImFkZDMrMCIsIHNyYyA9ICJp
bnN0cnVtZW50LmM6MyIKPiAgICAgIH0sIHZwaWQgPSA4NTIzIH0sIHsgYWRkciA9IDB4NTVDRkE0
RjVDMUE5LCBjYWxsX3NpdGUgPQo+ICAgICAgMHg1NUNGQTRGNUMyMzcgfQo+ICAgICAgZnVuY19l
eGl0OiB7IGNwdV9pZCA9IDEgfSwgeyBpcCA9IDB4NTVDRkE0RjVDMUE5LCBkZWJ1Z19pbmZvID0g
eyBiaW4KPiAgICAgID0gImluc3RydW1lbnQrMHgxMWE5IiwgZnVuYyA9ICJhZGQzKzAiLCBzcmMg
PSAiaW5zdHJ1bWVudC5jOjMiIH0sCj4gICAgICB2cGlkID0gODUyMyB9LCB7IGFkZHIgPSAweDU1
Q0ZBNEY1QzFBOSwgY2FsbF9zaXRlID0gMHg1NUNGQTRGNUMyMzcgfQo+ICAgICAgZnVuY19leGl0
OiB7IGNwdV9pZCA9IDEgfSwgeyBpcCA9IDB4NTVDRkE0RjVDMUVFLCBkZWJ1Z19pbmZvID0geyBi
aW4KPiAgICAgID0gImluc3RydW1lbnQrMHgxMWVlIiwgZnVuYyA9ICJtYWluKzAiLCBzcmMgPSAi
aW5zdHJ1bWVudC5jOjciIH0sCj4gICAgICB2cGlkID0gODUyMyB9LCB7IGFkZHIgPSAweDU1Q0ZB
NEY1QzFFRSwgY2FsbF9zaXRlID0gMHg3RjI3QzRCMUUwQjMgfQo+IAo+ICAgICBNYXliZSBJJ20g
bWlzc2luZyBzb21ldGhpbmcsIGJ1dCBpc24ndCBpdCByaWdodCBoZXJlPyBFLmcuCiAgICAgIEkn
bSBhbHNvIGN1cmlvdXMgYWJvdXQgdGhlIG91dHB1dCBoZXJlLiAibWFpbiswIiB0aGUgZnVuY3Rp
b24gbmFtZQogICAgICAibWFpbiIgaXMgcmlnaHQsIGJ1dCB0aGUgb2Zmc2V0ICIrMCIgaXNuJ3Qg
cmlnaHQuCiAgICAgIEkndmUgcnVuIGl0IGZvciBzZXZlcmFsIHRpbWVzLCBpdCBhbHdheXMgc2hv
d3MgbGlrZSB0aGUgYWJvdmUKICAgICAgb3V0cHV0LgogICAgICBTbywgdHdvIHF1ZXN0aW9ucyBo
ZXJlOgogICAgICAxLiBIb3cgdG8gc2hvdyB0aGUgcmlndGggb2Zmc2V0PwogICAgICAyLiBIb3cg
dG8gc2hvdyBjYWxsX3NpdGUgaW4gImZ1bmMvb2Zmc2V0IiBmb3JtYXQ/Cj4gCj4gICAgICBkZWJ1
Z19pbmZvID0geyBiaW4gPSAiaW5zdHJ1bWVudCsweDExZWUiLCBmdW5jID0gIm1haW4rMCIsIHNy
YyA9Cj4gICAgICAiaW5zdHJ1bWVudC5jOjciIH0KPiAKPiAgICBPdGhlcndpc2UsIEkgZG9uJ3Qg
dGhpbmsgYmFiZWx0cmFjZSBjYW4gcHJvdmlkZSBhbnkgbW9yZSBpbmZvcm1hdGlvbi4KPiAgICBD
aHJpc3RvcGhlCj4gCj4gUmVmZXJlbmNlcwo+IAo+ICAgIDEuIG1haWx0bzpjaGFuZ2NoZW5nLmxp
dUBpbnRlbC5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
