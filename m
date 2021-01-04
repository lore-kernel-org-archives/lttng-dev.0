Return-Path: <SRS0=oMcx=GH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298EBC433E0
	for <lttng-dev@archiver.kernel.org>; Mon,  4 Jan 2021 15:36:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4968121D93
	for <lttng-dev@archiver.kernel.org>; Mon,  4 Jan 2021 15:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4968121D93
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4D8fqd3nP5zMgX;
	Mon,  4 Jan 2021 10:36:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1609774590;
	bh=+K4WLMc06hOrQY1beVP7PjWt/xhC9HvhETqC+zaOo0s=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=s7R7QmcvJBxTKRWIp2JyrbDylQzTPDCLkIjocPyD9QhnXC9ha05cwPRZkdTa18ZlR
	 A82QAece0VJsBhZ3OkICvVo2iqQy/eOqPrhG9xS1U0d5ofX7f4aSSZIQQrpg7cqEji
	 VcuD94xRF9OwEPytpYfcPcziYBNK3zxlIWCfXT1RFSZ8WJoMd+h4dOHZlhWizc4XYZ
	 ZLKSOHoqEl2U2ctje/Xvxs/hqVGmrKbVzB6fB8Vm9OVilCO2L/4AOU1Q4h0UapjU5n
	 SK8z9LZ+WirR1ORKiXTBFls0gYTwMiW5qOT2FMN/vN19DIyq71cJb5IyOfybDhtDqH
	 MwKe/a3K90Ghw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4D8fqb0V3GzMM7
 for <lttng-dev@lists.lttng.org>; Mon,  4 Jan 2021 10:36:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9043B2F5740;
 Mon,  4 Jan 2021 10:36:20 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id liOTjAr4yPpT; Mon,  4 Jan 2021 10:36:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DFFF52F573F;
 Mon,  4 Jan 2021 10:36:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DFFF52F573F
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id X8_TpmDUi3Af; Mon,  4 Jan 2021 10:36:19 -0500 (EST)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 6ECC62F546E;
 Mon,  4 Jan 2021 10:36:19 -0500 (EST)
Date: Mon, 4 Jan 2021 10:36:18 -0500
To: Serica <serica_law@qq.com>
Message-ID: <20210104153618.GC60341@joraj-alpa>
References: <tencent_13C276218B5808AF7848BFEF00E8B4AB3A05@qq.com>
 <1510592650.3765.1609214285939.JavaMail.zimbra@efficios.com>
 <tencent_4C429FE980FC54AC7AC796244B4048B19805@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_4C429FE980FC54AC7AC796244B4048B19805@qq.com>
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSN77yaIEVuYW1lYmxpbmcgbmFtZXNwYWNl?=
 =?utf-8?q?_contexts?=
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksCgo+IFRoZSB2ZXJzaW9uIG9mIG15IGx0dG5nIGlzOiBsdHRuZyAoTFRUbmcgVHJhY2UgQ29u
dHJvbCkgMi4xMC43IC0gS2VLcmllay4KClBsZWFzZSB1cGdyYWRlIHRvIGx0dG5nIDIuMTIueC4g
Q29udGFpbmVyIGF3YXJlbmVzcyB3YXMgYWRkZWQgaW4gdGhlIDIuMTIgcmVsZWFzZQpjeWNsZS4K
CkNoZWVycwoKPiBUaGFua3MsCj4gU2VyaWNhCj4gCj4gCj4gLS0tLS0tLS0tLS0tLS0tLS0tJm5i
c3A75Y6f5aeL6YKu5Lu2Jm5ic3A7LS0tLS0tLS0tLS0tLS0tLS0tCj4g5Y+R5Lu25Lq6OiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJNYXRoaWV1IERlc25veWVycyIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tJmd0OzsKPiDlj5HpgIHml7bpl7Q6Jm5ic3A7MjAyMOW5tDEy
5pyIMjnml6Uo5pif5pyf5LqMKSDkuK3ljYgxMTo1OAo+IOaUtuS7tuS6ujombmJzcDsiU2VyaWNh
IjxzZXJpY2FfbGF3QHFxLmNvbSZndDs7Cj4g5oqE6YCBOiZuYnNwOyJsdHRuZy1kZXYiPGx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcmZ3Q7Owo+IOS4u+mimDombmJzcDtSZTogW2x0dG5nLWRldl0g
RW5hbWVibGluZyBuYW1lc3BhY2UgY29udGV4dHMKPiAKPiAKPiAKPiAtLS0tLSBPbiBEZWMgMjMs
IDIwMjAsIGF0IDk6NTUgUE0sIGx0dG5nLWRldiA8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyZn
dDsgd3JvdGU6Cj4gCj4gSGksCj4gCj4gVGhJIGZvdW5kIHRoYXQgbHR0bmcgaXMgd29ya2luZyBv
biBjb250YWluZXIgYXdhcmVuZXNzIGluIHRoaXMgc2xpZGVzOiBodHRwczovL2FyY2hpdmUuZm9z
ZGVtLm9yZy8yMDE5L3NjaGVkdWxlL2V2ZW50L2NvbnRhaW5lcnNfbHR0bmcvYXR0YWNobWVudHMv
c2xpZGVzLzM0MTkvZXhwb3J0L2V2ZW50cy9hdHRhY2htZW50cy9jb250YWluZXJzX2x0dG5nL3Ns
aWRlcy8zNDE5L2x0dG5nX2NvbnRhaW5lcnNfZm9zZGVtMTkucGRmCj4gCj4gT24gcGFnZSAjMTMs
IHRoZXJlIGlzIGEgY29tbWFuZDombmJzcDsgbHR0bmcgYWRkLWNvbnRleHQgLWsgLXQgcHJvY25h
bWUgLXQgcGlkIC10IHZwaWQgLXQgdGlkIC10IHZ0aWQgLXQgcGlkX25zLCB3aGVyZSBwaWRfbnMg
YW5kIG90aGVyIG5hbWVzcGFjZSBpZGVudGlmaWVycyBhcmUgdmVyeSB1c2VmdWwgZm9yIHRyYWNp
bmcgY29udGFpbmVycy4gSG93ZXZlciwgaXQgc2VlbXMgbGlrZSB0aGF0IGx0dG5nIG9mIGN1cnJl
bnQgdmVyc2lvbiBkb2Vzbid0IHN1cHBvcnQgYWRkaW5nIGNvbnRleHQgcGlkX25zKEVycm9yOiBV
bmtub3duIGNvbnRleHQgdHlwZSBwaWRfbnMpLiBEbyB5b3Uga25vdyBob3cgdG8gZW5hYmxlIHRo
ZXNlIGZlYXR1cmVzPwo+IAo+IFdoYXQgdmVyc2lvbiBvZiBMVFRuZyBkbyB5b3UgdXNlIChvdXRw
dXQgb2YgImx0dG5nIC0tdmVyc2lvbiIpLCBhbmQgd2hhdCBpcyB0aGUgb3V0cHV0IG9mICJsdHRu
ZyBhZGQtY29udGV4dCAtLWxpc3QiID8KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
