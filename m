Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA315C54798
	for <lttng-dev@archiver.kernel.org>; Tue,  5 Mar 2024 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1709670839;
	bh=ZKR7w9PY0d2l8a/W3pi8TABmKzpisV2PUmirSH9lgpw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=BAz7rxC/4GesEoMBizCB+AUYt+qWTzIAuNzMCKd7aB5gKdfeErs/knW6ZmLoyhFEp
	 y9g7pFQshlaZopZ++sVohV7kqf/DoMH9RTxEigQaHjAQwK/jepBbd8tpppuTi9KIdu
	 3pPR/MZzhHr/7Dh2c1bGiUycE9EZSHLqtYzz0+zzeKwwz1be6IvEl3yJ3D41kTLKXX
	 K0fvkqrf3Zm+BIEprpIzbK+f7kL89XPiT3DcLl5qBJeVIto1PhkXL1OKAVhuq0JQsz
	 CHTZeKlHhKvgP2sj4mcgYaJ2CLmZ/uuWx4wXm982KZotkeQeheHQ+uCsJHuZZ2I0ru
	 XUileGQ40xw6Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Tq6jL3t5Yz2Fps;
	Tue,  5 Mar 2024 15:33:58 -0500 (EST)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by lists.lttng.org (Postfix) with ESMTPS id 4Tq6jJ0nkyz2FmD
 for <lttng-dev@lists.lttng.org>; Tue,  5 Mar 2024 15:33:55 -0500 (EST)
Received: from mailer.emlix.com (cr-emlix.sta.goetel.net [81.20.112.87])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id AF6F15F795
 for <lttng-dev@lists.lttng.org>; Tue,  5 Mar 2024 21:27:45 +0100 (CET)
