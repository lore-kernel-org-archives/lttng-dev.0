Return-Path: <SRS0=bdJV=HL=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17E5C433DB
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Feb 2021 21:26:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA53A601FE
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Feb 2021 21:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA53A601FE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DZwtg17Jjz19dw;
	Tue,  9 Feb 2021 16:26:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612905980;
	bh=FHLgVKsn7YP07vEonioJnF6G5mUdf9nfNbpQN/QDOS0=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wYAWH3QOv84uNXKNMGwuZU6jU98r8paj11j11ijB4hNkB+W/5LCvSvf0vGKUF5+1L
	 BDAPoaFg8YJWGWa0p68W0z4ISbwDU981oOmEz0I8onGwQ/XJSCJbj4HSqIUi/tdRsc
	 bm/pn7doDK9qpGn1pHNM1nmPFeDcqc74LSjYpGmxI8fyC0vETwOxSNPzjGs7ZEC0Vb
	 TzgtmGIqf06T0/YB39rrKUMa8oS2AD7hIZX7F/dsWOSwwqNsL8DADylJaUKacPUzYB
	 dYbBVl6Ka5NnL3g65fPl2XzhQJO+RKNCi8tusXjyKK/Hz3kqnX3FPA5mWLVqXvxoKH
	 79FoQ3HrXy0Iw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DZwtd2Y0cz19Pt
 for <lttng-dev@lists.lttng.org>; Tue,  9 Feb 2021 16:26:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9D32D2E3A67
 for <lttng-dev@lists.lttng.org>; Tue,  9 Feb 2021 16:26:16 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id XyOc8Av8HVbH; Tue,  9 Feb 2021 16:26:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 34DED2E3CCA;
 Tue,  9 Feb 2021 16:26:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 34DED2E3CCA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id p_1uUhueAvW1; Tue,  9 Feb 2021 16:26:16 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2993C2E3EA9;
 Tue,  9 Feb 2021 16:26:16 -0500 (EST)
Date: Tue, 9 Feb 2021 16:26:16 -0500 (EST)
To: jderehag <jderehag@hotmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <850018908.13039.1612905976059.JavaMail.zimbra@efficios.com>
In-Reply-To: <AM4PR05MB31530BB10FFB0D30228D46B0DDB99@AM4PR05MB3153.eurprd05.prod.outlook.com>
References: <1389106165.6573.1611674358449.JavaMail.zimbra@efficios.com>
 <AM4PR05MB31530BB10FFB0D30228D46B0DDB99@AM4PR05MB3153.eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: Community input: Feedback on use of enumeration type within
 LTTng-UST
