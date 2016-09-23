From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [RFC] perf sampling library for LTTng-UST
Date: Fri, 23 Sep 2016 14:43:32 -0400
Message-ID: <1483f0d3-da42-8269-a25b-a45d7db5e1ea__12839.0535981909$1474656231$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
 [209.85.220.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7EDF1A3A2E
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2016 18:44:47 +0000 (UTC)
Received: by mail-qk0-f180.google.com with SMTP id t7so114186345qkh.2
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2016 11:43:35 -0700 (PDT)
Received: from [132.207.72.22] ([132.207.72.22])
 by smtp.gmail.com with ESMTPSA id b1sm4533003qkg.9.2016.09.23.11.43.33
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Sep 2016 11:43:33 -0700 (PDT)
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

SGVsbG8hIAoKSSBkaWQgYSBzbWFsbCBzaGFyZWQgbGlicmFyeSBmb3IgcHJvZmlsaW5nIGNvZGUg
dXNpbmcgcGVyZiBzYW1wbGluZyBhbmQgTFRUbmctVVNUOgoKICBodHRwczovL2dpdGh1Yi5jb20v
Z2lyYWxkZWF1L2x0dG5nLXVzdC90cmVlL3NhbXBsaW5nL2xpYmx0dG5nLXVzdC1zYW1wbGluZwoK
SXQgd29ya3MgYnkgcHJlbG9hZGluZyB0aGUgbGlicmFyeSB3aGVuIGV4ZWN1dGluZyBhIHByb2dy
YW0uIEluc2lkZSB0aGUgbGlicmFyeSBjb25zdHJ1Y3RvciwgYSBwZXJmIGNvdW50ZXIgaXMgY3Jl
YXRlZCBhbmQgc2FtcGxlcyBhcmUgc2F2ZWQgaW5zaWRlIHRoZSBTSUdJTyBoYW5kbGVyIHVzaW5n
IGFuIExUVG5nLVVTVCB0cmFjZXBvaW50LiBUaGUgY2FsbCBzdGFjayBpcyBvYnRhaW5lZCB1c2lu
ZyBsaWJ1bndpbmQsIGFuZCB0aHVzIGl0IHdvcmtzIGV2ZW4gd2l0aG91dCBmcmFtZSBwb2ludGVy
cyBhbmQgd2l0aCB1bm1vZGlmaWVkIGV4ZWN1dGFibGVzLiAKClByZWxpbWluYXJ5IG92ZXJoZWFk
IG1lYXN1cmUgd2l0aCB0aGUgZGVmYXVsdCBzYW1wbGluZyBwZXJpb2Qgb2YgMUU0IGZvciBjcHUg
Y3ljbGVzIGlzIGFib3V0IDguNSUsIG9yIDIuMnVzIHBlciBldmVudC4gT24gbXkgbWFjaGluZSwg
YWJvdXQgMzhrIHNhbXBsZXMgcGVyIHNlY29uZCBhcmUgZ2VuZXJhdGVkLiBUaGlzIGZpZ3VyZSBp
cyBvYnRhaW5lZCB3aGVuIGNvbXBpbGluZyBsaWJ1bndpbmQgd2l0aG91dCBzaWduYWwgcmUtZW50
cmFuY2Ugc3VwcG9ydC4KCkdlbmV2aWV2ZSBCYXN0aWVuIGRpZCBhIG5pY2UgdmlldyBpbiBUcmFj
ZUNvbXBhc3MgdG8gbG9hZCB0aGlzIHRyYWNlIGFuZCBkaXNwbGF5IHRoZSBjb3JyZXNwb25kaW5n
IGNhbGwgZ3JhcGggdmlldy4gCgogIGh0dHA6Ly9zZWNyZXRhaXJlLmRvcnNhbC5wb2x5bXRsLmNh
L35nYmFzdGllbi9zY3JlZW5zaG90cy9sdHRuZ19zYW1wbGluZ19jYWxsc3RhY2sucG5nCgpUaGUg
Y291bnRlciBpcyBoYXJkIGNvZGVkIG5vdywgYnV0IGl0J3MganVzdCBhIHByb3RvdHlwZSB0byBk
ZW1vbnN0cmF0ZSB0aGUgY29uY2VwdC4gSSB3b3VsZCBmaW5kIGl0IHZlcnkgY29vbCB0byBzZWUg
c3VjaCBmZWF0dXJlIGluIExUVG5nLiBXaGF0IGRvIHlvdSB0aGluaz8KCkNoZWVycywgCgpGcmFu
Y2lzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
