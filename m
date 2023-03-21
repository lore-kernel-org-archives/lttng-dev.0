Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16623C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679410158;
	bh=LHJYV/SaeiqBXzIG3MlG4ytTK0iDC5OfVrbzadI0r9Q=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XZj1L3UYXxgvV71nbp8a4TMEYL87aa9s2Z4vXmhYdiQubDaWNrBGWpsY9GUtUC8LZ
	 oENGGiwDPdkuilnNlJwP7ZNbvjh7+RRoyYS3Tbn333kC9Ed2FJvG62W1QkC15nHLCl
	 /1nRmZjVQfLqcDn9Ez8v1zZwexoCmlXdr+4ZKpFqm45XlDpkWx2uaez4Q4wsP8ZPIl
	 u3pzn92H/0zsvUce0PX1hujTXz5LRzFQfnmKaaE93dAXNLB8zdZznztfasegcdattn
	 bQ0PTxDV3TcoFjA03iah8ycfcWSOb/nmbWwRfyYobao04WpNRz1xsmrVPFrE4da9j9
	 /FB75mbxftLXw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pgvd94xTHz2Gyv;
	Tue, 21 Mar 2023 10:49:17 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pgvd768LYz2Gys
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 10:49:15 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pgvd73cpSzr1D;
 Tue, 21 Mar 2023 10:49:15 -0400 (EDT)
Message-ID: <51974db5-f63f-7006-f2ae-37b3ca817041@efficios.com>
Date: Tue, 21 Mar 2023 10:49:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-8-ondrej@sury.org>
 <e7384cff-06a6-6e1e-9abc-ce7932760964@efficios.com>
 <A012AAA8-7E40-40A3-A272-1703EFA26314@sury.org>
 <66635c75-b869-9704-edac-21026cce2b99@efficios.com>
 <1B64F3D0-EB5C-4023-BA15-37D0DBCBB1B3@sury.org>
In-Reply-To: <1B64F3D0-EB5C-4023-BA15-37D0DBCBB1B3@sury.org>
Subject: Re: [lttng-dev] [PATCH 7/7] Experiment: Add explicit memory barrier
 in free_completion()
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

