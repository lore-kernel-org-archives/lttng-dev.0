Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FA4C00140
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Aug 2022 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660848929;
	bh=zN1Iw1FUFo/ESbzxYFc9CdihWqyX7F30iLTppsqLNro=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DLPEh7zMoGCx+SLvAGAm+08LYiWlBb5i/QZoLHtzJi+FHhG2gZXQa9VdrRZCp4rtU
	 5vrO3oQDlwBGShvoZ26BxxqK4dZXsQx7oEBsxz6dnx/LbPm/jLhP93uNYUfKXhAZwh
	 s9GWdh39SocO9KxnCjAu4Uf4+WhoWrIuowecko8/js5MIeHgV+p9cva+nRoTGysqqp
	 xYZAx/f1qdKCp9J2/cBnrpGxaYMFSH40ew8pdvO9C22QVFE1XpGTqPCfNcJRTrcIN7
	 qdlgvVdfeB2jzQlb7dNI/ah/pqgyGo2On8+w4l4BPyqMwE5Dcn3fs1wRngBILEyg4J
	 IVK2NFajqZk7A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M7vGS30nGz1JfB;
	Thu, 18 Aug 2022 14:55:28 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M7vGQ42BRz1JYH
 for <lttng-dev@lists.lttng.org>; Thu, 18 Aug 2022 14:55:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2B1F2396673;
 Thu, 18 Aug 2022 14:55:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BLt42WffuhwE; Thu, 18 Aug 2022 14:55:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A4089396671;
 Thu, 18 Aug 2022 14:55:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A4089396671
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FkFWZYnY9O-r; Thu, 18 Aug 2022 14:55:25 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 9A3A93967B8;
 Thu, 18 Aug 2022 14:55:25 -0400 (EDT)
Date: Thu, 18 Aug 2022 14:55:25 -0400 (EDT)
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Sam Saffron <sam.saffron@gmail.com>,
 Simon Marchi <simon.marchi@efficios.com>
Message-ID: <2040534742.15368.1660848925552.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220809181927.GA3718@dcvr>
References: <20220809181927.GA3718@dcvr>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103
 (Linux)/8.8.15_GA_4372)
Thread-Topic: urcu 7ca7fe9c03 + _LGPL_SOURCE regression?
Thread-Index: oDPn0sDHxIKaQ2yNSjyBIjmdoUMiPw==
Subject: Re: [lttng-dev] urcu 7ca7fe9c03 + _LGPL_SOURCE regression?
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

