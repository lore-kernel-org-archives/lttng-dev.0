From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question about lock in synchronize_rcu
	implementation of URCU
Date: Wed, 27 Apr 2016 19:08:03 -0700
Message-ID: <20160428020803.GN4967__40115.0918486111$1461809286$gmane$org@linux.vnet.ibm.com>
References: <CAAKbDrfmcqEE7_6p_J0DPVO85yDGJ0GCbi5k9Lm19g4VaLgOWw@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id AB9DEA32A1
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 02:07:40 +0000 (UTC)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 22:07:39 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D154538C803B
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 22:07:26 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3S27Qpt41615456
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 02:07:26 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3S27QPR027068
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 22:07:26 -0400
Content-Disposition: inline
In-Reply-To: <CAAKbDrfmcqEE7_6p_J0DPVO85yDGJ0GCbi5k9Lm19g4VaLgOWw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yuxin Ren <ryx@gwmail.gwu.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gV2VkLCBBcHIgMjcsIDIwMTYgYXQgMDk6MzQ6MTZQTSAtMDQwMCwgWXV4aW4gUmVuIHdyb3Rl
Ogo+IEhpLAo+IAo+IEkgYW0gbGVhcm5pbmcgdGhlIFVSQ1UgY29kZS4KPiAKPiBXaHkgZG8gd2Ug
bmVlZCByY3VfZ3BfbG9jayBpbiBzeW5jaHJvbml6ZV9yY3U/Cj4gaHR0cHM6Ly9naXRodWIuY29t
L3VyY3UvdXNlcnNwYWNlLXJjdS9ibG9iL21hc3Rlci91cmN1LmMjTDQwMQo+IAo+IEluIHRoZSBj
b21tZW50LCBpdCBzYXlzIHRoaXMgbG9jayBlbnN1cmVzIG11dHVhbCBleGNsdXNpb24gYmV0d2Vl
bgo+IHRocmVhZHMgY2FsbGluZyBzeW5jaHJvbml6ZV9yY3UoKS4KPiBCdXQgb25seSB0aGUgZmly
c3QgdGhyZWFkIGFkZGVkIHRvIHdhaXRlciBxdWV1ZSBjYW4gcHJvY2VlZCB0byBkZXRlY3QKPiBn
cmFjZSBwZXJpb2QuCj4gSG93IGNhbiBtdWx0aXBsZSB0aHJlYWRzIGN1cnJlbnRseSBwZXJmb3Jt
IHRoZSBncmFjZSB0aHJlYWQ/CgpUaGV5IGRvbid0IGNvbmN1cnJlbnRseSBwZXJmb3JtIGdyYWNl
IHBlcmlvZHMsIGFuZCBpdCB3b3VsZCBiZSB3YXN0ZWZ1bApmb3IgdGhlbSB0byBkbyBzby4gIElu
c3RlYWQsIHRoZSBmaXJzdCBvbmUgcGVyZm9ybXMgdGhlIGdyYWNlIHBlcmlvZCwKYW5kIGFsbCB0
aGF0IHdlcmUgd2FpdGluZyBhdCB0aGUgdGltZSBpdCBzdGFydGVkIGdldCB0aGUgYmVuZWZpdCBv
ZiB0aGF0CnNhbWUgZ3JhY2UgcGVyaW9kLgoKQW55IHRoYXQgYXJyaXZlZCBhZnRlciB0aGUgZmly
c3QgZ3JhY2UgcGVyaW9kIHBlcmZvcm1zIHRoZSBmaXJzdApncmFjZSBwZXJpb2QgYXJlIHNlcnZl
ZCBieSB3aGljaGV2ZXIgb2YgdGhlbSBwZXJmb3JtcyB0aGUgc2Vjb25kCmdyYWNlIHBlcmlvZC4K
CgkJCQkJCQlUaGFueCwgUGF1bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
