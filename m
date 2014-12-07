From: =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Subject: lttng-modules not building against latest linux 3.14.x
Date: Sun, 7 Dec 2014 14:38:41 +0100
Message-ID: <CAEYzJUGjPnhHbKXop87-kZOd4oJNRb4Gh8F3UbXwz63Qtn52ew__3816.87515550784$1417960552$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bjorn.forsman@gmail.com>) id 1Xxc2x-0005CO-C2
 for lttng-dev@lists.lttng.org; Sun, 07 Dec 2014 08:38:48 -0500
Received: by mail-yk0-f175.google.com with SMTP id 200so1572939ykr.34
 for <lttng-dev@lists.lttng.org>; Sun, 07 Dec 2014 05:38:41 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGkgbGlzdCwKCihJJ20gbm90IHN1YnNjcmliZWQsIHBsZWFzZSBDQyBtZS4pCgpJJ20gYSBtYWlu
dGFpbmVyIG9mIGx0dG5nLW1vZHVsZXMgaW4gTml4T1NbMV0uIFNpbmNlIHRoZSB1cGRhdGUgZnJv
bQpMaW51eCAzLjE0LjI0IHRvIDMuMTQuMjUsIGx0dG5nLW1vZHVsZXMgZmFpbCB0byBidWlsZDoK
Cmh0dHA6Ly9oeWRyYS5uaXhvcy5vcmcvYnVpbGQvMTc1MzgzMTkvbml4bG9nLzEvcmF3CgpUaGUg
YWJvdmUgYnVpbGQgaXMgd2l0aCBsdHRuZy1tb2R1bGVzIDIuNi4wLXJjMSwgYnV0IGxvb2tpbmcg
aW4gZ2l0LCBJCmRvbid0IHNlZSBhbnkgcmVsZXZhbnQgY2hhbmdlcyBmb3IgbGludXggMy4xNC54
LgoKSSBkb24ndCBrbm93IGlmIHlvdSdyZSBhd2FyZSBvZiB0aGlzIGJyZWFrYWdlIGFscmVhZHks
IGJ1dCBJIHRob3VnaHQKSSdkIG1ha2Ugc3VyZSB5b3UgZGlkIDotKQoKWzFdOiBodHRwOi8vbml4
b3Mub3JnLwoKQmVzdCByZWdhcmRzLApCasO4cm4gRm9yc21hbgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