T24gMjAyMy0wMy0yMSAxMDo0OCwgT25kxZllaiBTdXLDvSB3cm90ZToKPj4gT24gMjEuIDMuIDIw
MjMsIGF0IDE1OjQ2LCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPiB3cm90ZToKPj4KPj4gT24gMjAyMy0wMy0yMSAwNjoyMSwgT25kxZllaiBTdXLDvSB3
cm90ZToKPj4+PiBPbiAyMC4gMy4gMjAyMywgYXQgMTk6MzcsIE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMy0w
My0xNyAxNzozNywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+Pj4+PiBGSVhN
RTogVGhpcyBpcyBleHBlcmltZW50IHRoYXQgYWRkcyBleHBsaWNpdCBtZW1vcnkgYmFycmllciBp
biB0aGUKPj4+Pj4gZnJlZV9jb21wbGV0aW9uIGluIHRoZSB3b3JrcXVldWUuYywgc28gVGhyZWFk
U2FuaXRpemVyIGtub3dzIGl0J3Mgb2sgdG8KPj4+Pj4gZnJlZSB0aGUgcmVzb3VyY2VzLgo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBPbmTFmWVqIFN1csO9IDxvbmRyZWpAc3VyeS5vcmc+Cj4+Pj4+IC0t
LQo+Pj4+PiAgIHNyYy93b3JrcXVldWUuYyB8IDEgKwo+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQo+Pj4+PiBkaWZmIC0tZ2l0IGEvc3JjL3dvcmtxdWV1ZS5jIGIvc3JjL3dv
cmtxdWV1ZS5jCj4+Pj4+IGluZGV4IDEwMzlkNzIuLmYyMTkwN2YgMTAwNjQ0Cj4+Pj4+IC0tLSBh
L3NyYy93b3JrcXVldWUuYwo+Pj4+PiArKysgYi9zcmMvd29ya3F1ZXVlLmMKPj4+Pj4gQEAgLTM3
Nyw2ICszNzcsNyBAQCB2b2lkIGZyZWVfY29tcGxldGlvbihzdHJ1Y3QgdXJjdV9yZWYgKnJlZikK
Pj4+Pj4gICAgc3RydWN0IHVyY3Vfd29ya3F1ZXVlX2NvbXBsZXRpb24gKmNvbXBsZXRpb247Cj4+
Pj4+ICAgICAgY29tcGxldGlvbiA9IGNhYV9jb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgdXJjdV93
b3JrcXVldWVfY29tcGxldGlvbiwgcmVmKTsKPj4+Pj4gKyBhc3NlcnQoIXVyY3VfcmVmX2dldF91
bmxlc3NfemVybygmY29tcGxldGlvbi0+cmVmKSk7Cj4+Pj4KPj4+PiBQZXJoYXBzIHdoYXQgd2Ug
cmVhbGx5IHdhbnQgaGVyZSBpcyBhbiBBTk5PVEFURV9VTlBVQkxJU0hfTUVNT1JZX1JBTkdFKCkg
b2Ygc29tZSBzb3J0ID8KPj4+IEkgZ3Vlc3M/Cj4+PiBNeSBleHBlcmllbmNlIHdpdGggVFNBTiB0
ZWxscyBtZSwgdGhhdCB5b3UgbmVlZCBzb21lIGtpbmQgb2YgbWVtb3J5IGJhcnJpZXIgd2hlbiB1
c2luZyBhY3F1aXJlLXJlbGVhc2UKPj4+IHNlbWFudGljcyBhbmQgeW91IGRvOgo+Pj4gaWYgKF9f
YXRvbWljX3N1Yl9mZXRjaChvYmotPnJlZiwgX19BVE9NSUNfUkVMRUFTRSkgPT0gMCkgewo+Pj4g
ICAgLyogX19BVE9NSUNfQUNRVUlSRSBuZWVkZWQgaGVyZSAqLwo+Pj4gICAgIGZyZWUob2JqKTsK
Pj4+IH0KPj4+IHdlIGVuZCB1cCB1c2luZyBmb2xsb3dpbmcgY29kZSBpbiBCSU5EIDk6Cj4+PiBp
ZiAoX19hdG9taWNfc3ViX2ZldGNoKG9iai0+cmVmLCBfX0FUT01JQ19BQ1FfUkVMKSA9PSAwKSB7
Cj4+PiAgICAgZnJlZShvYmopOwo+Pj4gfQo+Pj4gU28sIEkgYW0gZ3Vlc3NpbmcgYWZ0ZXIgdGhl
IGNoYW5nZSBvZiB1YXRvbWljX3N1Yl9yZXR1cm4oKSB0byBfX0FUT01JQ19BQ1FfUkVMLAo+Pj4g
dGhpcyBwYXRjaCBzaG91bGQgbm8gbG9uZ2VyIGJlIG5lZWRlZC4KPj4KPj4gQWN0dWFsbHkgd2Ug
d2FudCBfX0FUT01JQ19TRVFfQ1NULCB3aGljaCBpcyBldmVuIHN0cm9uZ2VyIHRoYW4gQUNRX1JF
TC4KPiAKPiBZZWFoLCBJIHRoaW5rIEkgYWxyZWFkeSBkaWQgdGhhdCwgYnV0IHdyb3RlIHRoZSBl
bWFpbCBiZWZvcmUgdGhhdC4gTmV2ZXJ0aGVsZXNzLCBteSBtYWluCj4gcG9pbnQgd2FzIHRoYXQg
aXQgc2hvdWxkIG5vdCBiZSBuZWVkZWQgYW55bW9yZS4KCkFncmVlZCwgbGV0J3Mgc2VlIGhvdyBp
dCBob2xkcyB1cCB0byB0ZXN0aW5nIHVuZGVyIFRTQU4uIDopCgpUaGFua3MsCgpNYXRoaWV1Cgo+
IAo+IE9uZHJlago+IC0tCj4gT25kxZllaiBTdXLDvSAoSGUvSGltKQo+IG9uZHJlakBzdXJ5Lm9y
Zwo+IAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZm
aWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