Message-ID: <3a2eeb99-0979-45b4-b309-42ddfcd40391@emlix.com>
Date: Tue, 5 Mar 2024 21:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
To: lttng-dev@lists.lttng.org
Organization: emlix GmbH
Subject: [lttng-dev] Using CRIU with LTTng-instrumented applications
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
From: =?utf-8?q?Daniel_Gl=C3=B6ckner_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksCgp3ZSBhcmUgdHJ5aW5nIHRvIHVzZSBMVFRuZyBpbiBhbiBhcHBsaWNhdGlvbiB0aGF0IHdp
bGwgYmUgZHVtcGVkIGFuZCByZXN0b3JlZAphY3Jvc3MgcmVib290cyB3aXRoIENSSVUuIFRoZSBw
cm9ibGVtIGlzIHRoYXQgQ1JJVSBpcyB1bmFibGUgdG8gcmVzdG9yZSB0aGUKdW5peCBzb2NrZXRz
IHVzZWQgdG8gY29tbXVuaWNhdGUgd2l0aCBsdHRuZy1zZXNzaW9uZCBhbmQgd291bGQgdHJ5IHRv
IHJlc3RvcmUKdGhlIGx0dG5nLXVzdC13YWl0LTggc2hhcmVkIG1lbW9yaWVzIHRvIHRoZSBjb250
ZW50cyB0aGV5IGhhZCB3aGVuIHRoZQphcHBsaWNhdGlvbiB3YXMgZHVtcGVkLiBUaGUgZ29vZCB0
aGluZyBpcyB0aGF0IG91ciBhcHBsaWNhdGlvbiBrbm93cyB3aGVuIGl0CndpbGwgYmUgZHVtcGVk
IGJ5IENSSVUgYW5kIGNvdWxkIHRlbGwgbGlibHR0bmctdXN0IHRvIHByZXBhcmUgZm9yIHRoYXQu
CgpJIHNlZSB0d28gcG9zc2liaWxpdGllczoKCjEuIERyb3AgdGhlIGNvbm5lY3Rpb24gdG8gbHR0
bmctc2Vzc2lvbmQgYW5kIGNhdGNoIHRoZSB0aHJlYWQgd2l0aCBhIG11dGV4IG9yCiAgIHNlbWFw
aG9yZSB3aGVuIGl0IHdhbnRzIHRvIGFjY2VzcyB3YWl0X3NobV9tbWFwLiBUZW1wb3JhcmlseSB1
bm1hcCB0aGUKICAgc2hhcmVkIG1lbW9yeSBhbmQgbGV0IENSSVUgZG8gaXRzIHdvcmsgYmVmb3Jl
IGFsbG93aW5nIHRoZSB0aHJlYWQgdG8KICAgY29udGludWUKCjIuIENhdXNlIHRoZSB0aHJlYWRz
IHRvIHRlcm1pbmF0ZS4gRG8gdGhlIHN0ZXBzIGRvbmUgaW4KICAgbHR0bmdfdXN0X2FmdGVyX2Zv
cmtfY2hpbGQsIGJ1dCBhbGxvdyBDUklVIHRvIGJlIGNhbGxlZCBiZWZvcmUKICAgbHR0bmdfdXN0
X2N0b3IgaXMgY2FsbGVkIGFnYWluLgoKSSBzdXNwZWN0IHRoZSB0d28gdXN0X2xpc3RlbmVyX3Ro
cmVhZCBpbnN0YW5jZXMgd2lsbCBiZSBpbiBvbmUgb2YgdHdvIHN0YXRlcwptb3N0IG9mIHRoZSB0
aW1lLiBFaXRoZXIgdGhlcmUgaXMgYSBjb25uZWN0aW9uIHRvIGx0dG5nLXNlc3Npb25kIGFuZCB0
aGUgdGhyZWFkCmlzIHdhaXRpbmcgaW5zaWRlIHVzdGNvbW1fcmVjdl91bml4X3NvY2sgb3IgdGhl
cmUgaXMgbm8gY29ubmVjdGlvbiBhbmQgdGhlCnRocmVhZCBpcyBkb2luZyBGVVRFWF9XQUlUIG9u
IHRoZSBzaGFyZWQgbWVtb3J5LiBXZSBjYW4gbWFrZSBpdCBzdG9wIHdhaXRpbmcKaW5zaWRlIHVz
dGNvbW1fcmVjdl91bml4X3NvY2sgYnkgdXNpbmcgc2h1dGRvd24oKSB3aXRoIFNIVVRfUkQgb24g
dGhlIHNvY2tldApmcm9tIGFub3RoZXIgdGhyZWFkLiBUaGUgb25seSB3YXkgdG8gaW50ZXJydXB0
IEZVVEVYX1dBSVQgd2l0aG91dCB3cml0aW5nIHRvCnRoZSBzaGFyZWQgbWVtb3J5IGlzIHByb2Jh
Ymx5IHRvIHNlbmQgYSBzaWduYWwuIEkgaGF2ZSBzZWVuIHdhcm5pbmdzIGluIHRoZQpjb2RlIGFk
dmlzaW5nIGFnYWluc3QgcHRocmVhZF9qb2luLCBidXQgSSB0aGluayB3aXRoIHNodXRkb3duKCkg
YW5kCnB0aHJlYWRfa2lsbCB3ZSBjYW4gbWFrZSB0aGUgdGhyZWFkIHJlZXZhbHVhdGUgbHR0bmdf
dXN0X2NvbW1fc2hvdWxkX3F1aXQgaW4gYQpzYWZlIHdheSAob3IgY2F1c2UgaXQgdG8gcmVhY3F1
aXJlIHRoZSBtdXRleC9zZW1hcGhvcmUgbWVudGlvbmVkIGFib3ZlIGluCnBvc3NpYmlsaXR5IDEp
LgoKQW55IHRob3VnaHRzIG9uIHRoaXM/IFdoaWNoIGRpcmVjdGlvbiBsb29rcyBtb3JlIHByb21p
c2luZz8gSXMgdGhlcmUgYW55CmNoYW5jZSB0byBnZXQgaGVscGVyIGZ1bmN0aW9ucyBsaWtlIHRo
aXMgYWNjZXB0ZWQgaW50byBsaWJsdHRuZy11c3Q/CgpCZXN0IHJlZ2FyZHMsCgogIERhbmllbAoK
Ci0tIApEaXBsLi1NYXRoLiBEYW5pZWwgR2zDtmNrbmVyLCBlbWxpeCBHbWJILCBodHRwOi8vd3d3
LmVtbGl4LmNvbQpGb24gKzQ5IDU1MSAzMDY2NC0wLCBGYXggKzQ5IDU1MSAzMDY2NC0xMSwKQmVy
bGluZXIgU3RyYcOfZSAxMiwgMzcwNzMgR8O2dHRpbmdlbiwgR2VybWFueQpTaXR6IGRlciBHZXNl
bGxzY2hhZnQ6IEfDtnR0aW5nZW4sIEFtdHNnZXJpY2h0IEfDtnR0aW5nZW4gSFIgQiAzMTYwCkdl
c2Now6RmdHNmw7xocnVuZzogSGVpa2UgSm9yZGFuLCBEci4gVXdlIEtyYWNrZQpVc3QtSWROci46
IERFIDIwNSAxOTggMDU1CgplbWxpeCAtIHlvdXIgZW1iZWRkZWQgbGludXggcGFydG5lcgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
