Return-Path: <SRS0=H5el=AF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D3DC433E1
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Jun 2020 01:45:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB8020702
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Jun 2020 01:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="UCckhgkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB8020702
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49s5ZR53Dzz131W;
	Tue, 23 Jun 2020 21:45:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1592963136;
	bh=rE75WMb8Y1hCZgEQgYMsnhbAK4/IwGVeboBQQEpVwrw=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UCckhgkdR9gAngpwX4z0dHt9BRpkhKT3RcSQCTBfXt1LCF99KTLV5aPU8JzD8j93H
	 hWdqhp76k8fk9ygxcbsdXNsznxVArw525GM7IShXooXsqG70czXMAJayaWT5HieH9P
	 guSA/OppyMKRvxz384kZE4Wdxoi4EGGm93ByZ30PORqdlqCGv94ZFqlfy/Djg7pMC9
	 qi5SAY50WeNYl+XYa9ch9+/edWRlXKgqbWKxqOmYabB7o+Ql934eAwBnxEKCWZX3Pt
	 NY+7CD4/RvvEWhsO/rv6JbJXc7cF8RnWx4A62BNcDBDxhoNYiiWrfssxXdeCLBSSG2
	 wM/tMPd8Vd3kA==
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.lttng.org (Postfix) with ESMTPS id 49s5ZP26hnz1395
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2020 21:45:32 -0400 (EDT)
IronPort-SDR: upqrHKRMCaQuqHcWJ4d4mXJ3fQLoLli/YZ4wiBdsaGi/6TYm76FGcGvV0+GHN40kBjgOxHSLMK
 h/BugNHkftLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="132700947"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="132700947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 18:45:31 -0700
IronPort-SDR: Rvv05MwzxwtQf+gMtPHYeImDiy/jMQvka7QoTApPVKexnDkUxMFbc3RFryX/XFQk67CuH1uLbm
 eibNsatu+pPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="263507234"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.121])
 by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2020 18:45:29 -0700
Date: Wed, 24 Jun 2020 09:41:41 +0800
To: Christophe =?utf-8?Q?B=C3=A9dard?= <bedard.christophe@gmail.com>
Message-ID: <20200624014141.GA4166707@jerryopenix>
References: <20200623143758.GB4160129@jerryopenix>
 <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
 <CAAS9doZNif9Cw=kmo0hvKuF_qVBiqX_233JWFr4fTc5A72eLvw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAS9doZNif9Cw=kmo0hvKuF_qVBiqX_233JWFr4fTc5A72eLvw@mail.gmail.com>
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
Cc: lttng-dev@lists.lttng.org, changcheng.liu@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200624014141.nXOKnFpav0QR7CnhxoEk9Jw9q0YEdS-gZXbqjkAU0m4@z>

