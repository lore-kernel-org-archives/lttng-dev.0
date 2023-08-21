Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1738EE4996
	for <lttng-dev@archiver.kernel.org>; Mon, 21 Aug 2023 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692632549;
	bh=qXFBbAgMh5ROAdlm74Zd8kb2r+SmdwtRTCUatCKq5aA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eDJ71r/Zec3PaWDP2Xi/RAkujSuClHoS/lv5bNFMDJAAPQrfPzMJlJZuCcUyqbUB/
	 Zl6+QJDhZQfpiTuajyHxfSxmYhBfAtS3mjZn3GHfuaBxDYvgSkUWVG/Zq+e/QNEe6u
	 4pmtzXzV0q/RkLtYs6aeV2gpJICpDf5K9gBE60Ze3pXBnM20tH/eJlzgedBNNVKZxk
	 koBX0vvj8gO5efy8YdvNV5LQ0GkCCvCkOiKuPehvXjcaZtJFU+aStkiKzKvvLDzuPo
	 zXb6UuNSOpbCA5eIE37QejY6wGBVwlU9K+n4c0gfUrZkQfgVTvM93qHXqjXMFw9Xe5
	 KST668q/XXagw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RTxYw5n5Cz2Pq3;
	Mon, 21 Aug 2023 11:42:28 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4RTxYs1nwlz2Ppv
 for <lttng-dev@lists.lttng.org>; Mon, 21 Aug 2023 11:42:25 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4RTxYr3lFvz1M6d;
 Mon, 21 Aug 2023 11:42:24 -0400 (EDT)
Message-ID: <cf12aa23-f3ad-e286-58b6-ae1b7e70b9e2@efficios.com>
Date: Mon, 21 Aug 2023 11:43:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Olivier Dion <odion@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, 
 Michael Jeanson <mjeanson@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
References: <87v8gzuc3g.fsf@laura> <87jztxjpxa.fsf@laura>
 <df134b32-9e1b-8deb-14fc-b09f02e2e678@efficios.com>
In-Reply-To: <df134b32-9e1b-8deb-14fc-b09f02e2e678@efficios.com>
Subject: Re: [lttng-dev] [RFC] Deprecating RCU signal flavor
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

