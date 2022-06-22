Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A455C433EF
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jun 2022 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655929707;
	bh=RzLPcdmgFU51WfPt9o/Li3RoDFb1ZpTVm5u3PyoRyNM=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xEuJpNooEBFkctM7hdj5PbLchdvHKWqqQakmN5v9WuW5yYdB9kKuzhw83PtDQQQML
	 eMeetYafaUo7K0KQyDYA5pKh1J1c23MwxQtpTmdQN6df6rc6XUiHTFiS3REh3Q1M0U
	 Y5SwTLEoogr+PumPCyLNX/eBN+vSH2VB814dayJCcX/1auZOnHeyTOgyfOHJ3jAccG
	 gw5BHtc1rYoglVRR/jUiKBTSWLkvpzV612Wg67p3oBME4FrCK6pHHhwhBv/8MPdQvk
	 DQtUH1wVZxtVbvFsE7YLflToxc0Z+VnKjxCd7sJQ5hylectjt2e30pqNwgIxQAzcph
	 W53/9PWw6k06w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LSw2234nCzDZY;
	Wed, 22 Jun 2022 16:28:26 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LSw204h2dzCVG
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2022 16:28:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 79C513ABDD4
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2022 16:28:24 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id jRsSO905hwvw; Wed, 22 Jun 2022 16:28:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 039AF3ABADC;
 Wed, 22 Jun 2022 16:28:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 039AF3ABADC
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wWhGZsW06c-8; Wed, 22 Jun 2022 16:28:23 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id EB8F13ABD32;
 Wed, 22 Jun 2022 16:28:23 -0400 (EDT)
Date: Wed, 22 Jun 2022 16:28:23 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <1779693726.26841.1655929703853.JavaMail.zimbra@efficios.com>
In-Reply-To: <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
References: <20220614035533.GA174967@localhost.localdomain>
 <396090936.61897.1655302558168.JavaMail.zimbra@efficios.com>
 <20220616080912.GA246781@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
 <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
 <20220622074535.GA269641@localhost.localdomain>
 <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: ***UNCHECKED*** Re: Re: urcu workqueue thread uses 99% of cpu
 while workqueue is empty
