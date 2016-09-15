From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Thu, 15 Sep 2016 11:49:56 -0400
Message-ID: <5f03ae09-bc3a-8e14-0611-bb06b614d981__32543.5590617873$1473954623$gmane$org@efficios.com>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
 <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
 <CAF4oYfHyRe1KmbAgy4eKk6oDVWvZp+TP3SRXZ+BuJf5iWwEQwQ@mail.gmail.com>
 <022bc22a602e4631903ee12b6dd1be6c@EUX13SRV1.EU.NEC.COM>
 <02c06e3a-06ad-0c77-c3b2-bb9ab1dc3995@efficios.com>
 <bf4d2ea2d4844db0bf0511d48cade46d@EUX13SRV1.EU.NEC.COM>
 <646123a6-aed5-0b8e-bafa-ca9dfed6d802@efficios.com>
 <af8ddfb9c34443618a768264ee4f059f@EUX13SRV1.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2EE25A4079
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 15:50:54 +0000 (UTC)
In-Reply-To: <af8ddfb9c34443618a768264ee4f059f@EUX13SRV1.EU.NEC.COM>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: David Aldrich <David.Aldrich@EMEA.NEC.COM>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpPbiAyMDE2LTA5LTE1IDExOjQxIEFNLCBEYXZpZCBBbGRyaWNoIHdyb3RlOgo+IEhpIEpv
bmF0aGFuCj4KPiBUaGFua3MsIEkgaGFkIG5vdCBsb2dnZWQgb3V0L2luIGFmdGVyIGpvaW5pbmcg
dGhlIHRyYWNpbmcgZ3JvdXAuCj4KPiBJIG5vdyBzZWU6Cj4KPiAkIGx0dG5nIGNyZWF0ZSBkZW1v
X3Nlc3Npb24KPiBTZXNzaW9uIGRlbW9fc2Vzc2lvbiBjcmVhdGVkLgo+ICQgc3VkbyBsdHRuZyBl
bmFibGUtZXZlbnQgLWsgc2NoZWRfc3dpdGNoIC1zIGRlbW9fc2Vzc2lvbgo+IEVycm9yOiBFdmVu
dCBzY2hlZF9zd2l0Y2g6IEtlcm5lbCB0cmFjZXIgbm90IGF2YWlsYWJsZSAoY2hhbm5lbCBjaGFu
bmVsMCwgc2Vzc2lvbiBkZW1vX3Nlc3Npb24pCj4gV2FybmluZzogU29tZSBjb21tYW5kKHMpIHdl
bnQgd3JvbmcKPgo+IFdoYXQgZG8gSSBuZWVkIHRvIGluc3RhbGw/CgpEaWQgeW91IGhhdmUgYSBs
b29rIGF0IGh0dHA6Ly9sdHRuZy5vcmcvZG93bmxvYWQvI3VidW50dSA/CgpJIHJlY29tbWVuZCB0
aGUgdXNlIG9mIHRoZSBwcGEgaWYgcG9zc2libGUuIEZvciBrZXJuZWwgdHJhY2luZyBtYWtlIHN1
cmUgCnRvIGluc3RhbGwgdGhlIGx0dG5nLW1vZHVsZXMtZGttcy4KCk1ha2Ugc3VyZSB0aGVyZSBp
cyBub3QgZXJyb3IgZHVyaW5nIHRoZSBpbnN0YWxsYXRpb24uIEl0IG1pZ2h0IGhhcHBlbiAKYnV0
IHNob3VsZCBub3QgOikgLgoKSWYgaXQncyBub3QgZG9uZSBhbHJlYWR5IG1ha2Ugc3VyZSB0byBk
cm9wIGJ5IApodHRwOi8vbHR0bmcub3JnL2RvY3MvI2RvYy1nZXR0aW5nLXN0YXJ0ZWQgZm9yIG1v
cmUgaW5mb3JtYXRpb25zLgoKQ2hlZXJzCgo+Cj4gQmVzdCByZWdhcmRzCj4KPiBEYXZpZAoKLS0g
CkpvbmF0aGFuIFIuIEp1bGllbgpFZmZpY2lvcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
