From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Problem with application changing UID
Date: Tue, 24 Sep 2019 11:15:15 -0400
Message-ID: <20190924151515.GH187569__21112.9796270811$1569338145$gmane$org@joraj-alpa>
References: <SN4PR0601MB3614967ABCE12621B316C89D91840@SN4PR0601MB3614.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46d4W86DD0z1Mtx
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 11:15:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8DDB724FEA7
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 11:15:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <SN4PR0601MB3614967ABCE12621B316C89D91840@SN4PR0601MB3614.namprd06.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Kramer, Zach" <Zach.Kramer@cognex.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBTZXAgMjQsIDIwMTkgYXQgMDI6MzI6NDFQTSArMDAwMCwgS3JhbWVyLCBaYWNoIHdy
b3RlOgo+IEhpLAo+IAo+IElzIExUVG5nIGludGVuZGVkIHRvIHN1cHBvcnQgdXNlcnNwYWNlIGFw
cGxpY2F0aW9ucyB0aGF0IGNoYW5nZSB0aGVpciBVSUQgYXQgcnVuLXRpbWU/IEFzIGluLCBpcyB0
aGVyZSBhbiBleHBlY3RlZCBiZWhhdmlvciBmb3Igd2hlbiB0aGlzIGhhcHBlbnM/Cj4gCj4gRm9y
IGV4YW1wbGU6Cj4gCj4gICAxLiAgRW1iZWRkZWQgZGV2aWNlIGJvb3RzCj4gICAyLiAgTXkgZGFl
bW9uIGlzIGxhdW5jaGVkIGFzIHJvb3QgdmlhIHN5c3RlbWQKPiAgIDMuICBSdW5zIHByaXZpbGVn
ZWQgY29kZQo+ICAgNC4gIENoYW5nZXMgVUlEIHRvIGEgbGVzcyBwcml2aWxlZ2VkIHVzZXIgKDUw
MCkKPiAgIDUuICBDcmVhdGVzIExUVG5nIHNlc3Npb24KPiAgICAgICogICBJZiBzZXNzaW9uIGFs
cmVhZHkgZXhpc3RzLCBkZXN0cm95IGl0IGZpcnN0Cj4gICA2LiAgPGlmIOKAmHN5c3RlbWN0bCBz
dG9w4oCZIGlzIGNhbGxlZD46IERlc3Ryb3kgc2Vzc2lvbgo+ICAgICAgKiAgIE90aGVyd2lzZSBp
dCB3aWxsIGJlIGRlc3Ryb3llZCBuZXh0IGRhZW1vbiBsYXVuY2ggaW4gc3RlcCA1CgpXaGVuIGlu
IHRoaXMgY2hhaW4gb2Ygb3BlcmF0aW9ucyBpcyBsdHRuZy1zZXNzaW9uZCBzdGFydGVkPwoKPiAK
PiBbY2lkOmltYWdlMDAxLnBuZ0AwMUQ1NkY5RC5BRjE1ODc3MF0KPiBUaGUgbG9ncyBhcmUgY2xl
YXJlZCB3aGVuIOKAmGx0dG5nIGRlc3Ryb3kgc2Vzc+KAmSBpcyBjYWxsZWQgdmlhIHRoZSBMVFRu
ZyBDLUFQSS4gRnJvbSBteSB1bmRlcnN0YW5kaW5nLCB0aGlzIHNob3VsZCBub3QgaGFwcGVuLgoK
SSB3b3VsZCB0ZW5kIHRvIGFncmVlIHdpdGggeW91IGhlcmUuIFdvdWxkIHlvdSBiZSBhYmxlIHRv
IHByb3ZpZGUgYSBzbWFsbApyZXByb2R1Y2VyIGZvciB0aGlzPyBXaGF0IGlzIHRoZSB2ZXJzaW9u
IG9mIGx0dG5nLSoKCi0tIApKb25hdGhhbiBSYWpvdHRlLUp1bGllbgpFZmZpY2lPUwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
