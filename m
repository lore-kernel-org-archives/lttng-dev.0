From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: kref changes for kernel
	4.11
Date: Wed, 8 Mar 2017 16:59:05 +0000 (UTC)
Message-ID: <1881846116.720.1488992345506.JavaMail.zimbra__20149.1114021794$1488992349$gmane$org@efficios.com>
References: <1488947850-25483-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdfqn31Xdzw6X
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 16:58:44 +0000 (UTC)
In-Reply-To: <1488947850-25483-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CgotLS0tLSBPbiBNYXIgNywgMjAxNywgYXQgMTE6MzcgUE0sIEZyYW5jaXMgRGVzbGF1cmllcnMg
ZnJhbmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IFRoZSB1bmRlcmx5aW5n
IHR5cGUgb2YgYHN0cnVjdCBrcmVmYCBjaGFuZ2VkIGluIGtlcm5lbCA0LjExIGZyb20gYW4KPiBh
dG9taWNfdCB0byBhIHJlZmNvdW50X3QuIFRoaXMgY2hhbmdlIHdhcyBpbnRyb2R1Y2VkIGluIGtl
cm5lbAo+IGNvbW1pdDoxMDM4M2FlLiBUaGlzIGNvbW1pdCBhbHNvIGFkZGVkIGEgYnVpbHRpbiBv
dmVyZmxvdyBjaGVja3MgdG8KPiBga3JlZl9nZXQoKWAgc28gd2UgdXNlIGl0Lgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IEZyYW5jaXMgRGVzbGF1cmllcnMgPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNp
b3MuY29tPgo+IC0tLQo+IHdyYXBwZXIva3JlZi5oIHwgOCArKysrKysrKwo+IDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvd3JhcHBlci9rcmVmLmggYi93
cmFwcGVyL2tyZWYuaAo+IGluZGV4IGYzMGE5YWUuLjhkYjA1YjUgMTAwNjQ0Cj4gLS0tIGEvd3Jh
cHBlci9rcmVmLmgKPiArKysgYi93cmFwcGVyL2tyZWYuaAo+IEBAIC0zNCw5ICszNCwxNyBAQAo+
ICAqCj4gICogUmV0dXJuIDEgaWYgcmVmZXJlbmNlIGlzIHRha2VuLCAwIG90aGVyd2lzZSAob3Zl
cmZsb3cpLgo+ICAqLwo+ICsjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lP
Tig0LDExLDApKQoKRG9uJ3QgZm9yZ2V0IHRvIGluY2x1ZGUgCgojaW5jbHVkZSA8bGludXgvdmVy
c2lvbi5oPgoKSSdsbCBhZGQgaXQgbG9jYWxseSBhcyBJIG1lcmdlIGl0IGludG8gbWFzdGVyIGFu
ZCAyLjkuCgpUaGFua3MsCgpNYXRoaWV1Cgo+ICtzdGF0aWMgaW5saW5lIGludCBsdHRuZ19rcmVm
X2dldChzdHJ1Y3Qga3JlZiAqa3JlZikKPiArewo+ICsJa3JlZl9nZXQoa3JlZik7Cj4gKwlyZXR1
cm4gMTsKPiArfQo+ICsjZWxzZSAvKiAjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxf
VkVSU0lPTig0LDExLDApKSAqLwo+IHN0YXRpYyBpbmxpbmUgaW50IGx0dG5nX2tyZWZfZ2V0KHN0
cnVjdCBrcmVmICprcmVmKQo+IHsKPiAJcmV0dXJuIGF0b21pY19hZGRfdW5sZXNzKCZrcmVmLT5y
ZWZjb3VudCwgMSwgSU5UX01BWCk7Cj4gfQo+ICsjZW5kaWYgLyogI2Vsc2UgI2lmIChMSU5VWF9W
RVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxMSwwKSkgKi8KPiAKPiAjZW5kaWYgLyog
X0xUVE5HX1dSQVBQRVJfS1JFRl9IICovCj4gLS0KPiAyLjcuNAoKLS0gCk1hdGhpZXUgRGVzbm95
ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
