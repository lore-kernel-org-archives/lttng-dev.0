From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: YACC error building Babeltrace 1.5.2
Date: Tue, 4 Apr 2017 13:24:55 -0400
Message-ID: <90f67647-278a-08a8-3ac3-538a30cf99ab__28494.7561486208$1491326763$gmane$org@efficios.com>
References: <CAK-w0DdwPy625mds=3nda-UotgS2afCXg0J8m6GSHLoO3a6hig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vyG8H0Dwwzsd
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 17:25:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4EA8734012E
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 17:26:15 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id keIEh3KCwa43 for <lttng-dev@lists.lttng.org>;
 Tue,  4 Apr 2017 17:26:08 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BEB133401F1
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 17:26:08 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UQDnzM58zXW5 for <lttng-dev@lists.lttng.org>;
 Tue,  4 Apr 2017 17:26:08 +0000 (UTC)
Received: from [172.16.0.165] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id A93DA34012E
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 17:26:08 +0000 (UTC)
In-Reply-To: <CAK-w0DdwPy625mds=3nda-UotgS2afCXg0J8m6GSHLoO3a6hig@mail.gmail.com>
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

SGksCgpGcm9tIHRoZSByZWFkbWUgb2YgYmFiZWx0cmFjZToKCiAgICBUaGlzIHNvdXJjZSB0cmVl
IGlzIGJhc2VkIG9uIHRoZSBhdXRvdG9vbHMgc3VpdGUgZnJvbSBHTlUgdG8gc2ltcGxpZnkKICAg
IHBvcnRhYmlsaXR5LiBIZXJlIGFyZSBzb21lIHRoaW5ncyB5b3Ugc2hvdWxkIGhhdmUgb24geW91
ciBzeXN0ZW0gaW4gb3JkZXIgdG8KICAgIGNvbXBpbGUgdGhlIGdpdCByZXBvc2l0b3J5IHRyZWUg
OgoKICAgIC0gR05VIGF1dG90b29scyAoYXV0b21ha2UgPj0xLjEwLCBhdXRvY29uZiA+PTIuNTAs
IGF1dG9oZWFkZXIgPj0yLjUwKQogICAgICAobWFrZSBzdXJlIHlvdXIgc3lzdGVtIHdpZGUgImF1
dG9tYWtlIiBwb2ludHMgdG8gYSByZWNlbnQgdmVyc2lvbiEpCiAgICAtIEdOVSBMaWJ0b29sID49
Mi4yCiAgICAgIChmb3IgbW9yZSBpbmZvcm1hdGlvbiwgZ28gdG8gaHR0cDovL3d3dy5nbnUub3Jn
L3NvZnR3YXJlL2F1dG9jb25mLykKICAgIC0gRmxleCA+PTIuNS4zNS4KICAgIC0gQmlzb24gPj0y
LjQuCgpQbGVhc2UgdXBncmFkZSBiaXNvbi95YWNjIHRvIGF0IGxlYXN0IDIuNCBhbmQgcmVwb3J0
IHRvIHVzIGlmIGFueSBlcnJvcnMgaXMgc3RpbGwgcHJlc2VudC4KCkNoZWVycwoKT24gMjAxNy0w
NC0wNCAxMjo1OSBQTSwgUm9ja3kgRHVubGFwIHdyb3RlOgo+IEkgYW0gdHJ5aW5nIHRvIGJ1aWxk
IEJhYmVsdHJhY2UgMS41LjIgYW5kIEkgcmVjZWl2ZWQgdGhlIGZvbGxvd2luZyBlcnJvci4gIEFu
eSBoZWxwIHdvdWxkIGJlIGFwcHJlY2lhdGVkLiAgTGV0IG1lIGtub3cgd2hhdCBvdGhlciBpbmZv
IHRvIHNlbmQuCj4gCj4gbWFrZVs0XTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvZ3Bmc20vZGhvbWUv
cnNkdW5sYXAvYnQvYmFiZWx0cmFjZS0xLjUuMi9mb3JtYXRzL2N0Zi90eXBlcycKPiAgIENDICAg
ICAgIGFycmF5LmxvCj4gICBDQyAgICAgICBlbnVtLmxvCj4gICBDQyAgICAgICBmbG9hdC5sbwo+
ICAgQ0MgICAgICAgaW50ZWdlci5sbwo+ICAgQ0MgICAgICAgc2VxdWVuY2UubG8KPiAgIENDICAg
ICAgIHN0cmluZy5sbwo+ICAgQ0MgICAgICAgc3RydWN0LmxvCj4gICBDQyAgICAgICB2YXJpYW50
LmxvCj4gICBDQ0xEICAgICBsaWJjdGYtdHlwZXMubGEgPGh0dHA6Ly9saWJjdGYtdHlwZXMubGE+
Cj4gbWFrZVs0XTogTGVhdmluZyBkaXJlY3RvcnkgYC9ncGZzbS9kaG9tZS9yc2R1bmxhcC9idC9i
YWJlbHRyYWNlLTEuNS4yL2Zvcm1hdHMvY3RmL3R5cGVzJwo+IE1ha2luZyBhbGwgaW4gbWV0YWRh
dGEKPiBtYWtlWzRdOiBFbnRlcmluZyBkaXJlY3RvcnkgYC9ncGZzbS9kaG9tZS9yc2R1bmxhcC9i
dC9iYWJlbHRyYWNlLTEuNS4yL2Zvcm1hdHMvY3RmL21ldGFkYXRhJwo+ICAgWUFDQyAgICAgY3Rm
LXBhcnNlci5jCj4gL2hvbWUvcnNkdW5sYXAvYnQvYmFiZWx0cmFjZS0xLjUuMi9mb3JtYXRzL2N0
Zi9tZXRhZGF0YS9jdGYtcGFyc2VyLnk6MTA0MC45LTE2OiBzeW50YXggZXJyb3IsIHVuZXhwZWN0
ZWQgaWRlbnRpZmllciwgZXhwZWN0aW5nIHN0cmluZwo+IG1ha2VbNF06ICoqKiBbY3RmLXBhcnNl
ci5jXSBFcnJvciAxCj4gbWFrZVs0XTogTGVhdmluZyBkaXJlY3RvcnkgYC9ncGZzbS9kaG9tZS9y
c2R1bmxhcC9idC9iYWJlbHRyYWNlLTEuNS4yL2Zvcm1hdHMvY3RmL21ldGFkYXRhJwo+IG1ha2Vb
M106ICoqKiBbYWxsLXJlY3Vyc2l2ZV0gRXJyb3IgMQo+IG1ha2VbM106IExlYXZpbmcgZGlyZWN0
b3J5IGAvZ3Bmc20vZGhvbWUvcnNkdW5sYXAvYnQvYmFiZWx0cmFjZS0xLjUuMi9mb3JtYXRzL2N0
ZicKPiBtYWtlWzJdOiAqKiogW2FsbC1yZWN1cnNpdmVdIEVycm9yIDEKPiBtYWtlWzJdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL2dwZnNtL2Rob21lL3JzZHVubGFwL2J0L2JhYmVsdHJhY2UtMS41LjIv
Zm9ybWF0cycKPiBtYWtlWzFdOiAqKiogW2FsbC1yZWN1cnNpdmVdIEVycm9yIDEKPiBtYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL2dwZnNtL2Rob21lL3JzZHVubGFwL2J0L2JhYmVsdHJhY2Ut
MS41LjInCj4gbWFrZTogKioqIFthbGxdIEVycm9yIDIKPiAKPiAKPiBJZiBpdCBoZWxwcywgWUFD
QyBpczoKPiAKPiByc2R1bmxhcEBkaXNjb3ZlcjE4On4vYnQvYmFiZWx0cmFjZS0xLjUuMj4geWFj
YyAtLXZlcnNpb24KPiBiaXNvbiAoR05VIEJpc29uKSAyLjMKPiBXcml0dGVuIGJ5IFJvYmVydCBD
b3JiZXR0IGFuZCBSaWNoYXJkIFN0YWxsbWFuLgo+IAo+IAo+IFRoYW5rcywKPiBSb2NreQo+IAo+
IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0
bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4gCgot
LSAKSm9uYXRoYW4gUi4gSnVsaWVuCkVmZmljaW9zCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
