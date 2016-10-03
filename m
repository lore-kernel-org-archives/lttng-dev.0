From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: lttng-tools backport request: Fix: error.h ->
	common/error.h
Date: Mon, 3 Oct 2016 10:36:09 -0500
Message-ID: <4f48032d-049c-5e3a-f635-f7978a5ad783__21182.9904620119$1475509011$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DB7CAA1DC1
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 15:37:43 +0000 (UTC)
Received: from svr-orw-fem-06.mgc.mentorg.com ([147.34.97.120])
 by relay1.mentorg.com with esmtp
 id 1br5Hn-0006xF-5w from Nathan_Lynch@mentor.com
 for lttng-dev@lists.lttng.org; Mon, 03 Oct 2016 08:36:11 -0700
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

Q2FuIHRoaXMgYmUgYmFja3BvcnRlZCB0byB0aGUgc3RhYmxlLTIuOCBicmFuY2g/Cgpjb21taXQg
NjcxMmRiNjE3ZmU5CkF1dGhvcjogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5j
b20+CkRhdGU6ICAgV2VkIEp1biAxNSAxNzoxODowMyAyMDE2IC0wNDAwCgogICAgRml4OiBlcnJv
ci5oIC0+IGNvbW1vbi9lcnJvci5oCgpPRSBpcyBjYXJyeWluZyB0aGlzIHBhdGNoIGZvciBpdHMg
bHR0bmctdG9vbHMgMi44IHBhY2thZ2UgaW4gb3JkZXIgdG8KYnVpbGQgYWdhaW5zdCBtdXNsIGxp
YmM6CgpodHRwOi8vbGlzdHMub3BlbmVtYmVkZGVkLm9yZy9waXBlcm1haWwvb3BlbmVtYmVkZGVk
LWNvcmUvMjAxNi1TZXB0ZW1iZXIvMTI2ODUxLmh0bWwKCkkgaGF2ZW4ndCBwZXJzb25hbGx5IHZl
cmlmaWVkIHRoZSBwcm9ibGVtIG9yIHRoZSBwYXRjaCwgYnV0IGl0IHNlZW1zCmxpa2UgYW4gb2J2
aW91cywgbG93LXJpc2sgZml4PwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
