From: THEUNISSEN Rolf <rolf.theunissen@altran.com>
Subject: [lttng-ust] Missing events when just before a process
	exits
Date: Tue, 13 Mar 2018 10:48:17 +0000
Message-ID: <13B832E4CA0EA14BAB2DA7118C642FF76CFFCC43__2175.69212331927$1520953254$gmane$org@XMB-DCFR-35.europe.corp.altran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx08-001f8a01.pphosted.com (mx08-001f8a01.pphosted.com
 [91.207.212.157])
 by lists.lttng.org (Postfix) with ESMTPS id 400sCN62zPz1WB
 for <lttng-dev@lists.lttng.org>; Tue, 13 Mar 2018 06:53:20 -0400 (EDT)
Received: from pps.filterd (m0090857.ppops.net [127.0.0.1])
 by mx08-001f8a01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2DAirt8023537
 for <lttng-dev@lists.lttng.org>; Tue, 13 Mar 2018 11:48:20 +0100
Received: from xch-dcfr-34.europe.corp.altran.com ([194.98.79.73])
 by mx08-001f8a01.pphosted.com with ESMTP id 2gm7tkck1u-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 13 Mar 2018 11:48:20 +0100
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

SGksCgpJIGFtIGN1cnJlbnRseSB0cmFjaW5nIG1hbnkgcHJvY2Vzc2VzIHdpdGggTFRUbmctVVNU
IG9uIGEgc3lzdGVtIHVuZGVyIGhlYXZ5IGxvYWQsIHdpdGggMiBDUFVzLgoKVGhlIHRyYWNlcyBz
ZWVtIHRvIGJlIG1pc3NpbmcgdXN0LWV2ZW50cyBuZWFyIHRoZSBlbmQgb2YgYSB0cmFjZS4gQWZ0
ZXIgZG9pbmcgc29tZSBhbmFseXNpcywgaXQgc2VlbXMgdGhhdCBldmVudHMgYXJlIG1pc3Npbmcg
ZnJvbSB0aGUgb3RoZXIgQ1BVIHRoZW4gdGhlIHByb2Nlc3MgZXhpdHMgb24uIE1vcmUgY29uY3Jl
dGVseToKCkR1cmluZyB0aGUgbGlmZXRpbWUgb2YgYSBwcm9jZXNzOgotIFByb2Nlc3MgWCBleGVj
dXRlcyBvbiBDUFUgMCwxOiBhbGwgZXZlbnRzIGFyZSBpbiB0aGUgdHJhY2UKSnVzdCBiZWZvcmUg
dGhlIHByb2Nlc3MgaXMgYWJvdXQgdG8gZXhpdDoKLSBQcm9jZXNzIFggZXhlY3V0ZXMgb24gQ1BV
IDA6IG1pc3NpbmcgZXZlbnRzIGZyb20gdGhlIHRyYWNlCkEgZmV3IG1pbGktc2Vjb25kcyBsYXRl
cjoKLSBQcm9jZXNzIFggZXhlY3V0ZXMgb24gQ1BVMSBhbmQgZXhpdHM6IFRoZSBsYXN0IGV2ZW50
cyBhcmUgaW4gdGhlIHRyYWNlCgpJcyB0aGlzIGJlaGF2aW9yIGV4cGVjdGVkLCBvciBhbSBJIHJ1
bm5pbmcgaW50byBhbiBMVFRuZy1VU1QgYnVnPyBBbmQgd291bGQgdGhlcmUgYmUgYW55IHdvcmth
cm91bmQ/CgpLaW5kIHJlZ2FyZHMsClJvbGYgVGhldW5pc3NlbgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
