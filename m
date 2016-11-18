From: "Staffan Tjernstrom" <staffan@eternaltraveller.com>
Subject: Trying out 2.9.0-rcX - we get build errors
Date: Fri, 18 Nov 2016 10:26:27 -0600
Message-ID: <3f40cfd8ab99ce8948171a6d0a819f89.squirrel__30262.7820442014$1479486452$gmane$org@email.powweb.com>
Reply-To: stjernstrom@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from walmailout04.yourhostingaccount.com
 (mailout04.yourhostingaccount.com [65.254.254.70])
 by lists.lttng.org (Postfix) with ESMTPS id 3tL3Mj0m0nzdlh
 for <lttng-dev@lists.lttng.org>; Fri, 18 Nov 2016 16:28:32 +0000 (UTC)
Received: from mailscan09.yourhostingaccount.com ([10.1.15.9]
 helo=walmailscan09.yourhostingaccount.com)
 by walmailout04.yourhostingaccount.com with esmtp (Exim)
 id 1c7m0R-0006bO-JO
 for lttng-dev@lists.lttng.org; Fri, 18 Nov 2016 11:27:15 -0500
Received: from [10.114.3.32] (helo=walimpout12)
 by walmailscan09.yourhostingaccount.com with esmtp (Exim)
 id 1c7m0L-00070Y-AE
 for lttng-dev@lists.lttng.org; Fri, 18 Nov 2016 11:27:09 -0500
Received: from [127.0.0.1] (helo=email.powweb.com)
 by walwebmail09.yourhostingaccount.com with esmtp (Exim)
 id 1c7lzf-0004Ow-Ap
 for lttng-dev@lists.lttng.org; Fri, 18 Nov 2016 11:26:27 -0500
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

VHJ5aW5nIHRvIGJ1aWxkIGx0dG5nLXRvb2xzIGZyb20gdGhlIDIuOS4wLXJjMSB0YXJiYWxsLCB3
ZSBnZXQgdGhlCmZvbGxvd2luZyAtIGFueSBpZGVhcyB3aGF0IHdlJ3ZlIG1pc3NlZD8KCkNDTEQg
ICAgIGx0dG5nLWNvbnN1bWVyZAouLi8uLi8uLi9zcmMvY29tbW9uL2NvbnN1bWVyLy5saWJzL2xp
YmNvbnN1bWVyLmEodXN0LWNvbnN1bWVyLm8pOiBJbgpmdW5jdGlvbiBgZ2V0X2luZGV4X3ZhbHVl
cyc6Ci9yb290L3JwbWJ1aWxkL1NPVVJDRVMvbHR0bmctdG9vbHMtMi45LjAvc3JjL2NvbW1vbi91
c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmM6MjE1NToKdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
dXN0Y3RsX2dldF9pbnN0YW5jZV9pZCcKL3Jvb3QvcnBtYnVpbGQvU09VUkNFUy9sdHRuZy10b29s
cy0yLjkuMC9zcmMvY29tbW9uL3VzdC1jb25zdW1lci91c3QtY29uc3VtZXIuYzoyMTYyOgp1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGB1c3RjdGxfZ2V0X3NlcXVlbmNlX251bWJlcicKLi4vLi4vLi4v
c3JjL2NvbW1vbi9jb25zdW1lci8ubGlicy9saWJjb25zdW1lci5hKHVzdC1jb25zdW1lci5vKTog
SW4KZnVuY3Rpb24gYHVwZGF0ZV9zdHJlYW1fc3RhdHMnOgovcm9vdC9ycG1idWlsZC9TT1VSQ0VT
L2x0dG5nLXRvb2xzLTIuOS4wL3NyYy9jb21tb24vdXN0LWNvbnN1bWVyL3VzdC1jb25zdW1lci5j
OjIzNjk6CnVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHVzdGN0bF9nZXRfc2VxdWVuY2VfbnVtYmVy
JwouLi8uLi8uLi9zcmMvY29tbW9uL2NvbnN1bWVyLy5saWJzL2xpYmNvbnN1bWVyLmEodXN0LWNv
bnN1bWVyLm8pOiBJbgpmdW5jdGlvbiBgbHR0bmdfdXN0Y29uc3VtZXJfZ2V0X3NlcXVlbmNlX251
bWJlcic6Ci9yb290L3JwbWJ1aWxkL1NPVVJDRVMvbHR0bmctdG9vbHMtMi45LjAvc3JjL2NvbW1v
bi91c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmM6MjAwOToKdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgdXN0Y3RsX2dldF9zZXF1ZW5jZV9udW1iZXInCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJu
ZWQgMSBleGl0IHN0YXR1cwpNYWtlZmlsZTo1NDU6IHJlY2lwZSBmb3IgdGFyZ2V0ICdsdHRuZy1j
b25zdW1lcmQnIGZhaWxlZAptYWtlWzNdOiAqKiogW2x0dG5nLWNvbnN1bWVyZF0gRXJyb3IgMQpt
YWtlWzNdOiBMZWF2aW5nIGRpcmVjdG9yeQonL3Jvb3QvcnBtYnVpbGQvU09VUkNFUy9sdHRuZy10
b29scy0yLjkuMC9zcmMvYmluL2x0dG5nLWNvbnN1bWVyZCcKTWFrZWZpbGU6NTA2OiByZWNpcGUg
Zm9yIHRhcmdldCAnYWxsLXJlY3Vyc2l2ZScgZmFpbGVkCm1ha2VbMl06ICoqKiBbYWxsLXJlY3Vy
c2l2ZV0gRXJyb3IgMQptYWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeQonL3Jvb3QvcnBtYnVpbGQv
U09VUkNFUy9sdHRuZy10b29scy0yLjkuMC9zcmMvYmluJwpNYWtlZmlsZTo0OTQ6IHJlY2lwZSBm
b3IgdGFyZ2V0ICdhbGwtcmVjdXJzaXZlJyBmYWlsZWQKbWFrZVsxXTogKioqIFthbGwtcmVjdXJz
aXZlXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcvcm9vdC9ycG1idWlsZC9T
T1VSQ0VTL2x0dG5nLXRvb2xzLTIuOS4wL3NyYycKTWFrZWZpbGU6NTg4OiByZWNpcGUgZm9yIHRh
cmdldCAnYWxsLXJlY3Vyc2l2ZScgZmFpbGVkCm1ha2U6ICoqKiBbYWxsLXJlY3Vyc2l2ZV0gRXJy
b3IgMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
