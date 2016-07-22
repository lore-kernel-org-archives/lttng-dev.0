From: Anders Wallin <wallinux@gmail.com>
Subject: [PATCH lttng-modules] Fix: the clock plugin must be
	initiated before first use of the clock
Date: Fri, 22 Jul 2016 15:56:59 +0200
Message-ID: <20160722135659.28595-1-wallinux__38599.6133009487$1469195846$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E19A5A2B12
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2016 13:57:01 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id l69so7604061lfg.1
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2016 06:57:02 -0700 (PDT)
Received: from arn-awallin-linux-l4.corp.ad.wrs.com
 (h-94-254-57-193.na.cust.bahnhof.se. [94.254.57.193])
 by smtp.gmail.com with ESMTPSA id g74sm2977344ljg.24.2016.07.22.06.56.59
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 22 Jul 2016 06:56:59 -0700 (PDT)
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

V2hlbiBidWlsZGluZyBsdHRuZyBpbnNpZGUgdGhlIGtlcm5lbCB0aGUgY2xvY2sgcGx1Z2luIG11
c3QgYmUgaW5pdGF0ZWQKYmVmb3JlIHRoZSByZXN0IG9mIHRoZSBsdHRuZyBjb2RlLiBNb3ZlZCB0
aGUgbW9kdWxlX2luaXQgdG8Kcm9vdGZzX2luaXRjYWxsLiBUaGUgZnVuY3Rpb25hbGl0eSB3aWxs
IG5vdCBjaGFuZ2Ugd2hlbiBidWlsdCBhcyBhCm1vZHVsZS4KClNpZ25lZC1vZmYtYnk6IEFuZGVy
cyBXYWxsaW4gPHdhbGxpbnV4QGdtYWlsLmNvbT4KLS0tCiB0ZXN0cy9jbG9jay1wbHVnaW4vbHR0
bmctY2xvY2stcGx1Z2luLXRlc3QuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Nsb2NrLXBsdWdpbi9sdHRu
Zy1jbG9jay1wbHVnaW4tdGVzdC5jIGIvdGVzdHMvY2xvY2stcGx1Z2luL2x0dG5nLWNsb2NrLXBs
dWdpbi10ZXN0LmMKaW5kZXggZjE2ZWE2NC4uYmY4MTkzMiAxMDA2NDQKLS0tIGEvdGVzdHMvY2xv
Y2stcGx1Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMKKysrIGIvdGVzdHMvY2xvY2stcGx1
Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMKQEAgLTY3LDcgKzY3LDcgQEAgaW50IGx0dG5n
X2Nsb2NrX3BsdWdpbl9pbml0KHZvaWQpCiB7CiAJcmV0dXJuIGx0dG5nX2Nsb2NrX3JlZ2lzdGVy
X3BsdWdpbigmbHRjLCBUSElTX01PRFVMRSk7CiB9Ci1tb2R1bGVfaW5pdChsdHRuZ19jbG9ja19w
bHVnaW5faW5pdCk7Cityb290ZnNfaW5pdGNhbGwobHR0bmdfY2xvY2tfcGx1Z2luX2luaXQpOwog
CiBzdGF0aWMgX19leGl0CiB2b2lkIGx0dG5nX2Nsb2NrX3BsdWdpbl9leGl0KHZvaWQpCi0tIAoy
LjkuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
