Return-Path: <SRS0=Ne5+=MI=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26132C12002
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Jul 2021 21:56:08 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C1D613E3
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Jul 2021 21:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C1D613E3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GRQ6Y0GtGz12nv;
	Fri, 16 Jul 2021 17:56:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1626472565;
	bh=2SGqrdgB8cc3mtjXK+feTg+MiMVGdIfdG0hdmsp3jJ0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=DI6cwlp4lX8EvkRSMyNOXQkXyC6DpjM6sIWdh2Rs9QX1G8p5k4ORqUpORIQ60q33t
	 JCSrqMnXe0JjampY4JKRCtoRFoocROupQy/C877yur2bERzMlajM/bgLLx0nNvO2CM
	 VsJxwHprLh/SU56Hb5m4AP+cwr8KQQ/O9Mqf/ot/n8CC3VVe/QUAVeSA5FrVKLEona
	 Vj567SSOORxgsz4L2xI9hD5Nz5PUrsOpUexOMa2T8sjxylpnzVPlHgmO2zVLh5LWaG
	 Bl3zOkiIVUrfnO7ZFi5Jxr8ir0zcb6c6uXloxwmM3ZIxArhd1sH0NsD8TkTKvyIziC
	 UEmOdh7Cz2uqg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4GRQ6V3lsdz134b
 for <lttng-dev@lists.lttng.org>; Fri, 16 Jul 2021 17:56:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9870A334721
 for <lttng-dev@lists.lttng.org>; Fri, 16 Jul 2021 17:55:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id DMGVAkOpagin; Fri, 16 Jul 2021 17:55:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9C7DD334631;
 Fri, 16 Jul 2021 17:55:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9C7DD334631
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id irWXbAxvOj5G; Fri, 16 Jul 2021 17:55:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 91CFB33462E;
 Fri, 16 Jul 2021 17:55:55 -0400 (EDT)
Date: Fri, 16 Jul 2021 17:55:55 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <352801862.23977.1626472555562.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4059)
Thread-Index: teRjBQLEZeB3Rw0IuqaQtG8G6/JBBQ==
Thread-Topic: LTTng 2.13.0-rc3 - =?utf-8?Q?Nordicit=C3=A9?= - Linux kernel and
 user-space tracer
