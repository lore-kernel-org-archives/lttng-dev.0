From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Fri, 16 Sep 2016 13:36:36 -0400
Message-ID: <87c9dc47-8275-aa10-29ee-ee8769231bf6__35952.6802007624$1474047416$gmane$org@efficios.com>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
 <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
 <CAF4oYfHyRe1KmbAgy4eKk6oDVWvZp+TP3SRXZ+BuJf5iWwEQwQ@mail.gmail.com>
 <022bc22a602e4631903ee12b6dd1be6c@EUX13SRV1.EU.NEC.COM>
 <02c06e3a-06ad-0c77-c3b2-bb9ab1dc3995@efficios.com>
 <bf4d2ea2d4844db0bf0511d48cade46d@EUX13SRV1.EU.NEC.COM>
 <646123a6-aed5-0b8e-bafa-ca9dfed6d802@efficios.com>
 <af8ddfb9c34443618a768264ee4f059f@EUX13SRV1.EU.NEC.COM>
 <5f03ae09-bc3a-8e14-0611-bb06b614d981@efficios.com>
 <cbd292c898ec46ce8a4150c01ed71d3a@EUX13SRV1.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 36D7CA42A4
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 17:37:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3282F3400BE
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 17:37:09 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id lA6r1za3TiTc for <lttng-dev@lists.lttng.org>;
 Fri, 16 Sep 2016 17:37:07 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D4C4F3400E6
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 17:37:07 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id bKCwdAZZkqLp for <lttng-dev@lists.lttng.org>;
 Fri, 16 Sep 2016 17:37:07 +0000 (UTC)
Received: from [172.16.0.165] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id B8DF23400BE
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 17:37:07 +0000 (UTC)
In-Reply-To: <cbd292c898ec46ce8a4150c01ed71d3a@EUX13SRV1.EU.NEC.COM>
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

SGkKCgpPbiAyMDE2LTA5LTE2IDA3OjQzIEFNLCBEYXZpZCBBbGRyaWNoIHdyb3RlOgo+IEhpCj4K
PiBJIHdvbmRlciBpZiBJIG1pZ2h0IGFzayBmb3Igc29tZSBtb3JlIGd1aWRhbmNlIHBsZWFzZT8K
Pgo+IEkgbm93IGhhdmUgbHR0bmcgYW5kIFRyYWNlIENvbXBhc3MgcnVubmluZyBvbiBVYnVudHUu
ICBJIHdhbnQgdG8gaW5zcGVjdCB0aGUgc2NoZWR1bGluZyBvZiB0aHJlYWRzIGluIG15IHVzZXIt
c3BhY2UgYXBwbGljYXRpb24uICBTbyBmYXIsIEkgaGF2ZSBzdWNjZXNzZnVsbHkgY2FwdHVyZWQg
YSB0cmFjZSB3aXRoIHRoZSBzY2hlZF9zd2l0Y2ggZXZlbnQgZW5hYmxlZDoKPgo+ICQgc3VkbyBs
dHRuZyBlbmFibGUtZXZlbnQgLWsgc2NoZWRfc3dpdGNoCj4KPiBUaGlzIGluZGVlZCBzaG93cyBt
eSBhcHAncyB0aHJlYWRzLiAgSG93ZXZlciwgaXQgYWxzbyBzaG93cyBhbGwgdGhlIG90aGVyIHRo
cmVhZHMgaW4gdGhlIHN5c3RlbSBhbmQgZG9lcyBub3Qgc2hvdyBjbGVhcmx5ICh0byBteSB1bmRl
cnN0YW5kaW5nKSB3aGVuIHRoZSB0aHJlYWRzIGFyZSBzY2hlZHVsZWQgLyBibG9ja2VkLgo+Cj4g
SSB3b3VsZCBsaWtlIHNvbWUgZ3VpZGFuY2Ugb24gaG93IHRvIGltcHJvdmUgdGhpcyB0cmFjaW5n
Lgo+Cj4gMSkgV291bGQgaXQgYmUgYmV0dGVyIGlmIEkgZGVmaW5lZCBteSBvd24g4oCcdHJhY2Vw
b2ludCBwcm92aWRlcnPigJ0gYW5kIHRoZW4gc2V0IHRyYWNlIGV2ZW50cyBmb3Igd2hlbiBhIHRo
cmVhZCB3YWtlcyAvIGJsb2Nrcz8KCkNvdWxkIGJlIGEgc29sdXRpb24gYnV0IHlvdSBtaWdodCB3
YW50IHRoZSBidWlsdC1pbiB1dGlsaXR5IG9mIGx0dG5nIHRvIApmaWx0ZXIgb3V0IGFsbCBub2lz
ZSBmaXJzdCB1c2luZyB0aGUgZmlsdGVyaW5nIGZlYXR1cmUuCgplLmcgSSdtIGludGVyZXN0ZWQg
aW4gc2NoZWRfc3dpdGNoIGV2ZW50IHdoZXJlIGNocm9tZSBpcyBpbnZvbHZlZAoKbHR0bmcgY3Jl
YXRlCmx0dG5nIGVuYWJsZS1ldmVudCAtLWtlcm5lbCAic2NoZWRfc3dpdGNoIiAtLWZpbHRlciAn
cHJldl9jb21tID09IAoiY2hyb21lKiIgfHwgbmV4dF9jb21tID09ICJjaHJvbWUqIicKbHR0bmcg
c3RhcnQKLi4uLgoKVXNpbmcgVHJhY2VDb21wYXNzIHlvdSB3aWxsIGJlIG1haW5seSBpbnRlcmVz
dGVkIGluIHRoZSBDb250cm9sIEZsb3cgClZpZXcgYW5kIHRoZSBSZXNvdXJjZSB2aWV3IChzaG93
IHBlciBjcHUgdGltZWxpbmUgYWN0aXZpdHkpLgoKPgo+IDIpIEhvdyBjb3VsZCBJIHNob3cgd2hp
Y2ggY29yZSBhIHRocmVhZCBpcyBydW5uaW5nIG9uPwoKVGhlIFJlc291cmNlIHZpZXcgZnJvbSBU
cmFjZUNvbXBhc3Mgc2hvdWxkIGhlbHAgaGVyZS4KCkNoZWVycwoKPgo+IEJlc3QgcmVnYXJkcwo+
Cj4gRGF2aWQKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4g
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgoKLS0gCkpvbmF0aGFuIFIuIEp1bGllbgpFZmZpY2lvcwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
