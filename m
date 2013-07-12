From: David Goulet <dgoulet@ev0ke.net>
Subject: Re: [PATCH lttng-tools] Fix: Unchecked
 asprintf/vasprintf return values
Date: Fri, 12 Jul 2013 14:13:48 -0400
Message-ID: <51E0475C.4070206__4626.45942247963$1373652877$gmane$org@ev0ke.net>
References: <1373647136-5708-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@ev0ke.net>) id 1Uxhqv-0003mv-Dt
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 14:13:57 -0400
In-Reply-To: <1373647136-5708-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?B?SsOpcsOpbWllIEdhbGFybmVhdQ==?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIQoKSsOpcsOpbWllIEdhbGFybmVhdToKPiBzdHJwwrdtYXnCt2Jlwrdtb2RpZmllZMK3
ZXZlbsK3aW7Ct2Nhc2XCt29mwrdmYWlsdXJlwrdhY2NvcmRpbmfCt3Rvwrd0aGUgQVNQUklOVEYo
MykgbWFuCj4gcGFnZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxq
ZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL3V0aWxzL3RhcC90
YXAuYyB8IDEyICsrKysrKysrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy91dGlscy90YXAvdGFwLmMg
Yi90ZXN0cy91dGlscy90YXAvdGFwLmMKPiBpbmRleCBhNDMwOTUxLi41ZDY0ZDg0IDEwMDY0NAo+
IC0tLSBhL3Rlc3RzL3V0aWxzL3RhcC90YXAuYwo+ICsrKyBiL3Rlc3RzL3V0aWxzL3RhcC90YXAu
Ywo+IEBAIC04Myw3ICs4Myw5IEBAIF9nZW5fcmVzdWx0KGludCBvaywgY29uc3QgY2hhciAqZnVu
YywgY2hhciAqZmlsZSwgdW5zaWduZWQgaW50IGxpbmUsCj4gIAkgICBleHBhbnNpb25zIG9uIGl0
ICovCj4gIAlpZih0ZXN0X25hbWUgIT0gTlVMTCkgewo+ICAJCXZhX3N0YXJ0KGFwLCB0ZXN0X25h
bWUpOwo+IC0JCXZhc3ByaW50ZigmbG9jYWxfdGVzdF9uYW1lLCB0ZXN0X25hbWUsIGFwKTsKPiAr
CQlpZiAodmFzcHJpbnRmKCZsb2NhbF90ZXN0X25hbWUsIHRlc3RfbmFtZSwgYXApID09IC0xKSB7
Cj4gKwkJCWxvY2FsX3Rlc3RfbmFtZSA9IE5VTEw7Cj4gKwkJfQo+ICAJCXZhX2VuZChhcCk7Cj4g
IAo+ICAJCS8qIE1ha2Ugc3VyZSB0aGUgdGVzdCBuYW1lIGNvbnRhaW5zIG1vcmUgdGhhbiBkaWdp
dHMKPiBAQCAtMjk5LDcgKzMwMSw5IEBAIHNraXAodW5zaWduZWQgaW50IG4sIGNoYXIgKmZtdCwg
Li4uKQo+ICAJTE9DSzsKPiAgCj4gIAl2YV9zdGFydChhcCwgZm10KTsKPiAtCWFzcHJpbnRmKCZz
a2lwX21zZywgZm10LCBhcCk7Cj4gKwlpZiAoYXNwcmludGYoJnNraXBfbXNnLCBmbXQsIGFwKSA9
PSAtMSkgewo+ICsJCXNraXBfbXNnID0gTlVMTDsKPiArCX0KPiAgCXZhX2VuZChhcCk7Cj4gIAo+
ICAJd2hpbGUobi0tID4gMCkgewo+IEBAIC0zMjQsNyArMzI4LDkgQEAgdG9kb19zdGFydChjaGFy
ICpmbXQsIC4uLikKPiAgCUxPQ0s7Cj4gIAo+ICAJdmFfc3RhcnQoYXAsIGZtdCk7Cj4gLQl2YXNw
cmludGYoJnRvZG9fbXNnLCBmbXQsIGFwKTsKPiArCWlmICh2YXNwcmludGYoJnRvZG9fbXNnLCBm
bXQsIGFwKSA9PSAtMSkgewo+ICsJCXRvZG9fbXNnID0gTlVMTDsKPiArCX0KPiAgCXZhX2VuZChh
cCk7Cj4gIAo+ICAJdG9kbyA9IDE7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
