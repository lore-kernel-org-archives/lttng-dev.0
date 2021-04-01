Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70921C433B4
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:19:53 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A140F6136F
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A140F6136F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FB7gW0dMnzSgY;
	Thu,  1 Apr 2021 12:19:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617293991;
	bh=hnNYU/54ZUO4ndrX+c00cy1EFiGzBPDN/0CSI6qh2As=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Vn0FXqxeXWyYtTz6AALi4RSqNn63/GvWUh6GgaCWhJ+b4sXmUxfIWLCGIj/vVRKYT
	 yKDaBIDrrUBnG8yXbCTHmQ02pYeAmDJNVeNW1HSXDqmnmPbNJR1X3Q32q3a8pfzcnb
	 4xgeVga9UThKR5aHUC/cReWoIxYr2uhcNnU3PKVrna09iL8Gk0TXFf/AMSB3Kuekr6
	 AMxCHs5RZlSe/O7NCPFt4US1AeWEG9cLk7YI+jqEjj//YvWTg0G8iLObxO0DYXlGXP
	 C+CPkNRnBt3E08vhbpDapg2dFtoItD983Cm8k4P2P3k/B+TMPfwIHC3k/rSNHkhNEX
	 CZVRW336zSwwA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FB7gV05ypzT1q
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 12:19:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7A0462B28FF;
 Thu,  1 Apr 2021 12:19:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id s4omAl7Wz4hd; Thu,  1 Apr 2021 12:19:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 786BA2B27EF;
 Thu,  1 Apr 2021 12:19:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 786BA2B27EF
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gPn69iZvKbor; Thu,  1 Apr 2021 12:19:42 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 67AC12B28F5;
 Thu,  1 Apr 2021 12:19:42 -0400 (EDT)
Date: Thu, 1 Apr 2021 12:19:42 -0400 (EDT)
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 Jeremie Galarneau <jgalar@efficios.com>
Message-ID: <1708925974.51224.1617293982339.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210331185624.406960-1-wallinux@gmail.com>
References: <20210331185624.406960-1-wallinux@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: test code assumes that child process is schedule to run before
 parent
Thread-Index: Y+O+t91Nkj6egFP+44Ih2zZDUXt4nw==
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: test code assumes that
 child process is schedule to run before parent
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LS0tLS0gT24gTWFyIDMxLCAyMDIxLCBhdCAyOjU2IFBNLCBsdHRuZy1kZXYgbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZyB3cm90ZToKCj4gdGhlIGZvbGxvd2luZyB0ZXN0cyBmYWlscyBvbiBhcm02
NAo+IC0gdGVzdF9ldmVudF92cGlkX3RyYWNrZXIgdXN0IDAgIiR7RVZFTlRfTkFNRX0iCj4gLSB0
ZXN0X2V2ZW50X3ZwaWRfdHJhY2tfdW50cmFjayB1c3QgMCAiJHtFVkVOVF9OQU1FfSIKPiAtIHRl
c3RfZXZlbnRfcGlkX3RyYWNrZXIgdXN0IDAgIiR7RVZFTlRfTkFNRX0iCj4gLSB0ZXN0X2V2ZW50
X3BpZF90cmFja191bnRyYWNrIHVzdCAwICIke0VWRU5UX05BTUV9Igo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEFuZGVycyBXYWxsaW4gPHdhbGxpbnV4QGdtYWlsLmNvbT4KPiAtLS0KPiB0ZXN0cy9yZWdy
ZXNzaW9uL3Rvb2xzL3RyYWNrZXIvdGVzdF9ldmVudF90cmFja2VyIHwgNCArKystCj4gMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQg
YS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3RyYWNrZXIvdGVzdF9ldmVudF90cmFja2VyCj4gYi90
ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3RyYWNrZXIvdGVzdF9ldmVudF90cmFja2VyCj4gaW5kZXgg
NzExNjkwYWYuLjY0OWM3ZTYxIDEwMDc1NQo+IC0tLSBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMv
dHJhY2tlci90ZXN0X2V2ZW50X3RyYWNrZXIKPiArKysgYi90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xz
L3RyYWNrZXIvdGVzdF9ldmVudF90cmFja2VyCj4gQEAgLTUsNyArNSw3IEBACj4gIwo+ICMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+IAo+IC1URVNUX0RFU0M9IkxUVG5n
IC0gRXZlbnQgdHJha2VyIHRlc3QiCj4gK1RFU1RfREVTQz0iTFRUbmcgLSBFdmVudCB0cmFja2Vy
IHRlc3QiCj4gCj4gQ1VSRElSPSQoZGlybmFtZSAiJDAiKS8KPiBURVNURElSPSIkQ1VSRElSLy4u
Ly4uLy4uIgo+IEBAIC00Miw2ICs0Miw4IEBAIGZ1bmN0aW9uIHByZXBhcmVfdXN0X2FwcAo+IAo+
IAkkVEVTVEFQUF9CSU4gLWkgJE5SX0lURVIgLXcgJE5SX1VTRUNfV0FJVCAtYSAiJEFGVEVSX0ZJ
UlNUX1BBVEgiIC1iCj4gCSIkQkVGT1JFX0xBU1RfUEFUSCIgJgo+IAlDSElMRF9QSUQ9JCEKPiAr
CSMgdm9sdW50YXJ5IGNvbnRleHQgc3dpdGNoIHRvIHN0YXJ0ICRURVNUQVBQX0JJTgo+ICsJc2xl
ZXAgMC4xCgpObywgd2UgaGF2ZSBiZWVuIGJpdHRlbiBhZ2FpbiBhbmQgYWdhaW4gYnkgdGVzdCBp
c3N1ZXMgaGlkZGVuIGJ5IHNsZWVwcyBpbiB0aGUKdGVzdCBjb2RlLiBVc2luZyBzbGVlcHMgZm9y
IHN5bmNocm9uaXphdGlvbiBpcyBmbGFreS4KCkkgZG9uJ3Qga25vdyBpZiB3ZSBkb2N1bWVudGVk
IGl0LCBidXQgd2UgYXMgbWFpbnRhaW5lcnMgYXJlIHN0cm9uZ2x5IGFnYWluc3QKYW55dGhpbmcg
dGhhdCBsb29rcyBsaWtlIGEgZGVsYXktYmFzZWQgYXBwcm9hY2ggdG8gZml4aW5nIGEgcmFjZSBp
biB0aGUgdGVzdHMuClRoaXMgdHlwaWNhbGx5IGp1c3QgYnVyeSB0aGUgcmFjZSB1bmRlciB0aGUg
Y2FycGV0IGFuZCBpdCBzaG93cyB1cCBvbmx5IGluCnNwZWNpZmljIGNvbmRpdGlvbnMgb24gdGhl
IENJIHdvcmtlcnMuCgpXZSBuZWVkIHRvIGFkZCBwcm9wZXIgcmVuZGV6LXZvdXMgYmFzZWQgc3lu
Y2hyb25pemF0aW9uIHRvIHRoZSB0ZXN0IGlmIHNvbWUKaXMgbWlzc2luZy4KCkFkZGluZyBKw6ly
w6ltaWUgaW4gQ0MuCgpUaGFua3MsCgpNYXRoaWV1CgoKPiB9Cj4gCj4gZnVuY3Rpb24gdHJhY2Vf
dXN0X2FwcAo+IC0tCj4gMi4zMS4xCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0
dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
