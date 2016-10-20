From: Anders Wallin <wallinux@gmail.com>
Subject: [PATCH lttng-tools] Add version info to lttng-relayd
	help
Date: Thu, 20 Oct 2016 07:58:55 +0200
Message-ID: <20161020055855.28518-1-wallinux__8083.73019467599$1476943169$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id CAE5CA45C9
 for <lttng-dev@lists.lttng.org>; Thu, 20 Oct 2016 06:01:01 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id b75so5629798lfg.3
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 22:58:58 -0700 (PDT)
Received: from localhost.localdomain (h-94-254-57-193.na.cust.bahnhof.se.
 [94.254.57.193])
 by smtp.gmail.com with ESMTPSA id j124sm11401965lfe.3.2016.10.19.22.58.55
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 19 Oct 2016 22:58:55 -0700 (PDT)
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

bHR0bmctcmVsYXlkIG1hbiBwYWdlcyBzdGF0ZXMgdGhhdCB0aGUgb3B0aW9uCi1WIC0tdmVyc2lv
biBpcyBhdmFpbGFibGUsIGJ1dCBpdCBpdCdzIG1pc3NpbmcgaW4gdGhlIGNvZGUKClNpZ25lZC1v
ZmYtYnk6IEFuZGVycyBXYWxsaW4gPHdhbGxpbnV4QGdtYWlsLmNvbT4KLS0tCiBzcmMvYmluL2x0
dG5nLXJlbGF5ZC9tYWluLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL21h
aW4uYyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL21haW4uYwppbmRleCBlYTQ2ZWM3Li45YzBlMmIx
IDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXJlbGF5ZC9tYWluLmMKKysrIGIvc3JjL2Jpbi9s
dHRuZy1yZWxheWQvbWFpbi5jCkBAIC0xNjEsMTAgKzE2MSwxMSBAQCBzdGF0aWMgc3RydWN0IG9w
dGlvbiBsb25nX29wdGlvbnNbXSA9IHsKIAl7ICJvdXRwdXQiLCAxLCAwLCAnbycsIH0sCiAJeyAi
dmVyYm9zZSIsIDAsIDAsICd2JywgfSwKIAl7ICJjb25maWciLCAxLCAwLCAnZicgfSwKKwl7ICJ2
ZXJzaW9uIiwgMCwgMCwgJ1YnIH0sCiAJeyBOVUxMLCAwLCAwLCAwLCB9LAogfTsKIAotc3RhdGlj
IGNvbnN0IGNoYXIgKmNvbmZpZ19pZ25vcmVfb3B0aW9uc1tdID0geyAiaGVscCIsICJjb25maWci
IH07CitzdGF0aWMgY29uc3QgY2hhciAqY29uZmlnX2lnbm9yZV9vcHRpb25zW10gPSB7ICJoZWxw
IiwgImNvbmZpZyIsICJ2ZXJzaW9uIiB9OwogCiAvKgogICogVGFrZSBhbiBvcHRpb24gZnJvbSB0
aGUgZ2V0b3B0IG91dHB1dCBhbmQgc2V0IGl0IGluIHRoZSByaWdodCB2YXJpYWJsZSB0byBiZQpA
QCAtMjU1LDYgKzI1Niw5IEBAIHN0YXRpYyBpbnQgc2V0X29wdGlvbihpbnQgb3B0LCBjb25zdCBj
aGFyICphcmcsIGNvbnN0IGNoYXIgKm9wdG5hbWUpCiAJCQlwZXJyb3IoImV4ZWMiKTsKIAkJfQog
CQlleGl0KEVYSVRfRkFJTFVSRSk7CisJY2FzZSAnVic6CisJCWZwcmludGYoc3Rkb3V0LCAiJXNc
biIsIFZFUlNJT04pOworCQlleGl0KEVYSVRfU1VDQ0VTUyk7CiAJY2FzZSAnbyc6CiAJCWlmIChs
dHRuZ19pc19zZXR1aWRfc2V0Z2lkKCkpIHsKIAkJCVdBUk4oIkdldHRpbmcgJyVzJyBhcmd1bWVu
dCBmcm9tIHNldHVpZC9zZXRnaWQgYmluYXJ5IHJlZnVzZWQgZm9yIHNlY3VyaXR5IHJlYXNvbnMu
IiwKLS0gCjIuMTAuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
