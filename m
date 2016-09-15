From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Thu, 15 Sep 2016 11:21:22 -0400
Message-ID: <646123a6-aed5-0b8e-bafa-ca9dfed6d802__16179.7672081322$1473953462$gmane$org@efficios.com>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
 <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
 <CAF4oYfHyRe1KmbAgy4eKk6oDVWvZp+TP3SRXZ+BuJf5iWwEQwQ@mail.gmail.com>
 <022bc22a602e4631903ee12b6dd1be6c@EUX13SRV1.EU.NEC.COM>
 <02c06e3a-06ad-0c77-c3b2-bb9ab1dc3995@efficios.com>
 <bf4d2ea2d4844db0bf0511d48cade46d@EUX13SRV1.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1790CA4038
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 15:31:38 +0000 (UTC)
In-Reply-To: <bf4d2ea2d4844db0bf0511d48cade46d@EUX13SRV1.EU.NEC.COM>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: David Aldrich <David.Aldrich@EMEA.NEC.COM>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgoKT24gMjAxNi0wOS0xNSAxMDozNiBBTSwgRGF2aWQgQWxkcmljaCB3cm90ZToKPiBIaQo+
Cj4gSSdtIGFmcmFpZCBJJ20gc3RpbGwgc3RydWdnbGluZyB3aXRoIGdldHRpbmcgc3RhcnRlZCB3
aXRoIGx0dG5nLiBUbyByZWNhcCwgSSB3YW50IHRvIHVzZSBsdHRuZyArIFRyYWNlQ29tcGFzcyB0
byBtb25pdG9yIHRoZSBzY2hlZHVsaW5nIG9mIHRocmVhZHMgaW4gbXkgbXVsdGktdGhyZWFkZWQg
QysrIGFwcGxpY2F0aW9uIG9uIFVidW50dS4KPgo+IEhlcmUgaXMgbXkgc2Vzc2lvbjoKPgo+ICQg
c3VkbyBwa2lsbCBsdHRuZy1zZXNzaW9uZAo+ICQgc3VkbyBsdHRuZy1zZXNzaW9uZAo+IEVycm9y
OiBBbHJlYWR5IHJ1bm5pbmcgZGFlbW9uLgoKV291bGQgeW91IGhhcHBlbiB0byBoYXZlIGluc3Rh
bGxlZCBsdHRuZyB2aWEgdGhlIHBwYSBvciBhcHQtZ2V0L2VxdWl2YWxlbnQuCgpJZiBJIHJlbWVt
YmVyIGNvcnJlY3RseSB0aG9zZSBwYWNrYWdlIGluc3RhbGwgYW4gYWN0dWFsIGRhZW1vbi4gSWYg
eW91IApraWxsIGl0LCBpdCB3aWxsIGdldCByZSBzcGF3bmVkLgoKTWFrZSBzdXJlIHRoYXQgYWRk
IHlvdXIgdXNlciB0byB0aGUgdHJhY2luZyBncm91cCB0aGVuIGxvZyBvdXQvbG9nIGluLgoKQ2hl
ZXJzCj4KPiAkIGx0dG5nIGNyZWF0ZSBkZW1vX3Nlc3Npb24gU3Bhd25pbmcgYSBzZXNzaW9uIGRh
ZW1vbiBTZXNzaW9uIGRlbW9fc2Vzc2lvbiBjcmVhdGVkLgo+IFRyYWNlcyB3aWxsIGJlIHdyaXR0
ZW4gaW4gL2hvbWUvPHNuaXA+L2x0dG5nLXRyYWNlcy9kZW1vX3Nlc3Npb24tMjAxNjA5MTUtMTUy
NjUzCj4gPHNuaXA+On4kIFBFUlJPUiBbMTQ5NTYvMTQ5NjRdOiBiaW5kIGluZXQ6IEFkZHJlc3Mg
YWxyZWFkeSBpbiB1c2UgKGluIGx0dGNvbW1fYmluZF9pbmV0X3NvY2soKSBhdCBpbmV0LmM6MTA5
KQo+IFdhcm5pbmc6IEFuIG90aGVyIHNlc3Npb24gZGFlbW9uIGlzIHVzaW5nIHRoaXMgSlVMIHBv
cnQuIEpVTCBzdXBwb3J0IHdpbGwgYmUgZGVhY3RpdmF0ZWQgbm90IGludGVyZmVyaW5nIHdpdGgg
dGhlIHRyYWNpbmcuCj4KPiAkIHN1ZG8gbHR0bmcgZW5hYmxlLWV2ZW50IC1rIHNjaGVkX3N3aXRj
aCAtcyBkZW1vX3Nlc3Npb24KPiBFcnJvcjogRXZlbnQgc2NoZWRfc3dpdGNoOiBTZXNzaW9uIG5h
bWUgbm90IGZvdW5kIChjaGFubmVsIGNoYW5uZWwwLCBzZXNzaW9uIGRlbW9fc2Vzc2lvbikKPiBX
YXJuaW5nOiBTb21lIGNvbW1hbmQocykgd2VudCB3cm9uZwo+Cj4gQXMgeW91IGNhbiBzZWUsIGVh
Y2ggb2YgdGhlc2UgY29tbWFuZCBnZW5lcmF0ZWQgYSB3YXJuaW5nIG9yIGVycm9yLiAgUGxlYXNl
IHdpbGwgeW91IHN1Z2dlc3Qgd2hlcmUgSSBhbSBnb2luZyB3cm9uZz8KPgo+IEJlc3QgcmVnYXJk
cwo+Cj4gRGF2aWQKPgoKLS0gCkpvbmF0aGFuIFIuIEp1bGllbgpFZmZpY2lvcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
