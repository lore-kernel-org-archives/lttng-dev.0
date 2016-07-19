From: Anders Wallin <wallinux@gmail.com>
Subject: The test clock plugin should be initiated earlier when
 built inside the kernel
Date: Tue, 19 Jul 2016 21:20:52 +0200
Message-ID: <CAF2baFeKw0M1qYpBbEqQLpHLsa5M_nPbW0Em=wgukq_LAzOqdw__19499.5366888636$1468956080$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114b0c56c89d3b053801fbd2
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 8F771A3801
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2016 19:20:54 +0000 (UTC)
Received: by mail-lf0-f51.google.com with SMTP id g62so22194269lfe.3
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2016 12:20:54 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--001a114b0c56c89d3b053801fbd2
Content-Type: text/plain; charset=UTF-8

Hi,

the test clock plugin should be initiated before all the other lttng
modules when build inside the kernel
. Move the module_init to e.g rootfs_initcall.

Anders Wallin

--001a114b0c56c89d3b053801fbd2
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-The-clock-plugin-must-be-initiated-before-first-use-.patch"
Content-Disposition: attachment;
	filename="0001-The-clock-plugin-must-be-initiated-before-first-use-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iqtui4c50

RnJvbSA4YTE1NWM2Mjc3MDExMTgyNDc1MDBlYjgwNDAzZjA5YjE5NTA0ZGYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8OGExNTVjNjI3NzAxMTE4MjQ3NTAwZWI4MDQwM2Yw
OWIxOTUwNGRmMC4xNDY4OTU1NzkxLmdpdC5hbmRlcnMud2FsbGluQHdpbmRyaXZlci5jb20+CkZy
b206IEFuZGVycyBXYWxsaW4gPGFuZGVycy53YWxsaW5Ad2luZHJpdmVyLmNvbT4KRGF0ZTogVHVl
LCAxOSBKdWwgMjAxNiAyMTowODoyMCArMDIwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBUaGUgY2xv
Y2sgcGx1Z2luIG11c3QgYmUgaW5pdGlhdGVkIGJlZm9yZSBmaXJzdCB1c2Ugb2YKIHRoZSBjbG9j
awoKV2hlbiBidWlsZGluZyBsdHRuZyBpbnNpZGUgdGhlIGtlcm5lbCB0aGUgY2xvY2sgcGx1Z2lu
IG11c3QgYmUgaW5pdGF0ZWQKYmVmb3JlIHRoZSByZXN0IG9mIHRoZSBsdHRuZyBjb2RlIGlzIGlu
aXRpYXRlZC4gTW92ZWQgdGhlIGluaXQgdG8Kcm9vdGZzX2luaXRjYWxsLgoKU2lnbmVkLW9mZi1i
eTogQW5kZXJzIFdhbGxpbiA8YW5kZXJzLndhbGxpbkB3aW5kcml2ZXIuY29tPgotLS0KIHRlc3Rz
L2Nsb2NrLXBsdWdpbi9sdHRuZy1jbG9jay1wbHVnaW4tdGVzdC5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMv
Y2xvY2stcGx1Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMgYi90ZXN0cy9jbG9jay1wbHVn
aW4vbHR0bmctY2xvY2stcGx1Z2luLXRlc3QuYwppbmRleCBmMTZlYTY0Li5iZjgxOTMyIDEwMDY0
NAotLS0gYS90ZXN0cy9jbG9jay1wbHVnaW4vbHR0bmctY2xvY2stcGx1Z2luLXRlc3QuYworKysg
Yi90ZXN0cy9jbG9jay1wbHVnaW4vbHR0bmctY2xvY2stcGx1Z2luLXRlc3QuYwpAQCAtNjcsNyAr
NjcsNyBAQCBpbnQgbHR0bmdfY2xvY2tfcGx1Z2luX2luaXQodm9pZCkKIHsKIAlyZXR1cm4gbHR0
bmdfY2xvY2tfcmVnaXN0ZXJfcGx1Z2luKCZsdGMsIFRISVNfTU9EVUxFKTsKIH0KLW1vZHVsZV9p
bml0KGx0dG5nX2Nsb2NrX3BsdWdpbl9pbml0KTsKK3Jvb3Rmc19pbml0Y2FsbChsdHRuZ19jbG9j
a19wbHVnaW5faW5pdCk7CiAKIHN0YXRpYyBfX2V4aXQKIHZvaWQgbHR0bmdfY2xvY2tfcGx1Z2lu
X2V4aXQodm9pZCkKLS0gCjIuOS4xCgo=
--001a114b0c56c89d3b053801fbd2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--001a114b0c56c89d3b053801fbd2--
