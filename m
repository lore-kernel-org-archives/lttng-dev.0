Return-Path: <SRS0=7caI=AI=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226EBC433E0
	for <lttng-dev@archiver.kernel.org>; Sat, 27 Jun 2020 02:42:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950812080C
	for <lttng-dev@archiver.kernel.org>; Sat, 27 Jun 2020 02:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="jbJorQC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950812080C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49tyhg5mrCz15Jc;
	Fri, 26 Jun 2020 22:42:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593225748;
	bh=hD21IYJ7BHb6xSfC8X7fy9kZtdZYv/uk5LkuYHbgPRY=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jbJorQC84PAK4853buOrZlk9lORYkRz5k0kKiOd63qGjwPIA9hB8HPqlkHlkX5Ikx
	 iG7Sr9wc5Q0HYFELeoD+QeFQIaL3o+57ubwcdUMPD/v8OC3MVBt6GuF16MMmwm35Dd
	 fxSlHql3nputuEy1DhE8bSWhXALs1vsj9a/Gif8TwdsW5MhTLvNFJcQ4wHxDiLUa1M
	 XkZW3dXnf/Jn2kq4TpWdV3K6jz0I1OCAXig3JRXOKBpMEe5pTzwFrbbX+TA9en7rSe
	 D5BRVG+azp+P/RDln3wU7Iht7uJd8F/PYsvoIctDaJohmnXBDyNc7diOyQLJB6Vh9K
	 PUNeHhqL6IkNQ==
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.lttng.org (Postfix) with ESMTPS id 49tyhY1xNGz15D7
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 22:42:21 -0400 (EDT)
IronPort-SDR: EISgLyxjA7GYaOuYDPe5Sm3P+9oPr0GM7yoeZLzUGvOkm8ZQ9kFupzlkK+OebEQc1+8FcWaPK9
 91LGLxp+OcGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="163587124"
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="163587124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 19:42:19 -0700
IronPort-SDR: jqYEgmJ6dcNHSc9Y/vY3iwYWOTvPEe9rGHv7v0UvhIIS3PNjs7ao7mjtsiplAvquDs4BWWXyjh
 UK6sNRCpdH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="480188780"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.121])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2020 19:42:18 -0700
Date: Sat, 27 Jun 2020 10:38:30 +0800
To: Christophe =?utf-8?Q?B=C3=A9dard?= <bedard.christophe@gmail.com>,
 mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
Message-ID: <20200627023830.GA19765@jerryopenix>
References: <20200623143758.GB4160129@jerryopenix>
 <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
 <CAAS9doZNif9Cw=kmo0hvKuF_qVBiqX_233JWFr4fTc5A72eLvw@mail.gmail.com>
 <20200624014141.GA4166707@jerryopenix>
 <CAAS9dob7WzAXX+bqca24ELTbAHkMwQvmgmk_r5ci9FVpO4BQYw@mail.gmail.com>
 <20200626142227.GA12325@jerryopenix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626142227.GA12325@jerryopenix>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200627023830.UH1GfS-2LcbDAN-RPSs4K_xojhgaRTYo8PT6EbCcN14@z>

