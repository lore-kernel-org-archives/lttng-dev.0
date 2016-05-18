From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: merge tap tests stdout and
	stderr
Date: Wed, 18 May 2016 17:55:14 -0400
Message-ID: <CA+jJMxtXjNHDmo5-VDF45+aYe=52XtNEgVyUnFL1jbohDOw7yA__9150.77871545709$1463608542$gmane$org@mail.gmail.com>
References: <1463600586-29374-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f68.google.com (mail-qg0-f68.google.com
 [209.85.192.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 09E4FA35A4
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 21:55:16 +0000 (UTC)
Received: by mail-qg0-f68.google.com with SMTP id 90so5360339qgz.0
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 14:55:15 -0700 (PDT)
In-Reply-To: <1463600586-29374-1-git-send-email-mjeanson@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFdlZCwgTWF5IDE4LCAyMDE2IGF0IDM6NDMg
UE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBUaGlz
IG1ha2VzIHRoZSBvdXRwdXQgYW5kIGVycm9yIHN0YXRlbWVudCBvcmRlcmVkIGluIHRoZSBsb2cK
PiBmaWxlIGFuZCBlbnN1cmUgdGhhdCB0aGUgZmlyc3QgbGluZSBpcyB0aGUgdGFwIHRlc3QgcGxh
bi4gU29tZSB0YXAKPiBwYXJzZXIgYXJlIGNvbmZ1c2VkIGlmIHRoZSB0ZXN0IHBsYW4gaXMgbm90
IG9uIHRoZSBmaXJzdCBsaW5lLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxt
amVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL3JlZ3Jlc3Npb24vTWFrZWZpbGUu
YW0gfCAxICsKPiAgdGVzdHMvdW5pdC9NYWtlZmlsZS5hbSAgICAgICB8IDEgKwo+ICAyIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Np
b24vTWFrZWZpbGUuYW0gYi90ZXN0cy9yZWdyZXNzaW9uL01ha2VmaWxlLmFtCj4gaW5kZXggNWY0
YTZlNC4uNmEyZDI0YyAxMDA2NDQKPiAtLS0gYS90ZXN0cy9yZWdyZXNzaW9uL01ha2VmaWxlLmFt
Cj4gKysrIGIvdGVzdHMvcmVncmVzc2lvbi9NYWtlZmlsZS5hbQo+IEBAIC0xLDUgKzEsNiBAQAo+
ICBTVUJESVJTID0gdG9vbHMga2VybmVsIHVzdAo+Cj4gK0xPR19EUklWRVJfRkxBR1M9Jy0tbWVy
Z2UnCj4gIExPR19EUklWRVIgPSBlbnYgQU1fVEFQX0FXSz0nJChBV0spJyAkKFNIRUxMKSBcCj4g
ICAgICAgICAkKHRvcF9zcmNkaXIpL2NvbmZpZy90YXAtZHJpdmVyLnNoCj4KPiBkaWZmIC0tZ2l0
IGEvdGVzdHMvdW5pdC9NYWtlZmlsZS5hbSBiL3Rlc3RzL3VuaXQvTWFrZWZpbGUuYW0KPiBpbmRl
eCBiN2YzMThmLi41NjI1Y2YwIDEwMDY0NAo+IC0tLSBhL3Rlc3RzL3VuaXQvTWFrZWZpbGUuYW0K
PiArKysgYi90ZXN0cy91bml0L01ha2VmaWxlLmFtCj4gQEAgLTMsNiArMyw3IEBAIFNVQkRJUlMg
PSBpbmlfY29uZmlnCj4gIEFNX0NGTEFHUyA9IC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlIC1JJCh0
b3Bfc3JjZGlyKS9zcmMgLUkkKHRvcF9zcmNkaXIpL3Rlc3RzL3V0aWxzLyAtSSQoc3JjZGlyKQo+
ICBBTV9MREZMQUdTID0KPgo+ICtMT0dfRFJJVkVSX0ZMQUdTPSctLW1lcmdlJwo+ICBMT0dfRFJJ
VkVSID0gZW52IEFNX1RBUF9BV0s9JyQoQVdLKScgJChTSEVMTCkgXAo+ICAgICAgICAgJCh0b3Bf
c3JjZGlyKS9jb25maWcvdGFwLWRyaXZlci5zaAo+Cj4gLS0KPiAyLjcuNAo+CgoKCi0tIApKw6ly
w6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
