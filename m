From: Antoine Busque <abusque@efficios.com>
Subject: [GIT PULL lttng-ust] Add is_pic field to statedump
	so_info event.
Date: Fri, 15 Apr 2016 15:16:54 -0400
Message-ID: <CA+MZcXsPPSQ2roRwKOaQgxW-tiU6OFSM5zKjHY_Htec5o+HTxQ__4732.65000987357$1460747839$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2A041A2FBA
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:16:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3D13E34022F
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:16:58 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tCR2t5RhrPOi for <lttng-dev@lists.lttng.org>;
 Fri, 15 Apr 2016 19:16:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EC0033402CA
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:16:56 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4HuuL_eOt-uQ for <lttng-dev@lists.lttng.org>;
 Fri, 15 Apr 2016 19:16:56 +0000 (UTC)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by mail.efficios.com (Postfix) with ESMTPSA id 89C8F34022F
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:16:56 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id u185so144070472iod.3
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 12:16:55 -0700 (PDT)
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

VGhlIG5ldyBpc19waWMgZmllbGQgYWxsb3dzIGEgcG9zdGVyaW9yaSBhbmFseXNlcyAoYmFiZWx0
cmFjZSwgVHJhY2UKQ29tcGFzcykgdG8ga25vdyB3aGV0aGVyIHRvIHRyZWF0IGFuIGV4ZWN1dGFi
bGUgYXMKcG9zaXRpb24taW5kZXBlbmRlbnQgY29kZSB3aXRob3V0IGhhdmluZyB0byByZWFkIHRo
ZSBFTEYgaGVhZGVyIG9mIHRoZQpmaWxlLCBhcyBkZXNjcmliZWQgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlcy4KClRoaXMgcHVsbCByZXF1ZXN0IGNvbnRhaW5zIHR3byBjb21taXRzOgoKIDhlOGU3YTcg
QWRkIGlzX3BpYyBmaWVsZCB0byBzdGF0ZWR1bXAgc29pbmZvIGV2ZW50CiBhZTNjYzA2IFRlc3Rz
OiBhZGQgdGVzdHMgZm9yIGx0dG5nX3VzdF9lbGZfaXNfcGljCgpQbGVhcyBwdWxsIGZyb206IGh0
dHBzOi8vZ2l0aHViLmNvbS9hYnVzcXVlL2x0dG5nLXVzdC90cmVlL2lzX3BpYwoKUmVnYXJkcywK
QW50b2luZSBCdXNxdWUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
