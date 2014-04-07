From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: Use $AM_CC when it is defined
	instead of gcc in demo-tracef
Date: Mon,  7 Apr 2014 12:16:51 -0400
Message-ID: <1396887411-9824-1-git-send-email-jeremie.galarneau__3143.69148477471$1396887499$gmane$org@efficios.com>
References: <CAEiAFz2ugQhoA6RO7NbxAPNcii6tvc-qQoM9CaqDDW5LPSNT7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXCEV-0000oy-K4
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 12:17:21 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so6548908qcx.41
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 09:17:10 -0700 (PDT)
In-Reply-To: <CAEiAFz2ugQhoA6RO7NbxAPNcii6tvc-qQoM9CaqDDW5LPSNT7w@mail.gmail.com>
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

U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIGRvYy9leGFtcGxlcy9kZW1vLXRyYWNlZi9NYWtlZmlsZSB8IDUgKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kb2MvZXhhbXBsZXMvZGVtby10cmFjZWYvTWFrZWZpbGUgYi9kb2MvZXhhbXBsZXMv
ZGVtby10cmFjZWYvTWFrZWZpbGUKaW5kZXggNjQ0YWNkYy4uNDBlOWE1OCAxMDA2NDQKLS0tIGEv
ZG9jL2V4YW1wbGVzL2RlbW8tdHJhY2VmL01ha2VmaWxlCisrKyBiL2RvYy9leGFtcGxlcy9kZW1v
LXRyYWNlZi9NYWtlZmlsZQpAQCAtMTUsNyArMTUsMTAgQEAKICMKICMgVGhpcyBtYWtlZmlsZSBp
cyBwdXJwb3NlZnVsbHkga2VwdCBzaW1wbGUgdG8gc3VwcG9ydCBHTlUgYW5kIEJTRCBtYWtlLgog
Ci1DQyA9IGdjYworaWZkZWYgQU1fQ0MKKwlDQyA9ICQoQU1fQ0MpCitlbmRpZgorCiBMSUJTID0g
LWxkbCAtbGx0dG5nLXVzdAkjIE9uIExpbnV4CiAjTElCUyA9IC1sYwkjIE9uIEJTRAogTE9DQUxf
Q1BQRkxBR1MgKz0gLUkuCi0tIAoxLjkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
