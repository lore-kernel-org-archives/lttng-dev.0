From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: preserve example files'
	timestamps when copying
Date: Thu, 16 Oct 2014 09:45:19 -0400
Message-ID: <1413467119-18187-1-git-send-email-jeremie.galarneau__21796.305923681$1413467180$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XelMu-0008Pb-4B
 for lttng-dev@lists.lttng.org; Thu, 16 Oct 2014 09:45:32 -0400
Received: by mail-qc0-f171.google.com with SMTP id i17so2764933qcy.16
 for <lttng-dev@lists.lttng.org>; Thu, 16 Oct 2014 06:45:22 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhpcyBmaXhlcyBhbiBpc3N1ZSB3aGVyZSBleGFtcGxlcyB3ZXJlIGFsd2F5cyBiZWluZyByZWJ1
aWx0CndoZW4gcGVyZm9ybWluZyBhbiBvdXQgb2YgdHJlZSBidWlsZCBzaW5jZSB0aGUgZXhhbXBs
ZXMgd2VyZQpiZWluZyBjb3BpZWQgdG8gdGhlIGJ1aWxkIGRpcmVjdG9yeSB3aXRoIGEgdGltZXN0
YW1wIG1vcmUKcmVjZW50IHRoYW4gdGhlIGFscmVhZHktYnVpbHQgZXhhbXBsZSBvYmplY3RzLgoK
U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIGRvYy9leGFtcGxlcy9NYWtlZmlsZS5hbSB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RvYy9l
eGFtcGxlcy9NYWtlZmlsZS5hbSBiL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbQppbmRleCBmYmFi
YjhlLi42ZjBhMzFhIDEwMDY0NAotLS0gYS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KKysrIGIv
ZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtCkBAIC01Nyw3ICs1Nyw3IEBAIGVuZGlmCiBhbGwtbG9j
YWw6CiAJQGlmIFsgeCIkKHNyY2RpcikiICE9IHgiJChidWlsZGRpcikiIF07IHRoZW4gXAogCQlm
b3Igc3ViZGlyIGluICQoU1VCRElSU19QUk9YWSkgJChTVUJESVJTX0pVTCk7IGRvIFwKLQkJCWNw
IC1mUiAkKHNyY2RpcikvJCRzdWJkaXIgJChidWlsZGRpcik7IFwKKwkJCWNwIC1wZlIgJChzcmNk
aXIpLyQkc3ViZGlyICQoYnVpbGRkaXIpOyBcCiAJCWRvbmU7IFwKIAlmaTsgXAogCWlmIFsgeCIk
KHNoZWxsIGVjaG8gIiQodG9wX3NyY2RpcikiIHwgZ3JlcCAiXi8iIHwgd2MgLWwpIiA9IHgiMSIg
XTsgdGhlbiBcCi0tIAoyLjEuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
