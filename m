From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu AC_FUNC_MALLOC fails for cross-compile
Date: Tue, 14 Jun 2016 16:21:04 +0000 (UTC)
Message-ID: <418211441.35787.1465921264498.JavaMail.zimbra__27684.1889288791$1465922214$gmane$org@efficios.com>
References: <A96D5DC1-9242-4C88-ADE1-150DCAE62C54@indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3E4D8A3877
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 16:21:10 +0000 (UTC)
In-Reply-To: <A96D5DC1-9242-4C88-ADE1-150DCAE62C54@indiana.edu>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Luke K D'Alessandro <ldalessa@indiana.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gSnVuIDE0LCAyMDE2LCBhdCAxMjoxMiBQTSwgTHVrZSBLIEQnQWxlc3NhbmRybyBs
ZGFsZXNzYUBpbmRpYW5hLmVkdSB3cm90ZToKCj4gVGhlIEFDX0ZVTkNfTUFMTE9DIGRlcGVuZHMg
b24gc29tZSBydW50aW1lIHJlc3VsdHMgd2hpY2ggZG9lc24ndCB3b3JrIHdoZW4gY3Jvc3MKPiBj
b21waWxpbmcuIEdvb2dsZSBoYXMgYSBiaXQgdG8gc2F5IGFib3V0IHRoaXMgYW5kIGJhc2ljYWxs
eSB0aGUgZml4IGlzIHRvIHN0b3AKPiB1c2luZyB0aGUgbWFjcm8uIElzIHRoZXJlIGEgc3BlY2lm
aWMgcHVycG9zZSBmb3IgdGhpcyBjaGVjaywgb3IgY291bGQgaXQganVzdAo+IGJlIGVsaW1pbmF0
ZWQgZnJvbSBjb25maWd1cmUuYWM/CgpJZiB3ZSByZW1vdmUgdGhpcyBjaGVjaywgd2UgbmVlZCB0
byBlbnN1cmUgdGhhdCBVUkNVIGRvZXMgbm90IGRlcGVuZApvbiBtYWxsb2MoMCkgcmV0dXJuaW5n
IG5vbi1OVUxMIGFueXdoZXJlLgoKVGhhbmtzLAoKTWF0aGlldQoKPiAKPiBUaGFua3MsCj4gTHVr
ZQo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
bHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cgot
LSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNv
bQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
