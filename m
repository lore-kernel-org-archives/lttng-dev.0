Return-Path: <SRS0=qetO=6N=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA6CC83000
	for <lttng-dev@archiver.kernel.org>; Wed, 29 Apr 2020 16:50:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57BC208FE
	for <lttng-dev@archiver.kernel.org>; Wed, 29 Apr 2020 16:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="uzax7DlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57BC208FE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49C4JW3bw0z1nvc;
	Wed, 29 Apr 2020 12:50:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588179035;
	bh=yor4ZH+gHUgzfN5jvWstYbBGU0RWrbWVjNByLsjAKTo=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=uzax7DlQ5YK5eEs+One+SlHViv/bzh5QEBhWqC78sy0D9bnpU2Iw3QbEspMRZTOXK
	 qX5RfHuX9nPew0HNymbl1Wfr5ir7fzzauLTfwCFRk/rDy/igm2ZHdjhirpW0YJspSm
	 D7+45pQFqChXwKiUqaSiDeG0Y/gjZjPef4z2c00WCfwMvyjyWBxfrF6QrFksr2zuoh
	 MCv73gWI1IUIEcv77wHYjw8lCo0Y2pcyifE33Qn4mZDUCysTaOn4IemAThh5IbntkQ
	 +ZrPpHGHaqkLno471nrvjuW++LWwM6yOaVvM1ehjJyAT4rkPYFeF+/t3dId0mYd986
	 0ExuZGFuZU8aQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49C4JV55yWz1nm3
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2020 12:50:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 69B6E294BD7;
 Wed, 29 Apr 2020 12:50:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 6caSIRC4e3Zr; Wed, 29 Apr 2020 12:50:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0C541294999;
 Wed, 29 Apr 2020 12:50:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0C541294999
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id iSBj_0DxwSbR; Wed, 29 Apr 2020 12:50:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id F39D7294996;
 Wed, 29 Apr 2020 12:50:33 -0400 (EDT)
Date: Wed, 29 Apr 2020 12:50:33 -0400 (EDT)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <1854624569.76059.1588179033966.JavaMail.zimbra@efficios.com>
In-Reply-To: <104691146.75724.1588162084473.JavaMail.zimbra@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
 <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
 <1859708486.72922.1588099890391.JavaMail.zimbra@efficios.com>
 <104691146.75724.1588162084473.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - GC79 (Linux)/8.8.15_GA_3895)
