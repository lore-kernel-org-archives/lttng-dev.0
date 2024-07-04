Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568DCC30653
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Jul 2024 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720116284;
	bh=O16/dJeIn9T6gWG/t/wtMtO0S9oFXPLUmuXG8r0z4jQ=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=fo1RlY+Tk0mqr4uko/bdEaVBLMcnnisZxn/bAfoLpKEh7zIeopHkUi9IU9zdtbn0P
	 +vJ7V/DvHrq97XdMfGwMRHKIrPUK7dQ4wl7lTZw5iNjRMF9taaXwtQuY80M6iXBl4p
	 czwFu6aONTA7EO4tjq5sAqFzY9ec8ZHDtYn4WNJyBS9jrqg2LGNu+e8bnf7R189XSm
	 yoYLD2WYJVu+vRGsu3t1zVJjRnW9ddjpI/fQLCKBcp65lpzr+Siox4AScWmgNG2vlg
	 5P0uznpsEWxdKpQgeS9hE6msOSDJvB0I43OywBWZR5nkC5VGrnQ1hnwR4fmzmdqrbD
	 FvJNecjLllNgg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WFPgH6nq4z8x6;
	Thu,  4 Jul 2024 14:04:43 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4WFPgG2x5Vz8x5
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2024 14:04:42 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4WFPg74VdLz18nV;
 Thu,  4 Jul 2024 14:04:35 -0400 (EDT)
Message-ID: <61279822-9375-4fad-a2cd-f13d36f1d0c3@efficios.com>
Date: Thu, 4 Jul 2024 14:04:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev <lttng-dev@lists.lttng.org>
References: <1944AC84-89A1-4C32-807C-335461C796C1@sury.org>
Content-Language: en-US
In-Reply-To: <1944AC84-89A1-4C32-807C-335461C796C1@sury.org>
Subject: Re: [lttng-dev] rcu_cmpxchg_pointer() documentation patch
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyNC0wNy0wNCAxMzozMywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+
IEhpLAo+IAo+IGxvb2tzIGxpa2UgbXkgZ2l0LXNlbmQtZW1haWwgY29uZmlndXJhdGlvbiBpcyBu
b3QgY29ycmVjdCBhbmQgbXkgCj4gbWFpbHNlcnZlciBhdGUgdGhlIHBhdGNoLAo+IHNvIGhlcmUn
cyBvbmUgY3JlYXRlZCBieSBnaXQtZm9ybWF0LXBhdGNoLi4uCj4gCj4gTm90aGluZyBpbXBvcnRh
bnQsIGJ1dCBpdCBiaXRlIG1lIHRvZGF5Li4uCgpNZXJnZWQgaW50byBtYXN0ZXIsIHN0YWJsZS0w
LjE0LCBzdGFibGUtMC4xMywgdGhhbmtzIQoKTWF0aGlldQoKPiAKPiAKPiAKPiBPbmRyZWoKPiAt
LQo+IE9uZMWZZWogU3Vyw70gKEhlL0hpbSkKPiBvbmRyZWpAc3VyeS5vcmcKPiAKPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWls
aW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldiAKPiA8aHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldj4KCi0tIApNYXRo
aWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
