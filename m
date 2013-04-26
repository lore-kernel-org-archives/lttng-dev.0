From: Zifei Tong <soariez@gmail.com>
Subject: Re: GSoC 2013, "C++ probe support" project and more
Date: Sat, 27 Apr 2013 02:47:36 +0800
Message-ID: <CAJ7wx-E3osJ9-JNh2agDRJTNtUu=TFYruSw-wcHa=9pJr2hMsA__28644.4456935444$1367002130$gmane$org@mail.gmail.com>
References: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA@mail.gmail.com>
	<CAJ7wx-Eq4eZ7g52W6c4ETLVHm88xrhOg2u1BjYwhDJ87vT+Kaw@mail.gmail.com>
	<CAGDH53k0DuDWg2sQa2fRfXPMDHLYeyGJr0MXsth0PcxiY6bXUQ@mail.gmail.com>
	<CAJ7wx-EyT-8TzBELBrFUgbhCwwDVorjDRpTaAhf0iTkXnH43cQ@mail.gmail.com>
	<1366860094.5178a13e78f12@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1UVnh0-0005dR-4Y
	for lttng-dev@lists.lttng.org; Fri, 26 Apr 2013 14:48:22 -0400
Received: by mail-ve0-f172.google.com with SMTP id db10so2008740veb.31
	for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2013 11:48:16 -0700 (PDT)
In-Reply-To: <1366860094.5178a13e78f12@www.imp.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgU3VjaGFrcmEgYW5kIENocmlzdGlhbgoKPiBOaWNlISBJIGhhdmUgZG9uZSBzb21ldGhpbmcg
c2ltaWxhciBoZXJlIGFuZCBJIHdhcyBhYmxlIHRvIGJ1aWxkIGFuZCBpbnNlcnQgY29kZQo+IHNu
aXBwZXRzLiBCdXQgdGhlbiBJIGFtIG1vcmUgaW5jbGluZWQgdG93YXJkcyBhbmFseXNpbmcgcGVy
Zm9ybWFuY2Ugb2YgZHluaW5zdC4KCkFjY29yZGluZyB0aGUgZG9jdW1lbnQgYW5kIG15IHRlc3Qs
IHR1cm4KJ0JQYXRjaDo6c2V0VHJhbXBSZWN1cnNpdmUodHJ1ZSknIG9uIHdpbGwgcmVkdWNlIHRo
ZSAnbXV0YXRlZScKaW5zdHJ1bWVudGF0aW9uIG92ZXJoZWFkIGEgbG90LgoKPiBZb3UgbWlnaHQg
YWxzbyBiZSBpbnRlcmVzdGVkIGluICdmYXN0IHRyYWNlcG9pbnQnIGluZnJhc3RydWN0dXJlIGFu
ZCBub3JtYWwgdHJhY2Vwb2ludHMgcHJvdmlkZWQgYnkgZ2RiLgo+IEJ1dCBnZXR0aW5nIGdkYidz
IGluZnJhIGZvciBkeW5hbWljIHRyYWNpbmcgd2l0aCBVU1QgbWF5IGJlIHNvbWV3aGF0IGEgc2Vy
aW91cyBoYWNrLgoKVGhhbmtzIGZvciBwb2ludGluZyBvdXQgZ2RiJ3MgJ2Zhc3QgdHJhY2Vwb2lu
dCcgZmVhdHVyZS4gSSBqdXN0CmNvbXBpbGVkIGdkYiBhbmQgZ290ICdmdHJhY2UnIHdvcmsuCgo+
IFF1b3RlIGZvcm0gZ2RiIGRvY3VtZW50IFsxXTogIkF0IHByZXNlbnQsIHRoZSBVU1QgKExUVG5n
IFVzZXJzcGFjZSBUcmFjZXIsIGh0dHA6Ly9sdHRuZy5vcmcvdXN0KSB0cmFjaW5nIGVuZ2luZSBp
cyBzdXBwb3J0ZWQuIgoKU28gZG9lcyBpdCBtZWFuIHRoZSBkeW5hbWljIGluc3RydW1lbnRhdGlv
biBwcm9qZWN0IGlzIGFscmVhZHkgZG9uZSBieQp0aGUgZ2RiIGd1eXM/Cgo+IFRoZSBkeW5hbWlj
IGluc3RydW1lbnRhdGlvbiBwcm9qZWN0IGlzIHZlcnkgaW50ZXJlc3RpbmcgaW5kZWVkLiBJIGFs
c28KPiB0aGluayBpdCBjb3VsZCBiZSBkb2FibGUgYXMgYSBHU29DIHByb2plY3QuIERvIHlvdSBo
YXZlIGFueSBwbGFuIG9uCj4gaG93IHlvdSB3b3VsZCBpbnRlZ3JhdGUgZHluaW5zdCB3aXRoIFVT
VD8KPiBBbHNvLCBhIHF1aWNrIHJlbWluZGVyIHRoYXQgdGhlIEdTb0MgYXBwbGljYXRpb24gZm9y
IHN0dWRlbnQgaXMgb3Blbgo+IHVudGlsIE1heSAzcmQuIERvbid0IGZvcmdldCB0byBzZW5kIHVz
IHlvdXIgcHJvcG9zYWwgOikhCgpJIHdpbGwgZmluaXNoIG15IHByb3Bvc2FsIGFzIHNvb24gcG9z
c2libGUuCgpUaGFua3MuCgpbMV0gaHR0cDovL3NvdXJjZXdhcmUub3JnL2dkYi9jdXJyZW50L29u
bGluZWRvY3MvZ2RiL1NlcnZlci5odG1sI1NlcnZlcgotLQpCZXN0IFJlZ2FyZHMsCuS7neWtkOmj
niAoWmlmZWkgVG9uZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
