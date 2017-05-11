From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: question about the RCU variant in CITRUS tree paper
Date: Thu, 11 May 2017 13:23:03 -0700
Message-ID: <20170511202303.GK3956__2961.71328886903$1494534197$gmane$org@linux.vnet.ibm.com>
References: <CAAKbDrcWwqDEB2Yi-ZqT_wQjbWN2PEsSJmjjKaPj_iN0Q23N2Q@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by lists.lttng.org (Postfix) with ESMTPS id 3wP4LB3dLvzyvw
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 20:23:13 +0000 (UTC)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4BKEOti116790
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 16:23:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2acwa63tyx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 16:23:05 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 11 May 2017 16:23:04 -0400
Content-Disposition: inline
In-Reply-To: <CAAKbDrcWwqDEB2Yi-ZqT_wQjbWN2PEsSJmjjKaPj_iN0Q23N2Q@mail.gmail.com>
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

T24gVGh1LCBNYXkgMTEsIDIwMTcgYXQgMDQ6MDU6NDVQTSAtMDQwMCwgWXV4aW4gUmVuIHdyb3Rl
Ogo+IEhpLAo+IAo+IEkgYW0gbGVhcm5pbmcgVS1SQ1Ugbm93Lgo+IEFuZCBJIHJlYWQgcGFwZXIg
Q29uY3VycmVudCBVcGRhdGVzIHdpdGggUkNVOiBTZWFyY2ggVHJlZSBhcyBhbiBFeGFtcGxlCj4g
KCBodHRwczovL3BkZnMuc2VtYW50aWNzY2hvbGFyLm9yZy83M2U0L2NkMjkyNzNjZjlkOThkMzVi
YzE4NDMzMGU2OTRiYTc5ODk4Ny5wZGYKPiApCj4gCj4gSW4gdGhpcyBwYXBlciwgdGhlIGF1dGhv
cnMgcHJlc2VudCBhIHZhcmlhbnQgUkNVIGltcGxlbWVudGF0aW9uLCBhbmQKPiBhcmd1ZWQgdGhl
aXIgbmV3IFJDVSBoYXMgYmV0dGVyIHBlcmZvcm1hbmNlIHRoYW4gZGVmYXVsdCBVLVJDVS4KPiAK
PiBEbyB5b3UgdGhpbmsgdGhlaXIgYXJndW1lbnQgYW5kIGltcGxlbWVudGF0aW9uIGlzIGNvcnJl
Y3QgaW4gYWxsIGNhc2VzPwo+IElmIHRoZXkgYXJlIHJpZ2h0LCB3aWxsIHlvdSB3YW4gdG8gaW50
ZWdyYXRlIHRoZWlyIGltcHJvbWVudCB0byBVLVJDVQo+IGltcGxlbWVudGF0aW9uPwo+IAo+IEZv
ciB5b3VyIGNvbnZlbmllbmNlLCBJIHBhc3RlIHRoZSByZWxhdGVkIHRleHQgZnJvbSB0aGUgcGFw
ZXIgaGVyZS4KPiAiSW4gb3VyIGltcGxlbWVudGF0aW9uLCBlYWNoIHRocmVhZCBoYXMgYSBjb3Vu
dGVyIGFuZCBmbGFnLCB0aGUKPiBjb3VudGVyIGNvdW50cyB0aGUgbnVtYmVyIG9mIGNyaXRpY2Fs
IHNlY3Rpb25zIGV4ZWN1dGVkIGJ5IHRoZSB0aHJlYWQKPiBhbmQgYSBmbGFnIGluZGljYXRlcyBp
ZiB0aGUgdGhyZWFkIGlzIGN1cnJlbnRseSBpbnNpZGUgaXRzIHJlYWQtc2lkZQo+IGNyaXRpY2Fs
IHNlY3Rpb24uIFRoZSByY3VfcmVhZF9sb2NrIG9wZXJhdGlvbiBpbmNyZW1lbnRzIHRoZSBjb3Vu
dGVyCj4gYW5kIHNldHMgdGhlIGZsYWcgdG8gdHJ1ZSwgd2hpbGUgdGhlIHJjdV9yZWFkX3VubG9j
ayBvcGVyYXRpb24gc2V0cwo+IHRoZSBmbGFnIHRvIGZhbHNlLiBXaGVuIGEgdGhyZWFkIGV4ZWN1
dGVzIGEgc3luY2hyb25pemVfcmN1IG9wZXJhdGlvbiwKPiBpdCB3YWl0cyBmb3IgZXZlcnkgb3Ro
ZXIgdGhyZWFkLCB1bnRpbCBvbmUgb2YgdHdvIHRoaW5ncyBvY2N1cnM6Cj4gZWl0aGVyIHRoZSB0
aHJlYWQgaGFzIGluY3JlYXNlZCBpdHMgY291bnRlciBvciB0aGUgdGhyZWFk4oCZcyBmbGFnIGlz
Cj4gc2V0IHRvIGZhbHNlLiAiCj4gCj4gT25lIGl0cyBpbXBsZW1lbnRhdGlvbiBjYW4gYmUgZm91
bmQgZnJvbSBzeW5jaHJvYmVuY2gKPiBodHRwczovL2dpdGh1Yi5jb20vZ3JhbW9saS9zeW5jaHJv
YmVuY2gvYmxvYi9tYXN0ZXIvYy1jcHAvc3JjL3RyZWVzL3RyZWUtbG9jay9uZXdfdXJjdS5jCgpJ
IGNvdmVyZWQgdGhpcyBvbmUgaGVyZTogIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy82Njc1OTMv
CgpUaGUgc2hvcnQgdmVyc2lvbiBpcyB0aGF0IHRoZXkgYXJlIHdvcmtpbmcgYXJvdW5kIHdoYXQg
SSBjb25zaWRlciB0bwpiZSBhIGRlc2lnbiBidWcgaW4gdGhlaXIgYWxnb3JpdGhtLCBuYW1lbHkg
dGhhdCB0aGV5IGFyZSBob2xkaW5nIHRoZQp1cGRhdGUtc2lkZSBsb2NrIGFjcm9zcyBSQ1UgZ3Jh
Y2UgcGVyaW9kcy4gIFRoZXkgZG8gdGhpcyB0byBhY2hpZXZlCmxpbmVhcml6YWJpbGl0eSwgd2hp
Y2ggaXMgcHJpemVkIGJ5IG1hbnkgY29uZmVyZW5jZSByZWZlcmVlcy9yZXZpZXdlcnMsCmJ1dCBu
b3QgYXMgdXNlZnVsIGluIHByYWN0aWNlIGFzIGlzIGNvbW1vbmx5IHN1cHBvc2VkLgoKQnV0IGl0
IGRvZXMgaGF2ZSBhIGJyb2tlbiBVUkwgdG8gdGhlIHBhcGVyLCBzbyBJIHdpbGwgc2VuZCB5b3Vy
IHdvcmtpbmcKdmVyc2lvbiB0byB0aGUgTFdOIGVkaXRvcnMgQ0NpbmcgeW91LiAgVGhhbmsgeW91
IGZvciB0aGF0IQoKCQkJCQkJCVRoYW54LCBQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
