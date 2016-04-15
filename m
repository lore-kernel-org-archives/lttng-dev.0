From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC lttng-ust] Renaming llttng_ust_statedump:soinfo
Date: Fri, 15 Apr 2016 19:55:57 +0000 (UTC)
Message-ID: <533463365.60094.1460750157256.JavaMail.zimbra__39251.6250642531$1460750177$gmane$org@efficios.com>
References: <CA+MZcXugBpNuWEoMbfP+WioDyhdcUkymj4zOdD+5Sd2Vig8X4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2FC19A30C6
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:55:58 +0000 (UTC)
In-Reply-To: <CA+MZcXugBpNuWEoMbfP+WioDyhdcUkymj4zOdD+5Sd2Vig8X4Q@mail.gmail.com>
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

LS0tLS0gT24gQXByIDE1LCAyMDE2LCBhdCAzOjQzIFBNLCBBbnRvaW5lIEJ1c3F1ZSBhYnVzcXVl
QGVmZmljaW9zLmNvbSB3cm90ZToKCj4gSGksCj4gCj4gSSdkIGxpa2UgdG8gc3VnZ2VzdCByZW5h
bWluZyB0aGUgbHR0bmdfdXN0X3N0YXRlZHVtcDpzb2luZm8gZXZlbnQuCj4gSW5kZWVkLCB0aGUg
Y3VycmVudCBuYW1lIGZlZWxzIHNvbWV3aGF0IG1pc2xlYWRpbmcgZ2l2ZW4gdGhhdCBpdAo+IGFw
cGxpZXMgbm90IG9ubHkgdG8gbG9hZGVkIHNoYXJlZCBvYmplY3RzLCAgYnV0IGFsc28gdG8gZXhl
Y3V0YWJsZXMsCj4gd2hldGhlciB0aGV5IGFyZSBwb3NpdGlvbi1pbmRlcGVuZGVudCBleGVjdXRh
YmxlcyAoUElFKSBvciBub3QuCj4gCj4gSSB3b3VsZCBwcm9wb3NlIGNoYW5naW5nIHRoZSBuYW1l
IHRvICJiaW5faW5mbyIsIGFzIEkgZmVlbCB0aGlzIHdvdWxkCj4gZW5jb21wYXNzIGJvdGggZXhl
Y3V0YWJsZXMgYW5kIHNoYXJlZCBvYmplY3RzLiBUaGUgZXZlbnQncyBmaWVsZAo+ICJzb3BhdGgi
IHNob3VsZCBhbHNvIGJlIHJlbmFtZWQgdG8gc2ltcGx5ICJwYXRoIiBmb3IgdGhlIHNhbWUKPiBy
ZWFzb25zLgo+IAo+IEkgdGhpbmsgaXQncyBpbXBvcnRhbnQgdG8ga2VlcCB0byBhIG1pbmltdW0g
c3VjaCBuYW1lIGNoYW5nZXMsIGJ1dCBub3cKPiBzZWVtcyBsaWtlIGEgcmVhc29uYWJsZSB0aW1l
IHRvIGRvIGl0IGJlZm9yZSBpdCBiZWNvbWVzIHdpZGVseSB1c2VkCj4gZm9yIGFuYWx5c2VzIGlu
IGJhYmVsdHJhY2UgYW5kIFRyYWNlIENvbXBhc3MuCj4gCj4gVGhvdWdodHM/CgpJbmRlZWQsIHRo
b3NlIG5ldyBmaWVsZCBuYW1lcyB3b3VsZCBiZSBjbGVhbmVyLiBBRkFJSywgdGhpcyB3b3VsZCBi
ZSBhIGdvb2QKdGltaW5nIHRvIGRvIHRoaXMgY2hhbmdlIGJlZm9yZSBUcmFjZSBDb21wYXNzLCBC
YWJlbHRyYWNlIGFuZCBMVFRuZyBBbmFseXNlcwpzdGFydCB0byByZWFsbHkgdXNlIHRoZXNlIGZp
ZWxkcy4KCklmIHRoZXJlIGFyZSBvdGhlciB2aWV3ZXJzIHRoYXQgcmVhbGx5IGRlZXBseSBjYXJl
IGFib3V0IHRoZSBuYW1lIG9mCnRob3NlIGZpZWxkcywgc3BlYWsgdXAgbm93LgoKVGhhbmtzLAoK
TWF0aGlldQoKPiAKPiBCZXN0IHJlZ2FyZHMsCj4gQW50b2luZSBCdXNxdWUuCgotLSAKTWF0aGll
dSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