T24gMTI6NTIgVHVlIDIzIEp1biwgQ2hyaXN0b3BoZSBCw6lkYXJkIHdyb3RlOgo+ICAgIEhpLAo+
IAo+ICAgICAgQmFiZWx0cmFjZSBpcyBkb2luZyBleGFjdGx5IHdoYXQgaXQgc2hvdWxkIGFzIGZh
ciBhcyBJIGtub3cuCj4gCj4gICAgeWVzLCBidXQgYmFiZWx0cmFjZSBjYW4gcHJvdmlkZSB0aGUg
aW5mb3JtYXRpb24gaWY6Cj4gICAgKiBpcCBhbmQgdnBpZCBjb250ZXh0cyBhcmUgZW5hYmxlZCAo
Zm9yIHVzZXJzcGFjZSksIGUuZy4KPiAKPiAgICAkIGx0dG5nIGFkZC1jb250ZXh0IC0tdXNlcnNw
YWNlIC0tdHlwZT1pcCAtLXR5cGU9dnBpZAo+IAo+ICAgICogTFRUbmcgc3RhdGUgZHVtcCBldmVu
dHMgYXJlIGVuYWJsZWQsIGUuZy4KPiAKPiAgICAkIGx0dG5nIGVuYWJsZS1ldmVudCAtLXVzZXJz
cGFjZSAnbHR0bmdfdXN0X3N0YXRlZHVtcDoqJwpUaGFua3MgQ2hyaXN0b3BoZS4gSSB3b3JrcyBu
b3cgdGhhdCB0aGUgZnVuY3Rpb24gZW50cnkgbmFtZSBjb3VsZCBiZSBnb3QKYWZ0ZXIgMSkgYWRk
IGlwJnZwaWQgY29udGV4dCAyKSBlbmFibGUgc3RhdGUgZHVtcAoKRG8geW91IGtub3cgaG93IHRv
IHByaW50IHRoZSBjYWxsIHNpdGUgZnVuY3Rpb25fbmFtZS9vZmZzZXQ/CkZvciBleGFtcGxlOgog
ICAgICAgICAgICAxMSAgICAgZ2V0Y2hhcigpOwogICAgICAgICAgICAxMgogICAgICAgICAgICAx
MyAgICAgeCA9IGFkZDMoeCk7CkN1cnJlbnRseSwgaXQgb25seSBzaG93cyBjYWxsX3NpdGUgYWRk
cmVzcyBpbnN0ZWFkIG9mIGZ1bmN0aW9uIG5hbWUgd2l0aCBvZmZzZXQuCgpmdW5jX2VudHJ5OiB7
IGNwdV9pZCA9IDIgfSwgeyBpcCA9IDB4NTVDRkE0RjVDMUVFLCBkZWJ1Z19pbmZvID0geyBiaW4g
PSAiaW5zdHJ1bWVudCsweDExZWUiLCBmdW5jID0gIm1haW4rMCIsIHNyYyA9ICJpbnN0cnVtZW50
LmM6NyIgfSwgdnBpZCA9IDg1MjMgfSwgeyBhZGRyID0gMHg1NUNGQTRGNUMxRUUsIGNhbGxfc2l0
ZSA9IDB4N0YyN0M0QjFFMEIzIH0KZnVuY19lbnRyeTogeyBjcHVfaWQgPSAxIH0sIHsgaXAgPSAw
eDU1Q0ZBNEY1QzFBOSwgZGVidWdfaW5mbyA9IHsgYmluID0gImluc3RydW1lbnQrMHgxMWE5Iiwg
ZnVuYyA9ICJhZGQzKzAiLCBzcmMgPSAiaW5zdHJ1bWVudC5jOjMiIH0sIHZwaWQgPSA4NTIzIH0s
IHsgYWRkciA9IDB4NTVDRkE0RjVDMUE5LCBjYWxsX3NpdGUgPSAweDU1Q0ZBNEY1QzIzNyB9CmZ1
bmNfZXhpdDogeyBjcHVfaWQgPSAxIH0sIHsgaXAgPSAweDU1Q0ZBNEY1QzFBOSwgZGVidWdfaW5m
byA9IHsgYmluID0gImluc3RydW1lbnQrMHgxMWE5IiwgZnVuYyA9ICJhZGQzKzAiLCBzcmMgPSAi
aW5zdHJ1bWVudC5jOjMiIH0sIHZwaWQgPSA4NTIzIH0sIHsgYWRkciA9IDB4NTVDRkE0RjVDMUE5
LCBjYWxsX3NpdGUgPSAweDU1Q0ZBNEY1QzIzNyB9CmZ1bmNfZXhpdDogeyBjcHVfaWQgPSAxIH0s
IHsgaXAgPSAweDU1Q0ZBNEY1QzFFRSwgZGVidWdfaW5mbyA9IHsgYmluID0gImluc3RydW1lbnQr
MHgxMWVlIiwgZnVuYyA9ICJtYWluKzAiLCBzcmMgPSAiaW5zdHJ1bWVudC5jOjciIH0sIHZwaWQg
PSA4NTIzIH0sIHsgYWRkciA9IDB4NTVDRkE0RjVDMUVFLCBjYWxsX3NpdGUgPSAweDdGMjdDNEIx
RTBCMyB9CgpCLlIuCkNoYW5nY2hlbmcKPiAKPiAgICBzZWUgdGhpcyAoZnJvbSBidDIgYnV0IGl0
IGFsc28gYXBwbGllcyB0bwo+ICAgIGJ0MSk6IFsxXWh0dHBzOi8vYmFiZWx0cmFjZS5vcmcvZG9j
cy92Mi4wL21hbjcvYmFiZWx0cmFjZTItZmlsdGVyLmx0dG5nCj4gICAgLXV0aWxzLmRlYnVnLWlu
Zm8uNy8jZG9jLWx0dG5nLXByZXJlcQo+ICAgIE5vdGUgdGhhdCB0aGUgUHl0aG9uIGJpbmRpbmdz
IGZvciBiYWJlbHRyYWNlIGRvbid0IHByb3ZpZGUvZXhwb3NlIHRoaXMKPiAgICBkZWJ1ZyBpbmZv
Lgo+ICAgIENocmlzdG9waGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
