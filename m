From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: lttng-modules 2.6.x: important fix for kernel
	compatibility check
Date: Wed, 27 Apr 2016 19:56:46 +0000 (UTC)
Message-ID: <1951090375.71628.1461787006693.JavaMail.zimbra__2379.85903299904$1461787027$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 37425A09C1
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 19:56:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 49037340257
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 19:56:48 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id XUyMpzDdt1Ll for <lttng-dev@lists.lttng.org>;
 Wed, 27 Apr 2016 19:56:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0C89A340345
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 19:56:47 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id iddBlg8eGZXc for <lttng-dev@lists.lttng.org>;
 Wed, 27 Apr 2016 19:56:46 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id DDDBE340257
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 19:56:46 +0000 (UTC)
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

SGksCgpFdmVyeW9uZSB1c2luZyBsdHRuZy1tb2R1bGVzIGZyb20gMi42LjEgdG8gMi42LjUgYW5k
IHVzaW5nIG1vZGVyYXRlbHkKcmVjZW50IExpbnV4IGtlcm5lbHMgc2hvdWxkIGNvbnNpZGVyIHVw
Z3JhZGluZyB0byBzdGFibGUtMi43LCBvciBhdApsZWFzdCBwaWNraW5nIHVwIHRoaXMgY29tbWl0
IGZyb20gdGhlIHN0YWJsZS0yLjYgYnJhbmNoOgoKY29tbWl0IGM3ODJmMWYzZThjNzk5YjdiYTUz
MWJhOTQwMjA5MDE0YjY2ZDQ1NjQKQXV0aG9yOiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tPgpEYXRlOiAgIFdlZCBBcHIgMjcgMTU6MTg6NDIgMjAxNiAt
MDQwMAoKICAgIEZpeDogbWlzc2luZyBUcmFjZXBvaW50IHByb3RvdHlwZSBjaGVja2luZyBkdWUg
dG8gYm9ndXMgbWVyZ2UKCldpdGhvdXQgdGhpcyBmaXgsIGx0dG5nLW1vZHVsZXMgMi42LnggaGFw
cGlseSBidWlsZHMgYWdhaW5zdCBtb3JlCnJlY2VudCBMaW51eCBrZXJuZWxzIHRoYXQgaGF2ZSBp
bmNvbXBhdGlibGUgdHJhY2Vwb2ludCBwcm90b3R5cGVzLgpUaGUgZW5kIHJlc3VsdCBpcyBhIGx0
dG5nLW1vZHVsZXMgdGhhdCBidWlsZHMgZmluZSBhZ2FpbnN0IGEga2VybmVsLApidXQgd2hpY2gg
T09QUyB0aGUga2VybmVsIHdoZW4ga2VybmVsIHRyYWNpbmcgaXMgdXNlZC4KClRoYW5rcywKCk1h
dGhpZXUKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZm
aWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
