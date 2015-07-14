From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [PATCH] Fix: Rename kvm TRACE_SYSTEM to avoid name clash
Date: Tue, 14 Jul 2015 14:43:48 -0400
Message-ID: <1436899428-26416-1-git-send-email-francis.giraldeau__49824.7539312162$1436899499$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1ZF5BP-0000Ae-87
 for lttng-dev@lists.lttng.org; Tue, 14 Jul 2015 14:43:59 -0400
Received: by qgep37 with SMTP id p37so8296900qge.1
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jul 2015 11:43:53 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: =?UTF-8?q?C=C3=A9dric=20Biancheri?= <cedric.biancheri@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

RnJvbTogQ8OpZHJpYyBCaWFuY2hlcmkgPGNlZHJpYy5iaWFuY2hlcmlAcG9seW10bC5jYT4KClRo
ZSBsdHRuZy1wcm9iZS1rdm0gYW5kIGx0dG5nLXByb2JlLWt2bS14ODYgaGFkIHRoZSBzYW1lIFRS
QUNFX1NZU1RFTSBzdHJpbmcuCkJlY2F1c2Ugb2YgdGhhdCwgYm90aCBtb2R1bGVzIGNhbid0IGJl
IGxvYWRlZCBhdCB0aGUgc2FtZSB0aW1lLiBUaGUgc2Vjb25kCm1vZHVsZSBmYWlscyB0byBsb2Fk
IHNpbGVudGx5LiBUaGlzIHBhdGNoIHJlbmFtZSB0aGUgVFJBQ0VfU1lTVEVNIG9mCmx0dG5nLXBy
b2JlLWt2bS14ODYgdG8gYXZvaWQgdGhlIGNsYXNoLgoKU2lnbmVkLW9mZi1ieTogRnJhbmNpcyBH
aXJhbGRlYXUgPGZyYW5jaXMuZ2lyYWxkZWF1QGdtYWlsLmNvbT4KLS0tCiBpbnN0cnVtZW50YXRp
b24vZXZlbnRzL2x0dG5nLW1vZHVsZS9hcmNoL3g4Ni9rdm0vdHJhY2UuaCB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2lu
c3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2FyY2gveDg2L2t2bS90cmFjZS5oIGIv
aW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYXJjaC94ODYva3ZtL3RyYWNlLmgK
aW5kZXggMzJjNDc0My4uZGRiZmRhNyAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50
cy9sdHRuZy1tb2R1bGUvYXJjaC94ODYva3ZtL3RyYWNlLmgKKysrIGIvaW5zdHJ1bWVudGF0aW9u
L2V2ZW50cy9sdHRuZy1tb2R1bGUvYXJjaC94ODYva3ZtL3RyYWNlLmgKQEAgLTEyLDcgKzEyLDcg
QEAKICNpbmNsdWRlIDwuLi9hcmNoL3g4Ni9rdm0va3ZtX2NhY2hlX3JlZ3MuaD4KIAogI3VuZGVm
IFRSQUNFX1NZU1RFTQotI2RlZmluZSBUUkFDRV9TWVNURU0ga3ZtCisjZGVmaW5lIFRSQUNFX1NZ
U1RFTSBrdm1feDg2CiAKIC8qCiAgKiBUcmFjZXBvaW50IGZvciBndWVzdCBtb2RlIGVudHJ5Lgot
LSAKMi4xLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