Thread-Topic: Clarify that unlisted enum values are implementation-defined
Thread-Index: 5rnZzbaQIIrW8uKoGz/PvuDKOpUtDZMKMmtGL8qxFNku909Heg==
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>,
 gbastien+lttng <gbastien+lttng@versatic.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200429165033.wxPHvhxkFtf-G5L_j336nu145ysr-Bl_kg4vzUkij4U@z>

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJNYXRoaWV1IERlc25veWVycyIg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiBUbzogIlBoaWxpcHBlIFByb3VseCIg
PHBwcm91bHhAZWZmaWNpb3MuY29tPgo+IENjOiAiZ2Jhc3RpZW4rbHR0bmciIDxnYmFzdGllbits
dHRuZ0B2ZXJzYXRpYy5uZXQ+LCAiTWF0dGhldyBLaG91emFtIiA8bWF0dGhldy5raG91emFtQGVy
aWNzc29uLmNvbT4sICJKZXJlbWllCj4gR2FsYXJuZWF1IiA8amdhbGFyQGVmZmljaW9zLmNvbT4s
ICJsdHRuZy1kZXYiIDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiwgImRpYW1vbi1kaXNjdXNz
Igo+IDxkaWFtb24tZGlzY3Vzc0BsaXN0cy5saW51eGZvdW5kYXRpb24ub3JnPgo+IFNlbnQ6IFdl
ZG5lc2RheSwgMjkgQXByaWwsIDIwMjAgMDg6MDg6MDQKPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRD
SCBDVEYgMS8zXSBDbGFyaWZ5IHRoYXQgdW5saXN0ZWQgZW51bSB2YWx1ZXMgYXJlIGltcGxlbWVu
dGF0aW9uLWRlZmluZWQKCj4gLS0tLS0gT24gQXByIDI4LCAyMDIwLCBhdCAyOjUxIFBNLCBNYXRo
aWV1IERlc25veWVycwo+IG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbSB3cm90ZToKPiAK
Pj4gLS0tLS0gT24gQXByIDI4LCAyMDIwLCBhdCAyOjQwIFBNLCBQaGlsaXBwZSBQcm91bHggcHBy
b3VseEBlZmZpY2lvcy5jb20gd3JvdGU6Cj4+IAo+Pj4gLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAt
LS0tLQo+Pj4+IEZyb206ICJNYXRoaWV1IERlc25veWVycyIgPG1hdGhpZXUuZGVzbm95ZXJzQGVm
ZmljaW9zLmNvbT4KPj4+PiBUbzogImdiYXN0aWVuK2x0dG5nIiA8Z2Jhc3RpZW4rbHR0bmdAdmVy
c2F0aWMubmV0PiwgIk1hdHRoZXcgS2hvdXphbSIKPj4+PiA8bWF0dGhldy5raG91emFtQGVyaWNz
c29uLmNvbT4sCj4+Pj4gZGlhbW9uLWRpc2N1c3NAbGludXhmb3VuZGF0aW9uLm9yZywgcHByb3Vs
eEBlZmZpY2lvcy5jb20sICJKZXJlbWllIEdhbGFybmVhdSIKPj4+PiA8amdhbGFyQGVmZmljaW9z
LmNvbT4KPj4+PiBDYzogImx0dG5nLWRldiIgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+LCAi
TWF0aGlldSBEZXNub3llcnMiCj4+Pj4gPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
Pj4+PiBTZW50OiBUaHVyc2RheSwgMjMgQXByaWwsIDIwMjAgMTY6NTI6MjQKPj4+PiBTdWJqZWN0
OiBbUkZDIFBBVENIIENURiAxLzNdIENsYXJpZnkgdGhhdCB1bmxpc3RlZCBlbnVtIHZhbHVlcyBh
cmUKPj4+PiBpbXBsZW1lbnRhdGlvbi1kZWZpbmVkCj4+PiAKPj4+PiBGcm9tOiBHZW5ldmnDqHZl
IEJhc3RpZW4gPGdiYXN0aWVuK2x0dG5nQHZlcnNhdGljLm5ldD4KPj4+PiAKPj4+PiBTaWduZWQt
b2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4gPGdiYXN0aWVuK2x0dG5nQHZlcnNhdGljLm5ldD4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNA
ZWZmaWNpb3MuY29tPgo+Pj4+IC0tLQo+Pj4+IGNvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNh
dGlvbi5tZCB8IDMgKysrCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pj4+
IAo+Pj4+IGRpZmYgLS1naXQgYS9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNpZmljYXRpb24ubWQK
Pj4+PiBiL2NvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZAo+Pj4+IGluZGV4IGZk
NDllNTkuLmY1ZmVhNTEgMTAwNjQ0Cj4+Pj4gLS0tIGEvY29tbW9uLXRyYWNlLWZvcm1hdC1zcGVj
aWZpY2F0aW9uLm1kCj4+Pj4gKysrIGIvY29tbW9uLXRyYWNlLWZvcm1hdC1zcGVjaWZpY2F0aW9u
Lm1kCj4+Pj4gQEAgLTQ2NCw2ICs0NjQsOSBAQCBlbnVtIHsKPj4+PiB9Cj4+Pj4gfn5+Cj4+Pj4g
Cj4+Pj4gK1RoZSBtYXBwaW5ncyBpbiB0aGUgZW51bWVyYXRpb24gdHlwZSBkbyBub3QgaGF2ZSB0
byBiZSBleGhhdXN0aXZlLgo+Pj4+ICtVbmxpc3RlZCB2YWx1ZXMgYXJlIGltcGxlbWVudGF0aW9u
IGRlZmluZWQuCj4+Pj4gKwo+Pj4gCj4+PiBXaHkgbm90IGp1c3Q6Cj4+PiAKPj4+ICAgIEFuIGVu
dW1lcmF0aW9uIGZpZWxkIGNhbiBoYXZlIGFuIGludGVncmFsIHZhbHVlIHdoaWNoIGl0cyB0eXBl
IGRvZXMgbm90Cj4+PiAgICBtYXAgdG8gYSBzdHJpbmcuCj4+PiAKPj4+ID8KPj4gCj4+IEdvb2Qg
cG9pbnQsIEkgd2lsbCB1c2UgdGhhdCB3b3JkaW5nLgo+IAo+IEdlbmV2acOodmUgcG9pbnRlZCBv
dXQgb24gSVJDIHRoYXQgdGhlIHNlbnRlbmNlIGFib3ZlIGlzIHdlaXJkLiBXb3VsZCB0aGUKPiBm
b2xsb3dpbmcgY29udmV5IHRoZSByaWdodCBtZWFuaW5nID8KPiAKPiAiQW4gZW51bWVyYXRpb24g
ZmllbGQgY2FuIGhhdmUgYW4gaW50ZWdyYWwgdmFsdWUgZm9yIHdoaWNoIHRoZSBhc3NvY2lhdGVk
Cj4gZW51bWVyYXRpb24KPiB0eXBlIGRvZXMgbm90IG1hcCB0byBhIHN0cmluZy4iCgpTdXJlLgoK
UGhpbAoKPiAKPiBUaGFua3MsCj4gCj4gTWF0aGlldQo+IAo+PiAKPj4gVGhhbmtzLAo+PiAKPj4g
TWF0aGlldQo+PiAKPj4+IAo+Pj4gUGhpbAo+Pj4gCj4+Pj4gIyMjIDQuMiBDb21wb3VuZCB0eXBl
cwo+Pj4+IAo+Pj4+IENvbXBvdW5kIGFyZSBhZ2dyZWdhdGlvbiBvZiB0eXBlIGRlY2xhcmF0aW9u
cy4gQ29tcG91bmQgdHlwZXMgaW5jbHVkZQo+Pj4+IC0tCj4+PiA+IDIuMTEuMAo+PiAKPj4gLS0K
Pj4gTWF0aGlldSBEZXNub3llcnMKPj4gRWZmaWNpT1MgSW5jLgo+PiBodHRwOi8vd3d3LmVmZmlj
aW9zLmNvbQo+IAo+IC0tCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZpY2lPUyBJbmMuCj4gaHR0
cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
