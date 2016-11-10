From: Jean-Francois MONESTIER <jean-francois.monestier@st.com>
Subject: [barectf] Building /w. Microsoft Visual Studio
Date: Thu, 10 Nov 2016 18:17:53 +0100
Message-ID: <14939700-3f1b-0541-a1de-edc7d0077d84__21838.7905894362$1478799595$gmane$org@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94])
 by lists.lttng.org (Postfix) with ESMTPS id 3tF9Kp0kKfzlp2
 for <lttng-dev@lists.lttng.org>; Thu, 10 Nov 2016 17:39:54 +0000 (UTC)
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 uAAHBdBb022327
 for <lttng-dev@lists.lttng.org>; Thu, 10 Nov 2016 18:17:54 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-.pphosted.com with ESMTP id 26mhvpp5fw-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 10 Nov 2016 18:17:54 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 417AF31
 for <lttng-dev@lists.lttng.org>; Thu, 10 Nov 2016 17:17:54 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas5.st.com [10.75.90.71])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F7F72B98
 for <lttng-dev@lists.lttng.org>; Thu, 10 Nov 2016 17:17:54 +0000 (GMT)
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

SGVsbG8gVHJhY2VycyAhCgpJJ20gY3VycmVudGx5IGhhdmluZyBoYXJkIHRpbWVzLCB0cnlpbmcg
dG8gYnVpbGQgYSBiYXJlY3RmLWdlbmVyYXRlZCBDVEYKd3JpdGVyIHdpdGggTWljcm9zb2Z0IFZp
c3VhbCBTdHVkaW8gMjAwOC4KClByb2JsZW0gcmVzaWRlcyBpbiB0aGUgLi5fYml0ZmllbGQuaCBm
aWxlLCBtYWNybwouLl9idF9iaXRmaWVsZF93cml0ZV9sZSggLi4gKSBhcyBfX3R5cGVfXyggLi4g
KSBpcyBhIGdjYyBleHRlbnNpb24gOgoKICB3YXJuaW5nIEM0MDEzOiAnX190eXBlb2ZfXycgdW5k
ZWZpbmVkOyBhc3N1bWluZyBleHRlcm4gcmV0dXJuaW5nIGludAoKQXJlIHRoZXJlIGFueSBNJCBj
b21wYXRpYmxlIGJpdGZpZWxkIG1hY3Jvcy9mdW5jdGlvbnMgYXJvdW5kIGhlcmUgPyBPcgphbSBJ
IG9uIHRoZSB3YXkgdG8gcG9ydCB0aGVzZSBteXNlbGYgPwoKRm9yIHdoYXQgSSd2ZSBzZWVuLCBJ
J20gb25seSB3cml0aW5nIDgvMTYvMzIvNjRiIGRhdGEgaW50byBteSBzdHJlYW0sIHNvCnRoYXQg
dGhlIG1hY3JvcyBzaG91bGQgcmV3cml0ZSBpbiBhIG11Y2ggbW9yZSBzaW1wbGVyIHdheS4KCkkn
bSBjdXJyZW50bHkgdXNpbmcgYmFyZWN0ZiB2Mi4xLjMKCgpBbnkgaGVscCBhcHByZWNpYXRlZCwK
VGhhbmtzIGluIGFkdmFuY2UKLS0gCkplYW4tRnJhbmNvaXMgTW9uZXN0aWVyCjA0MS02NzY2Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
