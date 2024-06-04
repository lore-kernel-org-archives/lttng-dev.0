Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6BEC25B78
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Jun 2024 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1717516540;
	bh=ZlUN/x7yH5HrYz6vKx90EWqxbNuJYGoPdDnYxiFgZxk=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=On//fjHHCJxZxr9kMydbsHpuEt3gD4BiK/nwIr9tHw4mBwoxCS8k4zWXZaKHfe3Og
	 y5yTsuTES+apd7ECRC4Wdp9rA93gTq2FjWZv1PbAf77UFf3ROpXgo246O75Rs91nFx
	 MUwsJbNYVTFlckO5WbTtFUos4MqqXFVUbGGEW9FGnl+ZYIRFXUfe0akQuu+jJrH9Ew
	 09zV0t8xwi82HLQ8XSb/KI88jW5eg5kDcMU+MYfhs5AxflUlPG2sFUt8p5IghWgJc+
	 NIi+0uYMfOoXAZejMN9jge4P6VnhziMFWUPJL9EkiP5SMZN0k/1OWIEMWRSOLB5weN
	 rEPYCeZtGCzOQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VtwDD12bPz2svx;
	Tue,  4 Jun 2024 11:55:40 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4VtwDB3KMwz2sMb
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jun 2024 11:55:38 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4VtwD95qd9z12WP;
 Tue,  4 Jun 2024 11:55:37 -0400 (EDT)
Message-ID: <24624b2e-3da0-4cfe-94c6-dd451d9818df@efficios.com>
Date: Tue, 4 Jun 2024 11:56:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Wu, Yannan" <yannanwu@amazon.com>, Kienan Stewart <kstewart@efficios.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <b2e9c32fbcbe4067a64fd831bac70d81@amazon.com>
 <b974bf9f-b511-4fdb-8d67-93a6c1b273ab@efficios.com>
 <92cc12a956e1404691519a7f02b7607d@amazon.com>
 <0d226e1c-ff15-47f1-a902-bad362053903@efficios.com>
 <9c0522c7090b4523aac4166a232ca50a@amazon.com>
Content-Language: en-US
In-Reply-To: <9c0522c7090b4523aac4166a232ca50a@amazon.com>
Subject: Re: [lttng-dev] [lttng-relayd] is there existing cases for relayd
 to stream over Android usb based adb?
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

