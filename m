From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] wfcqueue: allow defining CDS_WFCQ_WAIT_SLEEP
 to override `poll'
Date: Fri, 17 Aug 2018 20:31:34 +0000
Message-ID: <20180817203134.zhvzvddsdtv54wg5__41831.8939897746$1534538272$gmane$org@dcvr>
References: <20180801185445.mcvkvxmhqm5hflrj@dcvr>
 <1597828270.1143.1534169594018.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net (dcvr.yhbt.net [64.71.152.64])
 by lists.lttng.org (Postfix) with ESMTPS id 41sZnc60zZztGJ
 for <lttng-dev@lists.lttng.org>; Fri, 17 Aug 2018 16:39:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1597828270.1143.1534169594018.JavaMail.zimbra@efficios.com>
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

TWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6
Cj4gLS0tLS0gT24gQXVnIDEsIDIwMTgsIGF0IDI6NTQgUE0sIEVyaWMgV29uZyBub3JtYWxwZXJz
b25AeWhidC5uZXQgd3JvdGU6Cj4gCj4gPiBVc2VycyBtYXkgd2FudCB0byB1c2UgYWx0ZXJuYXRp
dmUgc2xlZXBpbmcgYmVoYXZpb3IgaW5zdGVhZCBvZgo+ID4gYHBvbGwnLiAgTWFrZSBDRFNfV0ZD
UV9XQUlUX1NMRUVQIGEgbWFjcm8gd2hpY2ggbWF5IGJlIGRlZmluZWQKPiA+IGJlZm9yZSBpbmNs
dWRpbmcgd2ZjcXVldWUuaC4KPiA+IAo+ID4gVGhpcyBhbHRlcm5hdGl2ZSBiZWhhdmlvciBjb3Vs
ZCBpbmNsdWRlIGxvZ2dpbmcsIHBlcmZvcm1pbmcKPiA+IGxvdy1wcmlvcml0eSBjbGVhbnVwIHdv
cmssIHNsZWVwaW5nIGEgc2hvcnRlci9sb25nZXIgaW50ZXJ2YWwKPiA+IG9yIGFueSBjb21iaW5h
dGlvbiBvZiB0aGF0Lgo+ID4gCj4gPiBUaGlzIHdpbGwgYWxzbyBtYWtlIGludGVncmF0aW9uIGlu
dG8gZ2xpYmMgZWFzaWVyLCBhcyBgcG9sbCcKPiA+IGxpbmthZ2UgY2F1c2VzIGNvbmZvcm1hbmNl
IHRlc3QgZmFpbHVyZXMgZXZlbiB3aGVuIHJlbGVnYXRlZAo+ID4gdG8gYW4gaW1wb3NzaWJsZSBj
b2RlIHBhdGg6Cj4gPiBodHRwczovL3B1YmxpYy1pbmJveC5vcmcvbGliYy1hbHBoYS8yMDE4MDgw
MTA5MjYyNi5qcnd5cm9qZnllNGF2Y2lzQHdoaXIvCj4gCj4gUmF0aGVyIHRoYW4gaW50cm9kdWNp
bmcgYSBtYWNybyBoZXJlLCBjYW4gd2UgZXh0ZW5kIHRoZSBBUEkgdG8KPiBwYXNzIGEgY2FsbGJh
Y2sgYW5kIGEgcHJpdmF0ZSBwb2ludGVyIHRoYXQgd291bGQgcGVyZm9ybSB0aGUKPiBzbGVlcGlu
ZyBiZWhhdmlvciByZXF1ZXN0ZWQgYnkgdGhlIGNhbGxlciA/CgpHaXZlbiB0aGlzIGlzIGRlZXAg
aW4gdGhlIGNhbGwgc3RhY2ssIGl0IHdvdWxkIHJlcXVpcmUgbW9kaWZ5aW5nCmEgbG90IG9mIGNh
bGxlcnMuICBTbyBpdCBzZWVtcyBsaWtlIGEgY29tcGF0aWJpbGl0eS9taWdyYXRpb24KbmlnaHRt
YXJlLiAgSSBmZWFyIGl0J3MgdG9vIG11Y2ggd29yayBmb3IgYSBzbWFsbCBpbXByb3ZlbWVudC4K
CkZvciBnbGliYywgd2UgY2FuIHNpbXBseSBkZWZpbmUgYHBvbGwnIHRvIGBfX3BvbGwnIHRvIGF2
b2lkCnRob3NlIHRlc3QgZmFpbHVyZXMsIGF0IGxlYXN0Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
