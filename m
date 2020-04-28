Return-Path: <SRS0=0zlt=6M=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58D1C83004
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:40 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEDD20575
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="p8uZDlN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEDD20575
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49BW2f6SGwz1mwq;
	Tue, 28 Apr 2020 14:51:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588099899;
	bh=Itqz7usSObrYSTp8Gpj1DArzYn01OWyrSXouY4cj1wM=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=p8uZDlN8HlfFzIl0qR9+Jxks2tJYdCpk4KnDhujnaN6hNAcqq3rhi329aAgz/I8oM
	 DPyULv2uPPaEmJfF9vj7M5Yh0PZs8tqa8ig+auzq+3eqOenGF3RPV1x0W8MQcPXsDo
	 ZasbKWsQlD2w/e1azv9cIm1k7DZY3iohcNlrLP1UYvXThCmrYy3qjzmlOyvo8UKHl+
	 rS9BlG87VmKvCXxXagNZuTVIKVjTq5GbpZ93/rLAQnA+2cmonvpmlCh7Mf07686Lrd
	 XKuBBYkb9JD+oZuhM4BzHaCp9jHo8pCbx1R2c2xwl9EJ03ZDtikIAJEk5TNgTJvWiP
	 04GpkEwjiZ5Dw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BW2c42K5z1nG8
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 14:51:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CC90F27F474;
 Tue, 28 Apr 2020 14:51:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id w5DpCgj-yTrM; Tue, 28 Apr 2020 14:51:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6FC2927F473;
 Tue, 28 Apr 2020 14:51:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6FC2927F473
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id SRX7NTVqDtvy; Tue, 28 Apr 2020 14:51:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 637E227F472;
 Tue, 28 Apr 2020 14:51:30 -0400 (EDT)
Date: Tue, 28 Apr 2020 14:51:30 -0400 (EDT)
To: Philippe Proulx <pproulx@efficios.com>
Message-ID: <1859708486.72922.1588099890391.JavaMail.zimbra@efficios.com>
In-Reply-To: <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
 <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: Clarify that unlisted enum values are implementation-defined
Thread-Index: 5rnZzbaQIIrW8uKoGz/PvuDKOpUtDZMKMmtG
Subject: Re: [lttng-dev] [RFC PATCH CTF 1/3] Clarify that unlisted enum
 values are implementation-defined
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.29
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
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>,
 Genevieve Bastien <gbastien+lttng@versatic.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200428185130.khzcAh-L2uQcnb5bH9A_s1v-JIQOJDfo8NATFkIPfQ8@z>

LS0tLS0gT24gQXByIDI4LCAyMDIwLCBhdCAyOjQwIFBNLCBQaGlsaXBwZSBQcm91bHggcHByb3Vs
eEBlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPj4g
RnJvbTogIk1hdGhpZXUgRGVzbm95ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
Pgo+PiBUbzogImdiYXN0aWVuK2x0dG5nIiA8Z2Jhc3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0Piwg
Ik1hdHRoZXcgS2hvdXphbSIKPj4gPG1hdHRoZXcua2hvdXphbUBlcmljc3Nvbi5jb20+LAo+PiBk
aWFtb24tZGlzY3Vzc0BsaW51eGZvdW5kYXRpb24ub3JnLCBwcHJvdWx4QGVmZmljaW9zLmNvbSwg
IkplcmVtaWUgR2FsYXJuZWF1Igo+PiA8amdhbGFyQGVmZmljaW9zLmNvbT4KPj4gQ2M6ICJsdHRu
Zy1kZXYiIDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiwgIk1hdGhpZXUgRGVzbm95ZXJzIgo+
PiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+PiBTZW50OiBUaHVyc2RheSwgMjMg
QXByaWwsIDIwMjAgMTY6NTI6MjQKPj4gU3ViamVjdDogW1JGQyBQQVRDSCBDVEYgMS8zXSBDbGFy
aWZ5IHRoYXQgdW5saXN0ZWQgZW51bSB2YWx1ZXMgYXJlCj4+IGltcGxlbWVudGF0aW9uLWRlZmlu
ZWQKPiAKPj4gRnJvbTogR2VuZXZpw6h2ZSBCYXN0aWVuIDxnYmFzdGllbitsdHRuZ0B2ZXJzYXRp
Yy5uZXQ+Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4gPGdiYXN0aWVu
K2x0dG5nQHZlcnNhdGljLm5ldD4KPj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPj4gLS0tCj4+IGNvbW1vbi10cmFjZS1m
b3JtYXQtc3BlY2lmaWNhdGlvbi5tZCB8IDMgKysrCj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNpZmlj
YXRpb24ubWQKPj4gYi9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNpZmljYXRpb24ubWQKPj4gaW5k
ZXggZmQ0OWU1OS4uZjVmZWE1MSAxMDA2NDQKPj4gLS0tIGEvY29tbW9uLXRyYWNlLWZvcm1hdC1z
cGVjaWZpY2F0aW9uLm1kCj4+ICsrKyBiL2NvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlv
bi5tZAo+PiBAQCAtNDY0LDYgKzQ2NCw5IEBAIGVudW0gewo+PiB9Cj4+IH5+fgo+PiAKPj4gK1Ro
ZSBtYXBwaW5ncyBpbiB0aGUgZW51bWVyYXRpb24gdHlwZSBkbyBub3QgaGF2ZSB0byBiZSBleGhh
dXN0aXZlLgo+PiArVW5saXN0ZWQgdmFsdWVzIGFyZSBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkLgo+
PiArCj4gCj4gV2h5IG5vdCBqdXN0Ogo+IAo+ICAgIEFuIGVudW1lcmF0aW9uIGZpZWxkIGNhbiBo
YXZlIGFuIGludGVncmFsIHZhbHVlIHdoaWNoIGl0cyB0eXBlIGRvZXMgbm90Cj4gICAgbWFwIHRv
IGEgc3RyaW5nLgo+IAo+ID8KCkdvb2QgcG9pbnQsIEkgd2lsbCB1c2UgdGhhdCB3b3JkaW5nLgoK
VGhhbmtzLAoKTWF0aGlldQoKPiAKPiBQaGlsCj4gCj4+ICMjIyA0LjIgQ29tcG91bmQgdHlwZXMK
Pj4gCj4+IENvbXBvdW5kIGFyZSBhZ2dyZWdhdGlvbiBvZiB0eXBlIGRlY2xhcmF0aW9ucy4gQ29t
cG91bmQgdHlwZXMgaW5jbHVkZQo+PiAtLQo+ID4gMi4xMS4wCgotLSAKTWF0aGlldSBEZXNub3ll
cnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
