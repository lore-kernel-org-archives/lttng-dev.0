From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU on non-cache-coherent memory
Date: Thu, 4 Aug 2016 07:58:24 -0700
Message-ID: <20160804145824.GI3482__2751.52265462584$1470322720$gmane$org@linux.vnet.ibm.com>
References: <CAAKbDrfJ=umcdwFp7j5RDMZt7AfhAhCnmOfZqvD2WeNuhcb0rw@mail.gmail.com>
 <1648244903.1131.1470178737812.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id CBF16A0A62
 for <lttng-dev@lists.lttng.org>; Thu,  4 Aug 2016 14:58:28 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74Eshaq041969
 for <lttng-dev@lists.lttng.org>; Thu, 4 Aug 2016 10:58:27 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kngd4ak6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 04 Aug 2016 10:58:26 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 08:58:26 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 074791FF004B
 for <lttng-dev@lists.lttng.org>; Thu,  4 Aug 2016 08:58:06 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74EwOx058196122
 for <lttng-dev@lists.lttng.org>; Thu, 4 Aug 2016 14:58:24 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74EwNkq012034
 for <lttng-dev@lists.lttng.org>; Thu, 4 Aug 2016 10:58:23 -0400
Content-Disposition: inline
In-Reply-To: <1648244903.1131.1470178737812.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBBdWcgMDIsIDIwMTYgYXQgMTA6NTg6NTdQTSArMDAwMCwgTWF0aGlldSBEZXNub3ll
cnMgd3JvdGU6Cj4gLS0tLS0gT24gQXVnIDEsIDIwMTYsIGF0IDg6MzAgUE0sIFl1eGluIFJlbiBy
eXhAZ3dtYWlsLmd3dS5lZHUgd3JvdGU6Cj4gCj4gPiBIaSBhbGwsCj4gPiAKPiA+IElzIHRoZXJl
IGFueSByZXNlYXJjaCBvciBwdWJsaWNhdGlvbnMgYWJvdXQgUkNVIG9uIHRvcCBvZgo+ID4gbm9u
LWNhY2hlLWNvaGVyZW50IG11bHRpLWNvcmUgYXJjaGl0ZWN0dXJlPwo+ID4gTm90IG9ubHkgUkNV
LCBhbnkgb3RoZXIgc3luY2hyb25pemF0aW9uIHRlY2huaXF1ZSBvbiB0b3Agb2YKPiA+IG5vbi1j
YWNoZS1jb2hlcmVudCBtdWx0aS1jb3JlCj4gPiBpcyBhbHNvIGhlbHBmdWwuCj4gCj4gQ0Npbmcg
UGF1bCBFLiBNY0tlbm5leSwgd2hvIG1pZ2h0IGtub3cgbW9yZSBvbiB0aGlzIHRvcGljLgo+IAo+
IEJhY2sgaW4gMjAwOSB3aGVuIEkgc3RhcnRlZCB0aGUgbGlidXJjdS5vcmcgcHJvamVjdCwgSQo+
IHBsYW5uZWQgdG8gZXZlbnR1YWxseSBhZGQgc3VwcG9ydCBmb3Igc3VjaCBhcmNoaXRlY3R1cmVz
LAo+IGUuZy4gQmxhY2tmaW4sIHdoaWNoIGlzIHdoeSBJIGluaXRpYWxseSBhZGRlZCB0aGUgY21t
X21jKCksCj4gY21tX3JtYygpIGFuZCBjbW1fd21jKCkgbWFjcm9zIGluIHRoZSBsaWJyYXJ5IChz
ZWUKPiBDT05GSUdfSEFWRV9NRU1fQ09IRVJFTkNZKS4gSG93ZXZlciwgYWxsIGN1cnJlbnRseSBp
bXBsZW1lbnRlZAo+IGFyY2hpdGVjdHVyZXMgaGF2ZSBtZW0gY29oZXJlbmN5LCBzbyBpdCdzIGFs
d2F5cyBkZWZpbmVkIGFzIGEKPiBzaW1wbGUgY29tcGlsZXIgYmFycmllci4gU2VlIGluY2x1ZGUv
dXJjdS9hcmNoL2dlbmVyaWMuaCBpbiBsaWJ1cmN1Cj4gZm9yIGRldGFpbHMuCgpNYXRoaWV1IHBy
ZXR0eSBtdWNoIGNvdmVyZWQgaXQuICBXZSBvbmx5IGhhdmUgdGhlb3JldGljYWwgZXhwZXJpZW5j
ZQp3aXRoIG5vbi1jYWNoZS1jb2hlcmVudCBzeXN0ZW1zLiAgWW91IG1pZ2h0IHdhbnQgdG8gY29u
dGFjdCB0aGUgYXV0aG9ycwpvZiB0aGVzZSBwYXBlcnM6CgpodHRwOi8vd3d3LnNpZ29wcy5vcmcv
c29zcC9zb3NwMTEvcG9zdGVycy9zdW1tYXJpZXMvc29zcDExLWZpbmFsNy5wZGYKaHR0cDovL2Fy
eGl2Lm9yZy9wZGYvMTMwMS40NDkwLnBkZgoKVGhlcmUgYXJlIHByb2JhYmx5IG90aGVycywgYXMg
dGhpcyB3YXMgYSBob3QgdG9waWMgYSBjb3VwbGUgb2YgeWVhcnMgYWdvLgoKCQkJCQkJCVRoYW54
LCBQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
