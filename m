From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: PID namespace support
Date: Wed, 17 Jul 2019 10:52:53 -0400
Message-ID: <20190717145253.GA15428__6443.63272456161$1563375199$gmane$org@joraj-alpa>
References: <tencent_53C71FC745A56F7A4D6DD9CA@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45pgHM2YX8z1DCX
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2019 10:53:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C826C2A8867
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2019 10:52:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <tencent_53C71FC745A56F7A4D6DD9CA@qq.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?5p2o5rW3?= <hai.yang@magic-shield.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgSGFpLAoKVGhlIHN1cHBvcnQgb2YgbmFtZXNwYWNlIGlzIHNjaGVkdWxlZCBmb3IgbHR0bmcg
Mi4xMi4KCllvdSBjYW4gY2hlY2sgdGhlIHB1bGwgcmVxdWVzdHMgZm9yIGJvdGggbHR0bmctdXN0
LCBsdHRuZy1tb2R1bGVzIGFuZApsdHRuZy10b29sczoKCmx0dG5nLW1vZHVsZXM6IGh0dHBzOi8v
Z2l0aHViLmNvbS9sdHRuZy9sdHRuZy1tb2R1bGVzL3B1bGwvMjAvY29tbWl0cwpsdHRuZy11c3Q6
IGh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy11c3QvcHVsbC81NQpsdHRuZy10b29sczog
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvcGlwZXJtYWlsL2x0dG5nLWRldi8yMDE4LU1hcmNoLzAy
Nzg3NC5odG1sCgpDaGVlcnMuCgpPbiBXZWQsIEp1bCAxNywgMjAxOSBhdCAwNzozMDozMVBNICsw
ODAwLCDmnajmtbcgd3JvdGU6Cj4gSGksCj4gCj4gCj4gTm9ybWFsbHkgdHdvIHByb2Nlc3NlcyB3
b24ndCBoYXZlIHRoZSBzYW1lIFBJRCB3aGlsZSBuYW1lc3BhY2UgbWFrZSBpdCBwb3NzaWJsZS4g
SGFzIExUVG5nIGVuYWJsZWQgUElEIG5hbWVzcGFjZSBzdXBwb3J0IHNvIHRoYXQgY29udGFpbmVy
IGlkIGNhbiBiZSBzdXBwbGllZCB0b2dldGhlciB3aXRoIFBJRCBpbiBTWVNDQUxMIGV2ZW50cz8K
PiAKPiAKPiBSZWdhcmRzCj4gSGFpCgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2CgoKLS0gCkpvbmF0aGFuIFJham90dGUtSnVsaWVuCkVmZmljaU9TCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
