Return-Path: <SRS0=qFiG=AM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3538C433E0
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 16:35:16 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C54F207F9
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 16:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="runI3ViL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C54F207F9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49xmzl2XQfz18by;
	Wed,  1 Jul 2020 12:35:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593621315;
	bh=KCwXJtDuVNYiBVWNwRXE3AFVKs030FRZJ65MF3s4pUc=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=runI3ViL0sQBvpqIRCf0pyFoRjtL8/ea2RwJnpxKe15blfgilDK59w8hvck9YVNc/
	 ID7vI1RZMbDvn63pbP3SCot8ZQ0jh7ccz0QWlb+ol2zn0W2+Wds0AlqYsCwkSrFiAh
	 rgbG5IcGGIDP+t2lZxWfqVOPkmVLisZCh7YyspA01XNoFE6tfeytU/uazJPPRL+Txr
	 KMw/sIVFD3YNsSNOifjOXQYP/ri9YeFcnXEkKDyljl/0u62INmXvhi7h9tZDJLV3rm
	 Oe9bK0dFc6iApkWW8ppL+w2tAmRTLSJRiNp+QBQFyoRX1tNgR5YwgkrzyfvoLKTEBH
	 xcjFi/OcqsNXg==
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by lists.lttng.org (Postfix) with ESMTPS id 49xmzj3RTkz18ZG
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 12:35:13 -0400 (EDT)
IronPort-SDR: gWtiQeV8SUd57Ey7vmYI55CT0ihpPxj148EzFYqIIKeGU78HQQn8QAb+NcLnBOPCXRPO/yVVaq
 F4fvJ7Tpx/hA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="231497802"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="231497802"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 09:35:05 -0700
IronPort-SDR: zdkiXlVCeVXDoYsmr1iQlQwwpjYNsLQmBJQUteZDSbf3D0hWTZsmGudr/3QuTwFsWj/by+K4pM
 m5WN/SEBUZaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="481658356"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.121])
 by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2020 09:35:05 -0700
Date: Thu, 2 Jul 2020 00:31:17 +0800
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20200701163116.GA100490@jerryopenix>
References: <20200701155309.GA99920@jerryopenix>
 <CADcCL0jxNy9hbvxpnQdKF_QGXYSeWD2WT+enFJO5UB7wAA8Bqw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADcCL0jxNy9hbvxpnQdKF_QGXYSeWD2WT+enFJO5UB7wAA8Bqw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Subject: Re: [lttng-dev] convert call_site to func/offset
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
Message-ID: <20200701163117.9H97QrfVjLCw3T4aWzCOVut1UYqocxMcmYtexMPCsSs@z>

T24gMTI6MjUgV2VkIDAxIEp1bCwgRnJhbmNpcyBEZXNsYXVyaWVycyB3cm90ZToKPiAgICBIaSBD
aGFuZ2NoZW5nLAo+ICAgIFRoaXMgaXMgbm90IGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkgQmFiZWx0
cmFjZS4gSXQgY291bGQgcHJvYmFibHkgYmUKPiAgICBkb25lIHRoZSBzYW1lIHdheSB3ZSBkbyBp
dCB3aXRoIHRoZSAiaXAiIGFuZCAidnBpZCIgY29udGV4dHMgaW4gdGhlCj4gICAgZGVidWctaW5m
byBjb21wb25lbnQgY2xhc3MgYnV0IGl0J3Mgbm90IGRvbmUgeWV0Lgo+ICAgIFRoYW5rcywKPiAg
ICBGcmFuY2lzCgpARnJhbmNpczogVGhhbmtzIGZvciB5b3VyIGluZm8uCkRvIHdlIGhhdmUgZmVh
dHVyZSByb2FkIG1hcCB0byBiZSBjaGVja2VkPwoKPiAKPiAgICBMZSBtZXIuIDEganVpbGwuIDIw
MjAsIMOgIDExIGggNTgsIExpdSwgQ2hhbmdjaGVuZyB2aWEgbHR0bmctZGV2Cj4gICAgPFsxXWx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+IGEgw6ljcml0IDoKPiAKPiAgICAgIEhpIGFsbCwKPiAg
ICAgICAgICBJIGNoZWNrZWQgX19jeWdfcHJvZmlsZV9mdW5jX2VudGVyIGltcGxlbWVudGF0aW9u
Lgo+ICAgICAgICAgIFRoZSBjYWxsZXIgYWRkcmVzcyBpcyByZWNvcmRlZCBpbnRvIGNhbGxfc2l0
ZSBmaWVsZC4KPiAgICAgICAgICBEb2VzIGFueW9uZSBrbm93IGhvdyB0byBsZXQgYmFiZWx0cmFj
ZSBzaG93IHRoZSBjYWxsX3NpdGUgaW50bwo+ICAgICAgICAgICJmdW5jL29mZnNldCIgZm9ybWF0
IGluc3RlYWQgb2YgdGhlIHJ1bm5pbmcgdmlydHVhbCBhZGRyZXNzPwo+ICAgICAgQi5SLgo+ICAg
ICAgQ2hhbmdjaGVuZwo+ICAgICAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiAgICAgIGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiAgICAgIFsyXWx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKPiAgICAgIFszXWh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiAKPiAgICAtLQo+IAo+ICAgIEZyYW5j
aXMgRGVzbGF1cmllcnMKPiAgICBDb21wdXRlciBFbmdpbmVlcgo+ICAgIEVmZmljaU9TIGluYy4K
PiAKPiBSZWZlcmVuY2VzCj4gCj4gICAgMS4gbWFpbHRvOmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiAgICAyLiBtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+ICAgIDMuIGh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
