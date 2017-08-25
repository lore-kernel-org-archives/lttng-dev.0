From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: wrong use of the
 relay_streams_sent in snapshot
Date: Fri, 25 Aug 2017 16:47:35 +0000 (UTC)
Message-ID: <1348147249.16120.1503679655259.JavaMail.zimbra__5228.21433046392$1503679620$gmane$org@efficios.com>
References: <1503521333-4905-1-git-send-email-jdesfossez@efficios.com>
 <165346610.15437.1503587759926.JavaMail.zimbra@efficios.com>
 <516484ad-49e6-d89f-f8c1-6a1326c4def2@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xf6WR4jbDz15Vw
 for <lttng-dev@lists.lttng.org>; Fri, 25 Aug 2017 16:46:43 +0000 (UTC)
In-Reply-To: <516484ad-49e6-d89f-f8c1-6a1326c4def2@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gQXVnIDI0LCAyMDE3LCBhdCAxMjozNSBQTSwgSnVsaWVuIERlc2Zvc3NleiBqZGVz
Zm9zc2V6QGVmZmljaW9zLmNvbSB3cm90ZToKCj4+IElmIHlvdSByZW1vdmUgdGhpcywgSSB0aGlu
ayB0aGUgc3RyZWFtcyB3aWxsIG5ldmVyIGdldCBwdWJsaXNoZWQKPj4gd2l0aGluIHRoZSByZWxh
eWQuIChwdWJsaXNoX2Nvbm5lY3Rpb25fbG9jYWxfc3RyZWFtcygpKS4gSXMgdGhpcwo+PiBhbiBl
eHBlY3RlZCBzaWRlLWVmZmVjdCA/IEl0IHNob3VsZCBiZSBkb2N1bWVudGVkIGluIHRoZSBjaGFu
Z2Vsb2cuCj4+IE15IGd1ZXNzIGlzIHRoYXQgd2UgaW5kZWVkIGRvbid0IHdhbnQgdG8gcHVibGlz
aCB0aGUgc25hcHNob3QKPj4gc3RyZWFtcyB0byB0aGUgdmlld2Vycy4KPiBJbmRlZWQsIGEgc25h
cHNob3Qgc2Vzc2lvbiBjYW5ub3QgYmUgYSBsaXZlIHNlc3Npb24sIHNvIHdlIGRvbid0Cj4gd2Fu
dC9uZWVkIHRvIHB1Ymxpc2ggdGhvc2Ugc3RyZWFtcy4gQWxzbywgc2VuZGluZyB0aGlzIG1lc3Nh
Z2UgZXZlcnkKPiB0aW1lIHdlIHNlbmQgYSBzdHJlYW0gaXMgYSB3cm9uZyB1c2FnZSBvZiB0aGUg
Y29tbWFuZC4KCllvdSdsbCBuZWVkIHRvIGVuc3VyZSB0aGF0IHdlIGFyZSBub3QgZnJlZWluZyB0
aGUgc3RyZWFtcyB0b28KcXVpY2tseSBvciBsZWFraW5nIHRoZW0gaW4gcmVsYXlkIGFmdGVyIHlv
dXIgY2hhbmdlLgoKPiAKPj4gVGhlIHJlYXNvbiBmb3IgZG9pbmcgdGhpcyBjaGFuZ2Ugc2hvdWxk
IGFsc28gYmUgZG9jdW1lbnRlZC4gV2hhdAo+PiBiZWhhdmlvciBpcyB1bndhbnRlZCBoZXJlIGZy
b20gYSByZWxheWQgcGVyc3BlY3RpdmUgPwo+IFdlIGFyZSBzZW5kaW5nIHRoaXMgbWVzc2FnZSB0
byB0aGUgcmVsYXkgKGFuZCB3YWl0aW5nIGZvciB0aGUKPiBjb25maXJtYXRpb24pIGJlZm9yZSB0
YWtpbmcgdGhlIHNuYXBzaG90IG9mIGVhY2ggc3RyZWFtLiBTbywgaW4gYWRkaXRpb24KPiB0byBi
ZWluZyB3cm9uZyBhbmQgdXNlbGVzcywgaXQgYWRkcyBhIGNvbnNpZGVyYWJsZSBkZWxheSBiZWZv
cmUgdGFraW5nCj4gdGhlIHNuYXBzaG90IG9mIGVhY2ggc3RyZWFtLgo+IAo+IERvIHlvdSBhZ3Jl
ZSA/CgpJdCBsb29rcyBsaWtlIGEgZ29vZCBpZGVhIHRvIHJlbW92ZSBpdC4gSSBqdXN0IHdhbnQg
dXMgdG8gbWFrZSBzdXJlIHRoZQpzbmFwc2hvdCBtb2RlIGRvZXMgbm90IHNvbWVob3cgZXhwZWN0
IHRoZSBzdHJlYW1zIHRvIGJlIHB1Ymxpc2hlZAp3aXRoaW4gb3RoZXIgcGFydHMgb2YgdGhlIHJl
bGF5ZCBjb2RlLgoKVGhhbmtzLAoKTWF0aGlldQoKPiAKPiBUaGFua3MsCj4gCj4gSnVsaWVuCgot
LSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNv
bQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
