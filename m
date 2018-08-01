From: =?utf-8?b?TG/Dr2M=?= Gelle <loic.gelle@polymtl.ca>
Subject: RFC: More flexible support for UST event collection in
	containers
Date: Wed, 01 Aug 2018 17:36:14 +0000
Message-ID: <20180801173614.Horde.ZvKFlt_4hfXqTXVGAy1Ck_S__27186.618690803$1533145323$gmane$org@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 41ggf72r6Zz14ln
 for <lttng-dev@lists.lttng.org>; Wed,  1 Aug 2018 13:43:59 -0400 (EDT)
Received: from horde5.polymtl.ca (horde5.polymtl.ca [132.207.4.156])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id w71HaEKb016690
 for <lttng-dev@lists.lttng.org>; Wed, 1 Aug 2018 13:36:15 -0400
Content-Disposition: inline
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

SGkgYWxsLAoKSSBhbSB3cml0aW5nIGEgcHJvb2Ygb2YgY29uY2VwdCBmb3IgTFRUbmcgKHVzdCAr
IHRvb2xzKSBmb3IgYmV0dGVyICAKc3VwcG9ydCBvZiBhcHBsaWNhdGlvbiB0cmFjaW5nIGluIGNv
bnRhaW5lcnMuIE15IHBvaW50IGlzIHRoYXQgd2UgIApzaG91bGQgYmUgYWJsZSB0byBjb2xsZWN0
IGFsbCBVU1QgZXZlbnRzIGVtaXR0ZWQgZnJvbSB3aXRoaW4gIApjb250YWluZXJzIHVzaW5nIGEg
c2luZ2xlIHNlc3Npb25kIC8gY29uc3VtZXJkLCBhdCBsZWFzdCBpZiB5b3Ugd2FudCAgCnRvLiBU
aGUgbWFpbiBwcm9ibGVtIHRvIHRoYXQgYXBwcm9hY2ggd2FzIHRoYXQgdGhlIHNlc3Npb24gZGVh
bW9uIHdhcyAgCnVuYWJsZSB0byBoYW5kbGUgUElEIGNsYXNoZXMgd2hlbiB0d28gYXBwcyB3aXRo
IHRoZSBzYW1lIHZwaWQgdHJpZWQgdG8gIApyZWdpc3Rlci4gSSBmaXggdGhpcyBieSBwYXRjaGlu
ZyB0aGUgVVNUIGNsaWVudCBmb3IgaXQgdG8gZGVjbGFyZSBib3RoICAKaXRzIFBJRCBhbmQgaXRz
IFBJRCBuYW1lc3BhY2UgaW5vZGUgbnVtYmVyIGR1cmluZyByZWdpc3RyYXRpb24gKGFuZCBJICAK
YWxzbyBwcm9wYWdhdGVkIHRoZSBjaGFuZ2UgdG8gbHR0bmctdG9vbHMgZm9yIGFwcCByZWdpc3Ry
YXRpb24gaW4gdGhlICAKaGFzaHRhYmxlKS4gTXkgcGF0Y2hlZCB2ZXJzaW9ucyBvZiB0b29scyBh
bmQgVVNUIGFyZSBoZXJlLCBpbiB0aGUgIApicmFuY2ggImNvbnRhaW5lcnMiOgoKaHR0cHM6Ly9n
aXRodWIuY29tL2xvaWNnZWxsZS9sdHRuZy11c3QKaHR0cHM6Ly9naXRodWIuY29tL2xvaWNnZWxs
ZS9sdHRuZy10b29scwoKT25lIHByb2JsZW0gdGhhdCBJIGhhdmUgbm93IGlzIHRoYXQgTFRUbmct
dG9vbHMgY3VycmVudGx5IHVzZXMgIAovcHJvYy9bcGlkXS9jbWRsaW5lIHRvIGZldGNoIHRoZSBu
YW1lIG9mIGVhY2ggYXBwbGljYXRpb24gd2hlbiBsaXN0aW5nICAKdGhlIGF2YWlsYWJsZSB0cmFj
ZXBvaW50cy4gVGhpcyBpcyBhIHByb2JsZW0gc2luY2Ugd2UgaGF2ZSBubyAoc2ltcGxlKSAgCndh
eSB0byBrbm93IHRoZSBQSUQgb2YgdGhlIHJlZ2lzdGVyZWQgYXBwcyBpbiB0aGUgY29udGV4dCBv
ZiB0aGUgUElEICAKbmFtZXNwYWNlIG9mIHNlc3Npb25kLCBzbyB0aGlzIHN0ZXAgYmFzaWNhbGx5
IGZhaWxzLiBJIHRob3VnaHQgdGhhdCBhICAKZml4IGZvciB0aGlzIHdvdWxkIGJlIHRvIGFzayB0
aGUgYXBwbGljYXRpb25zIHRoZW1zZWx2ZXMgdG8gZGVjbGFyZSAgCnRoZWlyIG5hbWUgdXNpbmcg
dGhlaXIgZGVkaWNhdGVkIHNvY2tldC4gRG8geW91IHRoaW5rIHRoYXQgd291bGQgYmUgIApwb3Nz
aWJsZSBhbmQgcmVsZXZhbnQ/CgpBbHNvLCBpZiB5b3UgbGlrZSB0aGUgaWRlYSB0aGF0IEknbSBw
dXNoaW5nLCB0aGVyZSBpcyBtb3JlIHdvcmsgYWhlYWQgIAp0byBtYWtlIGl0IGEgZmVhdHVyZSAo
Zm9yIGV4YW1wbGUgcHJvcGFnYXRpbmcgdGhlIGNoYW5nZXMgdG8gcGlkICAKdHJhY2tpbmcpLgoK
VGhhbmtzLApMb8OvYy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
