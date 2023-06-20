Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761F9EB64D7
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Jun 2023 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687298573;
	bh=SvRBTtSdn25NujInr7f9C6GP3Zm2h2vrH7DSFE/ePmA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WhVheGWjGB03JFVxedxlmAufZdqY2T88eGvKeSqlsmzlBvOCH0hmW2bv1Q3RKR4mJ
	 S22eGVWTtvBTAfD0ViWuhWjbKPcY2SUaiVZO2fN2DiILpxnTXjhMsWUnXhLHducBcJ
	 2qlYbAephBW9NXzmKbuJD+q585coFD41RQrx+CvTvWZ7EqxFZ+T6NVm7wYqWau7cvS
	 nCz2TBxr4SkG+Fjzu2bCbm3oXbIa7DFz/cxFeShlYUS+SPa38uEjbFUoH7ihOe/K+E
	 zau0CqeRydETacehGYwkPR0QcqSEQlbmRPX3lBQVSxPDuTOtas074hjAle3CMdgrz0
	 PtzZCXa6Sey9A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qm0xT1XKpz1yjN;
	Tue, 20 Jun 2023 18:02:53 -0400 (EDT)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qm0xR5WNJz1yjB
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 18:02:51 -0400 (EDT)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3113da5260dso2652960f8f.2
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 15:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687298570; x=1689890570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkpUDCdBom8Nor/VxpgM9w9ha9lhIti8LAIjusq7+QM=;
 b=NVngBbibWJIPbQJVKyBaRYUhy7JLZj5fsvcu0SIam0nEtodQRYvVLbuwTdXd/7hDuF
 BjzgMaz1flK2Ga6NxfdDhBwwOL+pYW80F2u5LrdRWa9nTVQ6wwd+P6iRA5uOGUR2TKa8
 XCYq4nxB6A2sZOqCM+ywl6txVPllYN38lbbPxBtD9MC+dWudTTeOffKYU+Mh4E7PoS5S
 vtTAjolCYXDQP17Su84OtEete8+sV3MfZPJo4mW1hk39ZwR7uKJIlBw2CdygbspZktN1
 nekFDA0Znguvv7OCvrJiXzCg0nEO76M78Rxnm7EifkAmAegjOvrdkpJi4s+YY5jj44eO
 RUkg==
X-Gm-Message-State: AC+VfDyuoTKorBL6x4tCeXtq/u6nL0y75mpUMjfTj5v5WNj2k2LPYvEF
 TYKqEX5KKGTS7+9rxTYBKFTaPM6itbg1Ywz6argIn8r4
X-Google-Smtp-Source: ACHHUZ6Te3yzEHrsBPfNdXVmNzGtyv/c+ZaUPBhRM6PClfIDgBw9FAYWSigCho6If68BSFg1LnYlcQ/9IY6yZ8QkSQo=
X-Received: by 2002:a05:6000:1207:b0:311:1664:94c5 with SMTP id
 e7-20020a056000120700b00311166494c5mr8534399wrx.63.1687298570153; Tue, 20 Jun
 2023 15:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
 <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
 <41fa4914-b519-9ff9-3659-7e4cf2d41904@efficios.com>
 <91d1c0ca-af15-2972-da1e-8f07a148158b@efficios.com>
