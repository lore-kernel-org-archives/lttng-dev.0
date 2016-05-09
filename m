From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: remove NULL check of nonnull
 parameter in dlclose
Date: Mon, 9 May 2016 20:36:52 +0000 (UTC)
Message-ID: <1087510221.4841.1462826212324.JavaMail.zimbra__44186.8141912439$1462826229$gmane$org@efficios.com>
References: <1462826009-3883-1-git-send-email-abusque@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id ABFF0A3411
 for <lttng-dev@lists.lttng.org>; Mon,  9 May 2016 20:36:53 +0000 (UTC)
In-Reply-To: <1462826009-3883-1-git-send-email-abusque@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Antoine Busque <abusque@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyIGFuZCBzdGFibGUtMi44LiBJIHR3ZWFrZWQgeW91ciBlbWFpbCBj
aGFuZ2Vsb2cgdG8gcmVtb3ZlCnRoZSB3aGl0ZXNwYWNlIGF0IHRoZSBiZWdpbm5pbmcgb2YgZXZl
cnkgbGluZS4gWW91IG1heSBoYXZlIGFuIGlzc3VlIHdpdGggeW91cgplbWFpbCBjbGllbnQgY29u
ZmlnLgoKVGhhbmtzLAoKTWF0aGlldQoKLS0tLS0gT24gTWF5IDksIDIwMTYsIGF0IDQ6MzMgUE0s
IEFudG9pbmUgQnVzcXVlIGFidXNxdWVAZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBUaGUgYGhhbmRs
ZWAgcGFyYW1ldGVyIG9mIGBkbGNsb3NlYCwgYXMgZGVmaW5lZCBpbgo+IGBpbmNsdWRlL2x0dG5n
L3VzdC1kbGZjbi5oYCBpcyBtYXJrZWQgYF9fbm9ubnVsbGAuIEdDQyBzdGFydGluZyB3aXRoCj4g
dmVyc2lvbiA2LjEgZW1pdHMgd2FybmluZ3MgZm9yIGNvbXBhcmlzb25zIG9mIG5vbm51bGwgYXJn
dW1lbnRzCj4gYWdhaW5zdCBOVUxMIGJ5IGRlZmF1bHQgKHNlZSAtV25vbm51bGwtY29tcGFyZSku
Cj4gCj4gVGhlcmVmb3JlLCB0aGlzIHJlbW92ZXMgYSBzdXBlcmZsdW91cyBOVUxMIGNoZWNrIG9u
IGBoYW5kbGVgLCBmb3IKPiB3aGljaCBHQ0MgZW1pdHRlZCBhIHdhcm5pbmcuCj4gCj4gU2lnbmVk
LW9mZi1ieTogQW50b2luZSBCdXNxdWUgPGFidXNxdWVAZWZmaWNpb3MuY29tPgo+IC0tLQo+IGxp
Ymx0dG5nLXVzdC1kbC9sdHRuZy11c3QtZGwuYyB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0
LWRsL2x0dG5nLXVzdC1kbC5jIGIvbGlibHR0bmctdXN0LWRsL2x0dG5nLXVzdC1kbC5jCj4gaW5k
ZXggOTU0ZDlkZi4uYWMzYzk1MSAxMDA2NDQKPiAtLS0gYS9saWJsdHRuZy11c3QtZGwvbHR0bmct
dXN0LWRsLmMKPiArKysgYi9saWJsdHRuZy11c3QtZGwvbHR0bmctdXN0LWRsLmMKPiBAQCAtMTQ0
LDcgKzE0NCw3IEBAIHZvaWQgKmRsb3Blbihjb25zdCBjaGFyICpmaWxlbmFtZSwgaW50IGZsYWcp
Cj4gCj4gaW50IGRsY2xvc2Uodm9pZCAqaGFuZGxlKQo+IHsKPiAtCWlmIChfX3RyYWNlcG9pbnRf
cHRyc19yZWdpc3RlcmVkICYmIGhhbmRsZSkgewo+ICsJaWYgKF9fdHJhY2Vwb2ludF9wdHJzX3Jl
Z2lzdGVyZWQpIHsKPiAJCXN0cnVjdCBsaW5rX21hcCAqcCA9IE5VTEw7Cj4gCQlpbnQgcmV0Owo+
IAo+IC0tCj4gMi44LjIKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