T24gOC8xNS8yMyAwODozOCwgTWF0aGlldSBEZXNub3llcnMgdmlhIGx0dG5nLWRldiB3cm90ZToK
PiBPbiA4LzE0LzIzIDE3OjA1LCBPbGl2aWVyIERpb24gdmlhIGx0dG5nLWRldiB3cm90ZToKPj4K
Pj4gQWZ0ZXIgZGlzY3Vzc2luZyBpdCB3aXRoIE1hdGhpZXUsIHdlIGFncmVlIG9uIHRoZSBmb2xs
b3dpbmcgMyBwaGFzZXMgZm9yCj4+IGRlcHJlY2F0aW5nIHRoZSBzaWduYWwgZmxhdm9yOgo+Pgo+
PiDCoCAxKSBsaWJ1cmN1LXNpZ25hbCB3aWxsIGJlIGltcGxlbWVudGVkIGluIHRlcm0gb2YgbGli
dXJjdS1tYi4gVGhlIG9ubHkKPj4gwqAgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSB0d28gZmxhdm9y
cyB3aWxsIGJlIHRoZSBwdWJsaWMgaGVhZGVyIGZpbGVzLAo+PiDCoCBsaW5rZWQgc3ltYm9scyBh
bmQgbGlicmFyeSBuYW1lLsKgIE5vdGUgdGhhdCB0aGlzIGFkZCBhIHJlZ3Jlc3Npb24gaW4KPj4g
wqAgdGVybSBvZiBwZXJmb3JtYW5jZSwgc2luY2UgdGhlIGltcGxlbWVudGF0aW9uIG9mIGxpYnVy
Y3UtbWIgYWRkcyBtZW1vcnkKPj4gwqAgYmFycmllcnMgb24gdGhlIHJlYWRlciBzaWRlIHdoaWNo
IGFyZSBub3QgcHJlc2VudCBpbiB0aGUgb3JpZ2luYWwKPj4gwqAgbGlidXJjdS1zaWduYWwgaW1w
bGVtZW50YXRpb24uCj4+Cj4+IMKgIDIpIEFkZGluZyB0aGUgZGVwcmVjYXRlZCBhdHRyaWJ1dGUg
dG8gZXZlcnkgcHVibGljIGZ1bmN0aW9ucyBleHBvc2VkIGJ5Cj4+IMKgIHRoZSBsaWJ1cmN1LXNp
Z25hbCBmbGF2b3IuwqAgQXQgdGhpcyBwb2ludCwgdGVzdHMgZm9yIGxpYnVyY3Utc2lnbmFsCj4+
IMKgIHdpbGwgYWxzbyBiZSByZW1vdmVkIGZyb20gdGhlIHByb2plY3QuwqAgVGhlcmUgd2lsbCBi
ZSBubyBtb3JlIHN1cHBvcnQKPj4gwqAgZm9yIHRoaXMgZmxhdm9yLgo+Pgo+PiDCoCAzKSBSZW1v
dmluZyB0aGUgbGlidXJjdS1zaWduYWwgZmxhdm9yIGNvbXBsZXRlbHkgZnJvbSB0aGUgcHJvamVj
dC4KPj4KPj4gRmluYWxseSwgaGVyZSBpcyBhIHRlbnRhdGl2ZSB2ZXJzaW9ucyByZWxlYXNlIG9m
IG1pbmUgZm9yIGVhY2ggcGhhc2U6Cj4+Cj4+IMKgIDEpIDAuMTUuMCBbT2N0b2JlciAyMDIzXSAo
YWxzbyBUU0FOIHN1cHBvcnQgeWF5ISkKPj4KPj4gwqAgMikgMC4xNS4xCj4+Cj4+IMKgIDMpIDAu
MTYuMCB8fCAxLjAuMCAobWF5YmUgYSBtYWpvciBidW1wIHNpbmNlIHRoaXMgaXMgYW4gQVBJIGJy
ZWFraW5nCj4+IMKgIGNoYW5nZSkKPiAKPiBUaGVyZSBpcyBhIGRpc3RpbmN0aW9uIGJldHdlZW4g
dGhlIHZlcnNpb24gbnVtYmVyIG9mIHRoZSBsaWJ1cmN1IHByb2plY3QgCj4gKDAuMTQpIGFuZCB0
aGUgQUJJIHNvbmFtZSBmb3IgdGhlIHNoYXJlZCBvYmplY3RzLiBXZSBtYXkgYmUgYWJsZSB0byBk
byAKPiBzdGVwICgzKSB3aXRob3V0IGdvaW5nIHRvIDEuMC4wIChJIGRvbid0IHNlZSByZW1vdmFs
IG9mIHRoZSB1cmN1LXNpZ25hbCAKPiBmbGF2b3IgYSBzdHJvbmcgZW5vdWdoIG1vdGl2YXRpb24g
Zm9yIGhpdHRpbmcgMS4wLjAgeWV0KS4KPiAKPiBUZWNobmljYWxseSBzcGVha2luZywgZ2l2ZW4g
dGhhdCB3ZSB3b3VsZCBiZSByZW1vdmluZyB0aGUgZW50aXJlIAo+IGxpYnVyY3Utc2lnbmFsLnNv
IHNoYXJlZCBvYmplY3QsIHdlIHdvdWxkIG5vdCBiZSBjaGFuZ2luZyBfc3ltYm9sc18gCj4gd2l0
aGluIGFuIGV4aXN0aW5nIHNoYXJlZCBvYmplY3QsIHRoZXJlZm9yZSBJJ20gbm90IGV2ZW4gc3Vy
ZSB3ZSBuZWVkIHRvIAo+IGJ1bXAgdGhlIHNvbmFtZSBmb3IgYWxsIHRoZSBvdGhlciByZW1haW5p
bmcgc2hhcmVkIG9iamVjdHMuCgpTbyBhZnRlciBtZXJnaW5nIHRoaXMgY29tbWl0OgoKICAgICBQ
aGFzZSAxIG9mIGRlcHJlY2F0aW5nIGxpYnVyY3Utc2lnbmFsCiAgICAgCiAgICAgVGhlIGZpcnN0
IHBoYXNlIG9mIGxpYnVyY3Utc2lnbmFsIGRlcHJlY2F0aW9uIGNvbnNpc3RzIG9mIGltcGxlbWVu
dGluZwogICAgIGl0IGluIHRlcm0gb2YgbGlidXJjdS1tYi4gSW4gb3RoZXIgd29yZHMsIGxpYnVy
Y3Utc2lnbmFsIGlzIGlkZW50aWNhbCB0bwogICAgIGxpYnVyY3UtbWIgYXQgdGhlIGV4Y2VwdGlv
biBvZiB0aGUgZnVuY3Rpb24gc3ltYm9scyBhbmQgcHVibGljIGhlYWRlcgogICAgIGZpbGVzLgog
ICAgIAogICAgIFRoaXMgaXMgZG9uZSBieToKICAgICAKICAgICAgIDEpIFJlbW92aW5nIHRoZSBS
Q1VfU0lHTkFMIHNwZWNpZmljIGNvZGUgaW4gdXJjdS5jCiAgICAgCiAgICAgICAyKSBNYWtpbmcg
dGhlIFJDVV9NQiBzcGVjaWZpYyBjb2RlIGFsc28gc3BlY2lmaWMgdG8gUkNVX1NJR05BTCBpbgog
ICAgICAgdXJjdS5jCiAgICAgCiAgICAgICAzKSBSZXdyaXRpbmcgX3VyY3Vfc2lnbmFsX3JlYWRf
dW5sb2NrX3VwZGF0ZV9hbmRfd2FrZXVwIHRvIHVzZSBhCiAgICAgICBhdG9taWMgc3RvcmUgd2l0
aCBDTU1fU0VRX0NTVCBpbnN0ZWFkIG9mIGEgc3RvcmUgQ01NX1JFTEFYRUQgd2l0aAogICAgICAg
Y21tX2JhcnJpZXIoKSBhcm91bmQgaXQuIFdlIGNvdWxkIGtlZXAgdGhlIGV4cGxpY2l0IGJhcnJp
ZXJzLCBidXQgdGhhdAogICAgICAgd291bGQgcmVxdWlyZSB0byBhZGQgc29tZSBjbW1fYW5ub3Rh
dGUgYW5ub3RhdGlvbnMuIFRoZXJlZm9yZSwgdG8gYmUKICAgICAgIGxlc3MgaW50cnVzaXZlIGlu
IGEgcHVibGljIGhlYWRlciBmaWxlLCBzaW1wbHkgdXNlIHRoZSBDTU1fU0VRX0NTVAogICAgICAg
bGlrZSBmb3IgdGhlIG1iIGZsYXZvci4KCkkgbm90aWNlIHRoYXQgYW4gYXBwbGljYXRpb24gcHJl
dmlvdXNseSBidWlsdCBhZ2FpbnN0IHVyY3Utc2lnbmFsIHdpdGgKX0xHUExfU09VUkNFIGRlZmlu
ZWQgd291bGQgaGF2ZSB0byBiZSByZWJ1aWx0LCB3aGljaCB3b3VsZCByZXF1aXJlIGEKc29uYW1l
IGJ1bXAgb2YgdXJjdS1zaWduYWwuCgpTbyBjb25zaWRlcmluZyB0aGF0IHRoaXMgcGhhc2UgMSBp
cyBub3QgcmVhbGx5IGEgImRyb3AgaW4iIHJlcGxhY2VtZW50LApJIGZhdm9yIHJlbW92aW5nIHRo
ZSB1cmN1LXNpZ25hbCBmbGF2b3IgZW50aXJlbHkgYmVmb3JlIHRoZSBuZXh0IHJlbGVhc2UuCgpU
aG91Z2h0cyA/CgpUaGFua3MsCgpNYXRoaWV1CgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmlj
aU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
