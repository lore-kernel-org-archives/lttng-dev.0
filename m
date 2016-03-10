From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Re: real time Userspace RCU
Date: Thu, 10 Mar 2016 15:33:51 -0500
Message-ID: <CAAKbDrdac6jYEu4kjNq8kzCxQkdxJGBHN2+fFCh9wOiotoSYiw__36949.5093859316$1457642054$gmane$org@mail.gmail.com>
References: <CAAKbDrcMU2rgStU1uFFg1Syk-B4ZOU2R7aC0On946gCXJ5DnMg@mail.gmail.com>
 <1138868550.112232059.1457635938477.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 8FEC8A0A8A
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 20:33:52 +0000 (UTC)
Received: by mail-lb0-f179.google.com with SMTP id k15so130006717lbg.0
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 12:33:52 -0800 (PST)
In-Reply-To: <1138868550.112232059.1457635938477.JavaMail.zimbra@polymtl.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LgoKSSB3YW50IHRvIGdlbmVyYWxseSB1bmRlcnN0YW5k
IGhvdyB0byBhcHBseSB1cmN1IHRvIHJlYWwgdGltZSBzeXN0ZW1zLgpJIGtub3cgcmVhbCB0aW1l
IHN5c3RlbSBmb2N1cyBvbiBwcmVkaWN0YWJpbGl0eSBvbiBib3RoIHRpbWluZyBhbmQKbWVtb3J5
IGNvbnN1bXB0aW9uLgpTbyBob3cgZG9lcyByZWFsIHRpbWUgdXJjdSBzdXBwb3J0IHByZWRpY3Rh
YmlsaXR5PwpDb3VsZCB5b3UgcHJvdmlkZSBtZSBzb21lIHBhcGVycywgZG9jdW1lbnRzIG9yIGFu
eSBtYXRlcmlhbHMgYWJvdXQgYW55CmFzcGVjdCBvZiByZWFsIHRpbWUgdXJjdT8KClRoYW5rcyBh
Z2FpbiEKCk9uIFRodSwgTWFyIDEwLCAyMDE2IGF0IDE6NTIgUE0sIE1pY2hlbCBEYWdlbmFpcwo8
bWljaGVsLmRhZ2VuYWlzQHBvbHltdGwuY2E+IHdyb3RlOgo+IFJlYWwtdGltZSBhbmQgZW1iZWRk
ZWQgc3lzdGVtcyBpcyBhbiBpbXBvcnRhbnQgY3VycmVudCBmb2N1cyBmb3IgdGhlIExUVG5nIHRv
b2xjaGFpbiByZXNlYXJjaC4gRG8geW91IGhhdmUgc3BlY2lmaWMgbmVlZHMgZm9yIHVzZXJzcGFj
ZSBSQ1U/Cj4KPiAtLS0tLSBNYWlsIG9yaWdpbmFsIC0tLS0tCj4+IEhpLAo+Pgo+PiAgSXMgdGhl
cmUgYW55IHdvcmsgb3IgcmVzZWFyY2ggYWJvdXQgVXNlcnNwYWNlIFJDVSBvbiByZWFsIHRpbWUg
b3IKPj4gZW1iZWRkZWQgc3lzdGVtcz8KPj4gQW55IGluZm9ybWF0aW9uIGlzIHdlbGNvbWUuCj4+
Cj4+IFRoYW5rcyBhIGxvdCEKPj4gWXV4aW4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+PiBsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCj4+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
