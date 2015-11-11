From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH 1/2] fix: missing cpuid kernel
	context in the ABI
Date: Wed, 11 Nov 2015 15:35:54 -0500
Message-ID: <CA+jJMxtYh4m=Jg+0+J=A+0jmvC1Ezhk8-qdUmbh1Mxwnfu-b5A__10824.6527881876$1447274208$gmane$org@mail.gmail.com>
References: <1447208475-24578-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Zwc7b-0006dY-N3
 for lttng-dev@lists.lttng.org; Wed, 11 Nov 2015 15:36:00 -0500
Received: by ykdv3 with SMTP id v3so69429319ykd.0
 for <lttng-dev@lists.lttng.org>; Wed, 11 Nov 2015 12:35:54 -0800 (PST)
In-Reply-To: <1447208475-24578-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciB3aXRoIHNvbWUgY2hhbmdlcy4gVGhlIHNlY29uZCBwYXRjaCBvZiB0
aGlzIHNlcmllcwpyZW1haW5zIHVubWVyZ2VkIGFzIHRoZSBsdHRuZy1tb2R1bGVzIHBhcnQgaXMg
c3RpbGwgdW5kZXIgcmV2aWV3LgoKUmVtb3ZlZCAiZml4IiBhcyB0aGlzIGRvZXMgbm90IGFkZHJl
c3MgYSBidWcgKENQVSBpZCByZW1haW5zIHVudXNlZCkuCgpPbiBUdWUsIE5vdiAxMCwgMjAxNSBh
dCA5OjIxIFBNLCBKdWxpZW4gRGVzZm9zc2V6CjxqZGVzZm9zc2V6QGVmZmljaW9zLmNvbT4gd3Jv
dGU6Cj4gU2lnbmVkLW9mZi1ieTogSnVsaWVuIERlc2Zvc3NleiA8amRlc2Zvc3NlekBlZmZpY2lv
cy5jb20+Cj4gLS0tCj4gIHNyYy9jb21tb24vbHR0bmcta2VybmVsLmggfCAxICsKPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9sdHRu
Zy1rZXJuZWwuaCBiL3NyYy9jb21tb24vbHR0bmcta2VybmVsLmgKPiBpbmRleCBmMTE0NGRlLi5m
NTgxMDhmIDEwMDY0NAo+IC0tLSBhL3NyYy9jb21tb24vbHR0bmcta2VybmVsLmgKPiArKysgYi9z
cmMvY29tbW9uL2x0dG5nLWtlcm5lbC5oCj4gQEAgLTUzLDYgKzUzLDcgQEAgZW51bSBsdHRuZ19r
ZXJuZWxfY29udGV4dF90eXBlIHsKPiAgICAgICAgIExUVE5HX0tFUk5FTF9DT05URVhUX1BQSUQg
ICAgICAgICAgID0gOCwKPiAgICAgICAgIExUVE5HX0tFUk5FTF9DT05URVhUX1ZQUElEICAgICAg
ICAgID0gOSwKPiAgICAgICAgIExUVE5HX0tFUk5FTF9DT05URVhUX0hPU1ROQU1FICAgICAgID0g
MTAsCj4gKyAgICAgICBMVFROR19LRVJORUxfQ09OVEVYVF9DUFVJRCAgICAgICAgICA9IDExLAoK
Q2hhbmdlZCB0byBMVFROR19LRVJORUxfQ09OVEVYVF9DUFVfSUQgdG8gbWF0Y2ggdGhlIG5hbWUg
dXNlZCBieSBsdHRuZy1tb2R1bGVzLgoKSsOpcsOpbWllCgo+ICB9Owo+Cj4gIC8qIFBlcmYgY291
bnRlciBhdHRyaWJ1dGVzICovCj4gLS0KPiAxLjkuMQo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJu
ZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
