From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [RFC PATCH CTF 1/3] Clarify that unlisted enum
 values are implementation-defined
Date: Tue, 28 Apr 2020 14:40:18 -0400 (EDT)
Message-ID: <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BVnk6xfnz1mp6
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 14:40:25 -0400 (EDT)
In-Reply-To: <20200423205226.496-2-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, gbastien+lttng <gbastien+lttng@versatic.net>, diamon-discuss@linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJNYXRoaWV1IERlc25veWVycyIg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiBUbzogImdiYXN0aWVuK2x0dG5nIiA8
Z2Jhc3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0PiwgIk1hdHRoZXcgS2hvdXphbSIgPG1hdHRoZXcu
a2hvdXphbUBlcmljc3Nvbi5jb20+LAo+IGRpYW1vbi1kaXNjdXNzQGxpbnV4Zm91bmRhdGlvbi5v
cmcsIHBwcm91bHhAZWZmaWNpb3MuY29tLCAiSmVyZW1pZSBHYWxhcm5lYXUiIDxqZ2FsYXJAZWZm
aWNpb3MuY29tPgo+IENjOiAibHR0bmctZGV2IiA8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4s
ICJNYXRoaWV1IERlc25veWVycyIgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiBT
ZW50OiBUaHVyc2RheSwgMjMgQXByaWwsIDIwMjAgMTY6NTI6MjQKPiBTdWJqZWN0OiBbUkZDIFBB
VENIIENURiAxLzNdIENsYXJpZnkgdGhhdCB1bmxpc3RlZCBlbnVtIHZhbHVlcyBhcmUgaW1wbGVt
ZW50YXRpb24tZGVmaW5lZAoKPiBGcm9tOiBHZW5ldmnDqHZlIEJhc3RpZW4gPGdiYXN0aWVuK2x0
dG5nQHZlcnNhdGljLm5ldD4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4g
PGdiYXN0aWVuK2x0dG5nQHZlcnNhdGljLm5ldD4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERl
c25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+IGNvbW1vbi10
cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZCB8IDMgKysrCj4gMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNp
ZmljYXRpb24ubWQKPiBiL2NvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZAo+IGlu
ZGV4IGZkNDllNTkuLmY1ZmVhNTEgMTAwNjQ0Cj4gLS0tIGEvY29tbW9uLXRyYWNlLWZvcm1hdC1z
cGVjaWZpY2F0aW9uLm1kCj4gKysrIGIvY29tbW9uLXRyYWNlLWZvcm1hdC1zcGVjaWZpY2F0aW9u
Lm1kCj4gQEAgLTQ2NCw2ICs0NjQsOSBAQCBlbnVtIHsKPiB9Cj4gfn5+Cj4gCj4gK1RoZSBtYXBw
aW5ncyBpbiB0aGUgZW51bWVyYXRpb24gdHlwZSBkbyBub3QgaGF2ZSB0byBiZSBleGhhdXN0aXZl
Lgo+ICtVbmxpc3RlZCB2YWx1ZXMgYXJlIGltcGxlbWVudGF0aW9uIGRlZmluZWQuCj4gKwoKV2h5
IG5vdCBqdXN0OgoKICAgIEFuIGVudW1lcmF0aW9uIGZpZWxkIGNhbiBoYXZlIGFuIGludGVncmFs
IHZhbHVlIHdoaWNoIGl0cyB0eXBlIGRvZXMgbm90CiAgICBtYXAgdG8gYSBzdHJpbmcuCgo/CgpQ
aGlsCgo+ICMjIyA0LjIgQ29tcG91bmQgdHlwZXMKPiAKPiBDb21wb3VuZCBhcmUgYWdncmVnYXRp
b24gb2YgdHlwZSBkZWNsYXJhdGlvbnMuIENvbXBvdW5kIHR5cGVzIGluY2x1ZGUKPiAtLQo+IDIu
MTEuMApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
