From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH] checkpatch: change status of warning from
 "BRACES" to "BRACES_SINGLE_STMT"
Date: Wed, 13 Nov 2013 09:38:08 -0500
Message-ID: <CAGDH53=vS-+mfjsJo8HFNGYsi+UbYgJDNZqd7bxQAYMpJhPf-w__6317.00881426713$1384353550$gmane$org@mail.gmail.com>
References: <1384321468-29220-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VgbaA-00052Z-9I
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 09:38:19 -0500
Received: by mail-ve0-f173.google.com with SMTP id c14so354973vea.18
	for <lttng-dev@lists.lttng.org>; Wed, 13 Nov 2013 06:38:08 -0800 (PST)
In-Reply-To: <1384321468-29220-1-git-send-email-raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?Rapha=C3=ABl_Beamonte?= <raphael.beamonte@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgUmFwaGHDq2wsCgpEbyB5b3UgaGF2ZSBhIHNwZWNpZmljIGV4YW1wbGUgdGhhdCBpcyBmYWls
aW5nIGZvciB0aGlzIGNhc2Ugb2YgYnJhY2VzCmRldGVjdGlvbj8gSSBwYXRjaGVkIGNoZWNrcGF0
Y2ggYSB3aGlsZSBhZ28gaW4gYSBzaW1pbGFyIHdheSBmb3IKYnJhY2VzIGFyb3VuZCBzaW5nbGUg
c3RhdGVtZW50IGJsb2NrcywgSSBkb24ndCByZW1lbWJlciB0aGUgaW50ZW50aW9uCmJlaGluZCB0
aGUgcGFydGljdWxhciBjaGVjayB5b3UgYXJlIHBhdGNoaW5nLgoKVGhhbmtzLAoKQ2hyaXN0aWFu
CgpPbiBXZWQsIE5vdiAxMywgMjAxMyBhdCAxMjo0NCBBTSwgUmFwaGHDq2wgQmVhbW9udGUKPHJh
cGhhZWwuYmVhbW9udGVAZ21haWwuY29tPiB3cm90ZToKPiBUaGUgd2FybmluZyBhYm91dCBicmFj
ZXMgdGhhdCBhcmUgbm90IG5lY2Vzc2FyeSBmb3IgYW55IGFybSBvZiBhIHN0YXRlbWVudAo+IHNo
b3VsZCBiZSBpbnRlcnByZXRlZCBhcyBhIHdhcm5pbmcgYWJvdXQgYnJhY2VzIGFyb3VuZCBzaW5n
bGUgc3RhdGVtZW50cy4KPgo+IFNpZ25lZC1vZmYtYnk6IFJhcGhhw6tsIEJlYW1vbnRlIDxyYXBo
YWVsLmJlYW1vbnRlQGdtYWlsLmNvbT4KPiAtLS0KPiAgZXh0cmFzL2NoZWNrcGF0Y2gucGwgfCAg
ICAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2V4dHJhcy9jaGVja3BhdGNoLnBsIGIvZXh0cmFzL2NoZWNrcGF0Y2gu
cGwKPiBpbmRleCBmZGQ4NDg0Li41YTY3NzA0IDEwMDc1NQo+IC0tLSBhL2V4dHJhcy9jaGVja3Bh
dGNoLnBsCj4gKysrIGIvZXh0cmFzL2NoZWNrcGF0Y2gucGwKPiBAQCAtMzEzOCw3ICszMTM4LDcg
QEAgc3ViIHByb2Nlc3Mgewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICRzdW1fYWxsb3dlZCArPSAkXzsKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoJHN1bV9hbGxvd2VkID09IDApIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBXQVJOKCJCUkFDRVMiLAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFdBUk4oIkJSQUNFU19TSU5HTEVfU1RNVCIsCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYnJh
Y2VzIHt9IGFyZSBub3QgbmVjZXNzYXJ5IGZvciBhbnkgYXJtIG9mIHRoaXMgc3RhdGVtZW50XG4i
IC4gJGhlcmVjdHgpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9
IGVsc2lmICgkc3VtX2FsbG93ZWQgIT0gJGFsbG93ICYmCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICRzZWVuICE9ICRhbGxvdykgewo+IC0tCj4gMS43
LjEwLjQKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+
IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
