Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890AFC76195
	for <lttng-dev@archiver.kernel.org>; Mon, 27 Mar 2023 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679920011;
	bh=2tnBhIHSwDlUE/EOUiJlKzFrEPa6FlRGtezZspbDgLE=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=wAYLYSG/PvINW8Yn36aEHfllrTsBoSJ5j87QBsh3nkFWaIB6Wc02F+OjK+fkroJKY
	 kCybqpVZjb6laBZP4KVWkl68kZxxl5l0HiRYayuYXWt9KbOGDtKqQ3T6Hb3M/fug1V
	 cJJR3AWGCDbXU6joFrHHcj/YQQwnEDJGrLrt9oyvbgWLsHfdpSSkTfN/prATKL/wij
	 yI/8Lg7sn5LR5ZX4QfUD9WjikYmhQ++d2tyi/0vJfLHJK4oe8Fm9p3eH+g7TPWW3sI
	 64j9a0vIdyuQg2oQW7yN6QVs/a712gqfDJmGkos7spYVZWul8DQj9jb7vH0sXCaabS
	 KUvnpbqbFJIjg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PlXB22pm1z2K83;
	Mon, 27 Mar 2023 08:26:50 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PlXB02Ppsz2K1Q
 for <lttng-dev@lists.lttng.org>; Mon, 27 Mar 2023 08:26:48 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PlX9z4H7Gzt7L;
 Mon, 27 Mar 2023 08:26:47 -0400 (EDT)
Message-ID: <3056c476-0e3a-8cde-39e4-907602d26d76@efficios.com>
Date: Mon, 27 Mar 2023 08:27:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: yashvardhan kukreti <yashvardhankukreti@gmail.com>
References: <CALx39aqN_YvfcDhhKgURZZU-bWZvuiZptbb-kJDYerEex9Q-7A@mail.gmail.com>
 <CALx39arqYKMj_M1q_XDBfCSrSruJ5obUuNHeN4Cu7a1sVDwwbw@mail.gmail.com>
