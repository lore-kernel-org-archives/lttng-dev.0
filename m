From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: It should be possible to build lttng w/o the test
 clock plugin.
Date: Tue, 19 Jul 2016 15:31:00 -0400
Message-ID: <553967e1-855a-954b-5a06-5fd7e2ab309e__9581.89331363446$1468956690$gmane$org@efficios.com>
References: <CAF2baFdXVFeg4yYHPUhi2Tmh3ghS1H0jSLMdUJF=NNjj_+72+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id F0BBCA3801
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2016 19:31:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7BA8E3400E2
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2016 19:31:02 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id S1phjWnt0Mfj for <lttng-dev@lists.lttng.org>;
 Tue, 19 Jul 2016 19:31:01 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C9A54340298
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2016 19:31:01 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id pL5moBLMuZxP for <lttng-dev@lists.lttng.org>;
 Tue, 19 Jul 2016 19:31:01 +0000 (UTC)
Received: from [172.16.0.165] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 508093400E2
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2016 19:31:01 +0000 (UTC)
In-Reply-To: <CAF2baFdXVFeg4yYHPUhi2Tmh3ghS1H0jSLMdUJF=NNjj_+72+A@mail.gmail.com>
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

SGkgQW5kZXJzLAoKVGhhbmtzIGZvciB5b3VyIGNvbnRyaWJ1dGlvbi4gTWFrZSBzdXJlIHRvIGxv
b2sgYXQgdGhlIGNvbnRyaWJ1dG9yJ3MgCmd1aWRlIFsxXS4KClsxXSBodHRwOi8vbHR0bmcub3Jn
L2NvbW11bml0eS8jY29udHJpYnV0b3JzLWd1aWRlCgoKT24gMjAxNi0wNy0xOSAwMzoxOCBQTSwg
QW5kZXJzIFdhbGxpbiB3cm90ZToKPiBIaSwKPgo+IG9ubHkgb25lIGNsb2NrIHBsdWdpbiBjYW4g
YmUgdXNlZCB3aGVuIGJ1aWxkaW5nIGx0dG5nIGluc2lkZSB0aGUga2VybmVsLgo+IFRvIGJlIGFi
bGUgdG8gd3JpdGUgYSBjdXN0b20gY2xvY2sgcGx1Z2luIGl0IHNob3VsZCBiZSBwb3NzaWJsZSB0
byBub3QKPiBidWlsZCB0aGUgdGVzdCBjbG9jayBwbHVnaW4uCj4KPiBUaGlzIGFwcGVuZGVkIHBh
dGNoIGlzIG9uZSB3YXkgdG8gbWFrZSB0aGlzIHBvc3NpYmxlLgoKV2hhdCB3b3VsZCBiZSB0aGUg
YWx0ZXJuYXRpdmUgPwoKQ2hlZXJzCgo+Cj4gUmVnYXJkcwo+IEFuZGVycyBXYWxsaW4KPgo+Cj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCi0tIApKb25h
dGhhbiBSLiBKdWxpZW4KRWZmaWNpb3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
