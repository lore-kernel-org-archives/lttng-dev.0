From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Statically compiling LTTNG
Date: Thu, 3 Oct 2019 10:56:56 -0400
Message-ID: <729841b1-e5d5-9030-9546-6128ce595516__34819.5138665446$1570114637$gmane$org@efficios.com>
References: <MW2PR2101MB0988D353BB406B8292BEE9018B9D0@MW2PR2101MB0988.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46kbgt0LS9z1N6Z
 for <lttng-dev@lists.lttng.org>; Thu,  3 Oct 2019 10:56:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6CDEF2D4175
 for <lttng-dev@lists.lttng.org>; Thu,  3 Oct 2019 10:56:57 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id 06o1xr_PhnDu for <lttng-dev@lists.lttng.org>;
 Thu,  3 Oct 2019 10:56:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 1BAB62D4158
 for <lttng-dev@lists.lttng.org>; Thu,  3 Oct 2019 10:56:57 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id dopRltnWfMj3 for <lttng-dev@lists.lttng.org>;
 Thu,  3 Oct 2019 10:56:57 -0400 (EDT)
Received: from [172.16.0.105] (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 0046D2D414D
 for <lttng-dev@lists.lttng.org>; Thu,  3 Oct 2019 10:56:56 -0400 (EDT)
In-Reply-To: <MW2PR2101MB0988D353BB406B8292BEE9018B9D0@MW2PR2101MB0988.namprd21.prod.outlook.com>
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
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAxOS0xMC0wMSA3OjE5IHAubS4sIEVkZGllIEtvbmcgdmlhIGx0dG5nLWRldiB3cm90ZToK
PiBIZWxsbywKPiAKPiBUaGFuayB5b3UgZm9yIGFsbCB0aGUgZ29vZCB3b3JrIHdpdGggTFRUTkch
IFdl4oCZZCBsb3ZlIHRvIHVzZSBMVFRORyB0byBkbwo+IGFuYWx5c2lzIGluIG91ciBzeXN0ZW1z
IPCfmIogV2UgYXJlIHJ1bm5pbmcgd2l0aCBhIHZlcnkgc3RyaXBwZWQgZG93bgo+IHZlcnNpb24g
b2YgbGludXggKG5vIHBhY2thZ2UgbWFuYWdlciwgYSBsb3Qgb2YgYmFzaWMgZnVuY3Rpb25hbGl0
aWVzCj4gcmVtb3ZlZCBldGMpLiBXYXMgd29uZGVyaW5nIGlmIHlvdSBrbm93IG9mIGEgd2F5IHRv
IHN0YXRpY2FsbHkgY29tcGlsZQo+IExUVE5HIHNvIHRoYXQgd2UgY2FuIHNpbXBseSB1bnBhY2sg
b3VyIGluaXRyZC5pbWcsIGRyb3AgdGhlIExUVE5HCj4gYmluYXJpZXMgaW4sIHJlcGFjayBpdCwg
YW5kIGp1c3QgcnVuIExUVE5HIHRvIGNvbGxlY3QgZGlhZ25vc3RpYyBkYXRhLgo+IFRoZSBpbnRl
bnQgaXMgdG8ga2VlcCB0aGUgc3lzdGVtIGFzIG1pbmltYWwgYXMgcG9zc2libGUgd2l0aCBMVFRO
Rwo+IHdvcmtpbmcgaW5zaWRlIGl0Lgo+IAo+IFRoYW5rIHlvdSwKPiAKPiBFZGRpZQoKSGksCgpG
aXJzdCBpdCBkZXBlbmRzIGlmIHlvdSB3YW50IHRvIGRvIGtlcm5lbCBvciB1c2Vyc3BhY2UgdHJh
Y2luZz8KCkZvciB1c2Vyc3BhY2UsIGx0dG5nLXVzdCByZXF1aXJlcyBkeW5hbWljIGxpbmtpbmcs
IHNvIHRoYXQncyBhIG5vIGdvLgoKT24gdGhlIGtlcm5lbCBzaWRlLCB5b3Ugd2lsbCBuZWVkIHRv
IGVpdGhlciBidWlsZCBsdHRuZy1tb2R1bGVzIGluIHlvdXIKa2VybmVsIGltYWdlIG9yIHNoaXAg
dGhlIG1vZHVsZXMgaW4geW91ciBpbml0cmQuIFRoZW4geW91J2xsIGhhdmUgdG8Kc3RhdGljYWxs
eSBidWlsZCBsdHRuZy10b29scyBhbmQgYWxsIGl0J3MgZGVwZW5kZW5jaWVzLiBJIHNlZSBubyBv
YnZpb3VzCnJlYXNvbnMgd2h5IGl0IHdvdWxkbid0IHdvcmssIGJ1dCBpdCdzIG5vdCBhIHNjZW5h
cmlvIHdlIGRvIGFueSB0ZXN0aW5nIGZvci4KCkNoZWVycywKCk1pY2hhZWwKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
