From: Michael Jeanson <mjeanson@efficios.com>
Subject: lttng-modules build failure on 4.8-rc2
Date: Thu, 25 Aug 2016 13:53:47 -0400
Message-ID: <7c042582-e513-bf0c-b82a-04f8dbfdc8c6__12765.835497021$1472147646$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5642AA41FA
 for <lttng-dev@lists.lttng.org>; Thu, 25 Aug 2016 17:54:10 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 371A63400C9
 for <lttng-dev@lists.lttng.org>; Thu, 25 Aug 2016 17:53:50 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 3wscLQratvbW for <lttng-dev@lists.lttng.org>;
 Thu, 25 Aug 2016 17:53:49 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9038C34020E
 for <lttng-dev@lists.lttng.org>; Thu, 25 Aug 2016 17:53:49 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id eCcIEd52ls3J for <lttng-dev@lists.lttng.org>;
 Thu, 25 Aug 2016 17:53:49 +0000 (UTC)
Received: from [192.168.0.25]
 (CPEbc4dfb969ba3-CMbc4dfb969ba0.cpe.net.cable.rogers.com [99.252.76.177])
 by mail.efficios.com (Postfix) with ESMTPSA id 2ECFB3400C9
 for <lttng-dev@lists.lttng.org>; Thu, 25 Aug 2016 17:53:49 +0000 (UTC)
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

SGksCgpUaGVzZSAyIGNvbW1pdHMgYnJlYWsgdGhlIGJsb2NrIGluc3RydW1lbnRhdGlvbiBpbiBs
dHRuZyBtb2R1bGVzIG1hc3RlciA6CgpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgv
Y29tbWl0LzRlMWIyZDUyYTgwZDc5Mjk2YTVkODk5ZDczMjQ5NzQ4ZGVhNzFhNTMKCmh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvMjg4ZGFiOGEzNWEwYmRlNDI2YTA5ODcw
OTQzYzhkM2VlM2E1MGRhYgoKVGhlIGVycm9ycyBhcmUgOgoKbHR0bmctbW9kdWxlcy9wcm9iZXMv
Li4vaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYmxvY2suaDozNToxMzoKZXJy
b3I6IOKAmFJFUV9ESVNDQVJE4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0
aW9uKQoKbHR0bmctbW9kdWxlcy9wcm9iZXMvLi4vaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRu
Zy1tb2R1bGUvYmxvY2suaDo0MToxNDoKZXJyb3I6IOKAmFJFUV9TRUNVUkXigJkgdW5kZWNsYXJl
ZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCgpJIHRyaWVkIGZpeGluZyBpdCBidXQgdGhp
cyBpcyBvdXQgb2YgdGhlIHNjb3BlIG9mIG15IGtlcm5lbCBmdS4KCk1pY2hhZWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
