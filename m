From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: question about the RCU variant in CITRUS tree paper
Date: Thu, 11 May 2017 16:05:45 -0400
Message-ID: <CAAKbDrcWwqDEB2Yi-ZqT_wQjbWN2PEsSJmjjKaPj_iN0Q23N2Q__10684.5569135205$1494533154$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x22a.google.com (mail-oi0-x22a.google.com
 [IPv6:2607:f8b0:4003:c06::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3wP3yB1pKVzyrG
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 20:05:54 +0000 (UTC)
Received: by mail-oi0-x22a.google.com with SMTP id b204so43648445oii.1
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 13:05:46 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

SGksCgpJIGFtIGxlYXJuaW5nIFUtUkNVIG5vdy4KQW5kIEkgcmVhZCBwYXBlciBDb25jdXJyZW50
IFVwZGF0ZXMgd2l0aCBSQ1U6IFNlYXJjaCBUcmVlIGFzIGFuIEV4YW1wbGUKKCBodHRwczovL3Bk
ZnMuc2VtYW50aWNzY2hvbGFyLm9yZy83M2U0L2NkMjkyNzNjZjlkOThkMzViYzE4NDMzMGU2OTRi
YTc5ODk4Ny5wZGYKKQoKSW4gdGhpcyBwYXBlciwgdGhlIGF1dGhvcnMgcHJlc2VudCBhIHZhcmlh
bnQgUkNVIGltcGxlbWVudGF0aW9uLCBhbmQKYXJndWVkIHRoZWlyIG5ldyBSQ1UgaGFzIGJldHRl
ciBwZXJmb3JtYW5jZSB0aGFuIGRlZmF1bHQgVS1SQ1UuCgpEbyB5b3UgdGhpbmsgdGhlaXIgYXJn
dW1lbnQgYW5kIGltcGxlbWVudGF0aW9uIGlzIGNvcnJlY3QgaW4gYWxsIGNhc2VzPwpJZiB0aGV5
IGFyZSByaWdodCwgd2lsbCB5b3Ugd2FuIHRvIGludGVncmF0ZSB0aGVpciBpbXByb21lbnQgdG8g
VS1SQ1UKaW1wbGVtZW50YXRpb24/CgpGb3IgeW91ciBjb252ZW5pZW5jZSwgSSBwYXN0ZSB0aGUg
cmVsYXRlZCB0ZXh0IGZyb20gdGhlIHBhcGVyIGhlcmUuCiJJbiBvdXIgaW1wbGVtZW50YXRpb24s
IGVhY2ggdGhyZWFkIGhhcyBhIGNvdW50ZXIgYW5kIGZsYWcsIHRoZQpjb3VudGVyIGNvdW50cyB0
aGUgbnVtYmVyIG9mIGNyaXRpY2FsIHNlY3Rpb25zIGV4ZWN1dGVkIGJ5IHRoZSB0aHJlYWQKYW5k
IGEgZmxhZyBpbmRpY2F0ZXMgaWYgdGhlIHRocmVhZCBpcyBjdXJyZW50bHkgaW5zaWRlIGl0cyBy
ZWFkLXNpZGUKY3JpdGljYWwgc2VjdGlvbi4gVGhlIHJjdV9yZWFkX2xvY2sgb3BlcmF0aW9uIGlu
Y3JlbWVudHMgdGhlIGNvdW50ZXIKYW5kIHNldHMgdGhlIGZsYWcgdG8gdHJ1ZSwgd2hpbGUgdGhl
IHJjdV9yZWFkX3VubG9jayBvcGVyYXRpb24gc2V0cwp0aGUgZmxhZyB0byBmYWxzZS4gV2hlbiBh
IHRocmVhZCBleGVjdXRlcyBhIHN5bmNocm9uaXplX3JjdSBvcGVyYXRpb24sCml0IHdhaXRzIGZv
ciBldmVyeSBvdGhlciB0aHJlYWQsIHVudGlsIG9uZSBvZiB0d28gdGhpbmdzIG9jY3VyczoKZWl0
aGVyIHRoZSB0aHJlYWQgaGFzIGluY3JlYXNlZCBpdHMgY291bnRlciBvciB0aGUgdGhyZWFk4oCZ
cyBmbGFnIGlzCnNldCB0byBmYWxzZS4gIgoKT25lIGl0cyBpbXBsZW1lbnRhdGlvbiBjYW4gYmUg
Zm91bmQgZnJvbSBzeW5jaHJvYmVuY2gKaHR0cHM6Ly9naXRodWIuY29tL2dyYW1vbGkvc3luY2hy
b2JlbmNoL2Jsb2IvbWFzdGVyL2MtY3BwL3NyYy90cmVlcy90cmVlLWxvY2svbmV3X3VyY3UuYwoK
ClRoYW5rcyBhIGxvdCEKWXV4aW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