LS0tLS0gT24gQXVnIDksIDIwMjIsIGF0IDI6MTkgUE0sIEVyaWMgV29uZyB2aWEgbHR0bmctZGV2
IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcgd3JvdGU6Cgo+IEhlbGxvLCBJJ3ZlIG5vdGljZWQg
bGlidXJjdSB2MC4xMS40KyBhbmQgbGF0ZXIgZmFpbHMgd2l0aCB0aGUKPiAibXdyYXAiIExEX1BS
RUxPQUQgbWFsbG9jIHdyYXBwZXIgd2hpY2ggaW5pdGlhbGl6ZXMgYW4gcmN1bGZoYXNoCj4gaW4g
YSBjb25zdHJ1Y3Rvci4KPiAKPiBUaGUgcHJvYmxlbSBoYXBwZW5zIHdoZW4gdXNpbmcgX0xHUExf
U09VUkNFICsgcmN1X2RlcmVmZXJlbmNlIG9uCj4gYSBjZHNfbGZodCBwb2ludGVyOgo+IAo+ICBJ
biBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9iL2luY2x1ZGUvdXJjdS9wb2ludGVyLmg6MzksCj4g
ICAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL2IvaW5jbHVkZS91cmN1L3VyY3UtYnAuaDo1OCwK
PiAgICAgICAgICAgICAgICAgICBmcm9tIC90bXAvYi9pbmNsdWRlL3VyY3UtYnAuaDoyLAo+ICAg
ICAgICAgICAgICAgICAgIGZyb20gLi4vN2NhN2ZlOWNfcmVncmVzc2lvbi5jOjEwOgo+ICAuLi83
Y2E3ZmU5Y19yZWdyZXNzaW9uLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6Cj4gIC90bXAvYi9p
bmNsdWRlL3VyY3Uvc3RhdGljL3BvaW50ZXIuaDoxMDE6MTg6IGVycm9yOiBpbnZhbGlkIHVzZSBv
ZiB1bmRlZmluZWQKPiAgdHlwZSDigJhzdHJ1Y3QgY2RzX2xmaHTigJkKPiAgICAxMDEgfCAgICAg
X190eXBlb2ZfXyhwICsgMCkgX19fX19fX19fcDE7ICAgIFwKPiAgICAgICAgfCAgICAgICAgICAg
ICAgICAgIF4KPiAgL3RtcC9iL2luY2x1ZGUvdXJjdS9wb2ludGVyLmg6NDc6MjY6IG5vdGU6IGlu
IGV4cGFuc2lvbiBvZiBtYWNybwo+ICDigJhfcmN1X2RlcmVmZXJlbmNl4oCZCj4gICAgIDQ3IHwg
I2RlZmluZSByY3VfZGVyZWZlcmVuY2UgIF9yY3VfZGVyZWZlcmVuY2UKPiAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fgo+ICAuLi83Y2E3ZmU5Y19yZWdy
ZXNzaW9uLmM6MjY6MjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhyY3VfZGVyZWZl
cmVuY2XigJkKPiAgICAgMjYgfCAgc3RydWN0IGNkc19sZmh0ICp0ID0gcmN1X2RlcmVmZXJlbmNl
KHRvdGFscyk7Cj4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fgo+IAo+IFJlbW92aW5nIF9MR1BMX1NPVVJDRSBhdm9pZHMgdGhlIHByb2JsZW0sIGJ1dCBJJ2Qg
cmF0aGVyIG5vdAo+IGludHJvZHVjZSBwZXJmb3JtYW5jZSByZWdyZXNzaW9ucy4KCkZpeGVkIGJ5
IGNvbW1pdHM6Cgpjb21taXQgMmQ0NjZhNjM5N2RiYzdhZjM5N2QwZmMxMGUzMjdjYzZjYWM3NmE1
YQpBdXRob3I6IFNpbW9uIE1hcmNoaSA8c2ltb24ubWFyY2hpQGVmZmljaW9zLmNvbT4KRGF0ZTog
ICBXZWQgQXVnIDE3IDExOjI0OjI1IDIwMjIgLTA0MDAKCiAgICBGaXg6IGNoYW5nZSBtZXRob2Qg
dXNlZCBieSBfcmN1X2RlcmVmZXJlbmNlIHRvIHN0cmlwIHR5cGUgY29uc3RuZXNzCgphbmQKCmNv
bW1pdCBmYWRhNjgyZjBkNmU2ODBmMThlMzI0M2FhMGFmNjA3ZGZhZmNiZDMyIChyZXZpZXcvbWFz
dGVyKQpBdXRob3I6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lv
cy5jb20+CkRhdGU6ICAgV2VkIEF1ZyAxNyAxNTozMjozOCAyMDIyIC0wNDAwCgogICAgRml4OiBh
ZGQgbWlzc2luZyB1bnVzZWQgYXR0cmlidXRlIHRvIF9yY3VfZGVyZWZlcmVuY2UKClRob3NlIHdp
bGwgYmUgcmVsZWFzZWQgaW4gdGhlIDAuMTIgYW5kIDAuMTMgc3RhYmxlIGJyYW5jaGVzIG9mIGxp
YnVyY3UuCgpOb3RlIHRoYXQgdGhlIDAuMTEgbGlidXJjdSBicmFuY2ggaXMgZW5kIG9mIGxpZmUg
YW5kIHdpbGwgbm90IGhhdmUgYW55CmZ1cnRoZXIgcmVsZWFzZSwgc28geW91IG1heSB3YW50IHRv
IHVwZ3JhZGUgaWYgeW91IHN0aWxsIHVzZSBpdC4KCj4gCj4gSW4gcmV0cm9zcGVjdCwgbXkgdXNl
IG9mIHJjdV9kZXJlZmVyZW5jZSBzZWVtcyB1bm5lY2Vzc2FyeSBzaW5jZQo+IGNvbnN0cnVjdG9y
IGZ1bmN0aW9ucyBzaG91bGQgYWx3YXlzIGZpcmUgYmVmb3JlIGFueSB0aHJlYWRzIGFyZQo+IGNy
ZWF0ZWQuCj4gCj4gVGhhdCBtZWFucyBJIGNhbiBzYWZlbHkgcmVwbGFjZSB0aGUgYXNzaWdubWVu
dCB3LyBDTU1fU1RPUkVfU0hBUkVELAo+IGFuZCByY3VfZGVyZWZlcmVuY2Ugd2l0aCBDTU1fTE9B
RF9TSEFSRUQsIGNvcnJlY3Q/CgpJIHdvdWxkIG5vdCByZWNvbW1lbmQgaXQuIE5vdGUgdGhhdCBj
ZHNfbGZodF9uZXcoKSBzdGFydHMgYSB3b3JrZXIKdGhyZWFkIChmcm9tIGEgY29uc3RydWN0b3Ip
IGluIHlvdXIgY29kZS4gU28gdGhlcmUgaXMgY29uY3VycmVudAphY2Nlc3MgYWZ0ZXIgdGhhdCBo
YXNoIHRhYmxlIGNyZWF0aW9uLCBldmVuIGlmIHlvdSBhY2Nlc3MgaXQgZnJvbQpjb25zdHJ1Y3Rv
ciBjb2RlLgoKVGhhbmtzLAoKTWF0aGlldQoKPiAKPiBTYW1wbGUgY29kZToKPiAvKgo+ICogc2hv
d3MgYSByZWdyZXNzaW9uIHdpdGggX0xHUExfU09VUkNFICsgdXJjdSB2MC4xMS40LCBjb21taXQ6
Cj4gKiA3Y2E3ZmU5YzAzMjE3ODEzIChNYWtlIHRlbXBvcmFyeSB2YXJpYWJsZSBpbiBfcmN1X2Rl
cmVmZXJlbmNlIG5vbi1jb25zdCwKPiAyMDIxLTA3LTI5KQo+ICogJChDQykgLW8geCAtSS9wYXRo
L3RvL2luY2x1ZGUvIC1ML3BhdGgvdG8vbGliLyBfX0ZJTEVfXyAtbHVyY3UtYnAgLWx1cmN1LWNk
cwo+ICoKPiAqIE9yaWdpbmFsbHkgbm90aWNlZCBpbiBhbiBMRF9QUkVMT0FEIG1hbGxvYyB3cmFw
cGVyOgo+ICogaHR0cHM6Ly84MHgyNC5vcmcvbXdyYXAuZ2l0IChSdWJ5IDIuNispCj4gKiBodHRw
czovLzgweDI0Lm9yZy9td3JhcC1wZXJsLmdpdCAoUGVybDUpCj4gKi8KPiAjZGVmaW5lIF9MR1BM
X1NPVVJDRQo+ICNpbmNsdWRlIDx1cmN1LWJwLmg+Cj4gI2luY2x1ZGUgPHVyY3UvcmN1bGZoYXNo
Lmg+Cj4gc3RhdGljIHN0cnVjdCBjZHNfbGZodCAqdG90YWxzOyAvKiBpbW1vcnRhbCAqLwo+IAo+
IF9fYXR0cmlidXRlX18oKGNvbnN0cnVjdG9yKSkgc3RhdGljIHZvaWQgaW5pdF9sZmh0KHZvaWQp
Cj4gewo+CS8qIFhYWCByZXBsYWNlIHdpdGggQ01NX1NUT1JFX1NIQVJFRD8gKi8KPgl0b3RhbHMg
PSBjZHNfbGZodF9uZXcoMTYzODQsIDEsIDAsIENEU19MRkhUX0FVVE9fUkVTSVpFLCAwKTsKPiB9
Cj4gCj4gaW50IG1haW4odm9pZCkgLyogdGhpcyBpcyBtZWFudCB0byBiZSBhIG1hbGxvYy1mYW1p
bHkgZnVuY3Rpb24gaW4gbXdyYXAgKi8KPiB7Cj4JLyogWFhYIHJlcGxhY2UgcmN1X2RlcmVmZXJl
bmNlIHdpdGggQ01NX0xPQURfU0hBUkVEPyAqLwo+CXN0cnVjdCBjZHNfbGZodCAqdCA9IHJjdV9k
ZXJlZmVyZW5jZSh0b3RhbHMpOwo+CXJldHVybiB0ID8gMCA6IDE7Cj4gfQo+IC0tLQo+IFRoYW5r
cyBmb3IgbWFueSB5ZWFycyBvZiB1cmN1ICsgY2RzIQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1Mg
SW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
