From: Anders Wallin <wallinux@gmail.com>
Subject: [PATCH lttng-modules] Fix: the clock plugin must be
 initiated before first use of the clock
Date: Fri, 22 Jul 2016 09:14:34 +0200
Message-ID: <CAF2baFdWhRmKQf=MX=7HOoxPnZCGTq419Mxc4B3YjQUeSGd1zA__24977.1147071899$1469171695$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2E5A4A2BA6
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2016 07:14:36 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id f93so6977397lfi.0
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2016 00:14:36 -0700 (PDT)
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

V2hlbiBidWlsZGluZyBsdHRuZyBpbnNpZGUgdGhlIGtlcm5lbCB0aGUgY2xvY2sgcGx1Z2luIG11
c3QgYmUgaW5pdGF0ZWQKYmVmb3JlIHRoZSByZXN0IG9mIHRoZSBsdHRuZyBjb2RlLiBNb3ZlZCB0
aGUgbW9kdWxlX2luaXQgdG8Kcm9vdGZzX2luaXRjYWxsLiBUaGUgZnVuY3Rpb25hbGl0eSB3aWxs
IG5vdCBjaGFuZ2Ugd2hlbiBidWlsdCBhcyBhCm1vZHVsZS4KClNpZ25lZC1vZmYtYnk6IEFuZGVy
cyBXYWxsaW4gPHdhbGxpbnV4QGdtYWlsLmNvbT4KLS0tCiB0ZXN0cy9jbG9jay1wbHVnaW4vbHR0
bmctY2xvY2stcGx1Z2luLXRlc3QuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Nsb2NrLXBsdWdpbi9sdHRu
Zy1jbG9jay1wbHVnaW4tdGVzdC5jCmIvdGVzdHMvY2xvY2stcGx1Z2luL2x0dG5nLWNsb2NrLXBs
dWdpbi10ZXN0LmMKaW5kZXggZjE2ZWE2NC4uYmY4MTkzMiAxMDA2NDQKLS0tIGEvdGVzdHMvY2xv
Y2stcGx1Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMKKysrIGIvdGVzdHMvY2xvY2stcGx1
Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMKQEAgLTY3LDcgKzY3LDcgQEAgaW50IGx0dG5n
X2Nsb2NrX3BsdWdpbl9pbml0KHZvaWQpCiB7CiAgICAgICAgcmV0dXJuIGx0dG5nX2Nsb2NrX3Jl
Z2lzdGVyX3BsdWdpbigmbHRjLCBUSElTX01PRFVMRSk7CiB9Ci1tb2R1bGVfaW5pdChsdHRuZ19j
bG9ja19wbHVnaW5faW5pdCk7Cityb290ZnNfaW5pdGNhbGwobHR0bmdfY2xvY2tfcGx1Z2luX2lu
aXQpOwoKIHN0YXRpYyBfX2V4aXQKIHZvaWQgbHR0bmdfY2xvY2tfcGx1Z2luX2V4aXQodm9pZCkK
77+8CgotLQoyLjkuMgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
