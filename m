From: Zifei Tong <soariez@gmail.com>
Subject: Re: [RFC PATCH lttng-tools 2/2] Implement dynamic
 instrumentation with dyninst
Date: Fri, 20 Sep 2013 08:34:02 +0800
Message-ID: <CAJ7wx-HzFsfeDMxuJ9vmwFFNiZRAJ77T=kaqQjPYaydS1dDBrg__7858.30595200441$1379637343$gmane$org@mail.gmail.com>
References: <CAJ7wx-EDBibZ-MO7pWfGGBdx+2yzN7pENpWpEoWAj7r5hDSGSA@mail.gmail.com>
	<1378292441-18272-1-git-send-email-soariez@gmail.com>
	<1378292441-18272-2-git-send-email-soariez@gmail.com>
	<523B6D30.3020205@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VMogK-00019w-Cn
	for lttng-dev@lists.lttng.org; Thu, 19 Sep 2013 20:34:52 -0400
Received: by mail-vc0-f175.google.com with SMTP id ia10so6912915vcb.20
	for <lttng-dev@lists.lttng.org>; Thu, 19 Sep 2013 17:34:42 -0700 (PDT)
In-Reply-To: <523B6D30.3020205@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

WWVzLCBmb3Igbm93IEFSTSBhbmQgb3RoZXIgYXJjaGl0ZWN0dXJlcyBhcmUgbm90IHN1cHBvcnRl
ZC4KClF1b3RlIGZvcm0gZHluaW5zdCdzIG1haWwgbGlzdDoKPj4gIEFueW9uZSB3b3JraW5nIG9u
IEFSTSBzdXBwb3J0Pwo+IFRoaXMgaXMgb24gb3VyICJ0byBkbyIgbGlzdCwgYnV0IHdlIGN1cnJl
bnRseSBkb24ndCBoYXZlIGZ1bmRpbmcgZm9yIGl0LgotLQpCZXN0IFJlZ2FyZHMsCuS7neWtkOmj
niAoWmlmZWkgVG9uZykKCgpPbiBGcmksIFNlcCAyMCwgMjAxMyBhdCA1OjMxIEFNLCBOYXRoYW4g
THluY2ggPE5hdGhhbl9MeW5jaEBtZW50b3IuY29tPiB3cm90ZToKPiBIZWxsbywKPgo+IE9uIDA5
LzA0LzIwMTMgMDY6MDAgQU0sIFppZmVpIFRvbmcgd3JvdGU6Cj4+IFRoaXMgcGF0Y2ggcHJvdmlk
ZXMgYSAqdmVyeSogYmFzaWMgaW1wbGVtZW50YXRpb24gb2YgZHluYW1pYwo+PiBpbnN0cnVtZW50
YXRpb24gc3VwcG9ydCB1c2luZyBkeW5pbnN0IGxpYnJhcnkuCj4KPiBMb29raW5nIHRocm91Z2gg
ZHluaW5zdCdzIHNvdXJjZSBhbmQgd2ViIHNpdGUsIGl0IGFwcGVhcnMgdG8gc3VwcG9ydAo+IG9u
bHkgeDg2IGFuZCBQb3dlclBDIGFyY2hpdGVjdHVyZXM7IGlzIHRoaXMgY29ycmVjdD8KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
