From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Lttng-UST behavior issue (potential bug in lttng-tools)
Date: Mon, 28 Nov 2016 17:09:24 +0100
Message-ID: <e1431908-c6c2-90ca-efd3-9291794ddc3d__34039.3235943795$1480349336$gmane$org@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 3tSBV12PXSzmBF
 for <lttng-dev@lists.lttng.org>; Mon, 28 Nov 2016 16:10:17 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKSSBhbSB0cmFjaW5nIGEgQysrIGFwcGxpY2F0aW9uIG9uIGEgMzItY29yZSBtYWNo
aW5lICgyIHggQU1EIE9wdGVyb24gNjM3NiAxNiBjb3JlcywgMjU2IEdCIFJBTSkuCgpJIGZvdW5k
IGEgYnVnIGluIGx0dG5nLXRvb2xzLgoKQWZ0ZXIgNSB0cmFjaW5nIHNlc3Npb25zLCB0aGUgc2Vz
c2lvbiBudW1iZXIgNiAodGhlIHNpeHRoIHNlc3Npb24sIHN0YXJ0aW5nIGluIGEgc3RhdGUgd2hl
cmUgbm8gbHR0bmcqIGRhZW1vbnMKYXJlIHJ1bm5pbmcsIGFsd2F5cyBjcmFzaCAobiA9IDEwKSBh
dCAibHR0bmcgZW5hYmxlLWV2ZW50IiAoIlVTVCBjcmVhdGUgY2hhbm5lbCBmYWlsZWQiKS4KQmVj
YXVzZSBvZiB0aGlzLCBsdHRuZyB0aHJvd3MgYW4gZXJyb3IgYW5kIGRvZXMgbm90IHNlZW0gdG8g
ZG8gYSBoZWFsdGggY2hlY2sgb3IgdG8gYmUgYWJsZSB0byByZWNvdmVyIGZyb20gdGhpcy4KSSBr
bm93IHRoYXQgdGhlIHByb2JsZW0gaXMgaW4gb25lIG9mIHRoZSBkYWVtb25zIGJlY2F1c2UgaWYg
SSBraWxsIHRoZW0gYWxsIHRoZSBwcm9ibGVtIGdvZXMgYXdheS4KCkkgc2VhcmNoZWQgIlVTVCBj
cmVhdGUgY2hhbm5lbCBmYWlsZWQiIG9uIGh0dHBzOi8vYnVncy5sdHRuZy5vcmcvLCBhbmQgZ290
IDEgc2VhcmNoIHJlc3VsdCAobm8Kb3BlbiBidWdzKToKCi0gaHR0cHM6Ly9idWdzLmx0dG5nLm9y
Zy9pc3N1ZXMvMzM5ICgiU3ViYnVmZmVyIHNpemUgb2YgPCA0MDk2IGFyZSBhY2NlcHRlZCBidXQg
dW5hYmxlIHRvIHVzZSB0aGUgY2hhbm5lbCBhZnRlcndhcmRzIikKCkhlcmUgaXMgbXkgYnVnIHJl
cG9ydDoKCmh0dHBzOi8vYnVncy5sdHRuZy5vcmcvaXNzdWVzLzEwNzgKCgpUaGFua3MKCgpJIGNh
biBoZWxwIHdpdGggdGhlIGZpeC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
