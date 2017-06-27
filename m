From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Allocation failures with babeltrace and
 TraceCompass - corrupt trace?
Date: Tue, 27 Jun 2017 10:25:28 -0400
Message-ID: <f7e1ee9d-4f06-bc7c-4e1d-b5da15e7187c__31706.8323064179$1498573732$gmane$org@efficios.com>
References: <077661a3-81fb-b8e7-bf3b-15167c9240cc@kdab.com>
 <2088647396.12698.1497453179549.JavaMail.zimbra@efficios.com>
 <85fce57d-85e8-7ce8-998b-7fd7e91f6002@kdab.com>
 <446189346.12874.1497458373753.JavaMail.zimbra@efficios.com>
 <b04b1c20-6981-b9f6-50a6-4c12bb6b4d69@kdab.com>
 <9be26c8f-8a5c-03d3-8e4b-0d8f37eeeb9a@efficios.com>
 <a4170e9a-5365-7e54-a847-95ca1e8ea785@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wxpBv3XFxztRn
 for <lttng-dev@lists.lttng.org>; Tue, 27 Jun 2017 14:26:31 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9F3F43401B2
 for <lttng-dev@lists.lttng.org>; Tue, 27 Jun 2017 14:25:50 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id VDKXA0yjYoE2 for <lttng-dev@lists.lttng.org>;
 Tue, 27 Jun 2017 14:25:49 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C57A2340355
 for <lttng-dev@lists.lttng.org>; Tue, 27 Jun 2017 14:25:49 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Fc3raAz2Ng_3 for <lttng-dev@lists.lttng.org>;
 Tue, 27 Jun 2017 14:25:49 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id A45133401B2
 for <lttng-dev@lists.lttng.org>; Tue, 27 Jun 2017 14:25:49 +0000 (UTC)
In-Reply-To: <a4170e9a-5365-7e54-a847-95ca1e8ea785@kdab.com>
Content-Language: en-CA
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

T24gMjAxNy0wNi0yNiAwNTo1NSwgVGhvbWFzIE1jR3VpcmUgd3JvdGU6Cj4gSGkgTWljaGFlbCwK
PiAKPiBPbiAyMy4wNi4yMDE3IDIxOjU1LCBNaWNoYWVsIEplYW5zb24gd3JvdGU6Cj4+IEkgc2Vl
IGZyb20gdGhlIG1ldGFkYXRhIGZpbGUgeW91IHByb3ZpZGVkIHRoYXQgeW91ciBrZXJuZWwgdmVy
c2lvbiBpcwo+PiA0LjkuMjgtMjAxNzA0MjgtMSwgaXMgaXQgYnVpbHQgZnJvbSB2YW5pbGxhIGtl
cm5lbCBzb3VyY2VzPyBJZiBub3QsCj4+IGNvdWxkIHlvdSBwb2ludCB1cyB0byBhIGdpdCByZXBv
IG9yIHNvdXJjZSBhcmNoaXZlPyBJdCB3b3VsZCBoZWxwIGEgbG90Cj4+IHRvIGZpZ3VyZSB0aGlz
IG91dC4KPiAKPiBUaGUgTGludXggc3lzdGVtIGlzIGJ1aWx0IHdpdGggcHR4ZGlzdCwgd2hpY2gg
aXMgc2ltaWxhciB0byBZb2N0by4gSSdtCj4gbm90IHZlcnkgZmFtaWxpYXIgd2l0aCBwdHhkaXN0
Lgo+IER1cmluZyB0aGUgYnVpbGQgcHJvY2VzcywgaXQgZmV0Y2hlcwo+IGh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92NC54L2xpbnV4LTQuOS50YXIueHouCj4gVGhlcmUg
YXJlIDI1IHBhdGNoZXMgaW4gcGF0Y2hlcy9saW51eC00LjkvIGluIHRoZSBwdHhkaXN0IHJvb3Qg
ZGlyLAo+IHdoaWNoIEkgYXNzdW1lIGFyZSBhbGwgdGhlIHBhdGNoZXMgdGhhdCBhcmUgYXBwbGll
ZC4KPiAKPiBOb25lIG9mIHRoZSBwYXRjaGVzIHRvdWNoIHRoZSBibG9jayBzdWJzeXN0ZW0sIGFu
ZCBvbmx5IG9uZSBwYXRjaAo+IHRvdWNoZXMgaW5jbHVkZS90cmFjZS8sIGFkZGluZyBhIG5ldyBz
aW94IHRyYWNlcG9pbnQuIE9uZSBwYXRjaCBzZXRzCj4gIjIwMTcwNDI4LTEiIGFzIHRoZSBFWFRS
QVZFUlNJT04uIEkgZG9uJ3Qga25vdyB3aGVyZSBTVUJMRVZFTCBpcyBzZXQgdG8gMjguCj4gCj4g
aW5jbHVkZS90cmFjZS9ldmVudHMvYmxvY2suaCBpcyB0aGUgc2FtZSBhcwo+IGh0dHBzOi8vZ2l0
aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL3Y0LjkvaW5jbHVkZS90cmFjZS9ldmVudHMvYmxv
Y2suaC4KPiAKPiBUaGF0J3MgYWxsIHJlbGV2YW50IGluZm9ybWF0aW9uIGFib3V0IHRoZSBrZXJu
ZWwgSSBjb3VsZCBmaWd1cmUgb3V0IHNvIGZhci4KPiAKPiBBbnkgb3RoZXIgaW5mb3JtYXRpb24g
dGhhdCB3b3VsZCBoZWxwPwo+IAo+IFJlZ2FyZHMsCj4gVGhvbWFzCgpIaSBUaG9tYXMsCgpJIGZv
cmdvdCB0byBhc2sgZm9yIHlvdXIga2VybmVsIC5jb25maWcgZmlsZS4KCk1pY2hhZWwKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
