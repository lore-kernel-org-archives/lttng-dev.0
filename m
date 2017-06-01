From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace stable-1.5] Fix: Add missing LIBS
	to python bindings
Date: Thu, 1 Jun 2017 14:29:33 -0400
Message-ID: <CA+jJMxsZUbVz7go9RGc4XLynbR_sqtvbKcjKszh0R=BLOJC64g__11924.8091280044$1496341893$gmane$org@mail.gmail.com>
References: <1495823137-7024-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3wdwrs4qBLz11wK
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 18:30:53 +0000 (UTC)
Received: by mail-yb0-x243.google.com with SMTP id r66so1724287yba.3
 for <lttng-dev@lists.lttng.org>; Thu, 01 Jun 2017 11:29:35 -0700 (PDT)
In-Reply-To: <1495823137-7024-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDI2IE1heSAyMDE3IGF0IDE0OjI1LCBNaWNo
YWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gQWxzbyBtb3ZlIGlu
Y2x1ZGVzIHRvIENQUEZMQUdTLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxt
amVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIC5naXRpZ25vcmUgICAgICAgICAgICAgICAg
ICB8IDEgKwo+ICBiaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0gfCA3ICsrKystLS0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvLmdpdGlnbm9yZSBiLy5naXRpZ25vcmUKPiBpbmRleCA5MjU5YjZmLi5lM2RiNDFmIDEw
MDY0NAo+IC0tLSBhLy5naXRpZ25vcmUKPiArKysgYi8uZ2l0aWdub3JlCj4gQEAgLTU0LDUgKzU0
LDYgQEAgYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UvX19pbml0X18ucHkKPiAgYmluZGluZ3Mv
cHl0aG9uL2JhYmVsdHJhY2UvYmFiZWx0cmFjZS5pCj4gIGJpbmRpbmdzL3B5dGhvbi9iYWJlbHRy
YWNlL2JhYmVsdHJhY2UucHkKPiAgYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UvYmFiZWx0cmFj
ZV93cmFwLmMKPiArYmluZGluZ3MvcHl0aG9uL2J1aWxkLXB5dGhvbi1iaW5kaW5ncy5zdGFtcAo+
ICBiYWJlbHRyYWNlLnBjCj4gIGJhYmVsdHJhY2UtY3RmLnBjCj4gZGlmZiAtLWdpdCBhL2JpbmRp
bmdzL3B5dGhvbi9NYWtlZmlsZS5hbSBiL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZS5hbQo+IGlu
ZGV4IDllNDQxMjcuLmY2ODA2YTggMTAwNjQ0Cj4gLS0tIGEvYmluZGluZ3MvcHl0aG9uL01ha2Vm
aWxlLmFtCj4gKysrIGIvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlLmFtCj4gQEAgLTIzLDkgKzIz
LDEwIEBAIEJJTkRJTkdTX0RFUFM9c2V0dXAucHkgXAo+ICAgICAgICAgICAgICAgICBiYWJlbHRy
YWNlL3B5dGhvbi1jb21wbGVtZW50cy5oCj4KPiAgQlVJTERfRkxBR1M9Q0M9IiQoQ0MpIiBcCj4g
LSAgICAgICAgICAgICAgIENGTEFHUz0iJChERUZTKSAkKERFRkFVTFRfSU5DTFVERVMpICQoSU5D
TFVERVMpICQoR0xJQl9DRkxBR1MpICQoQU1fQ0ZMQUdTKSIgXAo+IC0gICAgICAgICAgICAgICBD
UFBGTEFHUz0iJChBTV9DUFBGTEFHUykgJChDUFBGTEFHUykiIFwKPiAtICAgICAgICAgICAgICAg
TERGTEFHUz0iJChBTV9MREZMQUdTKSAkKExERkxBR1MpIgo+ICsgICAgICAgICAgICAgICBDRkxB
R1M9IiQoR0xJQl9DRkxBR1MpICQoQU1fQ0ZMQUdTKSAkKENGTEFHUykiIFwKPiArICAgICAgICAg
ICAgICAgQ1BQRkxBR1M9IiQoREVGUykgJChERUZBVUxUX0lOQ0xVREVTKSAkKEFNX0NQUEZMQUdT
KSAkKENQUEZMQUdTKSIgXAo+ICsgICAgICAgICAgICAgICBMREZMQUdTPSIkKEFNX0xERkxBR1Mp
ICQoTERGTEFHUykiIFwKPiArICAgICAgICAgICAgICAgTElCUz0iJChHTElCX0xJQlMpICQoTElC
UykiCj4KPiAgYnVpbGQtcHl0aG9uLWJpbmRpbmdzLnN0YW1wOiAkKEJJTkRJTkdTX0RFUFMpCj4g
ICAgICAgICAkKEJVSUxEX0ZMQUdTKSAkKFBZVEhPTikgJChidWlsZGRpcikvc2V0dXAucHkgYnVp
bGRfZXh0Cj4gLS0KPiAyLjcuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
