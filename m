From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] lttng-tools: remove bogus interpreter line
 from utils shell library
Date: Mon, 9 Jan 2017 19:52:27 -0500
Message-ID: <CA+jJMxsmDdNNckOWuLQQdSNGV4jz7dy+yqkVAaPk0kv0QB=yXw__20669.6498128169$1484009565$gmane$org@mail.gmail.com>
References: <1484000068-27224-1-git-send-email-nathan_lynch@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 by lists.lttng.org (Postfix) with ESMTPS id 3tyD6Y6yQlzkRY
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jan 2017 00:53:41 +0000 (UTC)
Received: by mail-vk0-x244.google.com with SMTP id 23so1609984vkc.2
 for <lttng-dev@lists.lttng.org>; Mon, 09 Jan 2017 16:52:28 -0800 (PST)
In-Reply-To: <1484000068-27224-1-git-send-email-nathan_lynch@mentor.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Nathan Lynch <nathan_lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuOSBhbmQgc3RhYmxlLTIuOC4KClRoYW5rcyEKSsOp
csOpbWllCgpPbiA5IEphbnVhcnkgMjAxNyBhdCAxNzoxNCwgTmF0aGFuIEx5bmNoIDxuYXRoYW5f
bHluY2hAbWVudG9yLmNvbT4gd3JvdGU6Cj4gdGVzdHMvdXRpbHMvdXRpbHMuc2ggaXMgYWx3YXlz
IHNvdXJjZWQsIG5ldmVyIGV4ZWN1dGVkLCBhbmQKPiAvc3JjL2Jpbi9iYXNoIGlzIG5vdCBhIHR5
cGljYWwgcGF0aCBmb3IgYSBzaGVsbCBpbnRlcnByZXRlci4gIEp1c3QKPiBkZWxldGUgaXQuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gTHluY2ggPG5hdGhhbl9seW5jaEBtZW50b3IuY29tPgo+
IC0tLQo+ICB0ZXN0cy91dGlscy91dGlscy5zaCB8IDIgLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdXRpbHMvdXRpbHMuc2ggYi90ZXN0
cy91dGlscy91dGlscy5zaAo+IGluZGV4IDA1ZDg4NjUwZTlmMy4uOWRiMDY0MGI3MGYzIDEwMDY0
NAo+IC0tLSBhL3Rlc3RzL3V0aWxzL3V0aWxzLnNoCj4gKysrIGIvdGVzdHMvdXRpbHMvdXRpbHMu
c2gKPiBAQCAtMSw1ICsxLDMgQEAKPiAtIyEvc3JjL2Jpbi9iYXNoCj4gLSMKPiAgIyBDb3B5cmln
aHQgKEMpIC0gMjAxMiBEYXZpZCBHb3VsZXQgPGRnb3VsZXRAZWZmaWNpb3MuY29tPgo+ICAjCj4g
ICMgVGhpcyBsaWJyYXJ5IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vciBtb2RpZnkgaXQgdW5kZXIKPiAtLQo+IDIuNy40Cj4KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
PiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVh
dQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
