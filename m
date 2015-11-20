From: "David Boles (dboles)" <dboles@micron.com>
Subject: Re: Lttng add-context perf commands gives me error
Date: Fri, 20 Nov 2015 22:33:51 +0000
Message-ID: <3e96575d71a549d4aa262a8dd31efc77__40398.5119578012$1448058910$gmane$org@BOWEX17-D.micron.com>
References: <328787043.5258001.1447796792694.JavaMail.yahoo.ref@mail.yahoo.com>
 <328787043.5258001.1447796792694.JavaMail.yahoo@mail.yahoo.com>
 <824342841.114145.1447857930891.JavaMail.zimbra@efficios.com>
 <886413694.5732011.1447877960962.JavaMail.yahoo@mail.yahoo.com>
 <1043364994.6119959.1447947438952.JavaMail.yahoo@mail.yahoo.com>
 <1171905821.121424.1447953945294.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout.micron.com ([137.201.242.129])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dboles@micron.com>) id 1ZzuFj-0004R9-Ba
 for lttng-dev@lists.lttng.org; Fri, 20 Nov 2015 17:34:00 -0500
Received: from mail.micron.com (bowex36-e.micron.com [137.201.85.145])
 by mailout.micron.com (8.14.4/8.14.6) with ESMTP id tAKMXqTR028203
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Fri, 20 Nov 2015 15:33:52 -0700
In-Reply-To: <1171905821.121424.1447953945294.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SeKAmW0gdXNpbmcgdGhlIGxpYnVyY3Ugc3lzdGVtIChxc2JyIGZsYXZvcikgd2l0aCBpdHMgbGlz
dCBzdHJ1Y3R1cmVzIGFzIHdlbGwgYXMgYSB2YXJpYW50IG9mIGEgYm9uc2FpIHRyZWUuDQoNCklu
IG15IHVuaXQgdGVzdGluZyBjb2RlIEkgaGF2ZSBhIHJhY2UgYmV0d2VlbiB0aGUgcmN1IGNhbGxi
YWNrIGludm9jYXRpb24gdGhyZWFkIChjdXJyZW50bHkganVzdCB0aGUgZGVmYXVsdCBvbmUpIGlu
dm9raW5nIGEgY2FsbGJhY2sgaXQgd2FzIGdpdmVuIGFuZCB0aGUgbWFpbiB0aHJlYWQgdGVhcmlu
ZyBkb3duIGRhdGEgdGhhdCBjYWxsYmFjayBkZXBlbmRzIG9uLg0KDQpJbiBsb29raW5nIGF0IHRo
ZSBjYWxsX3JjdV90aHJlYWQoKSBmdW5jdGlvbiwgaXQgbG9va3MgbGlrZSB0aGF0IHRocmVhZCBz
bGVlcHMgZm9yIG5vIG1vcmUgdGhhbiB+MTBtcy4gSG93ZXZlciwgZXZlbiBpZiBJIGd1YXJhbnRl
ZSAyMG1zIGVsYXBzZXMgYmV0d2VlbiB0aGUgbGFzdCB0aW1lIGNhbGxfcmN1KCkgaXMgY2FsbGVk
IGFuZCBteSB0ZWFyZG93biwgSSBhbSBzdGlsbCBzZWVpbmcgdGhlIGNhbGxiYWNrIHRocmVhZCBw
cm9jZXNzaW5nICJvbGQiIGNhbGxfcmN1KCkgcmVxdWVzdHMuIFRoaXMgYXBwZWFycyBjb3JyZWxh
dGVkIHdpdGggdGhlIGNhbGxiYWNrIHRocmVhZCBoYXZpbmcgdGhvdXNhbmRzIG9mIGZyZWUncyB0
byBwcm9jZXNzLg0KDQpJbiBteSByZWFsIGFwcGxpY2F0aW9uIEkgaGFwcGVuZWQgdG8gaGF2ZSBz
ZXQgdGhpbmdzIHVwIHNvIHRoYXQgZXZlcnl0aGluZyBhc3NvY2lhdGVkIHdpdGggcmN1LW1hbmFn
ZWQgYWxsb2NhdGlvbiBpcyBmcmVlZCB3aXRoIGNhbGxfcmN1KCkgc28gSSdtIG5vdCBzZWVpbmcg
YSBwcm9ibGVtIHRoZXJlIChzbyBmYXIpLiBIb3dldmVyLCBJIHN1c3BlY3QgdGhlIHNhbWUgaXNz
dWUgY291bGQgY3JvcCB1cCB3aXRoIGFibm9ybWFsIGV4aXQgcGF0aHMuDQoNCkhvdyBkbyBJIHJl
bGlhYmx5IGRldGVybWluZSB0aGF0IGFsbCByY3UgY2FsbGJhY2tzIHJlZ2lzdGVyZWQgcHJpb3Ig
dG8gc29tZSBwb2ludCBpbiB0aW1lIGhhdmUgYmVlbiBwcm9jZXNzZWQ/IA0KDQpUaGFua3MsDQoN
CkRhdmlkIEJvbGVzDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
