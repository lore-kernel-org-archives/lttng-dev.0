From: =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>
Subject: [PATCH lttng-modules] Container support for lttng-logger
Date: Tue, 19 Dec 2017 15:55:06 -0500
Message-ID: <20171219205507.23038-1-stgraber__12462.7540972599$1513717347$gmane$org@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpout1.stgraber.org (smtpout1.stgraber.org
 [IPv6:2001:470:b368:1020:1::6])
 by lists.lttng.org (Postfix) with ESMTPS id 3z1Vkw0FGtzp2M
 for <lttng-dev@lists.lttng.org>; Tue, 19 Dec 2017 21:04:07 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhpcyBhZGRzIGEgbmV3IC9kZXYvbHR0bmctbG9nZ2VyIGludGVyZmFjZSB0byBtYWtlIGl0IGVh
c3kgZm9yCmNvbnRhaW5lcnMgdG8gd3JpdGUgdG8gdGhlIGx0dG5nIGxvZ2dlci4KCnJvb3RAdm0x
MDp+L2x0dG5nLW1vZHVsZXMjIGxzIC1saCAvZGV2L2x0dG5nLWxvZ2dlciAKY3J3LXJ3LXJ3LSAx
IHJvb3Qgcm9vdCAxMCwgNTQgRGVjIDE5IDIwOjM5IC9kZXYvbHR0bmctbG9nZ2VyCnJvb3RAdm0x
MDp+L2x0dG5nLW1vZHVsZXMjIGxzIC1saCAvcHJvYy9sdHRuZy1sb2dnZXIgCi1ydy1ydy1ydy0g
MSByb290IHJvb3QgMCBEZWMgMTkgMjA6MzkgL3Byb2MvbHR0bmctbG9nZ2VyCgpyb290QHZtMTA6
fi9sdHRuZy1tb2R1bGVzIyBseGMgY29uZmlnIGRldmljZSBhZGQgdGVzdCBsdHRuZyB1bml4LWNo
YXIgcGF0aD0vZGV2L2x0dG5nLWxvZ2dlcgpEZXZpY2UgbHR0bmcgYWRkZWQgdG8gdGVzdAoKcm9v
dEB2bTEwOn4vbHR0bmctbW9kdWxlcyMgZWNobyBob3N0LWRldiA+IC9kZXYvbHR0bmctbG9nZ2Vy
IApyb290QHZtMTA6fi9sdHRuZy1tb2R1bGVzIyBlY2hvIGhvc3QtcHJvYyA+IC9wcm9jL2x0dG5n
LWxvZ2dlciAKcm9vdEB2bTEwOn4vbHR0bmctbW9kdWxlcyMgbHhjIGV4ZWMgdGVzdCBiYXNoCnJv
b3RAdGVzdDp+IyBlY2hvIGNvbnRhaW5lci1kZXYgPiAvZGV2L2x0dG5nLWxvZ2dlciAKClsyMDo0
Mjo1Ni42Mjc3MTkzMDBdICgrPy4/Pz8/Pz8/Pz8pIHZtMTAgbHR0bmdfbG9nZ2VyOiB7IGNwdV9p
ZCA9IDQgfSwgeyBfbXNnX2xlbmd0aCA9IDksIG1zZyA9ICJob3N0LWRldiIgfQpbMjA6NDI6NTgu
MTQ1OTYwOTEwXSAoKzEuNTE4MjQxNjEwKSB2bTEwIGx0dG5nX2xvZ2dlcjogeyBjcHVfaWQgPSA0
IH0sIHsgX21zZ19sZW5ndGggPSAxMCwgbXNnID0gImhvc3QtcHJvYyIgfQpbMjA6NDM6MDEuMTIz
ODQyMzkwXSAoKzIuOTc3ODgxNDgwKSB2bTEwIGx0dG5nX2xvZ2dlcjogeyBjcHVfaWQgPSAzIH0s
IHsgX21zZ19sZW5ndGggPSAxNCwgbXNnID0gImNvbnRhaW5lci1kZXYiIH0KCgpTdMOpcGhhbmUg
R3JhYmVyICgxKToKICBBZGQgYSBuZXcgL2Rldi9sdHRuZy1sb2dnZXIgaW50ZXJmYWNlCgogcHJv
YmVzL2x0dG5nLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgotLSAKMi4xNC4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
