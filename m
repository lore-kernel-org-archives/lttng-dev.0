From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH lttng-modules] Update: kvm instrumentation
 for ubuntu 4.13.0-38
Date: Fri, 23 Mar 2018 11:45:27 -0400
Message-ID: <b96ac777-0b5a-ae74-34fb-0a296491c1cd__19247.4916148514$1521819813$gmane$org@efficios.com>
References: <20180323150348.25137-1-khalid.elmously@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4077Cr44WdzxRp
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 11:45:28 -0400 (EDT)
In-Reply-To: <20180323150348.25137-1-khalid.elmously@canonical.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpPbiAyMDE4LTAzLTIzIDExOjAzLCBLaGFsaWQgRWxtb3VzbHkgd3JvdGU6Cj4gU3RhcnRp
bmcgZnJvbSA0LjEzLjAtMzggdGhlIHVidW50dSBrZXJuZWwgYmFja3BvcnQgYSBrdm0gaW5zdHJ1
bWVudGF0aW9uCj4gY2hhbmdlIGludHJvZHVjZWQgaW4gNC4xNSB3aGljaCBhZmZlY3RzIHRoZSBw
cm90b3R5cGUgb2YgdGhlIGt2bV9tbWlvIGV2ZW50Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEtoYWxp
ZCBFbG1vdXNseSA8a2hhbGlkLmVsbW91c2x5QGNhbm9uaWNhbC5jb20+Cj4gLS0tCj4gIGluc3Ry
dW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIHwgMSArCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9pbnN0cnVtZW50YXRpb24vZXZl
bnRzL2x0dG5nLW1vZHVsZS9rdm0uaCBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9k
dWxlL2t2bS5oCj4gaW5kZXggOGY5YTEzMi4uYWJhNmY5MyAxMDA2NDQKPiAtLS0gYS9pbnN0cnVt
ZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rdm0uaAo+ICsrKyBiL2luc3RydW1lbnRhdGlv
bi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oCj4gQEAgLTkyLDYgKzkyLDcgQEAgTFRUTkdfVFJB
Q0VQT0lOVF9FVkVOVChrdm1fYWNrX2lycSwKPiAgCXx8IExUVE5HX0tFUk5FTF9SQU5HRSg0LDEs
NTAsIDQsMiwwKSBcCj4gIAl8fCBMVFROR19LRVJORUxfUkFOR0UoMywxNiw1MiwgMywxNywwKSBc
Cj4gIAl8fCBMVFROR19LRVJORUxfUkFOR0UoMywyLDk3LCAzLDMsMCkgXAo+ICsJfHwgTFRUTkdf
VUJVTlRVX0tFUk5FTF9SQU5HRSg0LDEzLDE2LDM4LCA0LDE0LDI1NSwyNTUpIFwKCkkgdGhpbmsg
dGhlIGNvcnJlY3QgcmFuZ2Ugc2hvdWxkIGJlICg0LDEzLDE2LDM4LCA0LDE0LDAsMCksIGlmIHNv
bWUKa2VybmVscyBpbiB0aGUgNC4xNCBicmFuY2ggYXJlIGFsc28gYWZmZWN0ZWQgYW5vdGhlciBz
cGVjaWZpYyByYW5nZQptYWNybyBzaG91bGQgYmUgYWRkZWQuCgo+ICAJfHwgTFRUTkdfREVCSUFO
X0tFUk5FTF9SQU5HRSg0LDksNjUsMCwzLDAsIDQsMTAsMCwwLDAsMCkgXAo+ICAJfHwgTFRUTkdf
RkVET1JBX0tFUk5FTF9SQU5HRSg0LDE0LDEzLDMwMCwgNCwxNSwwLDApKQo+ICAKPiAKCgpBbmQg
dGhhbmtzIGZvciB0aGUgcGF0Y2ghCgpNaWNoYWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
