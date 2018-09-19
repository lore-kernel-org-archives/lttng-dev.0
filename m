From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: use
 LTTNG_VIEWER_ATTACH_UNK to report a closed session
Date: Wed, 19 Sep 2018 11:54:24 -0400
Message-ID: <20180919155423.GF2836__5524.96997775069$1537372363$gmane$org@gmail.com>
References: <20180907191838.17832-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by lists.lttng.org (Postfix) with ESMTPS id 42Fkv9060XzxSG
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 11:54:29 -0400 (EDT)
Received: by mail-qt0-f196.google.com with SMTP id l42-v6so5515360qtf.13
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 08:54:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180907191838.17832-1-jonathan.rajotte-julien@efficios.com>
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
OS4KClRoYW5rcywKSsOpcsOpbWllCgpPbiBGcmksIFNlcCAwNywgMjAxOCBhdCAwMzoxODozN1BN
IC0wNDAwLCBKb25hdGhhbiBSYWpvdHRlIHdyb3RlOgo+IExUVE5HX1ZJRVdFUl9ORVdfU1RSRUFN
U19IVVAgaXMgbm90IGEgdmFsaWQgZXJyb3IgbnVtYmVyIGZvciB0aGUKPiBMVFROR19WSUVXRVJf
QVRUQUNIX1NFU1NJT04gY29tbWFuZC4gVGhpcyByZXN1bHQgaW4gZXJyb25lb3VzIGVycm9yCj4g
cmVwb3J0aW5nIG9uIHRoZSBjbGllbnQgc2lkZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhh
biBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4g
IHNyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0
bmctcmVsYXlkL2xpdmUuYyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+IGluZGV4IDZm
NTBhZmM2Yy4uYmMwZTQ1MjlhIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xp
dmUuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+IEBAIC0xMDg5LDcgKzEw
ODksNyBAQCBpbnQgdmlld2VyX2F0dGFjaF9zZXNzaW9uKHN0cnVjdCByZWxheV9jb25uZWN0aW9u
ICpjb25uKQo+ICAJaWYgKGNsb3NlZCkgewo+ICAJCXNlbmRfc3RyZWFtcyA9IDA7Cj4gIAkJcmVz
cG9uc2Uuc3RyZWFtc19jb3VudCA9IDA7Cj4gLQkJcmVzcG9uc2Uuc3RhdHVzID0gaHRvYmUzMihM
VFROR19WSUVXRVJfTkVXX1NUUkVBTVNfSFVQKTsKPiArCQlyZXNwb25zZS5zdGF0dXMgPSBodG9i
ZTMyKExUVE5HX1ZJRVdFUl9BVFRBQ0hfVU5LKTsKPiAgCQlnb3RvIHNlbmRfcmVwbHk7Cj4gIAl9
Cj4gIAo+IC0tIAo+IDIuMTcuMQo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
