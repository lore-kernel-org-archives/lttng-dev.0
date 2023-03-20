Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF51C6FD1D
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679337054;
	bh=m8DGB+UlMCckxnmvxnPhgOkfCLbTPlGU3rHPAfl2fM4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=EaOu3sRAMDYczpP2lv0yqmThF6TfsvQ87b7UCTCvlZedURezemmMqHooD6bIx8I2l
	 0c2H3ypkcAQ+nPkHPlbZOOBKB9gYCq+dwXIyIG63wIP4ntiwDHfDXs4NMxOCMvodeg
	 bdIeDPy0W3ta9fuV5E6U0/91e4bEU4Q8oYfasoE5nGxmD+pF/rXFJe3Eju1uPymbuS
	 ZA2xTv7CYlq65pz1XOoA1kohPC5enM9cfJ5+mSlY9VPfb0BdtYpUJMz0L2rDtSGp2I
	 8AoI8HFrPpwwC4vHaOONR0RMquxbEOHRZwDUWU1SUdlb+y0Xkg52EGszaRiQc/CPBR
	 d35IyksHKEZdA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgNbK5BlDz2F2T;
	Mon, 20 Mar 2023 14:30:53 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgNbK0823z2DXQ
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:30:52 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgNbH4MTdzqxR;
 Mon, 20 Mar 2023 14:30:51 -0400 (EDT)
Message-ID: <9aad8537-6053-7d30-6575-8986c46ce607@efficios.com>
Date: Mon, 20 Mar 2023 14:31:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev@lists.lttng.org
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-7-ondrej@sury.org>
In-Reply-To: <20230317213755.455957-7-ondrej@sury.org>
Subject: Re: [lttng-dev] [PATCH 6/7] Fix: uatomic_or() need retyping to
 uintptr_t in rculfhash.c
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

T24gMjAyMy0wMy0xNyAxNzozNywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+
IFdoZW4gYWRkaW5nIFJFTU9WRURfRkxBRyB0byB0aGUgcG9pbnRlcnMgaW4gdGhlIHJjdWxmaGFz
aAo+IGltcGxlbWVudGF0aW9uLCByZXR5cGUgdGhlIGdlbmVyaWMgcG9pbnRlciB0byB1aW50cHRy
X3QgdG8gZml4IHRoZQo+IGNvbXBpbGVyIGVycm9yLgoKV2hhdCBpcyB0aGUgY29tcGlsZXIgZXJy
b3IgPyBJJ20gd29uZGVyaW5nIHdoZXRoZXIgdGhlIGV4cGVjdGVkIGNob2ljZQp0byBtYXRjaCB0
aGUgcmVzdCBvZiB0aGlzIGZpbGUncyBjb250ZW50IHdvdWxkIGJlIHRvIHVzZSAidWludHB0cl90
ICoiIApvciAidW5zaWduZWQgbG9uZyAqIiA/CgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IE9uZMWZZWogU3Vyw70gPG9uZHJlakBzdXJ5Lm9yZz4KPiAtLS0KPiAgIHNyYy9y
Y3VsZmhhc2guYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc3JjL3JjdWxmaGFzaC5jIGIvc3JjL3Jj
dWxmaGFzaC5jCj4gaW5kZXggYjQ1NjQxNS4uODYzMzg3ZSAxMDA2NDQKPiAtLS0gYS9zcmMvcmN1
bGZoYXNoLmMKPiArKysgYi9zcmMvcmN1bGZoYXNoLmMKPiBAQCAtMTE5OCw3ICsxMTk4LDcgQEAg
aW50IF9jZHNfbGZodF9kZWwoc3RydWN0IGNkc19sZmh0ICpodCwgdW5zaWduZWQgbG9uZyBzaXpl
LAo+ICAgCSAqIEtub3dpbmcgd2hpY2ggd2lucyB0aGUgcmFjZSB3aWxsIGJlIGtub3duIGFmdGVy
IHRoZSBnYXJiYWdlCj4gICAJICogY29sbGVjdGlvbiBwaGFzZSwgc3RheSB0dW5lZCEKPiAgIAkg
Ki8KPiAtCXVhdG9taWNfb3IoJm5vZGUtPm5leHQsIFJFTU9WRURfRkxBRyk7Cj4gKwl1YXRvbWlj
X29yKCh1aW50cHRyX3QgKikmbm9kZS0+bmV4dCwgUkVNT1ZFRF9GTEFHKTsKPiAgIAkvKiBXZSBw
ZXJmb3JtZWQgdGhlIChsb2dpY2FsKSBkZWxldGlvbi4gKi8KPiAgIAo+ICAgCS8qCj4gQEAgLTE0
NDEsNyArMTQ0MSw3IEBAIHZvaWQgcmVtb3ZlX3RhYmxlX3BhcnRpdGlvbihzdHJ1Y3QgY2RzX2xm
aHQgKmh0LCB1bnNpZ25lZCBsb25nIGksCj4gICAJCWRiZ19wcmludGYoInJlbW92ZSBlbnRyeTog
b3JkZXIgJWx1IGluZGV4ICVsdSBoYXNoICVsdVxuIiwKPiAgIAkJCSAgIGksIGosIGopOwo+ICAg
CQkvKiBTZXQgdGhlIFJFTU9WRURfRkxBRyB0byBmcmVlemUgdGhlIC0+bmV4dCBmb3IgZ2MgKi8K
PiAtCQl1YXRvbWljX29yKCZmaW5pX2J1Y2tldC0+bmV4dCwgUkVNT1ZFRF9GTEFHKTsKPiArCQl1
YXRvbWljX29yKCh1aW50cHRyX3QgKikmZmluaV9idWNrZXQtPm5leHQsIFJFTU9WRURfRkxBRyk7
Cj4gICAJCV9jZHNfbGZodF9nY19idWNrZXQocGFyZW50X2J1Y2tldCwgZmluaV9idWNrZXQpOwo+
ICAgCX0KPiAgIAlodC0+Zmxhdm9yLT5yZWFkX3VubG9jaygpOwoKLS0gCk1hdGhpZXUgRGVzbm95
ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
