From: Norbert Lange <nolange79@gmail.com>
Subject: Using lttng for traces and (in-process) logging
Date: Tue, 7 Aug 2018 00:42:11 +0200
Message-ID: <CADYdroNy37NmavhVhMaUkR+k9+rJLc_6C3PoXq1rx_ZMwX=VtQ__12893.3829292238$1533656799$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x232.google.com (mail-io0-x232.google.com
 [IPv6:2607:f8b0:4001:c06::232])
 by lists.lttng.org (Postfix) with ESMTPS id 41kt2915YNz14ZF
 for <lttng-dev@lists.lttng.org>; Mon,  6 Aug 2018 18:42:23 -0400 (EDT)
Received: by mail-io0-x232.google.com with SMTP id l14-v6so12420748iob.7
 for <lttng-dev@lists.lttng.org>; Mon, 06 Aug 2018 15:42:23 -0700 (PDT)
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

SGVsbG8sCgpzaW5jZSBsdHRuZyB3b3VsZCBtYWtlIGZvciBhIGRlY2VudCBsb2dnZXIsIGlzIGl0
IHBvc3NpYmxlIHRvIGNyZWF0ZSBhCm93biB0cmFjZXBvaW50IHByb3ZpZGVyIGFuZCBjaGFubmVs
IGFuZCBhY2VzcyBpdCBpbiB0aGUgdmVyeSBzYW1lCnByb2Nlc3MgdGhhdHMgdHJhY2VkPwp0aGUg
bG9nIGVudHJpZXMgd291bGQgbmVlZCB0byBiZSBhY2Nlc3NpYmxlIGRpcmVjdGx5IHRvIHN1cHBv
cnQgc29tZQpleGlzdGluZyBzY2hlbWVzIGZvciBtYW5pcHVsYXRpbmcgKGludGVycG9sYXRpbmcg
dG8gYSBkaWZmZXJlbnQKY2xvY2stc291cmNlKSwgZm9yd2FyZGluZyBhbmQgc3RvcmluZyB0aGVt
LgoKZWcuIEkgd291bGQgbGlrZSB0byBhY2Nlc3MgdGhlIGxvZ3MgYW5kIG90aGVyIHRyYWNlcyB3
aXRoIHRoZSBub3JtYWwKbHR0bmcgdG9vbHMsIGJ1dCBhbHNvIGJlIGFibGUgdG8gZ2V0IGEgY29w
eSBvZiB0aGUgbG9ncyBkaXJlY3RseSBmcm9tCnRoZSBwcm9jZXNzIGdlbmVyYXRpbmcgdGhlbS4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
