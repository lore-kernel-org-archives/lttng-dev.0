From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RCU on non-cache-coherent memory
Date: Tue, 2 Aug 2016 22:58:57 +0000 (UTC)
Message-ID: <1648244903.1131.1470178737812.JavaMail.zimbra__8223.46854624829$1470178763$gmane$org@efficios.com>
References: <CAAKbDrfJ=umcdwFp7j5RDMZt7AfhAhCnmOfZqvD2WeNuhcb0rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 67150A2051
 for <lttng-dev@lists.lttng.org>; Tue,  2 Aug 2016 22:59:03 +0000 (UTC)
In-Reply-To: <CAAKbDrfJ=umcdwFp7j5RDMZt7AfhAhCnmOfZqvD2WeNuhcb0rw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yuxin Ren <ryx@gwmail.gwu.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gQXVnIDEsIDIwMTYsIGF0IDg6MzAgUE0sIFl1eGluIFJlbiByeXhAZ3dtYWlsLmd3
dS5lZHUgd3JvdGU6Cgo+IEhpIGFsbCwKPiAKPiBJcyB0aGVyZSBhbnkgcmVzZWFyY2ggb3IgcHVi
bGljYXRpb25zIGFib3V0IFJDVSBvbiB0b3Agb2YKPiBub24tY2FjaGUtY29oZXJlbnQgbXVsdGkt
Y29yZSBhcmNoaXRlY3R1cmU/Cj4gTm90IG9ubHkgUkNVLCBhbnkgb3RoZXIgc3luY2hyb25pemF0
aW9uIHRlY2huaXF1ZSBvbiB0b3Agb2YKPiBub24tY2FjaGUtY29oZXJlbnQgbXVsdGktY29yZQo+
IGlzIGFsc28gaGVscGZ1bC4KCkNDaW5nIFBhdWwgRS4gTWNLZW5uZXksIHdobyBtaWdodCBrbm93
IG1vcmUgb24gdGhpcyB0b3BpYy4KCkJhY2sgaW4gMjAwOSB3aGVuIEkgc3RhcnRlZCB0aGUgbGli
dXJjdS5vcmcgcHJvamVjdCwgSQpwbGFubmVkIHRvIGV2ZW50dWFsbHkgYWRkIHN1cHBvcnQgZm9y
IHN1Y2ggYXJjaGl0ZWN0dXJlcywKZS5nLiBCbGFja2Zpbiwgd2hpY2ggaXMgd2h5IEkgaW5pdGlh
bGx5IGFkZGVkIHRoZSBjbW1fbWMoKSwKY21tX3JtYygpIGFuZCBjbW1fd21jKCkgbWFjcm9zIGlu
IHRoZSBsaWJyYXJ5IChzZWUKQ09ORklHX0hBVkVfTUVNX0NPSEVSRU5DWSkuIEhvd2V2ZXIsIGFs
bCBjdXJyZW50bHkgaW1wbGVtZW50ZWQKYXJjaGl0ZWN0dXJlcyBoYXZlIG1lbSBjb2hlcmVuY3ks
IHNvIGl0J3MgYWx3YXlzIGRlZmluZWQgYXMgYQpzaW1wbGUgY29tcGlsZXIgYmFycmllci4gU2Vl
IGluY2x1ZGUvdXJjdS9hcmNoL2dlbmVyaWMuaCBpbiBsaWJ1cmN1CmZvciBkZXRhaWxzLgoKVGhh
bmtzLAoKTWF0aGlldQoKPiAKPiBUaGFua3MgYSBsb3QhCj4gWXV4aW4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJz
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
