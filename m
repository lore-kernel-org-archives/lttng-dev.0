From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: lttng-tools 2.9.0 build failures
Date: Mon, 5 Dec 2016 15:44:56 -0500
Message-ID: <ed3016bf-c578-6a52-0462-deb1868c0447__18522.6002395668$1480970715$gmane$org@efficios.com>
References: <20161204230846.71049716@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tXcHx6TfCztsC
 for <lttng-dev@lists.lttng.org>; Mon,  5 Dec 2016 20:46:53 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 37390340125
 for <lttng-dev@lists.lttng.org>; Mon,  5 Dec 2016 20:46:43 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Ztx7P9oysYsU for <lttng-dev@lists.lttng.org>;
 Mon,  5 Dec 2016 20:46:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 315BE340256
 for <lttng-dev@lists.lttng.org>; Mon,  5 Dec 2016 20:46:37 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wjwP1D1_uUX0 for <lttng-dev@lists.lttng.org>;
 Mon,  5 Dec 2016 20:46:37 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id 0D874340125
 for <lttng-dev@lists.lttng.org>; Mon,  5 Dec 2016 20:46:37 +0000 (UTC)
In-Reply-To: <20161204230846.71049716@free-electrons.com>
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

T24gMjAxNi0xMi0wNCAxNzowOCwgVGhvbWFzIFBldGF6em9uaSB3cm90ZToKPiBIZWxsbywKPiAK
PiBJbiB0aGUgQnVpbGRyb290IHByb2plY3QsIHdlIHJlY2VudGx5IHVwZGF0ZWQgdG8gbHR0bmct
dG9vbHMgMi45LjAsIGFuZAo+IHdlJ3JlIGV4cGVyaWVuY2luZyB0d28gYnVpbGQgZmFpbHVyZXM6
Cj4gCj4gICogV2l0aCBhIHVDbGliYyBiYXNlZCB0b29sY2hhaW46Cj4gCj4gcHJvZy5jOjI0OjE1
OiBlcnJvcjogJ0xNX0lEX0JBU0UnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0
aW9uKQo+ICAgaDEgPSBkbG1vcGVuKExNX0lEX0JBU0UsICJsaWJmb28uc28iLCBSVExEX0xBWlkp
Owo+IAo+ICAgIEkgYmVsaWV2ZSBkbG1vcGVuKCkgaXMgbm90IGltcGxlbWVudGVkIGluIHVDbGli
YyBhbmQgbXVzbCwgc28KPiAgICBwZXJoYXBzIHRoaXMgc2hvdWxkIGJlIGhhbmRsZWQgaW4gbHR0
bmctdG9vbHMgYnkgbWFraW5nIHRoZSBjb2RlCj4gICAgY29uZGl0aW9uYWwuCj4gCj4gICAgU2Vl
Cj4gICAgaHR0cDovL2F1dG9idWlsZC5idWlsZHJvb3QubmV0L3Jlc3VsdHMvZDg3L2Q4NzQ1ZWY1
YzhjN2Q3MWY5OTNlZGYyYThmM2YxMDdkMmQxYjM1ZmMvYnVpbGQtZW5kLmxvZwo+ICAgIGZvciB0
aGUgZnVsbCBidWlsZCBsb2cuCj4gCj4gICogV2l0aCBhIG11c2wgYmFzZWQgdG9vbGNoYWluOgo+
IAo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBoZWFsdGguYzoyNjowOgo+IC4uLy4uLy4uL3NyYy9j
b21tb24vZGVmYXVsdHMuaDozNzA6MTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdwdGhyZWFk
X2F0dHJfdCcKPiAgcHRocmVhZF9hdHRyX3QgKmRlZmF1bHRfcHRocmVhZF9hdHRyKHZvaWQpOwo+
IAo+ICAgIFNlZQo+ICAgIGh0dHA6Ly9hdXRvYnVpbGQuYnVpbGRyb290Lm5ldC9yZXN1bHRzLzI1
NS8yNTU2YjMyNjZiOTEzOTY0YmVhMjVjMjFkMDE0ZjRiMWIyNWI2ODA4L2J1aWxkLWVuZC5sb2cK
PiAgICBmb3IgdGhlIGZ1bGwgYnVpbGQgbG9nLgo+IAo+IEJlc3QgcmVnYXJkcywKPiAKPiBUaG9t
YXMKPiAKCkkndmUgYWxzbyBlbmNvdW50ZXJlZCB0aGVzZSBwcm9ibGVtcyBvbiBBbHBpbmUgTGlu
dXgsIEkndmUganVzdApzdWJtaXR0ZWQgYSBwYXRjaCBmb3IgdGhlIHB0aHJlYWQgaW5jbHVkZS4g
QXMgZm9yIGRsbW9wZW4sIHRoYXQgd2lsbApyZXF1aXJlIGEgYml0IHRvIG1vcmUgd29yayB0byBt
YWtlIGEgY2xlYW4gcGF0Y2guIEluIHRoZSBtZWFuIHRpbWUsIHlvdQpjYW4ganVzdCBzdHJpcCB0
aGlzIHBhcnQgb2YgdGhlIGNvZGUgYmVmb3JlIGJ1aWxkaW5nLCB0aGF0J3Mgd2hhdCBJIGRpZApm
b3IgdGhlIEFscGluZSBwYWNrYWdlLgoKUmVnYXJkcywKCk1pY2hhZWwKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