In-Reply-To: <CALx39arqYKMj_M1q_XDBfCSrSruJ5obUuNHeN4Cu7a1sVDwwbw@mail.gmail.com>
Subject: Re: [lttng-dev]
 https://lists.lttng.org/pipermail/lttng-dev/2020-May/029631.html
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
Cc: lttng-dev@lists.lttng.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wMy0yNiAxMTowMCwgeWFzaHZhcmRoYW4ga3VrcmV0aSB3cm90ZToKPiAKPiAgICAg
SGkgTWF0aGV3LAo+IAo+ICAgICBJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0aGlzIHBhdGNoIGZv
ciBsdHRuZy1tb2R1bGVzIGFuZCB0aGUgdXNlIG9mCj4gICAgIHJlZ2lzdGVyX2twcm9iZSgpIHRv
IGZldGNoIHRoZSBmdW5jdGlvbiBwdHIuCj4gICAgIFRoZSBxdWVzdGlvbiBpbiB0aGlzIHJlZ2Fy
ZCBpcyBlc3BlY2lhbGx5IGZyb20gUFBDNjQgRUxGX0FCSV92MQo+ICAgICBwZXJzcGVjdGl2ZS4K
PiAKPiAgICAgVGhlIGZ1bmN0aW9ucyBvbiBQUEM2NCBhcmUgYWNjZXNzZWQgdmlhIHRoZSBGdW5j
dGlvbiBkZXNjcmlwdG9yCj4gICAgIHdoaWxlIHdoYXQgcmVnaXN0ZXJfa3Byb2JlcyByZXR1cm5z
IGlzIHRoZSBlbnRyeSBwb2ludCBvZiB0aGUgZnVuY3Rpb24uCj4gICAgIEhlbmNlIHVzaW5nIHRo
ZSByZXR1cm4gcG9pbnRlciB0ZW5kcyB0byBpbnRlcnByZXTCoHRoZSBhZGRyIGFzIHRoZQo+ICAg
ICBhZGRyZXNzIG9mIHRoZSBmdW5jdGlvbiBkZXNjcmlwdG9ywqBhbmQgZGVyZWZlcmVuY2VzIHRo
ZSBwcGNfaW5zdCBhcwo+ICAgICB0aGUgZnVuY3Rpb24gZW50cnnCoHBvaW50wqBhbmQgY3Jhc2hl
cwo+IAo+ICAgICBbIDQxNDUuNDgzNTk0XSBrZXJuZWwgdHJpZWQgdG8gZXhlY3V0ZSBleGVjLXBy
b3RlY3RlZCBwYWdlCj4gICAgICg3YzA4MDJhNmZiODFmZmUwKSAtIGV4cGxvaXQgYXR0ZW1wdD8g
KHVpZDogMCkKPiAgICAgaGVyZSA3YzA4MDJhNiBpcyB0aGUgbWZzcHIgaW5zdHJ1Y3Rpb24gZnJv
bSB0aGUgY29kZSB0ZXh0IHNlY3Rpb24gb2YKPiAgICAgdGhlIGthbGxzeW1zX2xvb2t1cF9uYW1l
KCkKPiAKPiAgICAgbm90ZSBmb3IgUFBDX0VMRl9BQklfdjEgdGhlIHJlZ2lzdGVyX2twcm9iZXMo
KSBzZWFyY2hlcyBmb3IgdGhlIGRvdAo+ICAgICB2YXJpYW50IG9mIHRoZSBzeW1ib2wgYW5kIG9u
bHkgaW4gY2FzZSBpZiBjYW5ub3QgZmluZCB0aGUgZG90Cj4gICAgIHZhcmlhbnQgbG9va3MgZm9y
IHRoZSBub3JtYWwgc3ltYm9sLgo+ICAgICByZWdpc3Rlcl9rcHJvYmUoKSAtPiBrcHJvYmVfYWRk
cigpIC0+IGtwcm9iZV9sb29rdXBfbmFtZSgpIFthcmNoCj4gICAgIHZhcmlhbnQgcmVwbGFjZXMg
d2VhayBzeW1ib2xdCj4gICAgIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjEw
LjE3NC9DL2lkZW50L2twcm9iZV9sb29rdXBfbmFtZSA8aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjUuMTAuMTc0L0MvaWRlbnQva3Byb2JlX2xvb2t1cF9uYW1lPgo+IAo+ICAgICBQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgaSBtYWtlIHNlbnNlIG9yIHRoYXQgaSBtYXkgaGF2ZSBtaXNz
ZWQgc29tZXRoaW5nLgo+IAo+ICAgICBJIGhhdmUgbG9va2VkIGF0IHRoZSBjb2RlIG9mIDIuMTIu
OCBhcyB3ZWxsIGFuZCAyLjEyLjMgdmVyc3Rpb24gb2YKPiAgICAgbHR0bmctbW9kdWxlcy4KClBs
ZWFzZSBoYXZlIGEgbG9vayBhdCBjb21taXRzIChmcm9tIHN0YWJsZS0yLjEyIGJyYW5jaCBvZiBs
dHRuZy1tb2R1bGVzKToKCmNvbW1pdCA1Mzc3MmRiMjRmYWNkODRmMWYzZGRjZjIxYTFlZjVmMTYy
NjA4NzIxCkF1dGhvcjogSGUgWmhlIDx6aGUuaGVAd2luZHJpdmVyLmNvbT4KRGF0ZTogICBUdWUg
U2VwIDI3IDE1OjU5OjQyIDIwMjIgKzA4MDAKCiAgICAgd3JhcHBlcjogcG93ZXJwYzY0OiBmaXgg
a2VybmVsIGNyYXNoIGNhdXNlZCBieSBkb19nZXRfa2FsbHN5bXMKCmNvbW1pdCA4ZmU4ODhkODZj
Y2FkNDIyNmIwNWE1MzZlZmI3M2Q3MWJiMDkxMDYyCkF1dGhvcjogTWljaGFlbCBKZWFuc29uIDxt
amVhbnNvbkBlZmZpY2lvcy5jb20+CkRhdGU6ICAgVGh1IE5vdiAyNCAxNDoyNTozMyAyMDIyIC0w
NTAwCgogICAgIGZpeDoga2FsbHN5bXMgd3JhcHBlciBvbiBwcGM2NGVsCgpJIHN1c3BlY3QgeW91
J2xsIGFsc28gbmVlZCB0aGlzIGNoYW5nZSBjdXJyZW50bHkgaW4gcmV2aWV3OgoKaHR0cHM6Ly9y
ZXZpZXcubHR0bmcub3JnL2MvbHR0bmctbW9kdWxlcy8rLzkxMTMKClBsZWFzZSBsZXQgdXMga25v
dyBpZiBlc3BlY2lhbGx5IHRoaXMgbGFzdCBjaGFuZ2UgZml4ZXMgdGhpbmdzIG9uIHlvdXIgc2lk
ZS4KClRoYW5rcywKCk1hdGhpZXUKCgo+IAo+ICAgICBSZWdhcmRzLAo+ICAgICBTaGFzaGFuawo+
IAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNp
b3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
