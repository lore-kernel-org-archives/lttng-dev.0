From: Simon Marchi <simon.marchi@efficios.com>
Subject: Re: [PATCH lttng-tools] configure.ac: Remove duplicated
 CMD_DESCR_ROTATE definition
Date: Mon, 25 Nov 2019 15:00:13 -0500
Message-ID: <f50969b4-289a-237e-012d-2f76e437c0af__8337.87593744404$1574712037$gmane$org@efficios.com>
References: <20190527155246.24102-1-simon.marchi@efficios.com>
 <5e19a746-9270-11c1-dd26-24e13a95c359@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47MHvP3G29z1RBM
 for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2019 15:00:17 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E76124212D3
 for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2019 15:00:15 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id bqj4Xdv023pA for <lttng-dev@lists.lttng.org>;
 Mon, 25 Nov 2019 15:00:14 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B872F4212C6
 for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2019 15:00:14 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id GLHOvjDnJ2yX for <lttng-dev@lists.lttng.org>;
 Mon, 25 Nov 2019 15:00:14 -0500 (EST)
Received: from [172.16.0.95] (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id A06274212B9
 for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2019 15:00:14 -0500 (EST)
In-Reply-To: <5e19a746-9270-11c1-dd26-24e13a95c359@efficios.com>
Content-Language: tl
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

T24gMjAxOS0wOC0xOSA5OjQ3IHAubS4sIFNpbW9uIE1hcmNoaSB3cm90ZToKPiBPbiAyMDE5LTA1
LTI3IDExOjUyIGEubS4sIFNpbW9uIE1hcmNoaSB3cm90ZToKPj4gQ01EX0RFU0NSX1JPVEFURSBp
cyBkZWZpbmVkIHR3aWNlIGJ5IGNvbmZpZ3VyZS4gIFRoaXMgYnJlYWtzIGNvbmZpZ3VyaW5nCj4+
IHdpdGggIi1XZXJyb3IgLVdhbGwiLCBhcyBzb21lIHRlc3QgcHJvZ3JhbXMgZG9uJ3QgY29tcGls
ZSBkdWUgdG86Cj4+Cj4+ICAgY29uZmlndXJlOjE2OTkwOiBnY2MgLW8gY29uZnRlc3QgLVdhbGwg
LVdlcnJvciAgIGNvbmZ0ZXN0LmMgID4mNQo+PiAgIGNvbmZ0ZXN0LmM6MTYzOiBlcnJvcjogIkNP
TkZJR19DTURfREVTQ1JfUk9UQVRFIiByZWRlZmluZWQgWy1XZXJyb3JdCj4+ICAgICNkZWZpbmUg
Q09ORklHX0NNRF9ERVNDUl9ST1RBVEUgIkFyY2hpdmUgYSB0cmFjaW5nIHNlc3Npb27igJlzIGN1
cnJlbnQgdHJhY2UgY2h1bmsiCj4+Cj4+ICAgY29uZnRlc3QuYzoxNTQ6IG5vdGU6IHRoaXMgaXMg
dGhlIGxvY2F0aW9uIG9mIHRoZSBwcmV2aW91cyBkZWZpbml0aW9uCj4+ICAgICNkZWZpbmUgQ09O
RklHX0NNRF9ERVNDUl9ST1RBVEUgIkFyY2hpdmUgYSB0cmFjaW5nIHNlc3Npb24ncyBjdXJyZW50
IHRyYWNlIGNodW5rIgo+Pgo+PiAgIGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIE1hcmNoaSA8c2ltb24ubWFyY2hpQGVm
ZmljaW9zLmNvbT4KPj4gLS0tCj4+ICBjb25maWd1cmUuYWMgfCAxIC0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25m
aWd1cmUuYWMKPj4gaW5kZXggMjE0ZDU4YWM4ODU2Li5lODg4NzU4NTYxMTUgMTAwNjQ0Cj4+IC0t
LSBhL2NvbmZpZ3VyZS5hYwo+PiArKysgYi9jb25maWd1cmUuYWMKPj4gQEAgLTQxMiw3ICs0MTIs
NiBAQCBfQUNfREVGSU5FX1FVT1RFRF9BTkRfU1VCU1QoW0NNRF9ERVNDUl9TVEFUVVNdLCBbR2V0
IHRoZSBzdGF0dXMgb2YgdGhlIGN1cnJlbnQgdAo+PiAgX0FDX0RFRklORV9RVU9URURfQU5EX1NV
QlNUKFtDTURfREVTQ1JfU1RPUF0sIFtTdG9wIHRyYWNpbmddKQo+PiAgX0FDX0RFRklORV9RVU9U
RURfQU5EX1NVQlNUKFtDTURfREVTQ1JfRElTQUJMRV9ST1RBVElPTl0sIFtVbnNldCBhIHJvdGF0
aW9uIHNjaGVkdWxlXSkKPj4gIF9BQ19ERUZJTkVfUVVPVEVEX0FORF9TVUJTVChbQ01EX0RFU0NS
X0VOQUJMRV9ST1RBVElPTl0sIFtTZXQgYSByb3RhdGlvbiBzY2hlZHVsZV0pCj4+IC1fQUNfREVG
SU5FX1FVT1RFRF9BTkRfU1VCU1QoW0NNRF9ERVNDUl9ST1RBVEVdLCBbQXJjaGl2ZSBhIHRyYWNp
bmcgc2Vzc2lvbuKAmXMgY3VycmVudCB0cmFjZSBjaHVua10pCj4+ICBfQUNfREVGSU5FX1FVT1RF
RF9BTkRfU1VCU1QoW0NNRF9ERVNDUl9UUkFDS10sIFtUcmFjayBzcGVjaWZpYyBzeXN0ZW0gcmVz
b3VyY2VzXSkKPj4gIF9BQ19ERUZJTkVfUVVPVEVEX0FORF9TVUJTVChbQ01EX0RFU0NSX1VOVFJB
Q0tdLCBbVW50cmFjayBzcGVjaWZpYyBzeXN0ZW0gcmVzb3VyY2VzXSkKPj4gIF9BQ19ERUZJTkVf
UVVPVEVEX0FORF9TVUJTVChbQ01EX0RFU0NSX1ZFUlNJT05dLCBbU2hvdyB2ZXJzaW9uIGluZm9y
bWF0aW9uXSkKPj4KPiAKPiBQaW5nLgo+IAoKUmUtcGluZy4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
