From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: High memory consumption issue on RCU side
Date: Thu, 22 Sep 2016 22:14:46 +0300
Message-ID: <CAO6Ho0cLZc0x3RBfHd=qh_XZ+PPPMkaG_GaGGiT5=6MhsreR+Q__38196.9173475683$1474571707$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id F2FBDA42C5
 for <lttng-dev@lists.lttng.org>; Thu, 22 Sep 2016 19:15:58 +0000 (UTC)
Received: by mail-io0-f179.google.com with SMTP id r145so96120626ior.0
 for <lttng-dev@lists.lttng.org>; Thu, 22 Sep 2016 12:14:48 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKSSdtIGludmVzdGlnYXRpbmcgaGlnaCBtZW1vcnkgdXNhZ2Ugb2YgbXkgcHJvZ3Jh
bTogUlNTIHZhcmllcyBiZXR3ZWVuCmV4ZWN1dGlvbnMgaW4gcmFuZ2UgMjAtNTAgR0IsIHRob3Vn
aCBpdCBzaG91bGQgYmUgZGV0ZXJtZW5pc3RpYy4gSSd2ZQpmb3VuZCB0aGF0IGFsbCB0aGUgbWVt
b3J5IGlzIGFsbG9jYXRlZCBpbiB0aGlzIHN0YWNrOgoKQWxsb2NhdGVkIDE3NjczNzgxMjQ4IGJ5
dGVzIGluIDU1NiBhbGxvY2F0aW9ucwogICAgICAgIGNkc19sZmh0X2FsbG9jX2J1Y2tldF90YWJs
ZTMgICAgIGZyb20gbGlidXJjdS1jZHMuc28uMi4wLjAKICAgICAgICBfZG9fY2RzX2xmaHRfcmVz
aXplICAgICAgZnJvbSBsaWJ1cmN1LWNkcy5zby4yLjAuMAogICAgICAgIGRvX3Jlc2l6ZV9jYiAg
ICAgICAgICAgICBmcm9tIGxpYnVyY3UtY2RzLnNvLjIuMC4wCiAgICAgICAgY2FsbF9yY3VfdGhy
ZWFkICAgICAgICAgIGZyb20gbGlidXJjdS1xc2JyLnNvLjIuMC4wCiAgICAgICAgc3RhcnRfdGhy
ZWFkICAgICAgICAgICAgIGZyb20gbGlicHRocmVhZC0yLjEyLnNvCiAgICAgICAgY2xvbmUgICAg
ICAgICAgICAgICAgICAgIGZyb20gbGliYy0yLjEyLnNvCgpBY2NvcmRpbmcgcHN0YWNrIGl0IHNo
b3VsZCBiZSBxdWllc2NlbnQgc3RhdGUuICBDYWxsIHRocmVhZCB3YWl0cyBvbiBzeXNjYWxsOgpz
eXNjYWxsCmNhbGxfcmN1X3RocmVhZApzdGFydF90aHJlYWQKY2xvbmUKCldlIHVzZSB1cmN1LTAu
OC43LCBvbmx5IHJjdWxmaGFzaCAoUVNCUikuIElzIGl0IHNvbWUga2luZCBvZiBsZWFrIGluClJD
VSBvciBhbnkgY2hhbmNlIEkgbWlzdXNlIGl0PyBXaGF0IHdvdWxkIHlvdSByZWNvbW1lbmQgdG8K
dHJvdWJsZXNob290IHRoZSBzaXR1YXRpb24/CgoKUC5TLiBzb3JyeSBpZiB0aGlzIGVtYWlsIHJl
Y2VpdmVkIG11bHRpcGxlIHRpbWVzOiBJJ3RyaWVkIHR3aWNlIGZyb20KbXkgd29yayBlbWFpbCBh
bmQgYWZ0ZXIgZmV3IGhvdXJzIGRpZG4ndCBub3RpY2UgdGhlIGVtYWlsIGluIHRoZSBsaXN0Lgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
