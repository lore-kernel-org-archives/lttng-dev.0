Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B10C7618A
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679336881;
	bh=1B/chGJu43CKkkn0VZu1apnCVnXTAK+nN5YlMo2U4uw=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=X4dwlhOuvyf0V8RDjw/MDu5vwAACBK8kNEFX35pZneUrjeVwbzBfNCJ8wgY9KN/2f
	 J2B9DYw0YiWy8ytD6VNu0bF4cjGuDOq8AFP6C/VVTeR9bxDq2JxPkOTCzbKaROInU5
	 /5Mhtb4EMpPestCLH9TuIkH2780FclkZxzYOlq25bbcnsq492xHxr4QtyQwz7Vap1h
	 B+WXXEE7Qw+kf3CeG0luLoG9AnsxlebsT1n3Hq9lXVZvGLH/QceICfNxcl+hT3667X
	 u/4TREOlOG5Zi9W0eWUR/lS9rGi8wyJsyrhukJtmW2CAzX4Wem0NkvAUTCCWPvgV+V
	 KUTid3ggkzFQg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgNX13d4Tz2GVq;
	Mon, 20 Mar 2023 14:28:01 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgNX052jZz2GVn
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:28:00 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgNX00Zt9zqjK;
 Mon, 20 Mar 2023 14:28:00 -0400 (EDT)
Message-ID: <a25e571a-2c93-5482-6c94-1ec80a5ad296@efficios.com>
Date: Mon, 20 Mar 2023 14:28:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev@lists.lttng.org
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-6-ondrej@sury.org>
In-Reply-To: <20230317213755.455957-6-ondrej@sury.org>
Subject: Re: [lttng-dev] [PATCH 5/7] Use __atomic builtins to implement
 CMM_{LOAD, STORE}_SHARED
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

T24gMjAyMy0wMy0xNyAxNzozNywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+
IEluc3RlYWQgb2YgdXNpbmcgQ01NX0FDQ0VTU19PTkNFKCkgd2l0aCBtZW1vcnkgYmFycmllcnMs
IHVzZSBfX2F0b21pYwo+IGJ1aWx0aW5zIHdpdGggcmVsYXhlZCBtZW1vcnkgb3JkZXJpbmcgdG8g
aW1wbGVtZW50IENNTV9MT0FEX1NIQVJFRCgpIGFuZAo+IENNTV9TVE9SRV9TSEFSRUQoKS4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBPbmTFmWVqIFN1csO9IDxvbmRyZWpAc3VyeS5vcmc+Cj4gLS0tCj4g
ICBpbmNsdWRlL3VyY3Uvc3lzdGVtLmggfCA3ICsrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dXJjdS9zeXN0ZW0uaCBiL2luY2x1ZGUvdXJjdS9zeXN0ZW0uaAo+IGluZGV4IGZhYWUzOTAuLjk5
ZTc0NDMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91cmN1L3N5c3RlbS5oCj4gKysrIGIvaW5jbHVk
ZS91cmN1L3N5c3RlbS5oCj4gQEAgLTI2LDcgKzI2LDcgQEAKPiAgICAqIElkZW50aWZ5IGEgc2hh
cmVkIGxvYWQuIEEgY21tX3NtcF9ybWMoKSBvciBjbW1fc21wX21jKCkgc2hvdWxkIGNvbWUKPiAg
ICAqIGJlZm9yZSB0aGUgbG9hZC4KPiAgICAqLwo+IC0jZGVmaW5lIF9DTU1fTE9BRF9TSEFSRUQo
cCkJICAgICAgIENNTV9BQ0NFU1NfT05DRShwKQo+ICsjZGVmaW5lIF9DTU1fTE9BRF9TSEFSRUQo
cCkJICAgICAgIF9fYXRvbWljX2xvYWRfbigmKHApLCBfX0FUT01JQ19SRUxBWEVEKQo+ICAgCj4g
ICAvKgo+ICAgICogTG9hZCBhIGRhdGEgZnJvbSBzaGFyZWQgbWVtb3J5LCBkb2luZyBhIGNhY2hl
IGZsdXNoIGlmIHJlcXVpcmVkLgo+IEBAIC00Miw3ICs0Miw3IEBACj4gICAgKiBJZGVudGlmeSBh
IHNoYXJlZCBzdG9yZS4gQSBjbW1fc21wX3dtYygpIG9yIGNtbV9zbXBfbWMoKSBzaG91bGQKPiAg
ICAqIGZvbGxvdyB0aGUgc3RvcmUuCj4gICAgKi8KPiAtI2RlZmluZSBfQ01NX1NUT1JFX1NIQVJF
RCh4LCB2KQlfX2V4dGVuc2lvbl9fICh7IENNTV9BQ0NFU1NfT05DRSh4KSA9ICh2KTsgfSkKPiAr
I2RlZmluZSBfQ01NX1NUT1JFX1NIQVJFRCh4LCB2KQlfX2F0b21pY19zdG9yZV9uKCYoeCksICh2
KSwgX19BVE9NSUNfUkVMQVhFRCkKCl9fYXRvbWljX3N0b3JlX24oKSBpcyB2b2lkLiBfQ01NX1NU
T1JFX1NIQVJFRCgpIHNob3VsZCBldmFsdWF0ZSB0byAodikgCih1bmxlc3Mgd2UgZGVjaWRlIHRv
IGNoYW5nZSB0aGUgc2VtYW50aWMsIHdoaWNoIEkgd291bGQgcmF0aGVyIGF2b2lkKS4KClRoYW5r
cywKCk1hdGhpZXUKCj4gICAKPiAgIC8qCj4gICAgKiBTdG9yZSB2IGludG8geCwgd2hlcmUgeCBp
cyBsb2NhdGVkIGluIHNoYXJlZCBtZW1vcnkuIFBlcmZvcm1zIHRoZQo+IEBAIC01MSw5ICs1MSw4
IEBACj4gICAjZGVmaW5lIENNTV9TVE9SRV9TSEFSRUQoeCwgdikJCQkJCQlcCj4gICAJX19leHRl
bnNpb25fXwkJCQkJCQlcCj4gICAJKHsJCQkJCQkJCVwKPiAtCQlfX3R5cGVvZl9fKHgpIF92ID0g
X0NNTV9TVE9SRV9TSEFSRUQoeCwgdik7CQlcCj4gKwkJX0NNTV9TVE9SRV9TSEFSRUQoeCwgdik7
CQkJCVwKPiAgIAkJY21tX3NtcF93bWMoKTsJCQkJCQlcCj4gLQkJX3YgPSBfdjsJLyogV29yayBh
cm91bmQgY2xhbmcgInVudXNlZCByZXN1bHQiICovCVwKPiAgIAl9KQo+ICAgCj4gICAjZW5kaWYg
LyogX1VSQ1VfU1lTVEVNX0ggKi8KCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMu
Cmh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
