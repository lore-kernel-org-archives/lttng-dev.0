From: "Staffan Tjernstrom" <staffan@eternaltraveller.com>
Subject: Keeping traces separate query
Date: Mon, 26 Sep 2016 09:14:01 -0500
Message-ID: <13210846eae7d21c01b45f120c5644ee.squirrel__33925.6290732466$1474901074$gmane$org@email.powweb.com>
Reply-To: stjernstrom@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from walmailout08.yourhostingaccount.com
 (walmailout08.yourhostingaccount.com [65.254.253.232])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5CD95A2053
 for <lttng-dev@lists.lttng.org>; Mon, 26 Sep 2016 14:45:30 +0000 (UTC)
Received: from mailscan14.yourhostingaccount.com ([10.1.15.14]
 helo=walmailscan14.yourhostingaccount.com)
 by walmailout08.yourhostingaccount.com with esmtp (Exim)
 id 1boWfV-0002Wd-Jl
 for lttng-dev@lists.lttng.org; Mon, 26 Sep 2016 10:14:05 -0400
Received: from [10.114.3.31] (helo=walimpout11)
 by walmailscan14.yourhostingaccount.com with esmtp (Exim)
 id 1boWfV-0007Vh-FQ
 for lttng-dev@lists.lttng.org; Mon, 26 Sep 2016 10:14:05 -0400
Received: from [127.0.0.1] (helo=email.powweb.com)
 by walwebmail07.yourhostingaccount.com with esmtp (Exim)
 id 1boWfR-0001N2-Nn
 for lttng-dev@lists.lttng.org; Mon, 26 Sep 2016 10:14:01 -0400
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

SSBoYXZlIGEgc2NlbmFyaW8gd2hlcmUgSSBoYXZlIHR3byBjb3BpZXMgb2YgdGhlIHNhbWUgZXhl
Y3V0YWJsZQpydW5uaW5nIG9uIG9uZSBzeXN0ZW0gKGJ1dCBmcm9tIGRpZmZlcmVudCBkaXJlY3Rv
cmllcykuCgpXaGF0IEkgd291bGQgbGlrZSB0byBoYXZlIGhhcHBlbiBpcyB0byBiZSBhYmxlIHRv
IHJ1biB0d28gc2VwYXJhdGUKYmFiZWx0cmFjZSBpbnN0YW5jZXMsIGVhY2ggZmVlZGluZyBmcm9t
IGl0cyBvd24gZXhlY3V0YWJsZSBpbnN0YW5jZS4KClRoZSBjb21wbGljYXRpbmcgZmFjdG9yIGlz
IHRoYXQgSSBuZWVkIHRvIHJ1biBpbiAtLWxpdmUgbW9kZSwgYW5kIEkKbmVlZCB0byBjYXB0dXJl
IHRoZSBmaXJzdCB0cmFjZXBvaW50cyB0aGF0IGVhY2ggZXhlY3V0YWJsZSBzcGl0cyBvdXQsCnNv
IEkgZG9uJ3QgdGhpbmsgdGhhdCBmaWx0ZXJpbmcgYnkgcGlkIHdpbGwgd29yayAoSSdkIGhhdmUg
dG8ga25vdyB0aGUKcGlkIGJlZm9yZSB0aGUgZXhlY3V0YWJsZSBzdGFydHMgLi4uKQoKSWYgYW55
Ym9keSBoYXMgYW55IGdvb2QgaWRlYXMsIEknZCBiZSBncmF0ZWZ1bC4KCktpbmQgUmVnYXJkcwpT
dGFmZmFuIFRqLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
