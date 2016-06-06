From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: 'lttng create' does not create the session directory
Date: Mon, 6 Jun 2016 11:16:09 -0400
Message-ID: <575593B9.8040107__17268.9202627682$1465226082$gmane$org@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 594D2A36D3
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 15:14:24 +0000 (UTC)
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

SGksCgpJIGFtIHVzaW5nIExUVG5nIHRvIHRyYWNlIGFuIGFsaWduZXIgb2YgRE5BIG9wdGljYWwg
YXNzZXRzIHRoYXQgd2UgYXJlCmRldmVsb3BpbmcgYXQgR3lkbGUgSW5jLiBMVFRuZyBpcyB2ZXJ5
IHVzZWZ1bC4KCkkgaW5zdGFsbGVkIGl0IHdpdGggdGhlIFBQQSAoImRlYiBodHRwOi8vcHBhLmxh
dW5jaHBhZC5uZXQvbHR0bmcvcHBhL3VidW50dSIpLgoKSSBkb24ndCBrbm93IHdoYXQgaGFzIGNo
YW5nZWQgaW4gbXkgc2V0dXAsIGJ1dCBzaW5jZSB0aGlzIG1vcm5pbmcgbHR0bmcgaXMgbm90CmNy
ZWF0aW5nIHNlc3Npb24gZGlyZWN0b3JpZXMuCgoKWjEkIGx0dG5nIC0tdmVyc2lvbgpsdHRuZyAo
TFRUbmcgVHJhY2UgQ29udHJvbCkgMi43LjMgLSBIZXJiZSDDoCBEw6l0b3VybmUKCloxJCBsdHRu
ZyBjcmVhdGUgClNlc3Npb24gYXV0by0yMDE2MDYwNi0xMDE5NTMgY3JlYXRlZC4KVHJhY2VzIHdp
bGwgYmUgd3JpdHRlbiBpbiAvaG9tZS9zYm9pc3ZlcnQvbHR0bmctdHJhY2VzL2F1dG8tMjAxNjA2
MDYtMTAxOTUzCgpaMSQgbHMgL2hvbWUvc2JvaXN2ZXJ0L2x0dG5nLXRyYWNlcy9hdXRvLTIwMTYw
NjA2LTEwMTk1MwpsczogY2Fubm90IGFjY2VzcyAvaG9tZS9zYm9pc3ZlcnQvbHR0bmctdHJhY2Vz
L2F1dG8tMjAxNjA2MDYtMTAxOTUzOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CgoKSSBoYXZl
IGVub3VnaCBkaXNrIHNwYWNlLgoKSSBhbSBub3Qgc3VyZSB3aGF0IGlzIGNhdXNpbmcgdGhpcy4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
