From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: .split() the CC environment
	variable in lttng-gen-tp
Date: Tue,  8 Apr 2014 11:28:23 -0400
Message-ID: <1396970903-17438-1-git-send-email-jeremie.galarneau__136.448446619575$1396970969$gmane$org@efficios.com>
References: <20140408085021.GA3326@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXXwv-00013K-RH
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 11:28:37 -0400
Received: by mail-qa0-f48.google.com with SMTP id s7so553386qap.35
 for <lttng-dev@lists.lttng.org>; Tue, 08 Apr 2014 08:28:28 -0700 (PDT)
In-Reply-To: <20140408085021.GA3326@hal>
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

VGhlIENDIHZhcmlhYmxlIG1pZ2h0IGNvbnRhaW4gY29tbWFuZCBsaW5lIGFyZ3VtZW50cyB3aGlj
aCBsdHRuZy1nZW4tdHAKY3VycmVudGx5IGRvZXMgbm90IGhhbmRsZS4gVGhpcyBmaXggZW5zdXJl
cyB0aGF0IHRoZSBhcmd1bWVudHMgYXJlCnByb3Blcmx5IHBhc3NlZCBvbiB0byB0aGUgY29tcGls
ZXIgYmluYXJ5IGFzIGlmIGEgbm9ybWFsIE1ha2VmaWxlCndhcyB1c2VkLgoKU2lnbmVkLW9mZi1i
eTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgot
LS0KIHRvb2xzL2x0dG5nLWdlbi10cCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL2x0dG5nLWdlbi10cCBiL3Rv
b2xzL2x0dG5nLWdlbi10cAppbmRleCBhM2EwMWYyLi5iNjJjZDk5IDEwMDc1NQotLS0gYS90b29s
cy9sdHRuZy1nZW4tdHAKKysrIGIvdG9vbHMvbHR0bmctZ2VuLXRwCkBAIC05NCw3ICs5NCw3IEBA
IGNsYXNzIE9iakZpbGU6CiAgICAgICAgIGlmICdDQycgaW4gb3MuZW52aXJvbjoKICAgICAgICAg
ICAgIGNjID0gb3MuZW52aXJvblsnQ0MnXQogICAgICAgICAgICAgdHJ5OgotICAgICAgICAgICAg
ICAgIHN1YnByb2Nlc3MuY2FsbChjYywKKyAgICAgICAgICAgICAgICBzdWJwcm9jZXNzLmNhbGwo
Y2Muc3BsaXQoKSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Rkb3V0PXN1YnBy
b2Nlc3MuUElQRSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RkZXJyPXN1YnBy
b2Nlc3MuUElQRSkKICAgICAgICAgICAgIGV4Y2VwdCBPU0Vycm9yIGFzIG1zZzoKLS0gCjEuOS4x
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
