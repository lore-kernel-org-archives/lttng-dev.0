From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-ust 2/2] dl instrumentation: add
 dlmopen event, trace dlopen flags
Date: Tue, 21 Feb 2017 14:08:08 +0000 (UTC)
Message-ID: <188106062.195366.1487686088345.JavaMail.zimbra__21089.4890166403$1487685888$gmane$org@efficios.com>
References: <1467672828-19184-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1467672828-19184-2-git-send-email-mathieu.desnoyers@efficios.com>
 <20170221100301.6e409dc3@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vSMhG13TBzkWT
 for <lttng-dev@lists.lttng.org>; Tue, 21 Feb 2017 14:05:01 +0000 (UTC)
In-Reply-To: <20170221100301.6e409dc3@free-electrons.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gRmViIDIxLCAyMDE3LCBhdCA0OjAzIEFNLCBUaG9tYXMgUGV0YXp6b25pIHRob21h
cy5wZXRhenpvbmlAZnJlZS1lbGVjdHJvbnMuY29tIHdyb3RlOgoKPiBIZWxsbywKPiAKPiBPbiBN
b24sICA0IEp1bCAyMDE2IDE4OjUzOjQ4IC0wNDAwLCBNYXRoaWV1IERlc25veWVycyB3cm90ZToK
Pj4gQWRkIG1pc3NpbmcgZGxtb3BlbigzKSBpbnN0cnVtZW50YXRpb24sIGFuZCBhZGQgdGhlICJm
bGFncyIgZmllbGQgdG8KPj4gZGxvcGVuIGluc3RydW1lbnRhdGlvbi4KPj4gCj4+IExpbms6IGh0
dHA6Ly9tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuMy9kbG9wZW4uMy5odG1sCj4+IFNpZ25l
ZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5j
b20+Cj4gCj4gRllJLCB0aGlzIGNvbW1pdCAoN2IwZmRkODNjMTM3YmVhMWQ3MzAyZGYxYTQ1MjUy
ZGZkY2NkODE3MikgYnJlYWtzIHRoZQo+IGJ1aWxkIHdpdGggdGhlIG11c2wgQyBsaWJyYXJ5LCBi
ZWNhdXNlIGl0IGRvZXNuJ3QgaW1wbGVtZW50IHRoZQo+IGRsbW9wZW4oKSBleHRlbnNpb24uCj4g
Cj4gUGVyaGFwcyB0aGVyZSBzaG91bGQgYmUgYW4gYXV0b2NvbmYgdGVzdCB0byBjaGVjayBpZiB0
aGUgQyBsaWJyYXJ5Cj4gcHJvdmlkZXMgZGxtb3BlbigpIGZ1bmN0aW9uYWxpdHkgb3Igbm90PwoK
TXkgZXhwZWN0YXRpb24gaXMgdGhhdCB0aGUgZGxtb3BlbiBvdmVycmlkZSBzeW1ib2wgZ2V0cyBn
ZW5lcmF0ZWQsCmJ1dCBpdCBpcyBuZXZlciBpbnZva2VkIGluIGJ1aWxkcyB3aGVyZSB0aGUgbGli
YyBkb2VzIG5vdCBpbXBsZW1lbnQKaXQsIHNvIHdlIG5ldmVyIGhhdmUgdG8gbG9vayBpdCB1cCBk
eW5hbWljYWxseSB0aHJvdWdoIGRsc3ltKCkuCgpIb3cgZG9lcyB0aGUgYnVpbGQgZmFpbCB3aXRo
IG11c2wgPyBDYW4geW91IHByb3ZpZGUgdGhlIGJ1aWxkCm91dHB1dCA/CgpUaGFua3MsCgpNYXRo
aWV1Cgo+IAo+IEJlc3QgcmVnYXJkcywKPiAKPiBUaG9tYXMgUGV0YXp6b25pCj4gLS0KPiBUaG9t
YXMgUGV0YXp6b25pLCBDVE8sIEZyZWUgRWxlY3Ryb25zCj4gRW1iZWRkZWQgTGludXggYW5kIEtl
cm5lbCBlbmdpbmVlcmluZwo+IGh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20KCi0tIApNYXRoaWV1
IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