T24gMjAyNC0wNi0wNCAxMToyNSwgV3UsIFlhbm5hbiB3cm90ZToKPiBUaGUgZGV2aWNlIGlzIGEg
cm9vdGVkIGFuZHJvaWQgZGV2aWNlCj4gCj4gKk9uIHRoZSBkZXZpY2U6Kgo+IAo+IGx0dG5nLXNl
c3Npb25kIC1kIC0tbm8ta2VybmVsCj4gCj4gbHR0bmcgY3JlYXRlIG15LWxpdmUtc2Vzc2lvbiAt
LWxpdmUKPiAKPiBsdHRuZyBlbmFibGUtZXZlbnQgLXUgPG11IGN1c3RvbWl6ZWQgZXZlbnQ+Cj4g
Cj4gbHR0bmcgc3RhcnQKPiAKPiAKPiAqT24gdGhlIGhvc3Q6Kgo+IAo+IGFkYiByZXZlcnNlIHRj
cDo1MzQzIHRjcDo1MzQzCj4gCj4gVGhlIGFkYiByZXZlcnNlIHdpbGwgZmFpbCBmb3IgIi9hZGIu
ZXhlOiBlcnJvcjogY2Fubm90IGJpbmQgdG8gc29ja2V0LyIKPiAKPiAKPiBJbiB0aGUgcmV2ZXJz
ZWTCoG9yZGVyLCBpZiBzZXQgdXAgYWRiIHJldmVyc2UgZnJvbSB0aGUgaG9zdCBmaXJzdCBhbmQg
Cj4gY3JlYXRlIHRoZSBsaXZlIHNlc3Npb24gYWZ0ZXIsIGx0dG5nLXJlbGF5ZCBvbiBkZXZpY2Ug
Y2Fubm90IGJlIHN0YXJ0ZWQuCj4gSGVyZSBpcyB0aGUgZXJyb3IgbWVzc2FnZToKClRoZSAicmV2
ZXJzZSBvcmRlciIgeW91IGRlc2NyaWJlIGlzIHRoZSBvcmRlciB5b3UgbmVlZC4gV2hhdCB5b3Ug
YXJlCm1pc3NpbmcgaXMgdG8gcnVuIGx0dG5nLXJlbGF5ZCBvbiB0aGUgaG9zdCBhbmQgdG8gZm9y
d2FyZCBib3RoIHBvcnRzCjUzNDIgKmFuZCogNTM0My4gWW91IHdpbGwgYWxzbyBuZWVkIHRvIGVp
dGhlciBvdmVycmlkZSB0aGUgdGFyZ2V0IFVSTHMKZm9yIHRoZSBsaXZlIGNvbnRyb2wgYW5kIGRh
dGEgcG9ydHMgdG8gcHJldmVudCBzZXNzaW9uZCBmcm9tIGF1dG8tc3Bhd25pbmcKYSByZWxheWQs
IG9yIGZvcndhcmQgdGhlIGxpdmUgdmlld2VyIHBvcnQgYXMgd2VsbCB0aHJvdWdoIGFkYiAoNTM0
NCkuCgpPdmVyYWxsOgoKKiBGaXJzdCBvbiB0aGUgSG9zdDoKCmx0dG5nLXJlbGF5ZAphZGIgcmV2
ZXJzZSB0Y3A6NTM0MiB0Y3A6NTM0MiAgIyBjb250cm9sIHBvcnQKYWRiIHJldmVyc2UgdGNwOjUz
NDMgdGNwOjUzNDMgICMgZGF0YSBwb3J0CmFkYiByZXZlcnNlIHRjcDo1MzQ0IHRjcDo1MzQ0ICAj
IGxpdmUgdmlld2VyIHBvcnQKCiogVGhlbiBvbiB0aGUgQW5kcm9pZCBEZXZpY2U6CgpsdHRuZy1z
ZXNzaW9uZCAtZCAtLW5vLWtlcm5lbApsdHRuZyBjcmVhdGUgbXktbGl2ZS1zZXNzaW9uIC0tbGl2
ZSAtLWN0cmwtdXJsPXRjcDovL2xvY2FsaG9zdDo1MzQyIC0tZGF0YS11cmw9dGNwOi8vbG9jYWxo
b3N0OjUzNDMKbHR0bmcgZW5hYmxlLWV2ZW50IC11IDxteSBjdXN0b21pemVkIGV2ZW50PgpsdHRu
ZyBzdGFydAoKVGhlIHJlYXNvbiB3aHkgdGhlIHJlbGF5ZCBhdXRvLXNwYXduIG5lZWRzIHRvIGJl
IHByZXZlbnRlZCBpcyBiZWNhdXNlCnRoZSAibHR0bmcgY3JlYXRlIiBjb21tYW5kIGxpbmUgYXR0
ZW1wdHMgdG8gY29ubmVjdCB0byB0aGUgbG9jYWxob3N0IHJlbGF5ZAphcyBhIHZpZXdlciAoZGVm
YXVsdCBwb3J0IHRjcCA1MzQ0KS4gU28gaWYgeW91IGRvbid0IGZvcndhcmQgdGhpcwpwb3J0IGFz
IHdlbGwgdGhyb3VnaCBhZGIsIHRoZSBzZXNzaW9uZCB3aWxsIGFsd2F5cyB0cnkgdG8gYXV0by1z
cGF3bgphIHJlbGF5ZCB3aGljaCBjb25mbGljdHMgd2l0aCB5b3VyIGZvcndhcmRlZCBwb3J0cyBv
biB0aGUgQW5kcm9pZApkZXZpY2UuCgpUZWNobmljYWxseSBlaXRoZXIgZm9yd2FyZGluZyBwb3J0
IDUzNDQgb3Igc3BlY2lmeWluZyBjb250cm9sL2RhdGEKVVJMIG92ZXJyaWRlIGlzIHN1ZmZpY2ll
bnQgdG8gcHJldmVudCB0aGUgcmVsYXlkIGF1dG8tc3Bhd24sIGJ1dApJJ2QgcmVjb21tZW5kIGRv
aW5nIGJvdGggaWYgaXQgaXMgcG9zc2libGUuCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IC9QRVJS
T1IgLSAxNToyMzozMC45MTU5MzgzODcgWzk4MTMvOTgyOV06IEZhaWxlZCB0byBiaW5kIHNvY2tl
dDogQWRkcmVzcyAKPiBhbHJlYWR5IGluIHVzZSAoaW4gcmVsYXlfc29ja2V0X2NyZWF0ZSgpIGF0
IAo+IC9zcmMvVm9ka2FMdHRuZ1Rvb2wvYnVpbGQvcHJpdmF0ZS9zb3VyY2Uvc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvbWFpbi5jOjEwMzYpLwo+IC9FcnJvcjogSGVhbHRoIGVycm9yIG9jY3VycmVkIGlu
IHJlbGF5X3RocmVhZF9saXN0ZW5lci8KPiAvRXJyb3I6IEEgZmlsZSBkZXNjcmlwdG9yIGxlYWsg
aGFzIGJlZW4gZGV0ZWN0ZWQ6IDEgdHJhY2tlZCBmaWxlIAo+IGRlc2NyaXB0b3JzIGFyZSBzdGls
bCBiZWluZyB0cmFja2VkLwoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0
cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
