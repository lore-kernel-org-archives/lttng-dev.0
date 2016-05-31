From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 1/4] Add support for musl libc to
	ust-dlfcn.h
Date: Tue, 31 May 2016 04:38:20 +0000 (UTC)
Message-ID: <1078683747.23560.1464669500716.JavaMail.zimbra__458.889877381985$1464669532$gmane$org@efficios.com>
References: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E393CA36D8
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2016 04:38:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B65C43402CC
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2016 04:38:21 +0000 (UTC)
In-Reply-To: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
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

QWxsIG1lcmdlZCBpbnRvIG1hc3Rlciwgc3RhYmxlLTIuOC4gVGhlIGNvbW1pdCBtYXJrZWQKImZp
eCIgdGhhdCBhcHBseSB0byAyLjcgaGFzIGJlZW4gYmFja3BvcnRlZC4KCi0tLS0tIE9uIE1heSAz
MCwgMjAxNiwgYXQgMTA6MzEgUE0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZpY2lvcy5j
b20gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZm
aWNpb3MuY29tPgo+IC0tLQo+IGluY2x1ZGUvbHR0bmcvdXN0LWRsZmNuLmggfCA0ICsrKysKPiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bHR0bmcvdXN0LWRsZmNuLmggYi9pbmNsdWRlL2x0dG5nL3VzdC1kbGZjbi5oCj4gaW5kZXggYzky
ZjFiYi4uNzQ3MWQ5NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2x0dG5nL3VzdC1kbGZjbi5oCj4g
KysrIGIvaW5jbHVkZS9sdHRuZy91c3QtZGxmY24uaAo+IEBAIC0zMSw2ICszMSw3IEBACj4gI2Vy
cm9yICJQbGVhc2UgaW5jbHVkZSBsdHRuZy91c3QtZGxmY24uaCBiZWZvcmUgZGxmY24uaC4iCj4g
I2VuZGlmIC8qIF9ETEZDTl9IICovCj4gCj4gKyNpZmRlZiBfX0dMSUJDX18KPiAvKgo+ICAqIGds
aWJjIGRlY2xhcmVzIGRsc3ltKCkgYW5kIGRsZXJyb3IoKSB3aXRoIF9fYXR0cmlidXRlX18oKGxl
YWYpKSAoc2VlCj4gICogVEhST1cgYW5ub3RhdGlvbikuIFVuZm9ydHVuYXRlbHksIHRoaXMgaXMg
bm90IGluIHN5bmMgd2l0aCByZWFsaXR5LAo+IEBAIC01Nyw1ICs1OCw4IEBAIGV4dGVybiBpbnQg
ZGxjbG9zZSh2b2lkICpfX2hhbmRsZSkgX19ub25udWxsICgoMSkpOwo+IGV4dGVybiB2b2lkICpk
bHN5bSh2b2lkICpfX3Jlc3RyaWN0IF9faGFuZGxlLAo+IAkJX19jb25zdCBjaGFyICpfX3Jlc3Ry
aWN0IF9fbmFtZSkgX19ub25udWxsICgoMikpOwo+IGV4dGVybiBjaGFyICpkbGVycm9yKHZvaWQp
Owo+ICsjZWxzZQo+ICsjaW5jbHVkZSA8ZGxmY24uaD4KPiArI2VuZGlmIC8qIF9fR0xJQkNfXyAq
Lwo+IAo+ICNlbmRpZiAvKiBfTFRUTkdfVVNUX0RMRkNOX0ggKi8KPiAtLQo+IDIuNy40CgotLSAK
TWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
