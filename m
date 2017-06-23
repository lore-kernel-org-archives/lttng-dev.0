From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Allocation failures with babeltrace and
 TraceCompass - corrupt trace?
Date: Fri, 23 Jun 2017 15:55:21 -0400
Message-ID: <9be26c8f-8a5c-03d3-8e4b-0d8f37eeeb9a__47690.7871351161$1498248118$gmane$org@efficios.com>
References: <077661a3-81fb-b8e7-bf3b-15167c9240cc@kdab.com>
 <2088647396.12698.1497453179549.JavaMail.zimbra@efficios.com>
 <85fce57d-85e8-7ce8-998b-7fd7e91f6002@kdab.com>
 <446189346.12874.1497458373753.JavaMail.zimbra@efficios.com>
 <b04b1c20-6981-b9f6-50a6-4c12bb6b4d69@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wvTj52LZtztl7
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jun 2017 19:56:08 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 91214340256
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jun 2017 19:55:29 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 6dicTRQn9dbn for <lttng-dev@lists.lttng.org>;
 Fri, 23 Jun 2017 19:55:29 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3FBEC340259
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jun 2017 19:55:29 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zTX5w9DeCfxy for <lttng-dev@lists.lttng.org>;
 Fri, 23 Jun 2017 19:55:29 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id 24622340256
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jun 2017 19:55:29 +0000 (UTC)
In-Reply-To: <b04b1c20-6981-b9f6-50a6-4c12bb6b4d69@kdab.com>
Content-Language: en-CA
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

T24gMjAxNy0wNi0yMyAxMTo0OCwgVGhvbWFzIE1jR3VpcmUgd3JvdGU6Cj4+PiBBbnkgaWRlYSB3
aGF0IGNhbiBjYXVzZSB0aGUgY29ycnVwdGVkIHRyYWNlPwo+PiBCYXNlZCBvbiB5b3VyIGJhYmVs
dHJhY2UgYmFja3RyYWNlLCB0aGUgcG9zc2libGUgY3VscHJpdHMgd291bGQgYmUgdGhlCj4+IGV2
ZW50cyB0aGF0IGhhdmUgYSBzZXF1ZW5jZSAodmFyaWFibGUtc2l6ZWQgYXJyYXkpOgo+Pgo+PiBz
eXNjYWxsczogc2VsZWN0LCBwb2xsLCBwcG9sbCwgcHNlbGVjdDYsIGVwb2xsX3dhaXQsIGVwb2xs
X3B3YWl0Cj4+Cj4+IGJsb2NrX3JxX2lzc3VlLCBibG9ja19ycV9pbnNlcnQsIGJsb2NrX3JxX2Nv
bXBsZXRlLCBibG9ja19ycV9yZXF1ZXVlLCBibG9ja19ycV9hYm9ydC4KPj4KPj4gVGhlcmUgYXJl
IGEgZmV3IGFwcHJvYWNoZXMgdG8gY29ybmVyaW5nIHRoZSBpc3N1ZS4gWW91IGNhbiB0cnkgcmVw
cm9kdWNpbmcKPj4gb24geW91ciB3b3JrbG9hZC9jb25maWcgYnkgb25seSBlbmFibGluZyBvbmUg
b2YgdGhlc2UgZXZlbnRzIGF0IGEgdGltZS4KPj4gSnVzdCBrbm93aW5nIHdoaWNoIGV2ZW50KHMp
IGlzL2FyZSB0aGUgY3VscHJpdCB3b3VsZCBiZSBhIGdvb2Qgc3RhcnQuCj4+Cj4+IEFub3RoZXIg
cG9zc2liaWxpdHkgd291bGQgYmUgdG8gc2VuZCB1cyBhIHRyYWNlIHJlcHJvZHVjaW5nIHRoZSBp
c3N1ZQo+PiB3aXRoIG9ubHkgdGhvc2UgZXZlbnRzIGVuYWJsZWQsIHdoaWNoIHNob3VsZCBub3Qg
Y29udGFpbiBjb25maWRlbnRpYWwKPj4gaW5mbyBhYm91dCB5b3VyIHN5c3RlbS4KPiAKPiBJJ3Zl
IGFkZGVkIHNvbWUgZGVidWcgc3RhdGVtZW50cyB0byBiYWJlbHRyYWNlIG5vdy4gVGhlIGN1bHBy
aXQgaW4gdGhpcwo+IHBhcnRpY3VsYXIgY2FzZSBpcyB0aGUgZmlyc3QgYmxvY2tfcnFfY29tcGxl
dGUgZXZlbnQsIHRoZSBfX2NtZF9sZW5ndGgKPiBmaWVsZCBjb250YWlucyBhIGxhcmdlIHZhbHVl
ICgzMDQwODc3NTkyKS4gX19jbWRfbGVuZ3RoIGlzIHVzZWQgYXMgdGhlCj4gbGVuZ3RoIGZvciB0
aGUgX2NtZCBzZXF1ZW5jZSwgYW5kIHRoZW4gb2YgY291cnNlIGFsbG9jYXRpbmcgc3BhY2UgZm9y
Cj4gdGhhdCBzZXF1ZW5jZSBmYWlscy4KPiAKPiBBbnkgaWRlYSB3aGF0IGNhbiBjYXVzZSBfX2Nt
ZF9sZW5ndGggdG8gYmUgYm9ndXM/CgpIaSBUaG9tYXMsCgpJIHNlZSBmcm9tIHRoZSBtZXRhZGF0
YSBmaWxlIHlvdSBwcm92aWRlZCB0aGF0IHlvdXIga2VybmVsIHZlcnNpb24gaXMKNC45LjI4LTIw
MTcwNDI4LTEsIGlzIGl0IGJ1aWx0IGZyb20gdmFuaWxsYSBrZXJuZWwgc291cmNlcz8gSWYgbm90
LApjb3VsZCB5b3UgcG9pbnQgdXMgdG8gYSBnaXQgcmVwbyBvciBzb3VyY2UgYXJjaGl2ZT8gSXQg
d291bGQgaGVscCBhIGxvdAp0byBmaWd1cmUgdGhpcyBvdXQuCgpUaGFua3MsCgpNaWNoYWVsCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