Thread-Index: 5+AEU0e4tawuTd2JT3Ht+0f1na3RkO3j9o3WzoItZsM=
Subject: Re: [lttng-dev] Community input: Feedback on use of enumeration
 type within LTTng-UST
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgSmVzcGVyLAoKV2UgY3VycmVudGx5IGRvbid0IGhhdmUgYW55dGhpbmcgaW4gcGxhY2UgdG8g
YWxsb3cgc2hhcmluZyBhIGdpdmVuIGVudW1lcmF0aW9uCmFjcm9zcyBtdWx0aXBsZSB0cmFjZXBv
aW50IHByb3ZpZGVycy4gSG93ZXZlciwgeW91IGFyZSBub3QgdGhlIGZpcnN0IG9uZSB0bwpleHBy
ZXNzIHRoZSBuZWVkIGZvciBpdC4KCk9uZSB3YXkgSSBmaWd1cmUgd2UgY291bGQgZG8gdGhpcyB3
b3VsZCBiZSB0byBpbnRyb2R1Y2UgdGhlIG5vdGlvbiBvZgoicHJvYmUgcHJvdmlkZXIgZGVwZW5k
ZW5jeSIgaW4gbHR0bmctdXN0LiBUaGUgYmFzaWMgaWRlYSBpcyB0byBoYXZlIHRoZQplbnVtZXJh
dGlvbiB3aXRoaW4gYSBwcm9iZSBwcm92aWRlciB3aGljaCB3b3VsZCBiZSByZWZlcnJlZCB0byBh
cyBhCiJkZXBlbmRlbmN5IiBieSBvdGhlciB0cmFjZXBvaW50IHByb2Jlcy4gV2UgY291bGQgYWxz
byBkbyBzb21lIHNoYXJpbmcKb2YgdHJhY2Vwb2ludCBldmVudCBjbGFzcyBkZWNsYXJhdGlvbnMg
YXMgd2VsbCBpZiBuZWVkZWQgaW4gYSBzaW1pbGFyCndheS4KClRoZSB1cGdyYWRlIHNjZW5hcmlv
IHByb2JsZW0geW91IGhpZ2hsaWdodCBpcyBub3Qgc3BlY2lmaWMgdG8gZW51bWVyYXRpb25zLgpJ
dCBhbHNvIGFwcGxpZXMgdG8gZXZlbnRzIGJlaW5nIGNoYW5nZWQgd2hlbiB1cGdyYWRpbmcgYSB0
cmFjZXBvaW50IHByb2JlCnByb3ZpZGVyLgoKRm9yIGV2ZW50cywgdGhlIHdheSB3ZSBtYXRjaCB0
aGVtIHdpdGhpbiB0aGUgc2Vzc2lvbiBkYWVtb24gKGh0X21hdGNoX2V2ZW50KQppcyBieSBjb21w
YXJpbmcgdGhlaXIgZW50aXJlIGRlc2NyaXB0aW9uIGZvciBhbiBleGFjdCBtYXRjaDogdGhleSBu
ZWVkIHRvCmhhdmUgYWxsIHRoZSBzYW1lIGZpZWxkcy4gSWYgdHdvIGV2ZW50cyBoYXBwZW4gdG8g
aGF2ZSB0aGUgc2FtZSBuYW1lIGJ1dApkaWZmZXJlbnQgZmllbGRzIChkdWUgdG8gYW4gdXBncmFk
ZSBpbiBzb21lIGFwcGxpY2F0aW9ucyBidXQgbm90IG90aGVycyksCnRoZXkgd2lsbCBiZSByZXBy
ZXNlbnRlZCBieSBkaWZmZXJlbnQgZXZlbnQgSURzIHdpdGhpbiB0aGUgbWV0YWRhdGEuIFRoaXMK
YWxsb3dzIHVzIHRvIG1ha2Ugc3VyZSBlYWNoIGV2ZW50IGhhcyBhIHVuaXF1ZSBldmVudCBJRCB3
aXRoaW4gYSB0cmFjZSBpZgp0aGV5IGhhdmUgZGlmZmVyZW50IGNvbnRlbnQsIGV2ZW4gaWYgdGhl
eSBoYXZlIHRoZSBzYW1lIG5hbWUgKGUuZy4gdXBncmFkZQpzY2VuYXJpbykuCgpXaGVuIGRlYWxp
bmcgd2l0aCBlbnVtZXJhdGlvbiB0eXBlcyBpbiB0aGUgdXN0IHJlZ2lzdHJ5IHdpdGhpbiBsdHRu
Zy1zZXNzaW9uZCwKd2UgYWxyZWFkeSBkbyBzb21ldGhpbmcgc2ltaWxhciAoaHRfbWF0Y2hfZW51
bSk6IHdlIGNoZWNrIHRoYXQgYWxsIGxhYmVscyBtYXRjaC4KClNvIEkgdGhpbmsgdGhhdCB0aGUg
b25seSBwYXJ0IHdlIGFyZSBtaXNzaW5nIGlzIHJlYWxseSBhdCB0aGUgVVNUIHByb2JlIHByb3Zp
ZGVyCmxldmVsOiBhZGRpbmcgdGhlIGFiaWxpdHkgdG8gZXhwcmVzcyBkZXBlbmRlbmN5IGZyb20g
cHJvdmlkZXIgQSBvbiBhbiBlbnVtZXJhdGlvbgpkZWZpbmVkIGJ5IHByb3ZpZGVyIEIuIFRoZSBy
ZXN0IG9mIHRoZSBsb2dpYyBpcyBhbHJlYWR5IHRoZXJlIGluIHRoZSBzZXNzaW9uIGRhZW1vbgp0
byBhbGxvdyByZWZlcmVuY2UgdG8gYW4gZW51bWVyYXRpb24gZnJvbSB2YXJpb3VzIGV2ZW50IGZp
ZWxkcyB3aXRoaW4gYSBzaW5nbGUgcHJvYmUKcHJvdmlkZXIuCgpUaGFua3MsCgpNYXRoaWV1Cgot
LS0tLSBPbiBKYW4gMjksIDIwMjEsIGF0IDEwOjA3IEFNLCBqZGVyZWhhZyBqZGVyZWhhZ0Bob3Rt
YWlsLmNvbSB3cm90ZToKCj4gSGksCj4gCj4gSSBkb250IGhhdmUgYW55IGRhdGEgcmVnYXJkaW5n
IGVudW0gdXNhZ2UgdW5mb3J0dW5hdGx5Lgo+IAo+IEJ1dCBpcyBpdCBwb3NzaWJsZSB0byBzaGFy
ZSBtZXRhZGF0YSBiZXR3ZWVuIG11bHRpcGxlIHRwLXByb3ZpZGVycz8KPiBJZiBzbywgd291bGQg
eW91IG5vdCBiZSByZXF1aXJlZCBhbnl3YXkgdG8gcmUtZ2VuZXJhdGUgdGhlIGVudW1lcmF0aW9u
IGxhYmVscwo+IGdpdmVuIHRoYXQgYW55IHRyYWNlIHByb2R1Y2VyIChzaGFyaW5nIHRoZSBzYW1l
IG1ldGFkYXRhKSBtYXkgaGF2ZSBkaWZmZXJlbnQKPiBlbnVtZXJhdGlvbiBkZWZpbml0aW9ucz8K
PiBGb3IgZXhhbXBsZSBpZiB5b3Ugd291bGQgbGV0cyBzYXkgdHJhY2UgZGlmZmVyZW50IHZlcnNp
b25zIG9mIHRoZSBzYW1lIGFwcCBidXQKPiB3aGVyZSB0aGUgZW51bSBkZWZpbml0aW9uIGhhdmUg
Y2hhbmdlZD8KPiBDYXNlcyBsaWtlIHRob3NlIEkgZ3Vlc3Mgd291bGQgZm9yY2UgeW91IHRvIGF0
bGVhc3QgdmVyc2lvbiBlbnVtIGxhYmVscyBvcgo+IHNvbWVzdWNoPwo+IAo+IC9KZXNwZXIKPiAK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gRnLDpW46IGx0dG5n
LWRldiA8bHR0bmctZGV2LWJvdW5jZXNAbGlzdHMubHR0bmcub3JnPiBmw7ZyIE1hdGhpZXUgRGVz
bm95ZXJzIHZpYQo+IGx0dG5nLWRldiA8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4KPiBTa2lj
a2F0OiBkZW4gMjYgamFudWFyaSAyMDIxIDE2OjE5Cj4gVGlsbDogbHR0bmctZGV2Cj4gw4RtbmU6
IFtsdHRuZy1kZXZdIENvbW11bml0eSBpbnB1dDogRmVlZGJhY2sgb24gdXNlIG9mIGVudW1lcmF0
aW9uIHR5cGUgd2l0aGluCj4gTFRUbmctVVNUCj4gCj4gSGksCj4gCj4gV2UgYXJlIGN1cnJlbnRs
eSB3b3JraW5nIG9uIHRoZSBDVEYyIHNwZWNpZmljYXRpb24gWzFdIGF0IEVmZmljaU9TLCBhbmQg
dGhlcmUgaXMKPiBhIHVzZXIgbWV0cmljIHdlIHdvdWxkIG5lZWQgdG8gaGVscCB1cyB3aXRoIGEg
ZGVzaWduIGRlY2lzaW9uIHdpdGggcmVzcGVjdAo+IHRvIGVudW1lcmF0aW9ucy4gVGhpcyBpcyB3
aGVyZSB3ZSB3b3VsZCBuZWVkIGNvbW11bml0eSBpbnB1dC4KPiAKPiBUaGUgdXNhZ2UgbWV0cmlj
cyBpbiBxdWVzdGlvbiBhcmUgd2l0aCByZXNwZWN0IHRvIExUVG5nLVVTVCBlbnVtZXJhdGlvbiB0
eXBlcwo+IChUUkFDRVBPSU5UX0VOVU0pIFsyXSB1c2VkIGJ5IHRyYWNlcG9pbnQgZXZlbnRzIHdp
dGhpbiBpbnN0cnVtZW50ZWQKPiBhcHBsaWNhdGlvbnMuCj4gCj4gQSB0cmFjZXBvaW50IGVudW1l
cmF0aW9uIGNhbiBiZSB1c2VkIGJ5IG1hbnkgZXZlbnRzLiBXaGF0IHdlIGFyZSBsb29raW5nIGZv
ciBpcwo+IHRvIGdldAo+IGFuIGlkZWEgb2YgdGhlIGNvbW1vbiB1c2UsIGFuZCBleHRyZW1lIGNh
c2VzIGFzIHdlbGwuCj4gCj4gSWRlYWxseSwgd2hhdCB3ZSB3b3VsZCBuZWVkIGlzOgo+IAo+IC0g
Rm9yIGVhY2ggZW51bWVyYXRpb24gd2l0aGluIHlvdXIgYXBwbGljYXRpb24gaW5zdHJ1bWVudGF0
aW9uCj4gKFRSQUNFUE9JTlRfRU5VTSksIGhvdwo+ICBtYW55IGV2ZW50cyByZWZlciB0byBlYWNo
IGVudW1lcmF0aW9uID8gKGF2ZXJhZ2UsIG1vZGUsIGFuZCBtYXhpbXVtKQo+IC0gRm9yIGVhY2gg
VFJBQ0VQT0lOVF9FTlVNLCBob3cgbWFueSBsYWJlbHMgZG8gdGhleSBwb3NzZXNzID8gKHN1bSBu
dW1iZXIgb2YKPiAgY3RmX2VudW1fdmFsdWUvY3RmX2VudW1fcmFuZ2UvY3RmX2VudW1fYXV0byBl
bnRyaWVzKSAoYXZlcmFnZSwgbW9kZSwgYW5kCj4gIG1heGltdW0pCj4gLSBGb3IgZWFjaCBUUkFD
RVBPSU5UX0VOVU0sIGZvciBlYWNoIGxhYmVsLCB3aGF0IGlzIHRoZSBzdHJpbmcgbGVuZ3RoID8K
PiAoYXZlcmFnZSwgbW9kZSwgYW5kIG1heGltdW0pCj4gCj4gQmFzZWQgb24gdGhpcyBpbmZvcm1h
dGlvbiwgd2UgY2FuIGVzdGltYXRlIHRoZSBkYXRhIG92ZXJoZWFkIGdlbmVyYXRlZCBieQo+IHJl
cGVhdGluZyBlbnVtZXJhdGlvbgo+IGxhYmVscyBpbiB0aGUgTFRUbmctVVNUIG1ldGFkYXRhLiBX
ZSBuZWVkIHRvIGRlY2lkZSB3aGV0aGVyIHdlIGFsbG93IHJlZmVyZW5jZXMKPiB0byBhIHNpbmds
ZQo+IGVudW1lcmF0aW9uIGRlc2NyaXB0aW9uIHdoZW4gaXQgaXMgdXNlZCBieSBtYW55IGV2ZW50
cywgb3IgaWYgd2UgcmVxdWlyZQo+IHJlcGVhdGVkbHkgc2VyaWFsaXppbmcKPiB0aGUgZW50aXJl
IGVudW1lcmF0aW9uIGRlc2NyaXB0aW9uIGZvciBlYWNoIGV2ZW50IGZpZWxkIHVzaW5nIHRoZSBl
bnVtZXJhdGlvbi4KPiAKPiBUaGFua3MsCj4gCj4gTWF0aGlldQo+IAo+IFsxXSBodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9waXBlcm1haWwvbHR0bmctZGV2LzIwMjAtTm92ZW1iZXIvMDI5Nzc3Lmh0
bWwKPiBbMl0gaHR0cHM6Ly9sdHRuZy5vcmcvbWFuLzMvbHR0bmctdXN0L3YyLjEyLyNkb2MtdHJh
Y2Vwb2ludC1lbnVtCj4gCj4gLS0KPiBNYXRoaWV1IERlc25veWVycwo+IEVmZmljaU9TIEluYy4K
PiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpo
dHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
