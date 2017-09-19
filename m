From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 1/2] Fix: lttng-gen-tp: only
 replace file extension
Date: Tue, 19 Sep 2017 17:07:52 +0000 (UTC)
Message-ID: <1971304394.13635.1505840872725.JavaMail.zimbra__5917.77145532451$1505840838$gmane$org@efficios.com>
References: <20170919160834.23713-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xxTnT4LWZzsn3
 for <lttng-dev@lists.lttng.org>; Tue, 19 Sep 2017 17:07:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D87A834021D
 for <lttng-dev@lists.lttng.org>; Tue, 19 Sep 2017 17:07:58 +0000 (UTC)
In-Reply-To: <20170919160834.23713-1-jonathan.rajotte-julien@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjEwLCAyLjksIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0tIE9u
IFNlcCAxOSwgMjAxNywgYXQgMTI6MDggUE0sIEpvbmF0aGFuIFJham90dGUgam9uYXRoYW4ucmFq
b3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBQcmV2aW91cyByZXBsYWNlIHdhcyBk
b25lIG9uIHRoZSBjb21wbGV0ZSBwYXRoLiBBIHBhdGggY29udGFpbmluZwo+IC5jIG9yIC5vIHdv
dWxkIHJlc3VsdCBpbiBhIGNvcnJ1cHRlZCBmaWxlIHBhdGguCj4gCj4gUmVwb3J0ZWQtYnk6IEd1
bm5hciBTdHJhbmQgPEd1bm5hci5TdHJhbmRAZXJpY3Nzb24uY29tPgo+IFNpZ25lZC1vZmYtYnk6
IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4K
PiAtLS0KPiB0b29scy9sdHRuZy1nZW4tdHAgfCA5ICsrKysrKystLQo+IDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rvb2xz
L2x0dG5nLWdlbi10cCBiL3Rvb2xzL2x0dG5nLWdlbi10cAo+IGluZGV4IGI2MmNkOTkwLi42YWEx
YmJhMSAxMDA3NTUKPiAtLS0gYS90b29scy9sdHRuZy1nZW4tdHAKPiArKysgYi90b29scy9sdHRu
Zy1nZW4tdHAKPiBAQCAtNzksNyArNzksOSBAQCBjbGFzcyBDRmlsZToKPiAgICAgZGVmIHdyaXRl
KHNlbGYpOgo+ICAgICAgICAgb3V0cHV0RmlsZSA9IG9wZW4oc2VsZi5vdXRwdXRGaWxlbmFtZSwi
dyIpCj4gCj4gLSAgICAgICAgaGVhZGVyRmlsZW5hbWUgPSBzZWxmLm91dHB1dEZpbGVuYW1lLnJl
cGxhY2UoIi5jIiwiLmgiKQo+ICsgICAgICAgIGhlYWRlckZpbGVuYW1lID0gc2VsZi5vdXRwdXRG
aWxlbmFtZQo+ICsgICAgICAgIGlmIGhlYWRlckZpbGVuYW1lLmVuZHN3aXRoKCIuYyIpOgo+ICsg
ICAgICAgICAgICBoZWFkZXJGaWxlbmFtZSA9IGhlYWRlckZpbGVuYW1lWzotMl0gKyAiLmgiCj4g
Cj4gICAgICAgICBvdXRwdXRGaWxlLndyaXRlKENGaWxlLkZJTEVfVFBMLmZvcm1hdCgKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGVhZGVyRmlsZW5hbWUgPSBo
ZWFkZXJGaWxlbmFtZSkpCj4gQEAgLTEyNiw3ICsxMjgsMTAgQEAgY2xhc3MgT2JqRmlsZToKPiAg
ICAgICAgIHJldHVybiBjYwo+IAo+ICAgICBkZWYgd3JpdGUoc2VsZik6Cj4gLSAgICAgICAgY0Zp
bGVuYW1lID0gc2VsZi5vdXRwdXRGaWxlbmFtZS5yZXBsYWNlKCIubyIsIi5jIikKPiArICAgICAg
ICBjRmlsZW5hbWUgPSBzZWxmLm91dHB1dEZpbGVuYW1lCj4gKyAgICAgICAgaWYgY0ZpbGVuYW1l
LmVuZHN3aXRoKCIubyIpOgo+ICsgICAgICAgICAgICBjRmlsZW5hbWUgPSBjRmlsZW5hbWVbOi0y
XSArICIuYyIKPiArCj4gICAgICAgICBjYyA9IHNlbGYuX2RldGVjdENDKCkKPiAgICAgICAgIGlm
IGNjID09ICIiOgo+ICAgICAgICAgICAgIHJhaXNlIFJ1bnRpbWVFcnJvcigiTm8gQyBDb21waWxl
ciBkZXRlY3RlZCIpCj4gLS0KPiAyLjExLjAKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lP
UyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
