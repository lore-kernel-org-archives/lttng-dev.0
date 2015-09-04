From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: make check in OOT build
	with absolute path
Date: Fri, 4 Sep 2015 17:48:42 -0400
Message-ID: <CA+jJMxvrq9s=g4ccwouZh_0EoM9x-ahtTHiZ1=i7JT7mMCQKmg__2473.62576560608$1441403503$gmane$org@mail.gmail.com>
References: <1441401792-18815-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZXyql-0005LS-Ok
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 17:48:53 -0400
Received: by ykei199 with SMTP id i199so33874666yke.0
 for <lttng-dev@lists.lttng.org>; Fri, 04 Sep 2015 14:48:42 -0700 (PDT)
In-Reply-To: <1441401792-18815-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIGJvdGggbWFzdGVyIGFuZCBzdGFibGUtMS4yLgoKVGhhbmtzIQpKw6lyw6ltaWUK
Ck9uIEZyaSwgU2VwIDQsIDIwMTUgYXQgNToyMyBQTSwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNv
bkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFRoZSBwcmV2aW91cyBwYXRjaCBmaXhlZCB0aGUgb3V0
IG9mIHRyZWUgYnVpbGQgd2hlbiB0aGUgY29uZmlndXJlIHNjcmlwdAo+IHdhcyBjYWxsZWQgd2l0
aCBhIHBhdGggcmVsYXRpdmUgdG8gdGhlIGJ1aWxkZGlyIGJ1dCBzdGlsbCBmYWlsZWQgd2hlbgo+
IHRoZSBwYXRoIHdhcyBhYnNvbHV0ZS4gVGhpcyB3b3JrcyB3aXRoIGJvdGguCj4KPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAg
dGVzdHMvYmluL01ha2VmaWxlLmFtICAgICAgICB8IDIgKy0KPiAgdGVzdHMvYmluL3Rlc3RfdHJh
Y2VfcmVhZC5pbiB8IDIgKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvYmluL01ha2VmaWxlLmFtIGIvdGVz
dHMvYmluL01ha2VmaWxlLmFtCj4gaW5kZXggMDI0NTIzOC4uMDg2OTE5YiAxMDA2NDQKPiAtLS0g
YS90ZXN0cy9iaW4vTWFrZWZpbGUuYW0KPiArKysgYi90ZXN0cy9iaW4vTWFrZWZpbGUuYW0KPiBA
QCAtMyw1ICszLDUgQEAgQ0xFQU5GSUxFUyA9ICQobm9pbnN0X1NDUklQVFMpCj4gIEVYVFJBX0RJ
U1QgPSB0ZXN0X3RyYWNlX3JlYWQuaW4KPgo+ICAkKG5vaW5zdF9TQ1JJUFRTKTogJTogJS5pbgo+
IC0gICAgICAgc2VkICJzI0BUT1BTUkNESVJAIyQodG9wX3NyY2RpcikjZyIgPCAkPCA+ICRACj4g
KyAgICAgICBzZWQgInMjQEFCU1RPUFNSQ0RJUkAjJChhYnNfdG9wX3NyY2RpcikjZyIgPCAkPCA+
ICRACj4gICAgICAgICBjaG1vZCAreCAkQAo+IGRpZmYgLS1naXQgYS90ZXN0cy9iaW4vdGVzdF90
cmFjZV9yZWFkLmluIGIvdGVzdHMvYmluL3Rlc3RfdHJhY2VfcmVhZC5pbgo+IGluZGV4IGY5NDEw
ZTUuLjc2MWZkMDUgMTAwNzU1Cj4gLS0tIGEvdGVzdHMvYmluL3Rlc3RfdHJhY2VfcmVhZC5pbgo+
ICsrKyBiL3Rlc3RzL2Jpbi90ZXN0X3RyYWNlX3JlYWQuaW4KPiBAQCAtMjAsNyArMjAsNyBAQCBU
RVNURElSPSRDVVJESVIvLi4KPgo+ICBCQUJFTFRSQUNFX0JJTj0kQ1VSRElSLy4uLy4uL2NvbnZl
cnRlci9iYWJlbHRyYWNlCj4KPiAtQ1RGX1RSQUNFUz0kQ1VSRElSL0BUT1BTUkNESVJAL3Rlc3Rz
L2N0Zi10cmFjZXMKPiArQ1RGX1RSQUNFUz1AQUJTVE9QU1JDRElSQC90ZXN0cy9jdGYtdHJhY2Vz
Cj4KPiAgc291cmNlICRURVNURElSL3V0aWxzL3RhcC90YXAuc2gKPgo+IC0tCj4gMS45LjEKPgoK
CgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNp
b3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
