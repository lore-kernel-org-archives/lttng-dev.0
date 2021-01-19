Return-Path: <SRS0=FP6N=GW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A3C433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Jan 2021 18:35:05 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEC622CAD
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Jan 2021 18:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEC622CAD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DKvY15ZdmzSl1;
	Tue, 19 Jan 2021 11:40:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1611074454;
	bh=gE+3XmY9Hyq3vXOJ+JS7/GKM5ef7xRJbKMcUoP7rb+Q=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YyTRCVj3RtO/hpgDrmEqjy0Ra4iBAK/GS5H0YXDQLrJc273EdfpnUhJQetx6n/tYe
	 yfkDVB2hCma9h2AntsAqDV7DV7J0Z1+jo9DP44xoxaO2uJEMZgdixm9nUyapBaVz3X
	 OiaEoMAQ6NJDNqci419CNkKKCzSIKkhWa11xsdblIu9x1AH6KlvJrc8KFEhbzxZDWE
	 HKXat25jXxtaYb2H7cJzjnh8a1qaVzrLvFYrVUmKcHPggn1jnUvWCXDNvzUJOPf+qr
	 J0mUmjHUT2RlsJfm1oMhMavd8Zmpp0YFgjgp+Jd/vKr5JnVsiyqAsUL2IVZRiUjJPJ
	 9T9mx2pw8dBnQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DKvXz6xC0zSTC
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jan 2021 11:40:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5442224A8EB;
 Tue, 19 Jan 2021 11:40:45 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id AY9LY70bGefe; Tue, 19 Jan 2021 11:40:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2D0F024AB89;
 Tue, 19 Jan 2021 11:40:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2D0F024AB89
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id esV0U_xLHASv; Tue, 19 Jan 2021 11:40:45 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2443824A9CD;
 Tue, 19 Jan 2021 11:40:45 -0500 (EST)
Date: Tue, 19 Jan 2021 11:40:45 -0500 (EST)
To: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Message-ID: <818238944.1392.1611074445100.JavaMail.zimbra@efficios.com>
In-Reply-To: <BYAPR11MB26324771B431CB2262ACDBA0FFA40@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <BYAPR11MB263254ABB57F458031AB33DBFFD50@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632B3DA9B535943CEE08A73FFD00@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210106150309.GA227614@joraj-alpa>
 <BYAPR11MB2632B5DE22E2561F0B018909FFAF0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210107165408.GC227614@joraj-alpa>
 <BYAPR11MB2632B7E0BD848485746A80AFFFAE0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210115191841.GA3115961@joraj-alpa>
 <BYAPR11MB26324771B431CB2262ACDBA0FFA40@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3991 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3980)
Thread-Topic: help modpost: "__bad_cmpxchg"
Thread-Index: AQHW4D7de02FTHE4o0SVdoHpF3AAf6oaFo1DgACjDICAAKuTD4ABBcQAgAE4wQaAC4JIgIADlZCkjYH8j2s=
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogaGVscCBt?=
 =?utf-8?b?b2Rwb3N0OiAiX19iYWRfY21weGNoZyI=?=
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

CgotLS0tLSBPbiBKYW4gMTcsIDIwMjEsIGF0IDk6MDQgUE0sIGx0dG5nLWRldiBsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnIHdyb3RlOgoKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4g5Y+R5Lu25Lq6OiBKb25hdGhhbiBSYWpvdHRlLUp1bGllbiA8am9uYXRoYW4u
cmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IOWPkemAgeaXtumXtDogMjAyMeW5tDHmnIgx
NuaXpSAzOjE4Cj4g5pS25Lu25Lq6OiBaaGFuZywgUWlhbmcKPiDmioTpgIE6IGx0dG5nLWRldgo+
IOS4u+mimDogUmU6IOWbnuWkjTog5Zue5aSNOiBoZWxwIG1vZHBvc3Q6ICJfX2JhZF9jbXB4Y2hn
Igo+IAo+IFtQbGVhc2Ugbm90ZSB0aGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFp
bCBhZGRyZXNzXQo+IAo+PkhpIFF1aWFuZywKPj4KPj5QbGVhc2UgdGVzdCB0aGUgYXR0YWNoZWQg
cGF0Y2guCj4gCj4gSGVsbG8gSm9uYXRoYW4KPiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2gs
IEkgY2FuIGNvbXBpbGUgc3VjY2Vzc2Z1bGx5IGFmdGVyIHRlc3RpbmcuCgpQYXRjaCBwdXNoZWQg
aW50byBsdHRuZy1tb2R1bGVzIG1hc3RlciwgdGhhbmtzIGZvciB0ZXN0aW5nIQoKTWF0aGlldQoK
LS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5j
b20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
