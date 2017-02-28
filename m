From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: lttng-tools build failure with uClibc due to dlmopen()
Date: Wed, 1 Mar 2017 00:09:45 +0100
Message-ID: <20170301000945.38a285dc__32561.2929104411$1488323774$gmane$org@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.lttng.org (Postfix) with ESMTP id 3vXvbB2Mlkzl9H
 for <lttng-dev@lists.lttng.org>; Tue, 28 Feb 2017 23:16:21 +0000 (UTC)
Received: from localhost (LFbn-1-6691-76.w90-120.abo.wanadoo.fr
 [90.120.129.76])
 by mail.free-electrons.com (Postfix) with ESMTPSA id A926A20B7B
 for <lttng-dev@lists.lttng.org>; Wed,  1 Mar 2017 00:09:45 +0100 (CET)
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

SGVsbG8sCgpGaXJzdCBvZiBhbGwsIHRoYW5rcyBmb3IgaGF2aW5nIGZpeGVkIHRoZSBkbG1vcGVu
IGlzc3VlIHdpdGggbXVzbCBpbgpsdHRuZy11c3QuIE5vdywgdGhlcmUgaXMgYW5vdGhlciBkbG1v
cGVuIGlzc3VlLCB0aGlzIHRpbWUgaW4KbHR0bmctdG9vbHMsIGFuZCB0aGlzIHRpbWUgd2l0aCB1
Q2xpYmM6CgogIENDICAgICAgIHByb2cubwpwcm9nLmM6IEluIGZ1bmN0aW9uICdtYWluJzoKcHJv
Zy5jOjI0Ojc6IHdhcm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdkbG1v
cGVuJyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICBoMSA9IGRsbW9wZW4oTE1f
SURfQkFTRSwgImxpYmZvby5zbyIsIFJUTERfTEFaWSk7CiAgICAgICBeCnByb2cuYzoyNDoxNTog
ZXJyb3I6ICdMTV9JRF9CQVNFJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlv
bikKICBoMSA9IGRsbW9wZW4oTE1fSURfQkFTRSwgImxpYmZvby5zbyIsIFJUTERfTEFaWSk7CiAg
ICAgICAgICAgICAgIF4KcHJvZy5jOjI0OjE1OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRp
ZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBp
bgoKU2VlCmh0dHA6Ly9hdXRvYnVpbGQuYnVpbGRyb290Lm5ldC9yZXN1bHRzL2MwNy9jMDdiNWJh
YzYxNDZkODNjMzIyNGRlMTQ3ZGEzNzk4ZDNlN2I1MjdmL2J1aWxkLWVuZC5sb2cKZm9yIHRoZSBm
dWxsIGJ1aWxkIGxvZy4KClNvLCB0aGUgdXN0IHJlZ3Jlc3Npb24gdGVzdCBjYXNlIGluIGx0dG5n
LXRvb2xzIGRvZXNuJ3QgdGVzdCBpZgpkbG1vcGVuKCkgaXMgcHJvdmlkZWQgYnkgdGhlIEMgbGli
cmFyeSBiZWZvcmUgdXNpbmcgaXQuCgpJIGd1ZXNzIHNvbWUgYWRkaXRpb25hbCBhdXRvY29uZi9h
dXRvbWFrZSBjb25kaXRpb25hbCBpcyBuZWVkZWQgaGVyZS4KClRoYW5rcywKClRob21hcwotLSAK
VGhvbWFzIFBldGF6em9uaSwgQ1RPLCBGcmVlIEVsZWN0cm9ucwpFbWJlZGRlZCBMaW51eCBhbmQg
S2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
