From: "Liu, Changcheng via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: convert call_site to func/offset
Date: Thu, 2 Jul 2020 00:31:17 +0800
Message-ID: <20200701163116.GA100490@jerryopenix>
References: <20200701155309.GA99920@jerryopenix>
 <CADcCL0jxNy9hbvxpnQdKF_QGXYSeWD2WT+enFJO5UB7wAA8Bqw@mail.gmail.com>
Reply-To: "Liu, Changcheng" <changcheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by lists.lttng.org (Postfix) with ESMTPS id 49xmzj3RTkz18ZG
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 12:35:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CADcCL0jxNy9hbvxpnQdKF_QGXYSeWD2WT+enFJO5UB7wAA8Bqw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMTI6MjUgV2VkIDAxIEp1bCwgRnJhbmNpcyBEZXNsYXVyaWVycyB3cm90ZToKPiAgICBIaSBD
aGFuZ2NoZW5nLAo+ICAgIFRoaXMgaXMgbm90IGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkgQmFiZWx0
cmFjZS4gSXQgY291bGQgcHJvYmFibHkgYmUKPiAgICBkb25lIHRoZSBzYW1lIHdheSB3ZSBkbyBp
dCB3aXRoIHRoZSAiaXAiIGFuZCAidnBpZCIgY29udGV4dHMgaW4gdGhlCj4gICAgZGVidWctaW5m
byBjb21wb25lbnQgY2xhc3MgYnV0IGl0J3Mgbm90IGRvbmUgeWV0Lgo+ICAgIFRoYW5rcywKPiAg
ICBGcmFuY2lzCgpARnJhbmNpczogVGhhbmtzIGZvciB5b3VyIGluZm8uCkRvIHdlIGhhdmUgZmVh
dHVyZSByb2FkIG1hcCB0byBiZSBjaGVja2VkPwoKPiAKPiAgICBMZSBtZXIuIDEganVpbGwuIDIw
MjAsIMOgIDExIGggNTgsIExpdSwgQ2hhbmdjaGVuZyB2aWEgbHR0bmctZGV2Cj4gICAgPFsxXWx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+IGEgw6ljcml0IDoKPiAKPiAgICAgIEhpIGFsbCwKPiAg
ICAgICAgICBJIGNoZWNrZWQgX19jeWdfcHJvZmlsZV9mdW5jX2VudGVyIGltcGxlbWVudGF0aW9u
Lgo+ICAgICAgICAgIFRoZSBjYWxsZXIgYWRkcmVzcyBpcyByZWNvcmRlZCBpbnRvIGNhbGxfc2l0
ZSBmaWVsZC4KPiAgICAgICAgICBEb2VzIGFueW9uZSBrbm93IGhvdyB0byBsZXQgYmFiZWx0cmFj
ZSBzaG93IHRoZSBjYWxsX3NpdGUgaW50bwo+ICAgICAgICAgICJmdW5jL29mZnNldCIgZm9ybWF0
IGluc3RlYWQgb2YgdGhlIHJ1bm5pbmcgdmlydHVhbCBhZGRyZXNzPwo+ICAgICAgQi5SLgo+ICAg
ICAgQ2hhbmdjaGVuZwo+ICAgICAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiAgICAgIGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiAgICAgIFsyXWx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKPiAgICAgIFszXWh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiAKPiAgICAtLQo+IAo+ICAgIEZyYW5j
aXMgRGVzbGF1cmllcnMKPiAgICBDb21wdXRlciBFbmdpbmVlcgo+ICAgIEVmZmljaU9TIGluYy4K
PiAKPiBSZWZlcmVuY2VzCj4gCj4gICAgMS4gbWFpbHRvOmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiAgICAyLiBtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+ICAgIDMuIGh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
