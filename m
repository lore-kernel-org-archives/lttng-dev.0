From: David Aldrich <David.Aldrich@EMEA.NEC.COM>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Thu, 15 Sep 2016 14:36:48 +0000
Message-ID: <bf4d2ea2d4844db0bf0511d48cade46d__19609.743791125$1473953606$gmane$org@EUX13SRV1.EU.NEC.COM>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
 <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
 <CAF4oYfHyRe1KmbAgy4eKk6oDVWvZp+TP3SRXZ+BuJf5iWwEQwQ@mail.gmail.com>
 <022bc22a602e4631903ee12b6dd1be6c@EUX13SRV1.EU.NEC.COM>
 <02c06e3a-06ad-0c77-c3b2-bb9ab1dc3995@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cluster-e.mailcontrol.com (cluster-e.mailcontrol.com
 [85.115.58.190])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D88E4A4073
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 15:34:00 +0000 (UTC)
In-Reply-To: <02c06e3a-06ad-0c77-c3b2-bb9ab1dc3995@efficios.com>
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

SGkNCg0KSSdtIGFmcmFpZCBJJ20gc3RpbGwgc3RydWdnbGluZyB3aXRoIGdldHRpbmcgc3RhcnRl
ZCB3aXRoIGx0dG5nLiBUbyByZWNhcCwgSSB3YW50IHRvIHVzZSBsdHRuZyArIFRyYWNlQ29tcGFz
cyB0byBtb25pdG9yIHRoZSBzY2hlZHVsaW5nIG9mIHRocmVhZHMgaW4gbXkgbXVsdGktdGhyZWFk
ZWQgQysrIGFwcGxpY2F0aW9uIG9uIFVidW50dS4NCg0KSGVyZSBpcyBteSBzZXNzaW9uOg0KDQok
IHN1ZG8gcGtpbGwgbHR0bmctc2Vzc2lvbmQNCiQgc3VkbyBsdHRuZy1zZXNzaW9uZA0KRXJyb3I6
IEFscmVhZHkgcnVubmluZyBkYWVtb24uDQoNCiQgbHR0bmcgY3JlYXRlIGRlbW9fc2Vzc2lvbiBT
cGF3bmluZyBhIHNlc3Npb24gZGFlbW9uIFNlc3Npb24gZGVtb19zZXNzaW9uIGNyZWF0ZWQuDQpU
cmFjZXMgd2lsbCBiZSB3cml0dGVuIGluIC9ob21lLzxzbmlwPi9sdHRuZy10cmFjZXMvZGVtb19z
ZXNzaW9uLTIwMTYwOTE1LTE1MjY1Mw0KPHNuaXA+On4kIFBFUlJPUiBbMTQ5NTYvMTQ5NjRdOiBi
aW5kIGluZXQ6IEFkZHJlc3MgYWxyZWFkeSBpbiB1c2UgKGluIGx0dGNvbW1fYmluZF9pbmV0X3Nv
Y2soKSBhdCBpbmV0LmM6MTA5KQ0KV2FybmluZzogQW4gb3RoZXIgc2Vzc2lvbiBkYWVtb24gaXMg
dXNpbmcgdGhpcyBKVUwgcG9ydC4gSlVMIHN1cHBvcnQgd2lsbCBiZSBkZWFjdGl2YXRlZCBub3Qg
aW50ZXJmZXJpbmcgd2l0aCB0aGUgdHJhY2luZy4NCg0KJCBzdWRvIGx0dG5nIGVuYWJsZS1ldmVu
dCAtayBzY2hlZF9zd2l0Y2ggLXMgZGVtb19zZXNzaW9uDQpFcnJvcjogRXZlbnQgc2NoZWRfc3dp
dGNoOiBTZXNzaW9uIG5hbWUgbm90IGZvdW5kIChjaGFubmVsIGNoYW5uZWwwLCBzZXNzaW9uIGRl
bW9fc2Vzc2lvbikNCldhcm5pbmc6IFNvbWUgY29tbWFuZChzKSB3ZW50IHdyb25nDQoNCkFzIHlv
dSBjYW4gc2VlLCBlYWNoIG9mIHRoZXNlIGNvbW1hbmQgZ2VuZXJhdGVkIGEgd2FybmluZyBvciBl
cnJvci4gIFBsZWFzZSB3aWxsIHlvdSBzdWdnZXN0IHdoZXJlIEkgYW0gZ29pbmcgd3Jvbmc/DQoN
CkJlc3QgcmVnYXJkcw0KDQpEYXZpZA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
