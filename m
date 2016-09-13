From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
	guest-to-QEMU trace channel
Date: Tue, 13 Sep 2016 18:50:01 +0200
Message-ID: <8737l3n3ra.fsf__31625.3387755298$1473785421$gmane$org@fimbulvetr.bsc.es>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
 <20160823155430.GB3948@stefanha-x1.localdomain>
 <87lgzm4g5p.fsf@fimbulvetr.bsc.es>
 <20160829134502.GA26282@stefanha-x1.localdomain>
 <87a8fvjtw5.fsf@fimbulvetr.bsc.es>
 <20160831163547.GD18281@stefanha-x1.localdomain>
 <87y436mn02.fsf@fimbulvetr.bsc.es>
 <20160913135250.GA4024@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from roura.ac.upc.es (roura.ac.upc.es [147.83.33.10])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id B12C9A3EE1
 for <lttng-dev@lists.lttng.org>; Tue, 13 Sep 2016 16:51:03 +0000 (UTC)
In-Reply-To: <20160913135250.GA4024@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Tue, 13 Sep 2016 14:52:50 +0100")
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: lttng-dev@lists.lttng.org

U3RlZmFuIEhham5vY3ppIHdyaXRlczoKCj4gT24gTW9uLCBTZXAgMDUsIDIwMTYgYXQgMDQ6Mzc6
MDFQTSArMDIwMCwgTGx1w61zIFZpbGFub3ZhIHdyb3RlOgo+PiBJIHN1cHBvc2UgdGhhdCBpZiB5
b3UgZXhlY3V0ZSB0aGUgc3RhcCBzY3JpcHQgSSBwYXN0ZWQgaXQgd2lsbCBzaG93IHRoZSBwcm9w
ZXIKPj4gdmFsdWVzLiBUaGVuIGl0J3MgZGVmaW5pdGVseSBhIHByb2JsZW0gd2l0aCBEZWJpYW4n
cyB1c2Vyc3BhY2UgcHJvYmVzLgoKPiBTb3JyeSBmb3IgdGhlIGRlbGF5LiAgU3lzdGVtVGFwIHN0
YXRpYyBwcm9iZXMgYXBwZWFyIHRvIHdvcmsgY29ycmVjdGx5IG9uCj4gRmVkb3JhIDI0LgoKPiBJ
IGJ1aWx0IHFlbXUuZ2l0L21hc3RlciBmcm9tIHNvdXJjZSB3aXRoICItLWVuYWJsZS10cmFjZS1i
YWNrZW5kcz1kdHJhY2UiIGFuZAo+IHRyaWVkIHRoZSBmb2xsb3dpbmc6Cgo+ICQgcnBtIC1xaSBz
eXN0ZW10YXAga2VybmVsLWRldmVsIHwgZ3JlcCBTb3VyY2UKPiBTb3VyY2UgUlBNICA6IHN5c3Rl
bXRhcC0zLjAtMy5mYzI0LnNyYy5ycG0KPiBTb3VyY2UgUlBNICA6IGtlcm5lbC00LjcuMi0yMDEu
ZmMyNC5zcmMucnBtCgo+IChCeSB0aGUgd2F5LCBJIGhpdCB0aGUgc2FtZSBtdXRleF9sb2NrKCkg
dnMgaW5vZGVfbG9jaygpIGlzc3VlIGluIHN5c3RlbXRhcCBhcyB5b3UuKQoKPiAkIGNhdCB0ZXN0
LnN0cAo+IHByb2JlIGJlZ2luIHsKPiAJcHJpbnRmKCJoZWxsb1xuIik7Cj4gfQoKPiBwcm9iZSBw
cm9jZXNzKCJwYXRoL3RvL3FlbXUtc3lzdGVtLXg4Nl82NCIpLm1hcmsoImt2bV9pb2N0bCIpCj4g
ewo+IAlwcmludGYoIiV4ICVwXG4iLCAkYXJnMSwgJGFyZzIpCj4gfQoKPiAkIHN1ZG8gc3RhcCB0
ZXN0LnN0cCAtYyAncGF0aC90by9xZW11LXN5c3RlbS14ODZfNjQgLWVuYWJsZS1rdm0gLW0gMTAy
NCcKPiBoZWxsbwo+IGFlMDAgMHgwCj4gYWUwMyAweGEKPiBhZTAzIDB4OQo+IGFlMDMgMHg0Mgo+
IGFlMDEgMHgwCgo+IFRoZXNlIGFyZSB2YWxpZCBhcmd1bWVudCB2YWx1ZXMuICBXaGF0IGhhcHBl
bnMgb24geW91ciBEZWJpYW4gYm94PwoKTGlrZSBpbiBteSBleGFtcGxlLCBJIGdldCBhbGwgemVy
b2VzLiBTbyBJJ2xsIG9wZW4gYSBidWcgb24gZGViaWFuIGFuZCBhc3N1bWUgbXkKZXhhbXBsZSBz
dGFwIHNjcmlwdCBzaG93cyB0aGUgcHJvcGVyIHZhbHVlcy4KClRoYW5rcywKICBMbHVpcwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
