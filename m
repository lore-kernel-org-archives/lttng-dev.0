From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: update kvm
 instrumentation for 4.1.50+
Date: Thu, 8 Mar 2018 11:32:09 -0500 (EST)
Message-ID: <977019325.7029.1520526729108.JavaMail.zimbra__33237.8599014648$1520526621$gmane$org@efficios.com>
References: <1520525936-13554-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zxwyf4n9Jz15H
 for <lttng-dev@lists.lttng.org>; Thu,  8 Mar 2018 11:32:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B203841B544
 for <lttng-dev@lists.lttng.org>; Thu,  8 Mar 2018 11:32:09 -0500 (EST)
In-Reply-To: <1520525936-13554-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuMTAsIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0tIE9u
IE1hciA4LCAyMDE4LCBhdCAxMToxOCBBTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmlj
aW9zLmNvbSB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNv
bkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1
bGUva3ZtLmggfCAxICsKPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZm
IC0tZ2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKPiBiL2lu
c3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oCj4gaW5kZXggNzZlYWE2OS4u
OGY5YTEzMiAxMDA2NDQKPiAtLS0gYS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVs
ZS9rdm0uaAo+ICsrKyBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5o
Cj4gQEAgLTg5LDYgKzg5LDcgQEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChrdm1fYWNrX2lycSwK
PiAJfHwgTFRUTkdfREVCSUFOX0tFUk5FTF9SQU5HRSg0LDE0LDEzLDAsMSwwLCA0LDE1LDAsMCww
LDApIFwKPiAJfHwgTFRUTkdfS0VSTkVMX1JBTkdFKDQsOSw3NywgNCwxMCwwKSBcCj4gCXx8IExU
VE5HX0tFUk5FTF9SQU5HRSg0LDQsMTEyLCA0LDUsMCkgXAo+ICsJfHwgTFRUTkdfS0VSTkVMX1JB
TkdFKDQsMSw1MCwgNCwyLDApIFwKPiAJfHwgTFRUTkdfS0VSTkVMX1JBTkdFKDMsMTYsNTIsIDMs
MTcsMCkgXAo+IAl8fCBMVFROR19LRVJORUxfUkFOR0UoMywyLDk3LCAzLDMsMCkgXAo+IAl8fCBM
VFROR19ERUJJQU5fS0VSTkVMX1JBTkdFKDQsOSw2NSwwLDMsMCwgNCwxMCwwLDAsMCwwKSBcCj4g
LS0KPiAyLjcuNAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