SGkgQ2hyaXN0b3BoZSwKICAgIEkndmUgY2hlY2tlZCBsb3RzIG9mIGV4YW1wbGVzIGFib3V0IGZ1
bmNfZW50cnkvZXhpdC4gSXQgc2VlbXMgYWxsCiAgICB0aGUgYWRkcmVzcyBhcmUgdGhlIGxpbmtl
ZCBhZGRyZXNzLiBIb3dldmVyLCBteSByZXN1bHQgc2hvd3MgdGhhdAogICAgdGhleSdyZSB0aGUg
bG9hZGVkIHJ1bm5pbmcgYWRkcmVzcy4KCiAgICBEbyB5b3UgaGF2ZSBzb21lIHN1Z2dlc3Rpb25z
IHRvIGNoZWNrIGl0IGZ1cnRoZXI/CgpCLlIuCkNoYW5nY2hlbmcKCk9uIDIyOjIyIEZyaSAyNiBK
dW4sIExpdSwgQ2hhbmdjaGVuZyB3cm90ZToKPiBPbiAxMDoxOSBGcmkgMjYgSnVuLCBDaHJpc3Rv
cGhlIELDqWRhcmQgd3JvdGU6Cj4gPiAgICBIaSwKPiA+ICAgIE9uIFR1ZSwgMjMgSnVuIDIwMjAg
YXQgMjE6NDUsIExpdSwgQ2hhbmdjaGVuZwo+ID4gICAgPFsxXWNoYW5nY2hlbmcubGl1QGludGVs
LmNvbT4gd3JvdGU6Cj4gPiAKPiA+ICAgICAgRG8geW91IGtub3cgaG93IHRvIHByaW50IHRoZSBj
YWxsIHNpdGUgZnVuY3Rpb25fbmFtZS9vZmZzZXQ/Cj4gPiAgICAgIEZvciBleGFtcGxlOgo+ID4g
ICAgICAgICAgICAgICAgICAxMSAgICAgZ2V0Y2hhcigpOwo+ID4gICAgICAgICAgICAgICAgICAx
Mgo+ID4gICAgICAgICAgICAgICAgICAxMyAgICAgeCA9IGFkZDMoeCk7Cj4gPiAgICAgIEN1cnJl
bnRseSwgaXQgb25seSBzaG93cyBjYWxsX3NpdGUgYWRkcmVzcyBpbnN0ZWFkIG9mIGZ1bmN0aW9u
IG5hbWUKPiA+ICAgICAgd2l0aCBvZmZzZXQuCj4gPiAgICAgIGZ1bmNfZW50cnk6IHsgY3B1X2lk
ID0gMiB9LCB7IGlwID0gMHg1NUNGQTRGNUMxRUUsIGRlYnVnX2luZm8gPSB7Cj4gPiAgICAgIGJp
biA9ICJpbnN0cnVtZW50KzB4MTFlZSIsIGZ1bmMgPSAibWFpbiswIiwgc3JjID0gImluc3RydW1l
bnQuYzo3Igo+ID4gICAgICB9LCB2cGlkID0gODUyMyB9LCB7IGFkZHIgPSAweDU1Q0ZBNEY1QzFF
RSwgY2FsbF9zaXRlID0KPiA+ICAgICAgMHg3RjI3QzRCMUUwQjMgfQo+ID4gICAgICBmdW5jX2Vu
dHJ5OiB7IGNwdV9pZCA9IDEgfSwgeyBpcCA9IDB4NTVDRkE0RjVDMUE5LCBkZWJ1Z19pbmZvID0g
ewo+ID4gICAgICBiaW4gPSAiaW5zdHJ1bWVudCsweDExYTkiLCBmdW5jID0gImFkZDMrMCIsIHNy
YyA9ICJpbnN0cnVtZW50LmM6MyIKPiA+ICAgICAgfSwgdnBpZCA9IDg1MjMgfSwgeyBhZGRyID0g
MHg1NUNGQTRGNUMxQTksIGNhbGxfc2l0ZSA9Cj4gPiAgICAgIDB4NTVDRkE0RjVDMjM3IH0KPiA+
ICAgICAgZnVuY19leGl0OiB7IGNwdV9pZCA9IDEgfSwgeyBpcCA9IDB4NTVDRkE0RjVDMUE5LCBk
ZWJ1Z19pbmZvID0geyBiaW4KPiA+ICAgICAgPSAiaW5zdHJ1bWVudCsweDExYTkiLCBmdW5jID0g
ImFkZDMrMCIsIHNyYyA9ICJpbnN0cnVtZW50LmM6MyIgfSwKPiA+ICAgICAgdnBpZCA9IDg1MjMg
fSwgeyBhZGRyID0gMHg1NUNGQTRGNUMxQTksIGNhbGxfc2l0ZSA9IDB4NTVDRkE0RjVDMjM3IH0K
PiA+ICAgICAgZnVuY19leGl0OiB7IGNwdV9pZCA9IDEgfSwgeyBpcCA9IDB4NTVDRkE0RjVDMUVF
LCBkZWJ1Z19pbmZvID0geyBiaW4KPiA+ICAgICAgPSAiaW5zdHJ1bWVudCsweDExZWUiLCBmdW5j
ID0gIm1haW4rMCIsIHNyYyA9ICJpbnN0cnVtZW50LmM6NyIgfSwKPiA+ICAgICAgdnBpZCA9IDg1
MjMgfSwgeyBhZGRyID0gMHg1NUNGQTRGNUMxRUUsIGNhbGxfc2l0ZSA9IDB4N0YyN0M0QjFFMEIz
IH0KPiA+IAo+ID4gICAgIE1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IGlzbid0IGl0
IHJpZ2h0IGhlcmU/IEUuZy4KPiAgICAgICBJJ20gYWxzbyBjdXJpb3VzIGFib3V0IHRoZSBvdXRw
dXQgaGVyZS4gIm1haW4rMCIgdGhlIGZ1bmN0aW9uIG5hbWUKPiAgICAgICAibWFpbiIgaXMgcmln
aHQsIGJ1dCB0aGUgb2Zmc2V0ICIrMCIgaXNuJ3QgcmlnaHQuCj4gICAgICAgSSd2ZSBydW4gaXQg
Zm9yIHNldmVyYWwgdGltZXMsIGl0IGFsd2F5cyBzaG93cyBsaWtlIHRoZSBhYm92ZQo+ICAgICAg
IG91dHB1dC4KPiAgICAgICBTbywgdHdvIHF1ZXN0aW9ucyBoZXJlOgo+ICAgICAgIDEuIEhvdyB0
byBzaG93IHRoZSByaWd0aCBvZmZzZXQ/Cj4gICAgICAgMi4gSG93IHRvIHNob3cgY2FsbF9zaXRl
IGluICJmdW5jL29mZnNldCIgZm9ybWF0Pwo+ID4gCj4gPiAgICAgIGRlYnVnX2luZm8gPSB7IGJp
biA9ICJpbnN0cnVtZW50KzB4MTFlZSIsIGZ1bmMgPSAibWFpbiswIiwgc3JjID0KPiA+ICAgICAg
Imluc3RydW1lbnQuYzo3IiB9Cj4gPiAKPiA+ICAgIE90aGVyd2lzZSwgSSBkb24ndCB0aGluayBi
YWJlbHRyYWNlIGNhbiBwcm92aWRlIGFueSBtb3JlIGluZm9ybWF0aW9uLgo+ID4gICAgQ2hyaXN0
b3BoZQo+ID4gCj4gPiBSZWZlcmVuY2VzCj4gPiAKPiA+ICAgIDEuIG1haWx0bzpjaGFuZ2NoZW5n
LmxpdUBpbnRlbC5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