Subject: [lttng-dev] =?utf-8?q?=5BRELEASE=5D_LTTng_2=2E13=2E0-rc3_-_Nordi?=
 =?utf-8?q?cit=C3=A9_-_Linux_kernel_and_user-space_tracer?=
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgZXZlcnlvbmUsCgpUb2RheSBtYXJrcyB0aGUgcmVsZWFzZSBvZiB0aGUgdGhpcmQgTFRUbmcg
Mi4xMyAtIE5vcmRpY2l0w6kgcmVsZWFzZSBjYW5kaWRhdGUuCgpBIHByZXR0aWZpZWQgdmVyc2lv
biBvZiB0aGlzIGFubm91bmNlbWVudCBpcyBhdmFpbGFibGUgaGVyZToKaHR0cHM6Ly9naXRodWIu
Y29tL2x0dG5nL2x0dG5nLXRvb2xzL3JlbGVhc2VzL3RhZy92Mi4xMy4wLXJjMwoKSGF2ZSBhIGxv
b2sgYXQgdGhlIGZpcnN0IHJlbGVhc2UgY2FuZGlkYXRlJ3MgcmVsZWFzZSBub3RlcyBmb3IgYW4K
b3ZlcnZpZXcgb2YgdGhlIGZlYXR1cmVzIGludHJvZHVjZWQgaW4gTFRUbmcgMi4xMy4KCmh0dHBz
Oi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy10b29scy9yZWxlYXNlcy90YWcvdjIuMTMuMC1yYzEK
CgpXaGF0J3MgbmV3IGluIExUVG5nLVVTVCAoTGludXggYXBwbGljYXRpb24gdHJhY2VyKSAyLjEz
LjAtcmMzPwotLS0KCi0gUmVtb3ZlZCB2dHJhY2Vsb2cgYW5kIHZ0cmFjZWYgZnJvbSB0aGUgdjAg
Y29tcGF0aWJpbGl0eSBBUEkuCgotIFZhcmlvdXMgZG9jdW1lbnRhdGlvbiB1cGRhdGVzLgoKU2Vl
IHRoZSBDaGFuZ2VMb2cgZm9yIHRoZSBmdWxsIGxpc3Qgb2YgY2hhbmdlczoKaHR0cHM6Ly9naXRo
dWIuY29tL2x0dG5nL2x0dG5nLXVzdC9ibG9iL3YyLjEzLjAtcmMzL0NoYW5nZUxvZwoKCldoYXQn
cyBuZXcgaW4gTFRUbmctbW9kdWxlcyAoTGludXgga2VybmVsIHRyYWNlcikgMi4xMy4wLXJjMz8K
LS0tCgotIEFkYXB0ZWQgdGhlIGluc3RydW1lbnRhdGlvbiBmb3IgNS4xNC1yYyB1cHN0cmVhbSBr
ZXJuZWxzIGFuZCByZWNlbnQgUkhFTCA4LjQga2VybmVscy4KClNlZSB0aGUgQ2hhbmdlTG9nIGZv
ciB0aGUgZnVsbCBsaXN0IG9mIGNoYW5nZXM6Cmh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRu
Zy1tb2R1bGVzL2Jsb2IvdjIuMTMuMC1yYzMvQ2hhbmdlTG9nCgoKV2hhdCdzIG5ldyBpbiBMVFRu
Zy10b29scyAyLjEzLjAtcmMzPwotLS0KCi0gVXNhZ2UgZXhhbXBsZXMgd2VyZSBhZGRlZCB0byBh
bGwgbHR0bmcgY29tbWFuZCBtYW4gcGFnZXMuCgotIFNvbWUgc3ltYm9scyBpbnRyb2R1Y2VkIGlu
IGxpYmx0dG5nLWN0bCBhcyBwYXJ0IG9mIHRoZSAyLjEzIHJlbGVhc2Ugd2VyZSBjaGFuZ2VkOgog
IC0gRXJyb3IgcXVlcnkgYWN0aW9ucyBhcmUgbm93IHNwZWNpZmllZCB1c2luZyBhbiBsdHRuZ19h
Y3Rpb25fcGF0aCwKICAtIFRoZSBldmVudCBydWxlIEFQSSBoYXMgYmVlbiBuYW1lc3BhY2VkIHRv
IGluY2x1ZGUgdGhlIGRvbWFpbiBuYW1lLgoKLSBCdW1wZWQgdGhlIG1pbmltYWwgVXNlcnNwYWNl
IFJDVSBkZXBlbmRlbmN5IHRvIDAuMTEuCgotIEFkZGVkIHRoZSBNYWNoaW5lIEludGVyZmFjZSAo
TUkpIGZvciB0aGUgQ0xJJ3MgbmV3bHkgaW50cm9kdWNlZCB0cmlnZ2VyIGNvbW1hbmRzCiAgKGFk
ZC10cmlnZ2VyLCByZW1vdmUtdHJpZ2dlciwgbGlzdC10cmlnZ2VycykuCgpTZWUgdGhlIENoYW5n
ZUxvZyBmb3IgdGhlIGZ1bGwgbGlzdCBvZiBjaGFuZ2VzOgpodHRwczovL2dpdGh1Yi5jb20vbHR0
bmcvbHR0bmctdG9vbHMvYmxvYi92Mi4xMy4wLXJjMy9DaGFuZ2VMb2cKCgpMaW5rcwotLS0KClBy
b2plY3Qgd2Vic2l0ZToKaHR0cHM6Ly9sdHRuZy5vcmcKCkRvd25sb2FkIGxpbmtzOgpodHRwczov
L2x0dG5nLm9yZy9maWxlcy9sdHRuZy10b29scy9sdHRuZy10b29scy0yLjEzLjAtcmMzLnRhci5i
ejIKaHR0cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctdXN0L2x0dG5nLXVzdC0yLjEzLjAtcmMz
LnRhci5iejIKaHR0cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctbW9kdWxlcy9sdHRuZy1tb2R1
bGVzLTIuMTMuMC1yYzMudGFyLmJ6MgoKR1BHIHNpZ25hdHVyZXM6Cmh0dHBzOi8vbHR0bmcub3Jn
L2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIuMTMuMC1yYzMudGFyLmJ6Mi5hc2MKaHR0
cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctdXN0L2x0dG5nLXVzdC0yLjEzLjAtcmMzLnRhci5i
ejIuYXNjCmh0dHBzOi8vbHR0bmcub3JnL2ZpbGVzL2x0dG5nLW1vZHVsZXMvbHR0bmctbW9kdWxl
cy0yLjEzLjAtcmMzLnRhci5iejIuYXNjCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
