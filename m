From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] FIX: Align buffers on 4 bytes for 64bit
 access
Date: Thu, 15 May 2014 17:45:19 +0000 (UTC)
Message-ID: <274427862.18250.1400175919010.JavaMail.zimbra__14482.0588910536$1400175994$gmane$org@efficios.com>
References: <1400144250-26852-1-git-send-email-rongqing.li@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Wkzic-0003SZ-PB
 for lttng-dev@lists.lttng.org; Thu, 15 May 2014 13:45:28 -0400
In-Reply-To: <1400144250-26852-1-git-send-email-rongqing.li@windriver.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: rongqing li <rongqing.li@windriver.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJyb25ncWluZyBsaSIgPHJvbmdx
aW5nLmxpQHdpbmRyaXZlci5jb20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBT
ZW50OiBUaHVyc2RheSwgTWF5IDE1LCAyMDE0IDQ6NTc6MzAgQU0KPiBTdWJqZWN0OiBbbHR0bmct
ZGV2XSBbUEFUQ0hdIEZJWDogQWxpZ24gYnVmZmVycyBvbiA0IGJ5dGVzIGZvciA2NGJpdCBhY2Nl
c3MKCldoeSBoYXJkY29kZWQgY29uc3RhbnRzID8gV2h5IDQgPyBXaGF0IGlzIHRoZSBpbnRlbnQg
PwoKVGhhbmtzLAoKTWF0aGlldQoKPiAKPiBGcm9tOiBGcmVkcmlrIE1hcmtzdHLDtm0gPGZyZWRy
aWsubWFya3N0cm9tQGdtYWlsLmNvbT4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBGcmVkcmlrIE1hcmtz
dHLmnpptIDxmcmVkcmlrLm1hcmtzdHJvbUBnbWFpbC5jb20+Cj4gLS0tCj4gIGZvcm1hdHMvY3Rm
L21ldGFkYXRhL29ianN0YWNrLmMgfCAgICAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3RhY2su
Ywo+IGIvZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3RhY2suYwo+IGluZGV4IDllMjY0YTQuLjk2
NDNiOWIgMTAwNjQ0Cj4gLS0tIGEvZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3RhY2suYwo+ICsr
KyBiL2Zvcm1hdHMvY3RmL21ldGFkYXRhL29ianN0YWNrLmMKPiBAQCAtMTE4LDYgKzExOCw4IEBA
IHZvaWQgKm9ianN0YWNrX2FsbG9jKHN0cnVjdCBvYmpzdGFjayAqb2Jqc3RhY2ssIHNpemVfdAo+
IGxlbikKPiAgCXN0cnVjdCBvYmpzdGFja19ub2RlICpsYXN0X25vZGU7Cj4gIAl2b2lkICpwOwo+
ICAKPiArCWxlbiA9IChsZW4gKyAzKSAmIH4zOwo+ICsKPiAgCS8qIEdldCBsYXN0IG5vZGUgKi8K
PiAgCWxhc3Rfbm9kZSA9IGJ0X2xpc3RfZW50cnkob2Jqc3RhY2stPmhlYWQucHJldiwKPiAgCQkJ
c3RydWN0IG9ianN0YWNrX25vZGUsIG5vZGUpOwo+IC0tCj4gMS43LjEwLjQKPiAKPiAKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cDovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4gCgotLSAKTWF0aGll
dSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
