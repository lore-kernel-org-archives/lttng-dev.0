From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: section mismatch warning
 caused by __exit annotation
Date: Tue, 7 Mar 2017 14:18:30 +0000 (UTC)
Message-ID: <1003706389.31415.1488896310925.JavaMail.zimbra__9701.65233961797$1488896300$gmane$org@efficios.com>
References: <1488895951-12544-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vczKY4pl7zlBc
 for <lttng-dev@lists.lttng.org>; Tue,  7 Mar 2017 14:18:41 +0000 (UTC)
In-Reply-To: <1488895951-12544-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

bWVyZ2VkIGludG8gbWFzdGVyIGFuZCBzdGFibGUtMi45LCB0aGFua3MhCgpNYXRoaWV1CgotLS0t
LSBPbiBNYXIgNywgMjAxNywgYXQgOToxMiBBTSwgRnJhbmNpcyBEZXNsYXVyaWVycyBmcmFuY2lz
LmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gbHR0bmdfbG9nZ2VyX2V4aXQgaXMg
dXNlZCBpbiBhIG5vbi1leGl0IGZ1bmN0aW9uIHNvIGl0IGNhbiBub3QgYmUKPiBhbm5vdGF0ZWQg
d2l0aCBgX19leGl0YAo+IAo+IFNpZ25lZC1vZmYtYnk6IEZyYW5jaXMgRGVzbGF1cmllcnMgPGZy
YW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+IHByb2Jlcy9sdHRuZy5jIHwg
MiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS9wcm9iZXMvbHR0bmcuYyBiL3Byb2Jlcy9sdHRuZy5jCj4gaW5kZXggNThh
YTUxNS4uODgxMGZhMiAxMDA2NDQKPiAtLS0gYS9wcm9iZXMvbHR0bmcuYwo+ICsrKyBiL3Byb2Jl
cy9sdHRuZy5jCj4gQEAgLTEyOSw3ICsxMjksNyBAQCBlcnJvcjoKPiAJcmV0dXJuIHJldDsKPiB9
Cj4gCj4gLXZvaWQgX19leGl0IGx0dG5nX2xvZ2dlcl9leGl0KHZvaWQpCj4gK3ZvaWQgbHR0bmdf
bG9nZ2VyX2V4aXQodm9pZCkKPiB7Cj4gCV9fbHR0bmdfZXZlbnRzX2V4aXRfX2x0dG5nKCk7Cj4g
CWlmIChsdHRuZ19sb2dnZXJfZGVudHJ5KQo+IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25v
eWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
