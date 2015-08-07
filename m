From: Antoine Busque <abusque@efficios.com>
Subject: Re: Userspace C++ Fucntion entry exit insert tracepoints
Date: Fri, 7 Aug 2015 13:07:49 -0400
Message-ID: <CA+MZcXt0JTMQ8cwthAgAbnxonVQ3UpTYKmBC_w4Rn0qHS9eCyw__9182.08079315281$1438967341$gmane$org@mail.gmail.com>
References: <BAY179-W1929B629FBBDDBA12D96AD92750@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZNl7f-00052f-1k
 for lttng-dev@lists.lttng.org; Fri, 07 Aug 2015 13:08:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 390B8340523
 for <lttng-dev@lists.lttng.org>; Fri,  7 Aug 2015 17:07:53 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id AoDUJbtEWKca for <lttng-dev@lists.lttng.org>;
 Fri,  7 Aug 2015 17:07:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 91AA6340528
 for <lttng-dev@lists.lttng.org>; Fri,  7 Aug 2015 17:07:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Zt9QmRG51tfD for <lttng-dev@lists.lttng.org>;
 Fri,  7 Aug 2015 17:07:51 +0000 (UTC)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by mail.efficios.com (Postfix) with ESMTPSA id 1760D34051D
 for <lttng-dev@lists.lttng.org>; Fri,  7 Aug 2015 17:07:51 +0000 (UTC)
Received: by igr7 with SMTP id 7so35062293igr.0
 for <lttng-dev@lists.lttng.org>; Fri, 07 Aug 2015 10:07:49 -0700 (PDT)
In-Reply-To: <BAY179-W1929B629FBBDDBA12D96AD92750@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Farhan Shariff <farhan.shariff@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gV2VkLCBBdWcgNSwgMjAxNSBhdCAxMDozMiBBTSwgRmFyaGFuIFNoYXJpZmYKPGZhcmhhbi5z
aGFyaWZmQGhvdG1haWwuY29tPiB3cm90ZToKPiBIaSwKPgo+IEkgYW0gd29ya2luZyB3aXRoIGEg
YysrIGFwcGxpY2F0aW9uKCB1c2Vyc3BhY2UgKQo+Cj4gSSB3YW50IHRvIHBsYWNlIGluIG15IHNv
dXJjZSBjb2RlCj4gLSB0cmFjZXBvaW50KHByb3ZpZGUsbmFtZSwuLi4pICBhdCBldmVyeSBmdW5j
dGlvbiBlbnRyeSBhbmQgZXhpdCAuCj4KPiBpcyBpdCBwb3NzaWJsZSB0byBieSBhbnkgbWVhbnMg
dG8gYXV0b21hdGUgdGhpcyAgYXMgaXQgaXMgdmVyeSBjdW1iZXJzb21lIHRvCj4gcGxhY2UgaXQg
bWFudWFsbHkuCj4KPgo+Cj4gQmVzdCBSZWdhcmRzCj4KPiBGYXJoYW4gU2hhcmlmZgo+Cj4gRmFy
aGFuIFNoYXJpZmYKPgoKSGksCgpJIHN1Z2dlc3QgeW91IGhhdmUgYSBsb29rIGF0IHRoZSBMVFRu
ZyBkb2N1bWVudGF0aW9uIG9uIGZ1bmN0aW9uIHRyYWNpbmc6CgpodHRwOi8vbHR0bmcub3JnL2Rv
Y3MvI2RvYy1saWJsdHRuZ+KAkXVzdOKAkWN5Z+KAkXByb2ZpbGUKCkkgYmVsaWV2ZSB0aGlzIG1p
Z2h0IHN1aXQgeW91ciBuZWVkcy4KClJlZ2FyZHMsCkFudG9pbmUuCgo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
