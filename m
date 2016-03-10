From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: real time Userspace RCU
Date: Thu, 10 Mar 2016 20:53:05 +0000 (UTC)
Message-ID: <1899542687.22326.1457643185957.JavaMail.zimbra__45074.9777527109$1457643223$gmane$org@efficios.com>
References: <CAAKbDrcMU2rgStU1uFFg1Syk-B4ZOU2R7aC0On946gCXJ5DnMg@mail.gmail.com>
 <1138868550.112232059.1457635938477.JavaMail.zimbra@polymtl.ca>
 <CAAKbDrdac6jYEu4kjNq8kzCxQkdxJGBHN2+fFCh9wOiotoSYiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 05132A084F
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 20:53:17 +0000 (UTC)
In-Reply-To: <CAAKbDrdac6jYEu4kjNq8kzCxQkdxJGBHN2+fFCh9wOiotoSYiw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yuxin Ren <ryx@gwmail.gwu.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWFyIDEwLCAyMDE2LCBhdCAzOjMzIFBNLCBZdXhpbiBSZW4gcnl4QGd3bWFpbC5n
d3UuZWR1IHdyb3RlOgoKPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuCj4gCj4gSSB3YW50IHRv
IGdlbmVyYWxseSB1bmRlcnN0YW5kIGhvdyB0byBhcHBseSB1cmN1IHRvIHJlYWwgdGltZSBzeXN0
ZW1zLgo+IEkga25vdyByZWFsIHRpbWUgc3lzdGVtIGZvY3VzIG9uIHByZWRpY3RhYmlsaXR5IG9u
IGJvdGggdGltaW5nIGFuZAo+IG1lbW9yeSBjb25zdW1wdGlvbi4KPiBTbyBob3cgZG9lcyByZWFs
IHRpbWUgdXJjdSBzdXBwb3J0IHByZWRpY3RhYmlsaXR5Pwo+IENvdWxkIHlvdSBwcm92aWRlIG1l
IHNvbWUgcGFwZXJzLCBkb2N1bWVudHMgb3IgYW55IG1hdGVyaWFscyBhYm91dCBhbnkKPiBhc3Bl
Y3Qgb2YgcmVhbCB0aW1lIHVyY3U/CgpBZGRpbmcgUGF1bCBFLiBNY0tlbm5leSBpbiBDQywgd2hv
IG1heSBoYXZlIHNvbWUgdGhvdWdodHMgb24gdGhpcwp0b3BpYy4KClRoYW5rcywKCk1hdGhpZXUK
Cj4gCj4gVGhhbmtzIGFnYWluIQo+IAo+IE9uIFRodSwgTWFyIDEwLCAyMDE2IGF0IDE6NTIgUE0s
IE1pY2hlbCBEYWdlbmFpcwo+IDxtaWNoZWwuZGFnZW5haXNAcG9seW10bC5jYT4gd3JvdGU6Cj4+
IFJlYWwtdGltZSBhbmQgZW1iZWRkZWQgc3lzdGVtcyBpcyBhbiBpbXBvcnRhbnQgY3VycmVudCBm
b2N1cyBmb3IgdGhlIExUVG5nCj4+IHRvb2xjaGFpbiByZXNlYXJjaC4gRG8geW91IGhhdmUgc3Bl
Y2lmaWMgbmVlZHMgZm9yIHVzZXJzcGFjZSBSQ1U/Cj4+Cj4+IC0tLS0tIE1haWwgb3JpZ2luYWwg
LS0tLS0KPj4+IEhpLAo+Pj4KPj4+ICBJcyB0aGVyZSBhbnkgd29yayBvciByZXNlYXJjaCBhYm91
dCBVc2Vyc3BhY2UgUkNVIG9uIHJlYWwgdGltZSBvcgo+Pj4gZW1iZWRkZWQgc3lzdGVtcz8KPj4+
IEFueSBpbmZvcm1hdGlvbiBpcyB3ZWxjb21lLgo+Pj4KPj4+IFRoYW5rcyBhIGxvdCEKPj4+IFl1
eGluCj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
Pj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+Pj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+
Pj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo+Pj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4g
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lv
cy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