In-Reply-To: <91d1c0ca-af15-2972-da1e-8f07a148158b@efficios.com>
Date: Tue, 20 Jun 2023 18:02:38 -0400
Message-ID: <CAFZh4h-MPXsqHETtYGv2LqMgvt_me33eGSU-UhhZQxmjMEUTig@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] I'm still getting empty ust traces using tracef
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
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gVGh1LCBNYXkgMTEsIDIwMjMgYXQgMjoxNOKAr1BNIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+Cj4gT24gMjAyMy0wNS0xMSAxNDox
MywgTWF0aGlldSBEZXNub3llcnMgdmlhIGx0dG5nLWRldiB3cm90ZToKPiA+IE9uIDIwMjMtMDUt
MTEgMTI6MzYsIEJyaWFuIEh1dGNoaW5zb24gdmlhIGx0dG5nLWRldiB3cm90ZToKPiA+PiAuLi4g
bW9yZSBiYWNrZ3JvdW5kLiAgSSd2ZSBhbHdheXMgdXNlZCBsdHQgaW4gdGhlIGtlcm5lbCBzbyBJ
IGRvbid0Cj4gPj4gaGF2ZSBtdWNoIGV4cGVyaWVuY2Ugd2l0aCB0aGUgdXNlciBzaWRlIG9mIGl0
IGFuZCBlc3BlY2lhbGx5Cj4gPj4gbXVsdGktdGhyZWFkZWQsIG11bHRpLWNvcmUgc28gSSdtIHBy
b2JhYmx5IG1pc3Npbmcgc29tZSBmdW5kYW1lbnRhbAo+ID4+IGNvbmNlcHRzIHRoYXQgSSBuZWVk
IHRvIHVuZGVyc3RhbmQuCj4gPgo+ID4gV2hpY2ggYXJlIHRoZSBleGFjdCB2ZXJzaW9ucyBvZiBM
VFRuZy1VU1QgYW5kIExUVG5nLVRvb2xzIHlvdSBhcmUgdXNpbmcKPiA+IG5vdyA/ICgyLjEzLk4g
b3Igd2hpY2ggZ2l0IGNvbW1pdCA/KQo+ID4KPgo+IEFsc28sIGNhbiB5b3UgdHJ5IHVzaW5nIGx0
dG5nLXVzdCBzdGFibGUtMi4xMyBicmFuY2gsIHdoaWNoIGluY2x1ZGVzIHRoZSBmb2xsb3dpbmcg
Y29tbWl0ID8KPgo+IGNvbW1pdCBiZTJjYThiNTYzYmFiODFiZTE1Y2JjZTdiOWY1MjQyMjM2OWY3
OWY3Cj4gQXV0aG9yOiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPgo+IERhdGU6ICAgVHVlIEZlYiAyMSAxNDoyOTo0OSAyMDIzIC0wNTAwCj4KPiAgICAg
IEZpeDogUmVldmFsdWF0ZSBMVFROR19VU1RfVFJBQ0VQT0lOVF9ERUZJTkUgZWFjaCB0aW1lIHRy
YWNlcG9pbnQuaCBpcyBpbmNsdWRlZAo+Cj4gICAgICBGaXggaXNzdWVzIHdpdGggbWlzc2luZyBz
eW1ib2xzIGluIHVzZS1jYXNlcyB3aGVyZSB0cmFjZWYuaCBpcyBpbmNsdWRlZAo+ICAgICAgYmVm
b3JlIGRlZmluaW5nIExUVE5HX1VTVF9UUkFDRVBPSU5UX0RFRklORSwgZS5nLjoKPgo+ICAgICAg
ICNpbmNsdWRlIDxsdHRuZy90cmFjZWYuaD4KPiAgICAgICAjZGVmaW5lIExUVE5HX1VTVF9UUkFD
RVBPSU5UX0RFRklORQo+ICAgICAgICNpbmNsdWRlIDxwcm92aWRlci5oPgo+Cj4gICAgICBJdCBp
cyBjYXVzZWQgYnkgdGhlIGZhY3QgdGhhdCB0cmFjZWYuaCBpbmNsdWRlcyB0cmFjZXBvaW50Lmgg
aW4gYQo+ICAgICAgY29udGV4dCB3aGljaCBoYXMgTFRUTkdfVVNUX1RSQUNFUE9JTlRfREVGSU5F
IHVuZGVmaW5lZCwgYW5kIHRoaXMgaXMgbm90Cj4gICAgICByZS1ldmFsdWF0ZWQgZm9yIHRoZSBm
b2xsb3dpbmcgaW5jbHVkZXMuCj4KPiAgICAgIEZpeCB0aGlzIGJ5IGxpZnRpbmcgdGhlIGRlZmlu
aXRpb24gY29kZSBpbiB0cmFjZXBvaW50Lmggb3V0c2lkZSBvZiB0aGUKPiAgICAgIGhlYWRlciBp
bmNsdWRlIGd1YXJkcywgYW5kICN1bmRlZiB0aGUgb2xkIExUVE5HX1VTVF9fREVGSU5FX1RSQUNF
UE9JTlQKPiAgICAgIGJlZm9yZSByZS1kZWZpbmluZyBpdCB0byBpdHMgbmV3IHNlbWFudGljLiBV
c2UgYSBuZXcKPiAgICAgIF9MVFROR19VU1RfVFJBQ0VQT0lOVF9ERUZJTkVfT05DRSBpbmNsdWRl
IGd1YXJkIHdpdGhpbiB0aGUKPiAgICAgIExUVE5HX1VTVF9UUkFDRVBPSU5UX0RFRklORSBkZWZp
bmVkIGNhc2UgdG8gZW5zdXJlIHN5bWJvbHMgYXJlIG5vdAo+ICAgICAgZHVwbGljYXRlZC4KPgo+
ICAgICAgU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KPiAgICAgIENoYW5nZS1JZDogSTBlZjcyMDQzNTAwM2E3Y2EwYmZjZjI5
ZDdiZjI3ODY2YzVmZjg2NzgKPgoKSSBhcHBsaWVkIHRoaXMgcGF0Y2ggYW5kIGlmIEkgdXNlICJ0
cmFjZWYiIHR5cGUgY2FsbHMgaW4gb3VyCmFwcGxpY2F0aW9uIHRoYXQgaXMgbWFkZSB1cCBvZiBh
IGJ1bmNoIG9mIHN0YXRpYyBsaWJzIC4uLiB0aGUgVVNUCnRyYWNlIGNhbGxzIHdvcmsuICBJIHZl
cmlmaWVkIHRoYXQgdHJhY2VzIHRoYXQgd2VyZSBjYWxsZWQgZnJvbQpzZXZlcmFsIGRpZmZlcmVu
dCBzdGF0aWMgbGlicyBhbGwgd29ya2VkLgoKQnV0IGFzIHNvb24gYXMgSSBpbmNsdWRlIGEgInRy
YWNlcG9pbnQiIHN0eWxlIHRyYWNlcG9pbnQgKHRoYXQgdXNlcwp0cmFjZSBwcm92aWRlciBpbmNs
dWRlIGZpbGVzIGV0Yy4pIHRoZW4gZG9pbmcgYSAibHR0bmcgbGlzdCAtdSIKcmV0dXJucyAiTm9u
ZSIgZm9yIFVTVCBldmVudHMuCgpJcyB0aGVyZSBzb21lIGtpbmQgb2YgcnVsZSB0aGF0IHNheXMg
YSBmaWxlIGNhbid0IHVzZSBib3RoIHRyYWNlZiBhbmQKdHJhY2Vwb2ludCBjYWxscz8gIElzIHRo
ZXJlIHNvbWV0aGluZyBzcGVjaWFsIHlvdSBoYXZlIHRvIGRvIHRvIHVzZQp0cmFjZWYgYW5kIHRy
YWNlcG9pbnRzIGluIHNhbWUgZmlsZT8gIERvaW5nIHNvIGFwcGVhcnMgdG8gaGF2ZSBicm9rZW4K
ZXZlcnl0aGluZy4KClRoYW5rcywKCkJyaWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