Thread-Index: /dYvM5tb7eJkihrmAnXa3+eAc0+3EPpIC4W+
Subject: Re: [lttng-dev] ***UNCHECKED*** Re: Re: urcu workqueue thread uses
 99% of cpu while	workqueue is empty
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LS0tLS0gT24gSnVuIDIyLCAyMDIyLCBhdCA5OjE5IEFNLCBNYXRoaWV1IERlc25veWVycyBtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IC0tLS0tIE9uIEp1biAyMiwgMjAy
MiwgYXQgMzo0NSBBTSwgTWlubGFuIFdhbmcgd2FuZ21pbmxhbkBzenNhbmRzdG9uZS5jb20gd3Jv
dGU6Cj4gCj4gWy4uLl0KPiAKPiBIaSBNaW5sYW4sCj4gCj4+IC0tCj4+IDEuOC4zLjEKPj4gCj4+
IAo+PiBBbmQgdGhlIGx0dG5nIHNlc3Npb24gaXMgY29uZmlndXJlZCB0byB0cmFjZSB0aGVzZSBl
dmVudHM6Cj4+IGtlcm5lbDogc3lzY2FsbCBmdXRleAo+IAo+IE9uIHRoZSBrZXJuZWwgc2lkZSwg
aW4gYWRkaXRpb24gdG8gdGhlIHN5c2NhbGwgZnV0ZXgsIEkgd291bGQgcmVhbGx5IGxpa2UgdG8g
c2VlCj4gd2hhdAo+IGhhcHBlbnMgaW4gdGhlIHNjaGVkdWxlciwgbWFpbmx5IHRoZSB3YWl0L3dh
a2V1cCB0cmFjZXBvaW50cy4gVGhpcyBjYW4gYmUgYWRkZWQKPiBieSB1c2luZzoKPiAKPiBsdHRu
ZyBlbmFibGUtZXZlbnQgLWsgJ3NjaGVkXyonCj4gCj4gVGhpcyBzaG91bGQgaGVscCB1cyBjb25m
aXJtIHdoZXRoZXIgd2UgaW5kZWVkIGhhdmUgYSBzaXR1YXRpb24gd2hlcmUgcXVldWVkIHdha2UK
PiB1cHMKPiBoYXBwZW4gdG8gd2FrZSB1cCBhIHdhaXQgaGFwcGVuaW5nIG9ubHkgbGF0ZXIsIHdo
aWNoIGlzIHVuZXhwZWN0ZWQgYnkgdGhlCj4gY3VycmVudCBsaWJ1cmN1Cj4gdXNlcnNwYWNlIGNv
ZGUuCj4gCj4gWy4uLl0KPiAKPj4gLS0tCj4+IAo+PiBUaGUgYmFibGV0cmFjZSBvdXRwdXQgb2Yg
dGhpcyBzZXNzaW9uIGlzIHByZXR0eSBiaWcsIDYgTUIgaW4gc2l6ZSwgaSBwdXQgaXQgaW4KPj4g
dGhlIGF0dGFjaG1lbnQgdHJhY2VfMDYyMi50YXIuYnoyLgo+PiBMZXQgbXkga25vdyBpZiB5b3Vy
IG1haWxib3ggY2FuJ3QgaGFuZGxlIHN1Y2ggYmlnIGF0dGFjaG1lbnQuCj4gCj4gSXQgd291bGQg
YmUgZXZlbiBiZXR0ZXIgaWYgeW91IGNhbiBzaGFyZSB0aGUgYmluYXJ5IHRyYWNlLCBiZWNhdXNl
IHRoZW4gaXQncwo+IGVhc3kgdG8KPiBsb2FkIGl0IGluIHRyYWNlIGNvbXBhc3MsIGN1dCBhd2F5
IHRpbWUgcmFuZ2VzIHRoYXQgZG9uJ3QgbWF0dGVyLCBhbmQgbG90cyBvZgo+IG90aGVyCj4gdXNl
ZnVsIHN0dWZmLgoKSSBqdXN0IGZvdW5kIHRoZSByZWxldmFudCBzbmlwcGV0IG9mIGRvY3VtZW50
YXRpb24gaW4gZnV0ZXgoNSk6CgogICAgICAgRlVURVhfV0FJVAogICAgICAgICAgICAgIFJldHVy
bnMgMCBpZiB0aGUgY2FsbGVyIHdhcyB3b2tlbiB1cC4gIE5vdGUgdGhhdCBhICB3YWtlLXVwICBj
YW4KICAgICAgICAgICAgICBhbHNvICBiZSBjYXVzZWQgYnkgY29tbW9uIGZ1dGV4IHVzYWdlIHBh
dHRlcm5zIGluIHVucmVsYXRlZCBjb2RlCiAgICAgICAgICAgICAgdGhhdCBoYXBwZW5lZCB0byBo
YXZlIHByZXZpb3VzbHkgdXNlZCB0aGUgIGZ1dGV4ICB3b3JkJ3MgIG1lbW9yeQogICAgICAgICAg
ICAgIGxvY2F0aW9uICAoZS5nLiwgdHlwaWNhbCBmdXRleC1iYXNlZCBpbXBsZW1lbnRhdGlvbnMg
b2YgUHRocmVhZHMKICAgICAgICAgICAgICBtdXRleGVzIGNhbiBjYXVzZSB0aGlzIHVuZGVyIHNv
bWUgY29uZGl0aW9ucykuICBUaGVyZWZvcmUsIGNhbGzigJAKICAgICAgICAgICAgICBlcnMgc2hv
dWxkIGFsd2F5cyBjb25zZXJ2YXRpdmVseSBhc3N1bWUgdGhhdCBhIHJldHVybiB2YWx1ZSBvZiAw
CiAgICAgICAgICAgICAgY2FuIG1lYW4gYSBzcHVyaW91cyB3YWtlLXVwLCBhbmQgIHVzZSAgdGhl
ICBmdXRleCAgd29yZCdzICB2YWx1ZQogICAgICAgICAgICAgIChpLmUuLCAgdGhlIHVzZXItc3Bh
Y2Ugc3luY2hyb25pemF0aW9uIHNjaGVtZSkgdG8gZGVjaWRlIHdoZXRoZXIKICAgICAgICAgICAg
ICB0byBjb250aW51ZSB0byBibG9jayBvciBub3QuCgpJJ20gcHJldHR5IHN1cmUgdGhpcyBpcyB3
aGF0IGlzIGhhcHBlbmluZyBoZXJlLgoKVGhhbmtzLAoKTWF0aGlldQoKCj4gCj4gVGhhbmtzLAo+
IAo+IE1hdGhpZXUKPiAKPiAtLQo+IE1hdGhpZXUgRGVzbm95ZXJzCj4gRWZmaWNpT1MgSW5jLgo+
IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1Mg
SW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
