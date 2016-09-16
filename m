From: David Aldrich <David.Aldrich@EMEA.NEC.COM>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Fri, 16 Sep 2016 11:43:45 +0000
Message-ID: <cbd292c898ec46ce8a4150c01ed71d3a__45815.2159503244$1474030493$gmane$org@EUX13SRV1.EU.NEC.COM>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
 [85.115.52.190])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 82358A4064
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 12:55:37 +0000 (UTC)
Received: from mail1.neceur.com (mail1.neceur.com [195.47.207.3])
 by rly20a.srv.mailcontrol.com (MailControl) with ESMTP id u8GBhlpe021439
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 12:43:47 +0100
Received: from intmail2.neceur.com (intmail2.neceur.com [172.29.177.11])
 by mail1.neceur.com (8.14.4/8.14.4) with ESMTP id u8GBhlJK023426
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 12:43:47 +0100
Received: from av2.neceur.com (av2.neceur.com [172.29.177.7])
 by intmail2.neceur.com (8.13.8/8.13.8) with ESMTP id u8GBhkBW025140
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 12:43:46 +0100
Received: from av2.neceur.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53541CA051
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 12:43:46 +0100 (BST)
Received: from av2.neceur.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47F88CA050
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 12:43:46 +0100 (BST)
Received: from EUX13SRV1.EU.NEC.COM (unknown [172.29.155.138])
 by av2.neceur.com (Postfix) with ESMTPS
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 12:43:46 +0100 (BST)
In-Reply-To: <5f03ae09-bc3a-8e14-0611-bb06b614d981@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkNCg0KSSB3b25kZXIgaWYgSSBtaWdodCBhc2sgZm9yIHNvbWUgbW9yZSBndWlkYW5jZSBwbGVh
c2U/DQoNCkkgbm93IGhhdmUgbHR0bmcgYW5kIFRyYWNlIENvbXBhc3MgcnVubmluZyBvbiBVYnVu
dHUuICBJIHdhbnQgdG8gaW5zcGVjdCB0aGUgc2NoZWR1bGluZyBvZiB0aHJlYWRzIGluIG15IHVz
ZXItc3BhY2UgYXBwbGljYXRpb24uICBTbyBmYXIsIEkgaGF2ZSBzdWNjZXNzZnVsbHkgY2FwdHVy
ZWQgYSB0cmFjZSB3aXRoIHRoZSBzY2hlZF9zd2l0Y2ggZXZlbnQgZW5hYmxlZDoNCg0KJCBzdWRv
IGx0dG5nIGVuYWJsZS1ldmVudCAtayBzY2hlZF9zd2l0Y2gNCg0KVGhpcyBpbmRlZWQgc2hvd3Mg
bXkgYXBwJ3MgdGhyZWFkcy4gIEhvd2V2ZXIsIGl0IGFsc28gc2hvd3MgYWxsIHRoZSBvdGhlciB0
aHJlYWRzIGluIHRoZSBzeXN0ZW0gYW5kIGRvZXMgbm90IHNob3cgY2xlYXJseSAodG8gbXkgdW5k
ZXJzdGFuZGluZykgd2hlbiB0aGUgdGhyZWFkcyBhcmUgc2NoZWR1bGVkIC8gYmxvY2tlZC4NCg0K
SSB3b3VsZCBsaWtlIHNvbWUgZ3VpZGFuY2Ugb24gaG93IHRvIGltcHJvdmUgdGhpcyB0cmFjaW5n
Lg0KDQoxKSBXb3VsZCBpdCBiZSBiZXR0ZXIgaWYgSSBkZWZpbmVkIG15IG93biDigJx0cmFjZXBv
aW50IHByb3ZpZGVyc+KAnSBhbmQgdGhlbiBzZXQgdHJhY2UgZXZlbnRzIGZvciB3aGVuIGEgdGhy
ZWFkIHdha2VzIC8gYmxvY2tzPw0KDQoyKSBIb3cgY291bGQgSSBzaG93IHdoaWNoIGNvcmUgYSB0
aHJlYWQgaXMgcnVubmluZyBvbj8NCg0KQmVzdCByZWdhcmRzDQoNCkRhdmlkDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
