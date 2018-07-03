From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.5.6
Date: Tue, 3 Jul 2018 17:29:43 -0400
Message-ID: <CA+jJMxvycMLMgsfB0ROM+1J-shfonNft9p0m3bSwHAkwFEfcJw__19201.0067207322$1530653313$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 41Ky2q4VgWz19Ms
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 17:30:27 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id CE28E1A7BFC
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 17:30:26 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id EcN3kLQ97sco for <lttng-dev@lists.lttng.org>;
 Tue,  3 Jul 2018 17:30:26 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 50C771A7BF9
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 17:30:26 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id e8lV7JTLajZJ for <lttng-dev@lists.lttng.org>;
 Tue,  3 Jul 2018 17:30:26 -0400 (EDT)
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
 [209.85.215.42])
 by mail.efficios.com (Postfix) with ESMTPSA id F03581A7BF4
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 17:30:25 -0400 (EDT)
Received: by mail-lf0-f42.google.com with SMTP id h7-v6so2723549lfc.11
 for <lttng-dev@lists.lttng.org>; Tue, 03 Jul 2018 14:30:25 -0700 (PDT)
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

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgc2l4dGggYnVnLWZpeCByZWxlYXNl
IG9mIEJhYmVsdHJhY2UgMS41LjYuClRoaXMgcmVsZWFzZSBhZGRyZXNzZXMgYSBudW1iZXIgb2Yg
aXNzdWVzIGxpc3RlZCBiZWxvdy4KCjIwMTgtMDctMDMgYmFiZWx0cmFjZSAxLjUuNiAoTmF0aW9u
YWwgRnJpZWQgQ2xhbSBEYXkpCiAgICAgICAgKiBGaXg6IHJlbW92ZSBsZWZ0LW92ZXIgZGVidWcg
bG9nZ2luZyBzdGF0ZW1lbnQKICAgICAgICAqIFVzZSB0cmFjZS0+dHJhY2VfaWQgaW4gY2hlY2sg
dG8gcmVtb3ZlIHRyYWNlIGZyb20gYnRfY3R4CiAgICAgICAgKiBGaXg6IG1pc3NpbmcgaW5pdGlh
bGl6ZXIgYnJhY2VzIHdhcm5pbmcKICAgICAgICAqIEZpeDogemVybyBvdXQgVVJMIHBhcnNpbmcg
YXJyYXkgYmVmb3JlIHVzZSBhbmQgZW5zdXJlIHByb3BlcgplcnJvciByZXBvcnRpbmcKClByb2pl
Y3Qgd2Vic2l0ZTogaHR0cDovL2RpYW1vbi5vcmcvYmFiZWx0cmFjZS8KRG93bmxvYWQgbGluazog
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20vZmlsZXMvYmFiZWx0cmFjZS9iYWJlbHRyYWNlLTEuNS42
LnRhci5iejIKQ1RGIHNwZWNpZmljYXRpb246IGh0dHA6Ly9kaWFtb24ub3JnL2N0Zi8KCi0tIApK
w6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
