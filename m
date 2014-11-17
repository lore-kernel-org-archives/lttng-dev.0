From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Error in lttng_ust_exit()
Date: Mon, 17 Nov 2014 11:44:53 -0500
Message-ID: <CA+jJMxu=ppooz3_o1ZUjp_Fc-Fbpd5zpY4BfT8Yez+GTnmxD-w__9679.86336113444$1416242748$gmane$org@mail.gmail.com>
References: <CAM5kDqzqwG5hdHTiKJ6wC65RFhLE=0=Jcv_0V7_d7M6xOR012Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XqPQB-0001yK-At
 for lttng-dev@lists.lttng.org; Mon, 17 Nov 2014 11:45:02 -0500
Received: by mail-lb0-f173.google.com with SMTP id n15so16394516lbi.32
 for <lttng-dev@lists.lttng.org>; Mon, 17 Nov 2014 08:44:53 -0800 (PST)
In-Reply-To: <CAM5kDqzqwG5hdHTiKJ6wC65RFhLE=0=Jcv_0V7_d7M6xOR012Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gTW9uLCBOb3YgMTcsIDIwMTQgYXQgMTA6MDEgQU0sIEFuYW5kIE5lZWxpIDxhbmFuZC5uZWVs
aUBnbWFpbC5jb20+IHdyb3RlOgo+IEhpIEFsbCwKPgo+IGxpYnVzdFsyOTA0MC8yOTA0MF06IEVy
cm9yOiBFcnJvciBjYW5jZWxsaW5nIGdsb2JhbCB1c3QgbGlzdGVuZXIgdGhyZWFkOiBObwo+IHN1
Y2ggcHJvY2VzcyAoaW4gbHR0bmdfdXN0X2V4aXQoKSBhdCBsdHRuZy11c3QtY29tbS5jOjE1MTcp
Cj4gbGlidXN0WzI5MDQwLzI5MDQwXTogRXJyb3I6IEVycm9yIGNhbmNlbGxpbmcgbG9jYWwgdXN0
IGxpc3RlbmVyIHRocmVhZDogTm8KPiBzdWNoIHByb2Nlc3MgKGluIGx0dG5nX3VzdF9leGl0KCkg
YXQgbHR0bmctdXN0LWNvbW0uYzoxNTI2KQo+IGxpYnVzdFsyOTA0My8yOTA0M106IEVycm9yOiBF
cnJvciBjYW5jZWxsaW5nIGdsb2JhbCB1c3QgbGlzdGVuZXIgdGhyZWFkOiBObwo+IHN1Y2ggcHJv
Y2VzcyAoaW4gbHR0bmdfdXN0X2V4aXQoKSBhdCBsdHRuZy11c3QtY29tbS5jOjE1MTcpCj4gbGli
dXN0WzI5MDQzLzI5MDQzXTogRXJyb3I6IEVycm9yIGNhbmNlbGxpbmcgbG9jYWwgdXN0IGxpc3Rl
bmVyIHRocmVhZDogTm8KPiBzdWNoIHByb2Nlc3MgKGluIGx0dG5nX3VzdF9leGl0KCkgYXQgbHR0
bmctdXN0LWNvbW0uYzoxNTI2KQo+Cj4KPiBJJ20gZ2V0dGluZyBhYm92ZSBlcnJvciB3aGVuIHJ1
bm5pbmcgYW4gYXBwIG9uIGkzODYgd2hlcmUgbHR0bmcgaXMgbm90Cj4gaW5zdGFsbGVkLCBpJ20g
bGlua2luZyB0aGUgbGlicmFyaWVzIGJ5IGdpdmluZyBMRF9MSUJSQVJZX1BBVEguIEknbSB1c2lu
Zwo+IDQuMi4xIHZlcnNpb24gb24gbHR0bmcgbGlicmFyaWVzLgo+CgpJJ2xsIGd1ZXNzIHlvdSBt
ZWFuIDIuNC4xIDstKQoKPiBJIHRoaW5rIHRoaXMgaXMgY29taW5nIGZyb20gZGVzdHJ1Y3RvciBp
biBsdHRuZ191c3QuIEluIHdoYXQgY2FzZXMgd2lsbAo+IHRoZXNlIHdpbGwgY29tZS4gTXkgYXBw
IHVzZXMgc3lzdGVtKCkgY2FsbHMgd2hpY2ggZG9lcyBmb3JrKCksIGV4ZWMoKSBhbmQKPiBleGl0
KCkuCj4KCllvdSdsbCBoYXZlIHRvIExEX1BSRUxPQUQgbGlibHR0bmctdXN0LWZvcmsuc28gdG8g
dHJhY2UgYW4gYXBwbGljYXRpb24Kd2hpY2ggY2FsbHMgZm9yaygpLgoKRm9yIG1vcmUgZGV0YWls
cywgaGF2ZSBhIGxvb2sgYXQgdGhpcyBzZWN0aW9uIG9mIHRoZSBkb2N1bWVudGF0aW9uLgpodHRw
Oi8vbHR0bmcub3JnL2RvY3MvI2RvYy11c2luZy1sdHRuZy11c3Qtd2l0aC1kYWVtb25zCgpSZWdh
cmRzLApKw6lyw6ltaWUKCj4gQ2FuIGFueW9uZSBwbHMgaGVscC4KPgo+IFRoYW5rcywKPiBBbmFu
ZCBOZWVsaQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+
IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
