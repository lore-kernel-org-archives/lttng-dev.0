From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH lttng-tools v2] Fix: test cases now rely on
 explicit workloads
Date: Tue, 8 Nov 2016 14:06:53 -0600
Message-ID: <e9f53bab-dbba-6ceb-3d7b-26f30a33433a__47725.1261625954$1478635639$gmane$org@mentor.com>
References: <1478630947-29321-1-git-send-email-francis.deslauriers@efficios.com>
 <1478634550-5638-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by lists.lttng.org (Postfix) with ESMTPS id 865F61B7C6
 for <lttng-dev@lists.lttng.org>; Tue,  8 Nov 2016 20:07:49 +0000 (UTC)
In-Reply-To: <1478634550-5638-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

T24gMTEvMDgvMjAxNiAwMTo0OSBQTSwgRnJhbmNpcyBEZXNsYXVyaWVycyB3cm90ZToKPiBSdW4g
YSBwcm9jZXNzIGV4cGxpY2l0bHkgaW4gdGhlIHRyYWNpbmcgc2Vzc2lvbiB0byBnZW5lcmF0ZSB0
aGUgZW5hYmxlZCBldmVudHMKPiByYXRoZXIgdGhhbiByZWx5aW5nIG9uIHRoZSBldmVudHMgZ2Vu
ZXJhdGVkIGJ5IHRoZSBsdHRuZyBDTEkuCgpbLi4uXQoKPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcmVn
cmVzc2lvbi9rZXJuZWwvdGVzdF9hbGxfZXZlbnRzIGIvdGVzdHMvcmVncmVzc2lvbi9rZXJuZWwv
dGVzdF9hbGxfZXZlbnRzCj4gaW5kZXggNTAwMDJmNC4uODBhODAyMCAxMDA3NTUKPiAtLS0gYS90
ZXN0cy9yZWdyZXNzaW9uL2tlcm5lbC90ZXN0X2FsbF9ldmVudHMKPiArKysgYi90ZXN0cy9yZWdy
ZXNzaW9uL2tlcm5lbC90ZXN0X2FsbF9ldmVudHMKPiBAQCAtMjEsNiArMjEsOCBAQCBDVVJESVI9
JChkaXJuYW1lICQwKS8KPiAgVEVTVERJUj0kQ1VSRElSLy4uLy4uCj4gIE5VTV9URVNUUz04Cj4g
IAo+ICtURVNUQ01EPSJncmVwIC1WIC1xID4gL2Rldi9udWxsIgo+ICsKCldoYXQgd2FzIHdyb25n
IHdpdGggL2Jpbi90cnVlLCBhcyBpbiB2MSBvZiB0aGlzIHBhdGNoPwoKRllJLCBCdXN5Ym94IGdy
ZXAgZG9lc24ndCBrbm93IC1WOgoKIyBncmVwIC1WIC1xID4vZGV2L251bGwKZ3JlcDogaW52YWxp
ZCBvcHRpb24gLS0gJ1YnCkJ1c3lCb3ggdjEuMjQuMSAoMjAxNi0xMS0wOCAxMjo1OToxMyBDU1Qp
IG11bHRpLWNhbGwgYmluYXJ5LgoKVXNhZ2U6IGdyZXAgWy1IaG5sTG9xdnNyaXdGRV0gWy1tIE5d
IFstQS9CL0MgTl0gUEFUVEVSTi8tZSBQQVRURVJOLi4uLy1mCkZJTEUgW0ZJTEVdLi4uCgojIGVj
aG8gJD8KMQoKSXQgbG9va3MgbGlrZSB0aGUgdGVzdGNhc2VzIGRvbid0IGNhcmUgYWJvdXQgdGhl
IGV4aXQgc3RhdHVzIG9mIFRFU1RDTUQsCmJ1dCB5b3UgbWF5IHdhbnQgdG8gcmVkaXJlY3Qgc3Rk
ZXJyIHRvIC9kZXYvbnVsbCBhcyB3ZWxsLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
