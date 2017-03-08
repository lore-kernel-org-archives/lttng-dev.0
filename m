From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: kref changes for kernel 4.11
Date: Tue,  7 Mar 2017 23:37:30 -0500
Message-ID: <1488947850-25483-1-git-send-email-francis.deslauriers__44934.3311753639$1488947892$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdLP05PPfzw3d
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 04:37:56 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhlIHVuZGVybHlpbmcgdHlwZSBvZiBgc3RydWN0IGtyZWZgIGNoYW5nZWQgaW4ga2VybmVsIDQu
MTEgZnJvbSBhbgphdG9taWNfdCB0byBhIHJlZmNvdW50X3QuIFRoaXMgY2hhbmdlIHdhcyBpbnRy
b2R1Y2VkIGluIGtlcm5lbApjb21taXQ6MTAzODNhZS4gVGhpcyBjb21taXQgYWxzbyBhZGRlZCBh
IGJ1aWx0aW4gb3ZlcmZsb3cgY2hlY2tzIHRvCmBrcmVmX2dldCgpYCBzbyB3ZSB1c2UgaXQuCgpT
aWduZWQtb2ZmLWJ5OiBGcmFuY2lzIERlc2xhdXJpZXJzIDxmcmFuY2lzLmRlc2xhdXJpZXJzQGVm
ZmljaW9zLmNvbT4KLS0tCiB3cmFwcGVyL2tyZWYuaCB8IDggKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93cmFwcGVyL2tyZWYuaCBiL3dyYXBw
ZXIva3JlZi5oCmluZGV4IGYzMGE5YWUuLjhkYjA1YjUgMTAwNjQ0Ci0tLSBhL3dyYXBwZXIva3Jl
Zi5oCisrKyBiL3dyYXBwZXIva3JlZi5oCkBAIC0zNCw5ICszNCwxNyBAQAogICoKICAqIFJldHVy
biAxIGlmIHJlZmVyZW5jZSBpcyB0YWtlbiwgMCBvdGhlcndpc2UgKG92ZXJmbG93KS4KICAqLwor
I2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxMSwwKSkKK3N0YXRp
YyBpbmxpbmUgaW50IGx0dG5nX2tyZWZfZ2V0KHN0cnVjdCBrcmVmICprcmVmKQoreworCWtyZWZf
Z2V0KGtyZWYpOworCXJldHVybiAxOworfQorI2Vsc2UgLyogI2lmIChMSU5VWF9WRVJTSU9OX0NP
REUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxMSwwKSkgKi8KIHN0YXRpYyBpbmxpbmUgaW50IGx0dG5n
X2tyZWZfZ2V0KHN0cnVjdCBrcmVmICprcmVmKQogewogCXJldHVybiBhdG9taWNfYWRkX3VubGVz
cygma3JlZi0+cmVmY291bnQsIDEsIElOVF9NQVgpOwogfQorI2VuZGlmIC8qICNlbHNlICNpZiAo
TElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsMTEsMCkpICovCiAKICNlbmRp
ZiAvKiBfTFRUTkdfV1JBUFBFUl9LUkVGX0ggKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
