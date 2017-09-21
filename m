From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [RFC v2] Add kmalloc failover to vmalloc
Date: Thu, 21 Sep 2017 16:30:22 -0400
Message-ID: <72c66999-9d90-7101-199a-b0fc787d6f8e__2248.46918504245$1506025839$gmane$org@efficios.com>
References: <1506018582-22403-1-git-send-email-mjeanson@efficios.com>
 <1705207820.15923.1506019177110.JavaMail.zimbra@efficios.com>
 <73494ae7-dd98-4069-6b2c-49fad21698ca@efficios.com>
 <779758199.15975.1506019933645.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xypC44j9ZzCXZ
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 20:30:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 79EDF34020B
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 20:31:19 +0000 (UTC)
In-Reply-To: <779758199.15975.1506019933645.JavaMail.zimbra@efficios.com>
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
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0wOS0yMSAxNDo1MiwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gLS0tLS0gT24g
U2VwIDIxLCAyMDE3LCBhdCAyOjQzIFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNp
b3MuY29tIHdyb3RlOgo+IAo+PiBPbiAyMDE3LTA5LTIxIDE0OjM5LCBNYXRoaWV1IERlc25veWVy
cyB3cm90ZToKPj4+IC0tLS0tIE9uIFNlcCAyMSwgMjAxNywgYXQgMjoyOSBQTSwgTWljaGFlbCBK
ZWFuc29uIG1qZWFuc29uQGVmZmljaW9zLmNvbSB3cm90ZToKPj4+Cj4+Pj4gVGhpcyBwYXRjaCBp
cyBiYXNlZCBvbiB0aGUga3ZtYWxsb2MgaGVscGVycyBpbnRyb2R1Y2VkIGluIGtlcm5lbCA0LjEy
Lgo+Pj4+Cj4+Pj4gSXQgd2lsbCBncmFjZWZ1bGx5IGZhaWxvdmVyIG1lbW9yeSBhbGxvY2F0aW9u
cyBvZiBtb3JlIHRoYW4gb25lIHBhZ2UgdG8KPj4+PiB2bWFsbG9jIGZvciBzeXN0ZW1zIHVuZGVy
IGhpZ2ggbWVtb3J5IHByZXNzdXJlIG9yIGZyYWdtZW50YXRpb24uCj4+Pj4KPj4+PiBJIG9ubHkg
dXNlZCBpdCBpbiBsdHRuZy1ldmVudHMuYyBhcyBhIFBPQywgbW9zdCBhbGxvY2F0aW9ucyBmaXQg
aW50byBhCj4+Pj4gc2luZ2xlIHBhZ2Ugc28gSSdtIG5vdCBzdXJlIGhvdyB1c2VmdWwgdGhpcyBh
Y3R1YWxseSBpcy4KPj4+Pgo+Pj4+IFRob3VnaHRzPwo+Pj4KPj4+IEp1c3QgdXBkYXRlIHRoZSBj
aGFuZ2Vsb2cgdG8gc3BlY2lmeSB3aHkgd2UgbmVlZCB0aGlzIGZvciBzdHJ1Y3QgbHR0bmdfc2Vz
c2lvbgo+Pj4gKH4zMmtCKSwgYW5kIHlvdSBjYW4gc3VibWl0IGl0IGZvciBnb29kIHdpdGggYSAi
Rml4OiAiIHRhZy4KPj4KPj4gSSdtIG5vdCBzdXJlIGl0IHNob3VsZCBiZSBhIGZpeCwgZm9yIHRo
aXMgdG8gYmUgb2YgYW55IHVzZSBhbGwgdGhlIG90aGVyCj4+IGFsbG9jYXRpb25zIGJpZ2dlciB0
aGFuIFBBR0VfU0laRSBzaG91bGQgYWxzbyB1c2UgaXQuIE90aGVyd2lzZSwgdGhlCj4+IHNlc3Np
b24gYWxsb2NhdGlvbiB3aWxsIHN1Y2NlZWQgYnV0IHRoZSBuZXh0IHNpemVhYmxlIGFsbG9jYXRp
b24gd2lsbAo+PiBzdGlsbCBmYWlsLgo+IAo+IFdoYXQgb3RoZXIgYWxsb2NhdGlvbnMgbGFyZ2Vy
IHRoYW4gUEFHRV9TSVpFIHVzaW5nIGttYWxsb2MgZGlkIHlvdSBzcG90ID8KClRoaXMgaXMgbm90
IGFuIGV4aGF1c3RpdmUgbGlzdCA6CgpsdHRuZy1jb250ZXh0LmM6CiAtIG5ld19maWVsZHM6IDEz
NiAqIG4KCmx0dG5nLWNvbnRleHQtcGVyZi1jb3VudGVycy5jOgogLSBldmVudHM6IGlmIHlvdSBo
YXZlIG1vcmUgdGhhbiA1MTIgQ1BVcwoKbGliL3ByaW9faGVhcC9sdHRuZ19wcmlvX2hlYXAuYzoK
IC0gbmV3X3B0cnMKCgpCdXQgbW9zdGx5IGluIHRoZSByaW5nYnVmZmVyLCB0aG91Z2h0IEkgaGF2
ZSBubyBpZGVhIGlmIGEgZmFpbG92ZXIgdG8Kdm1hbGxvYyBpcyBhY2NlcHRhYmxlIGluIHRoaXMg
Y2FzZS4KCj4gCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAKPiAKPj4KPj4+Cj4+PiBUaGFua3Ms
Cj4+Pgo+Pj4gTWF0aGlldQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
