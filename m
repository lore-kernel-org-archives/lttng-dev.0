From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules stable-2.8] Documentation:
 lttng-modules 2.8 supports Linux < 4.10
Date: Fri, 17 Feb 2017 21:52:37 +0000 (UTC)
Message-ID: <1637368796.191572.1487368357220.JavaMail.zimbra__42433.6795848378$1487368177$gmane$org@efficios.com>
References: <1485376007-27299-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vQ6BB0GR3zlJv
 for <lttng-dev@lists.lttng.org>; Fri, 17 Feb 2017 21:49:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 31632340222
 for <lttng-dev@lists.lttng.org>; Fri, 17 Feb 2017 21:52:38 +0000 (UTC)
In-Reply-To: <1485376007-27299-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCBzb3JyeSBmb3IgdGhlIGRlbGF5LCB0aGUgcGF0Y2ggd2FzIGhpZGluZyBiZWhpbmQg
YQpyYXRoZXIgbGFyZ2UgUkNVIHBhdGNoc2V0IGZyb20gUGF1bCBNY0tlbm5leSBpbiBteSBpbmJv
eC4gOykKCi0tLS0tIE9uIEphbiAyNSwgMjAxNywgYXQgMzoyNiBQTSwgTWljaGFlbCBKZWFuc29u
IG1qZWFuc29uQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBK
ZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gTWFrZWZpbGUgIHwgNyArKysr
KysrCj4gUkVBRE1FLm1kIHwgMyArKy0KPiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCj4g
aW5kZXggODYwMjY0OS4uOTNhZDllNyAxMDA2NDQKPiAtLS0gYS9NYWtlZmlsZQo+ICsrKyBiL01h
a2VmaWxlCj4gQEAgLTI5LDYgKzI5LDEzIEBAIGlmbmVxICgkKEtFUk5FTFJFTEVBU0UpLCkKPiAg
ICAgZW5kaWYKPiAgIGVuZGlmCj4gCj4gKyAgaWZuZXEgKCQoc2hlbGwgXAo+ICsgICAgaWYgWyAk
KFZFUlNJT04pIC1nZSA1IFwKPiArICAgICAgLW8gXCggJChWRVJTSU9OKSAtZXEgNCAtYSAkKFBB
VENITEVWRUwpIC1nZSAxMCBcKSBdIDsgdGhlbiBcCj4gKyAgICAgIGVjaG8gInRydWUiIDsgZmk7
KSwpCj4gKyAgICAkKHdhcm5pbmcgWW91IGFyZSBlbnRlcmluZyB1bmNoYXJ0ZWQgdGVycml0b3Jp
ZXMgYWR2ZW50dXJlciEgUHJvY2VlZCB3aXRoCj4gdXRtb3N0IGNhdXRpb24gKGFsc28sIGx0dG5n
LW1vZHVsZXMgMi44IGRvZXMgbm90IHN1cHBvcnQgTGludXggPj0gNC4xMC4gWW91Cj4gc2hvdWxk
IHVwZ3JhZGUgdG8gYSBuZXdlciBsdHRuZy1tb2R1bGVzIHZlcnNpb24uKSkKPiArICBlbmRpZgo+
ICsKPiAgIGluY2x1ZGUgJChUT1BfTFRUTkdfTU9EVUxFU19ESVIpL01ha2VmaWxlLkFCSS53b3Jr
YXJvdW5kcwo+IAo+ICAgY2NmbGFncy15ICs9IC1JJChUT1BfTFRUTkdfTU9EVUxFU19ESVIpCj4g
ZGlmZiAtLWdpdCBhL1JFQURNRS5tZCBiL1JFQURNRS5tZAo+IGluZGV4IDkzZTJkZDMuLmQzYTY0
M2IgMTAwNjQ0Cj4gLS0tIGEvUkVBRE1FLm1kCj4gKysrIGIvUkVBRE1FLm1kCj4gQEAgLTEwNiw3
ICsxMDYsOCBAQCB0byBwcmludCB0cmFjZXMgYXMgYSBodW1hbi1yZWFkYWJsZSB0ZXh0IGxvZy4K
PiBTdXBwb3J0Cj4gLS0tLS0tLQo+IAo+IC1MaW51eCBrZXJuZWxzID49IDIuNi4zNiBhcmUgc3Vw
cG9ydGVkLgo+ICtMaW51eCBrZXJuZWxzID49IDIuNi4zNiBhbmQgPCA0LjEwIGFyZSBzdXBwb3J0
ZWQgYnkgTFRUbmcgbW9kdWxlcyAyLjguCj4gK1VwZ3JhZGUgdG8gYSBuZXdlciBMVFRuZyBtb2R1
bGVzIGZvciBtb3JlIHJlY2VudCBrZXJuZWxzLgo+IAo+IAo+IE5vdGVzCj4gLS0KPiAyLjcuNAoK
LS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5j
b20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
