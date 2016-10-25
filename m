From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [RFC/PATCH 0/3] babeltrace: test harness
 improvements + new tests
Date: Tue, 25 Oct 2016 13:43:49 -0400
Message-ID: <f5722cd5-1b07-a21f-f841-5813cc76cfee__18550.0656175011$1477417461$gmane$org@efficios.com>
References: <1477409667-8309-1-git-send-email-nathan_lynch@mentor.com>
 <70c97759-e06a-a744-7b71-e8a22275cc78@efficios.com>
 <a32c590f-8538-e7db-c2e0-2dfb9b6c949f@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 177AAA3A45
 for <lttng-dev@lists.lttng.org>; Tue, 25 Oct 2016 17:44:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 57FDD3402C2
 for <lttng-dev@lists.lttng.org>; Tue, 25 Oct 2016 17:44:03 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id SrIYyJk-nrej for <lttng-dev@lists.lttng.org>;
 Tue, 25 Oct 2016 17:43:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D47E534029C
 for <lttng-dev@lists.lttng.org>; Tue, 25 Oct 2016 17:43:58 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cty-rml8azGD for <lttng-dev@lists.lttng.org>;
 Tue, 25 Oct 2016 17:43:58 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id B5A6C340256
 for <lttng-dev@lists.lttng.org>; Tue, 25 Oct 2016 17:43:58 +0000 (UTC)
In-Reply-To: <a32c590f-8538-e7db-c2e0-2dfb9b6c949f@mentor.com>
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

T24gMjAxNi0xMC0yNSAxMjowNSwgTmF0aGFuIEx5bmNoIHdyb3RlOgo+IE9uIDEwLzI1LzIwMTYg
MTA6NTAgQU0sIEpvbmF0aGFuIFJham90dGUgSnVsaWVuIHdyb3RlOgo+Pgo+PiBPbiAyMDE2LTEw
LTI1IDExOjM0IEFNLCBOYXRoYW4gTHluY2ggd3JvdGU6Cj4+PiBUaGlzIGlzIHdvcmtpbmcgdG93
YXJkIG1vdmluZyBmcm9tIHBvcHQgdG8gR0xpYiBmb3IgY29tbWFuZC1saW5lCj4+PiBwYXJzaW5n
Lgo+Pgo+PiBXaGF0IGlzIHRoZSBtb3RpdmF0aW9uIGJlaGluZCB0aGlzID8KPiAKPiBCYWJlbHRy
YWNlIGFscmVhZHkgdXNlcyBHTGliIGV4dGVuc2l2ZWx5IGFuZCwgYXMgYmVzdCBJIGNhbiB0ZWxs
LCBpdAo+IGRvZXNuJ3QgZG8gYW55dGhpbmcgd2l0aCBjb21tYW5kLWxpbmUgb3B0aW9ucyB0aGF0
IEdMaWIgZG9lc24ndCBzdXBwb3J0Lgo+ICBHTGliJ3MgY29tbWFuZC1saW5lIHBhcnNpbmcgZmFj
aWxpdHkgaXMgZXhwbGljaXRseSBpbnRlbmRlZCB0byBiZSBhCj4gcmVwbGFjZW1lbnQgZm9yIHBv
cHQ6Cj4gCj4gaHR0cHM6Ly9kZXZlbG9wZXIuZ25vbWUub3JnL2dsaWIvc3RhYmxlL2dsaWItQ29t
bWFuZGxpbmUtb3B0aW9uLXBhcnNlci5odG1sI2dsaWItQ29tbWFuZGxpbmUtb3B0aW9uLXBhcnNl
ci5kZXNjcmlwdGlvbgo+IAo+IEknbSBhbHNvIHdvcmtpbmcgb24gaW1wcm92aW5nIEJhYmVsdHJh
Y2UncyBNaW5HVyBwb3J0IGFuZCByZW1vdmluZyB0aGUKPiBwb3B0IGRlcGVuZGVuY3kgd2lsbCBt
YWtlIHRoYXQgZWFzaWVyLgoKWW91IHNob3VsZCBoYXZlIGEgbG9vayBhdApodHRwczovL2dpdGh1
Yi5jb20vbWplYW5zb24vYmFiZWx0cmFjZS9jb21taXRzL21pbmd3NjQKCkNoZWVycywKCk1pY2hh
ZWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
