From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Skip closed session on
	viewer listing
Date: Wed, 19 Sep 2018 11:54:46 -0400
Message-ID: <20180919155444.GG2836__47998.0936310769$1537372519$gmane$org@gmail.com>
References: <20180907191838.17832-1-jonathan.rajotte-julien@efficios.com>
 <20180907191838.17832-2-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by lists.lttng.org (Postfix) with ESMTPS id 42Fkvc0n7mzxSl
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 11:54:51 -0400 (EDT)
Received: by mail-qk1-f193.google.com with SMTP id g13-v6so3267371qki.9
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 08:54:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180907191838.17832-2-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIHN0YWJsZS0yLjEwLCBhbmQgc3RhYmxlLTIu
OS4KClRoYW5rcywKSsOpcsOpbWllCgpPbiBGcmksIFNlcCAwNywgMjAxOCBhdCAwMzoxODozOFBN
IC0wNDAwLCBKb25hdGhhbiBSYWpvdHRlIHdyb3RlOgo+IFRoZXJlIGlzIG5vIHZhbHVlIGluIGxp
c3RpbmcgYSBjbG9zZWQgc2Vzc2lvbi4gQSB2aWV3ZXIgY2Fubm90IGhvb2sgaXRzZWxmCj4gdG8g
YSBjbG9zZWQgc2Vzc2lvbiBpbiBsaXZlIG1vZGUgYW5kIHRoZSBzZXNzaW9uIGlzIGFib3V0IHRv
IGJlIHJlbW92ZWQgZnJvbSB0aGUKPiBzZXNzaW9ucyBoYXNoIHRhYmxlLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9z
LmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jIHwgNSArKysrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4v
bHR0bmctcmVsYXlkL2xpdmUuYyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+IGluZGV4
IGJjMGU0NTI5YS4uMGZkNDFmMWE4IDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctcmVsYXlk
L2xpdmUuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+IEBAIC04MzUsNiAr
ODM1LDExIEBAIGludCB2aWV3ZXJfbGlzdF9zZXNzaW9ucyhzdHJ1Y3QgcmVsYXlfY29ubmVjdGlv
biAqY29ubikKPiAgCj4gIAkJaGVhbHRoX2NvZGVfdXBkYXRlKCk7Cj4gIAo+ICsJCWlmIChzZXNz
aW9uLT5jb25uZWN0aW9uX2Nsb3NlZCkgewo+ICsJCQkvKiBTa2lwIGNsb3NlZCBzZXNzaW9uICov
Cj4gKwkJCWNvbnRpbnVlOwo+ICsJCX0KPiArCj4gIAkJaWYgKGNvdW50ID49IGJ1Zl9jb3VudCkg
ewo+ICAJCQlzdHJ1Y3QgbHR0bmdfdmlld2VyX3Nlc3Npb24gKm5ld2J1ZjsKPiAgCQkJdWludDMy
X3QgbmV3X2J1Zl9jb3VudCA9IGJ1Zl9jb3VudCA8PCAxOwo+IC0tIAo+IDIuMTcuMQo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
