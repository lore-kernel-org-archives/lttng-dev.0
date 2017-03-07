From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: update btrfs
 instrumentation for kernel 4.11
Date: Tue, 7 Mar 2017 15:00:44 +0000 (UTC)
Message-ID: <760647670.31539.1488898844900.JavaMail.zimbra__31663.5670642883$1488898840$gmane$org@efficios.com>
References: <1488898408-27166-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vd0GN18xhzlJT
 for <lttng-dev@lists.lttng.org>; Tue,  7 Mar 2017 15:01:00 +0000 (UTC)
In-Reply-To: <1488898408-27166-1-git-send-email-francis.deslauriers@efficios.com>
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

Ci0tLS0tIE9uIE1hciA3LCAyMDE3LCBhdCA5OjUzIEFNLCBGcmFuY2lzIERlc2xhdXJpZXJzIGZy
YW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBG
cmFuY2lzIERlc2xhdXJpZXJzIDxmcmFuY2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbT4KPiAt
LS0KPiBpbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9idHJmcy5oIHwgOSArKysr
KysrKysKPiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBh
L2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2J0cmZzLmgKPiBiL2luc3RydW1l
bnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2J0cmZzLmgKPiBpbmRleCBjYzdiYTUwLi4yOTU1
ZTI4IDEwMDY0NAo+IC0tLSBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2J0
cmZzLmgKPiArKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9idHJmcy5o
Cj4gQEAgLTg3LDkgKzg3LDE4IEBAIExUVE5HX1RSQUNFUE9JTlRfRVZFTlRfSU5TVEFOQ0UoYnRy
ZnNfX2lub2RlLAo+IGJ0cmZzX2lub2RlX2V2aWN0LAo+IAo+IExUVE5HX1RSQUNFUE9JTlRfRVZF
TlQoYnRyZnNfZ2V0X2V4dGVudCwKPiAKPiArI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VS
TkVMX1ZFUlNJT04oNCwxMSwwKSkKPiArCj4gKwlUUF9QUk9UTyhzdHJ1Y3QgYnRyZnNfcm9vdCAq
cm9vdCwgc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwKPiArCQlzdHJ1Y3QgZXh0ZW50X21hcCAq
bWFwKSwKPiArCj4gKyNlbHNlIC8qICNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9W
RVJTSU9OKDQsMTEsMCkpICovCj4gKwo+IAlUUF9QUk9UTyhzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9v
dCwgc3RydWN0IGlub2RlICppbm9kZSwKPiAJCXN0cnVjdCBleHRlbnRfbWFwICptYXApLAo+IAo+
ICsjZW5kaWYgLyogI2Vsc2UgI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJ
T04oNCwxMSwwKSkgKi8KPiArCgpQbGVhc2UgdHJ5IHRvIGtlZXAgdGhlICNpZmRlZmZlcnkgYXJv
dW5kIHRoZSBlbnRpcmUgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVCwKZXZlbiBpZiBpdCBtZWFucyB3
ZSBjb3B5LXBhc3RlIGEgYml0IG9mIGNvZGUuIEl0IGJlY29tZXMgZWFzaWVyIHRvCm1haW50YWlu
IGluIHRoZSBsb25nIHJ1biB0aGFuIGhhdmluZyBzcGFnaGV0dGktbGlrZSBpZmRlZnMgd2l0aGlu
IHRoZQptYWNyb3MuCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAlUUF9BUkdTKHJvb3QsIGlub2RlLCBt
YXApLAo+IAo+IAlUUF9GSUVMRFMoCj4gLS0KPiAyLjcuNAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJz
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
