From: Antoine Busque <abusque@efficios.com>
Subject: [RFC lttng-ust] Renaming llttng_ust_statedump:soinfo
Date: Fri, 15 Apr 2016 15:43:55 -0400
Message-ID: <CA+MZcXugBpNuWEoMbfP+WioDyhdcUkymj4zOdD+5Sd2Vig8X4Q__47488.5805896067$1460749460$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 710F9A3097
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:43:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 911FD3402D2
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:43:59 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id V4AUBaqTa4cV for <lttng-dev@lists.lttng.org>;
 Fri, 15 Apr 2016 19:43:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D2877340304
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:43:57 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AoqNE5EUbS1Q for <lttng-dev@lists.lttng.org>;
 Fri, 15 Apr 2016 19:43:57 +0000 (UTC)
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by mail.efficios.com (Postfix) with ESMTPSA id 637B93402DF
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:43:57 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id g185so144785724ioa.2
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 12:43:56 -0700 (PDT)
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

SGksCgpJJ2QgbGlrZSB0byBzdWdnZXN0IHJlbmFtaW5nIHRoZSBsdHRuZ191c3Rfc3RhdGVkdW1w
OnNvaW5mbyBldmVudC4KSW5kZWVkLCB0aGUgY3VycmVudCBuYW1lIGZlZWxzIHNvbWV3aGF0IG1p
c2xlYWRpbmcgZ2l2ZW4gdGhhdCBpdAphcHBsaWVzIG5vdCBvbmx5IHRvIGxvYWRlZCBzaGFyZWQg
b2JqZWN0cywgIGJ1dCBhbHNvIHRvIGV4ZWN1dGFibGVzLAp3aGV0aGVyIHRoZXkgYXJlIHBvc2l0
aW9uLWluZGVwZW5kZW50IGV4ZWN1dGFibGVzIChQSUUpIG9yIG5vdC4KCkkgd291bGQgcHJvcG9z
ZSBjaGFuZ2luZyB0aGUgbmFtZSB0byAiYmluX2luZm8iLCBhcyBJIGZlZWwgdGhpcyB3b3VsZApl
bmNvbXBhc3MgYm90aCBleGVjdXRhYmxlcyBhbmQgc2hhcmVkIG9iamVjdHMuIFRoZSBldmVudCdz
IGZpZWxkCiJzb3BhdGgiIHNob3VsZCBhbHNvIGJlIHJlbmFtZWQgdG8gc2ltcGx5ICJwYXRoIiBm
b3IgdGhlIHNhbWUKcmVhc29ucy4KCkkgdGhpbmsgaXQncyBpbXBvcnRhbnQgdG8ga2VlcCB0byBh
IG1pbmltdW0gc3VjaCBuYW1lIGNoYW5nZXMsIGJ1dCBub3cKc2VlbXMgbGlrZSBhIHJlYXNvbmFi
bGUgdGltZSB0byBkbyBpdCBiZWZvcmUgaXQgYmVjb21lcyB3aWRlbHkgdXNlZApmb3IgYW5hbHlz
ZXMgaW4gYmFiZWx0cmFjZSBhbmQgVHJhY2UgQ29tcGFzcy4KClRob3VnaHRzPwoKQmVzdCByZWdh
cmRzLApBbnRvaW5lIEJ1c3F1ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
