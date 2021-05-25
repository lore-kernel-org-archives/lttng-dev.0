Return-Path: <SRS0=Lz2h=KU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,
	HTML_MESSAGE,HTML_NONELEMENT_30_40,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13CAC2B9F8
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 08:16:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0100C61159
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 08:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0100C61159
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fq6NF6GsZz1wCY;
	Tue, 25 May 2021 04:15:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621930558;
	bh=cSTHm+qjA6Ut/eK3B/zTXs+UyyAL8DgmNu8FKGX89cI=;
	h=To:Cc:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Wy25aL4/HpgUwkMmGohdlPnjLXT1RsO5uox2eB2khJ8KuEggJqmJvoKgpBL/5mmgf
	 f/kulm6Q91LxPnwVi1GvVCC305uM6TCMA7ChCYik+V0bQKxZW9ww7lP7rR33G3+99P
	 UT1tk0IgXpl3z1YzfDevIF6CsaOPFDDF9PlrjBpXZ78pQ3ClPpiD8eIJSHH9ymxaRy
	 56kCQg1AsmRMMZ+xxkepX/msMOsijpBGw6YzJAQKvbIne8uHelhXFIPb2cppwIgur7
	 leP54lqAVweNXWf3xKXYBpmEqFvKghGZqllfYN2WPAb4sMvzJDtUrhGWQaDlfx+W1+
	 4deS8ox/WKb5g==
Received: from qq.com (smtpbg477.qq.com [59.36.132.88])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fq6Mv3tYXz1wCW
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 04:15:38 -0400 (EDT)
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: d1t2hSjUHbHTQqY90Lwrdek/1M3PcDmkszVO8EqQRjIcPQLOIMsA4GJIBqX7J
 XGUv5I//L3RTazqN/sK0N4p1bpe15Ko/jF1OOivAIDV493MTAOyzkV+WssO0ZxF/JJ2qLL2
 tSr49hPySPr1OzklHcFbBjrjpMzDLlcqpvSoM9WqDVCVtxNbSkfrIYsdWwWyaFFY1IGiR4T
 EyTo4XaVAg/c8do5IeVYpVTzEWAEy9f6xgjdbCcQkNjKhRxqWgUjjpRmgGb7hpUEVV3GtTx
 wajEWDOTai0GgASbBmqQamFYF9zYwqaSYujReHLN/cpJ7M0L3RiQ4ouuZF7h3LvAsv3A==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 58.33.93.110
X-QQ-STYLE: 
X-QQ-mid: llogic34t1621930429t3669791
To: "=?utf-8?B?Sm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4=?="
 <jonathan.rajotte-julien@efficios.com>
Cc: "=?utf-8?B?bHR0bmctZGV2?=" <lttng-dev@lists.lttng.org>
Mime-Version: 1.0
Date: Tue, 25 May 2021 16:13:48 +0800
X-Priority: 3
Message-ID: <tencent_02D5BD1E0DB6EEBD7DC3A97D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_7588A64434D8A77544C70CAA@qq.com>
 <20190716142832.GA20789@joraj-alpa>
In-Reply-To: <20190716142832.GA20789@joraj-alpa>
X-QQ-ReplyHash: 1584420506
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 25 May 2021 16:13:50 +0800 (CST)
Feedback-ID: llogic:magic-shield.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Subject: [lttng-dev] LTTng container awareness
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?b?5p2o5rW3IHZpYSBsdHRuZy1kZXY=?= <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?5p2o5rW3?= <hai.yang@magic-shield.com>
Content-Type: multipart/mixed; boundary="===============5491394615516458715=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multi-part message in MIME format.

--===============5491394615516458715==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_60ACB1BC_1355A1E8_5C92F85A"
Content-Transfer-Encoding: 8Bit

This is a multi-part message in MIME format.

------=_NextPart_60ACB1BC_1355A1E8_5C92F85A
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SGkNCg0KDQpMVFRuZyBoYWQgdGhlIDIwMTkgcGxhbiB0byBkZWNvdXBsZSB0b29saW5nIGZv
ciBjb250YWluZXIgYXdhcmVuZXNzLCBob3cgaXMgdGhlIHByb2dyZXNzIG9uIHRoYXQ/DQpo
dHRwczovL2FyY2hpdmUuZm9zZGVtLm9yZy8yMDE5L3NjaGVkdWxlL2V2ZW50L2NvbnRhaW5l
cnNfbHR0bmcvDQoNCg0KQXMgc3RhdGVkIGluIHBhZ2UgMTgsJm5ic3A7TFRUbmcgaXMgY29t
cHJpc2VkIG9mIG1hbnkgY29tcG9uZW50cyB0aGF0Jm5ic3A7ZXhwZWN0IGEg4oCcbW9ub2xp
dGlj4oCdIHN5c3RlbS4gSG93IGFib3V0IHRoZSBmdXR1cmUgdG8gY29udGFpbmVyaXplIHRo
ZSBMVFRuZz8NCg0KDQoNCg0KUmVnYXJkcw0KSGFpDQoNCg0KDQombmJzcDsNCiZuYnNwOw0K
Jm5ic3A7DQotLS0tLS0tLS0tLS0tLS0tLS0mbmJzcDtPcmlnaW5hbCZuYnNwOy0tLS0tLS0t
LS0tLS0tLS0tLQ0KRnJvbTogJm5ic3A7IkpvbmF0aGFuIFJham90dGUtSnVsaWVuIjxqb25h
dGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20mZ3Q7Ow0KRGF0ZTogJm5ic3A7VHVl
LCBKdWwgMTYsIDIwMTkgMTA6MjggUE0NClRvOiAmbmJzcDsi5p2o5rW3IjxoYWkueWFuZ0Bt
YWdpYy1zaGllbGQuY29tJmd0OzsgDQpDYzogJm5ic3A7Imx0dG5nLWRldiI8bHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZyZndDs7IA0KU3ViamVjdDogJm5ic3A7UmU6IFtsdHRuZy1kZXZd
IFByb3MgYW5kIENvbnMgb2YgTFRUbmcNCg0KJm5ic3A7DQoNCkhpIEhhaSwNCg0KT24gVHVl
LCBKdWwgMTYsIDIwMTkgYXQgMTA6MTk6MzhBTSArMDgwMCwg5p2o5rW3IHdyb3RlOg0KJmd0
OyBPYnZpb3VzbHkgTFRUbmcgaGFzIG11Y2ggbG93ZXIgb3ZlcmhlYWQgY29tcGFyZWQgdG8g
YXVkaXRkLCB3aGVuIHdlIHR1cm4gb24NCiZndDsgYWxsIHN5c3RlbSBjYWxscyBhbmQgdXNl
IHRoZSBzYW1lIGxvYWQuIElzIGl0IHRydWUgZm9yIGJvdGggdXNlciBzcGFjZSBhbmQNCiZn
dDsga2VybmVsIHNwYWNlPw0KDQpsdHRuZy11c3QgKHVzZXJzcGFjZSB0cmFjZXIpIG1vc3Rs
eSB1c2UgdGhlIHNhbWUgY29uY2VwdCBhcyB0aGUga2VybmVsdHJhY2VyDQoocGVyLWNwdSBy
aW5nIGJ1ZmZlcnMsIGJpbmFyeSBvdXRwdXQvQ1RGLCBkZWxheWVkIGNvbnN1bXB0aW9uIG9m
IGV2ZW50cywgZXRjLikuDQpUaGVyZSBpcyBzb21lIHBlbmFsdHkgZm9yIGRvaW5nIHRoaW5n
cyBpbiB1c2Vyc3BhY2Ugc2luY2Ugd2UgbmVlZCBzb21lDQppbmZvcm1hdGlvbiBmcm9tIHRo
ZSBrZXJuZWwgZm9yIGVhY2ggdHJhY2Vwb2ludCBoaXQgKGUuZyB0aGUgY3VycmVudCBjcHUN
Cm51bWJlcikuIEJ1dCBhZ2FpbiBtb3N0IG9mIHRoZXNlIGhvdCBwYXRocyBhcmUgcXVpdGUg
b3B0aW1pemVkLg0KDQpJbiBhbnkgY2FzZSBJIGVuY291cmFnZSB5b3UgdG8gdHJ5IGl0IG91
dCBvbiB5b3VyIHdvcmtsb2FkIGFuZCBsdHRuZyBmaXQgeW91cg0KbmVlZHMuDQoNCklmIHlv
dSBkbyBub3QgZmluZCBhIHBhcnRpY3VsYXIgZmVhdHVyZSBpbiB0aGUgZG9jIFsxXSwgZG8g
bm90IGhlc2l0YXRlIHRvIGNvbnRhY3QNCnRoaXMgbWFpbGluZyBsaXN0IGZvciBtb3JlIGlu
Zm9ybWF0aW9uLg0KDQomZ3Q7U28gZmFyIEkgaGF2ZW4ndCBzZWVuIGFueSByZXBvcnQgY29t
cGFyZSBMVFRuZyBhbmQgYXVkaXRkLA0KJmd0OyBhbnlvbmUga25vd3M/DQoNCkkgZG8gbm90
IHJlbWVtYmVyIGFueSBjb252ZXJzYXRpb24gb24gdGhpcyB0b3BpYy4gQWZ0ZXIgcmVhZGlu
ZyBhIGJpdCBvbiBhdWRpdGQsDQpsdHRuZyBtaWdodCBiZSBhIGdvb2QgcmVwbGFjZW1lbnQg
ZGVwZW5kaW5nIG9uIHlvdXIgY29uc3RyYWludHMgYW5kIG5lZWRzLg0KDQpbMV0gaHR0cHM6
Ly9sdHRuZy5vcmcvZG9jcy92Mi4xMC8NCg0KQ2hlZXJzDQotLSANCkpvbmF0aGFuIFJham90
dGUtSnVsaWVuDQpFZmZpY2lPUw==

------=_NextPart_60ACB1BC_1355A1E8_5C92F85A
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGRpdj5IaTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TFRUbmcgaGFkIHRoZSAyMDE5IHBs
YW4gdG8gZGVjb3VwbGUgdG9vbGluZyBmb3IgY29udGFpbmVyIGF3YXJlbmVzcywgaG93IGlz
IHRoZSBwcm9ncmVzcyBvbiB0aGF0PzwvZGl2PjxkaXY+aHR0cHM6Ly9hcmNoaXZlLmZvc2Rl
bS5vcmcvMjAxOS9zY2hlZHVsZS9ldmVudC9jb250YWluZXJzX2x0dG5nLzwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+QXMgc3RhdGVkIGluIHBhZzxmb250IF9fZWRpdG9yd2FycF9fPSIx
IiBzdHlsZT0iZGlzcGxheTogaW5saW5lOyBmb250LXNpemU6IDE0cHg7IGZvbnQtZmFtaWx5
OiAmcXVvdDtsdWNpZGEgR3JhbmRlJnF1b3Q7LCBWZXJkYW5hLCAmcXVvdDtNaWNyb3NvZnQg
WWFIZWkmcXVvdDs7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGJhY2tncm91bmQtY29sb3I6IHJn
YmEoMCwgMCwgMCwgMCk7IGZvbnQtd2VpZ2h0OiA0MDA7IGZvbnQtc3R5bGU6IG5vcm1hbDsi
PmUgMTgsJm5ic3A7TFRUbmcgaXMgY29tcHJpc2VkIG9mIG1hbnkgY29tcG9uZW50cyB0aGF0
Jm5ic3A7PC9mb250PjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiByZ2JhKDAsIDAs
IDAsIDApOyI+ZXhwZWN0IGEg4oCcbW9ub2xpdGlj4oCdIHN5c3RlbS4gSG93IGFib3V0IHRo
ZSBmdXR1cmUgdG8gY29udGFpbmVyaXplIHRoZSBMVFRuZz88L3NwYW4+PC9kaXY+PGRpdj48
L2Rpdj48ZGl2PjxzaWduIHNpZ25pZD0iOTgiPjxkaXY+PGZvbnQ+PGJyPjwvZm9udD48ZGl2
IHN0eWxlPSJjb2xvcjojOTA5MDkwO2ZvbnQtZmFtaWx5OkFyaWFsIE5hcnJvdztmb250LXNp
emU6MTJweCI+PC9kaXY+PC9kaXY+PGRpdj48Zm9udD5SZWdhcmRzPC9mb250PjwvZGl2Pjxk
aXY+PGZvbnQ+SGFpPGJyPjwvZm9udD48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRw
eDtmb250LWZhbWlseTpWZXJkYW5hO2NvbG9yOiMwMDA7Ij48L2Rpdj48L3NpZ24+PC9kaXY+
PGRpdj4mbmJzcDs8L2Rpdj48ZGl2PjxpbmNsdWRldGFpbD48ZGl2PiZuYnNwOzwvZGl2Pjxk
aXY+Jm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0iZm9udDpWZXJkYW5hIG5vcm1hbCAxNHB4O2Nv
bG9yOiMwMDA7Ij48ZGl2IHN0eWxlPSJGT05ULVNJWkU6IDEycHg7Rk9OVC1GQU1JTFk6IEFy
aWFsIE5hcnJvdztwYWRkaW5nOjJweCAwIDJweCAwOyI+LS0tLS0tLS0tLS0tLS0tLS0tJm5i
c3A7T3JpZ2luYWwmbmJzcDstLS0tLS0tLS0tLS0tLS0tLS08L2Rpdj48ZGl2IHN0eWxlPSJG
T05ULVNJWkU6IDEycHg7YmFja2dyb3VuZDojZWZlZmVmO3BhZGRpbmc6OHB4OyI+PGRpdiBp
ZD0ibWVudV9zZW5kZXIiPjxiPkZyb206IDwvYj4mbmJzcDsiSm9uYXRoYW4gUmFqb3R0ZS1K
dWxpZW4iJmx0O2pvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbSZndDs7PC9k
aXY+PGRpdj48Yj5EYXRlOiA8L2I+Jm5ic3A7VHVlLCBKdWwgMTYsIDIwMTkgMTA6MjggUE08
L2Rpdj48ZGl2PjxiPlRvOiA8L2I+Jm5ic3A7IuadqOa1tyImbHQ7aGFpLnlhbmdAbWFnaWMt
c2hpZWxkLmNvbSZndDs7IDx3YnI+PC9kaXY+PGRpdj48Yj5DYzogPC9iPiZuYnNwOyJsdHRu
Zy1kZXYiJmx0O2x0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcmZ3Q7OyA8d2JyPjwvZGl2Pjxk
aXY+PGI+U3ViamVjdDogPC9iPiZuYnNwO1JlOiBbbHR0bmctZGV2XSBQcm9zIGFuZCBDb25z
IG9mIExUVG5nPC9kaXY+PC9kaXY+PGRpdj4mbmJzcDs8L2Rpdj48ZGl2IHN0eWxlPSJwb3Np
dGlvbjpyZWxhdGl2ZTsiPjxkaXYgaWQ9InRtcGNvbnRlbnRfcmVzIj48L2Rpdj5IaSBIYWks
PGJyPjxicj5PbiBUdWUsIEp1bCAxNiwgMjAxOSBhdCAxMDoxOTozOEFNICswODAwLCDmnajm
tbcgd3JvdGU6PGJyPiZndDsgT2J2aW91c2x5IExUVG5nIGhhcyBtdWNoIGxvd2VyIG92ZXJo
ZWFkIGNvbXBhcmVkIHRvIGF1ZGl0ZCwgd2hlbiB3ZSB0dXJuIG9uPGJyPiZndDsgYWxsIHN5
c3RlbSBjYWxscyBhbmQgdXNlIHRoZSBzYW1lIGxvYWQuIElzIGl0IHRydWUgZm9yIGJvdGgg
dXNlciBzcGFjZSBhbmQ8YnI+Jmd0OyBrZXJuZWwgc3BhY2U/PGJyPjxicj5sdHRuZy11c3Qg
KHVzZXJzcGFjZSB0cmFjZXIpIG1vc3RseSB1c2UgdGhlIHNhbWUgY29uY2VwdCBhcyB0aGUg
a2VybmVsdHJhY2VyPGJyPihwZXItY3B1IHJpbmcgYnVmZmVycywgYmluYXJ5IG91dHB1dC9D
VEYsIGRlbGF5ZWQgY29uc3VtcHRpb24gb2YgZXZlbnRzLCBldGMuKS48YnI+VGhlcmUgaXMg
c29tZSBwZW5hbHR5IGZvciBkb2luZyB0aGluZ3MgaW4gdXNlcnNwYWNlIHNpbmNlIHdlIG5l
ZWQgc29tZTxicj5pbmZvcm1hdGlvbiBmcm9tIHRoZSBrZXJuZWwgZm9yIGVhY2ggdHJhY2Vw
b2ludCBoaXQgKGUuZyB0aGUgY3VycmVudCBjcHU8YnI+bnVtYmVyKS4gQnV0IGFnYWluIG1v
c3Qgb2YgdGhlc2UgaG90IHBhdGhzIGFyZSBxdWl0ZSBvcHRpbWl6ZWQuPGJyPjxicj5JbiBh
bnkgY2FzZSBJIGVuY291cmFnZSB5b3UgdG8gdHJ5IGl0IG91dCBvbiB5b3VyIHdvcmtsb2Fk
IGFuZCBsdHRuZyBmaXQgeW91cjxicj5uZWVkcy48YnI+PGJyPklmIHlvdSBkbyBub3QgZmlu
ZCBhIHBhcnRpY3VsYXIgZmVhdHVyZSBpbiB0aGUgZG9jIFsxXSwgZG8gbm90IGhlc2l0YXRl
IHRvIGNvbnRhY3Q8YnI+dGhpcyBtYWlsaW5nIGxpc3QgZm9yIG1vcmUgaW5mb3JtYXRpb24u
PGJyPjxicj4mZ3Q7U28gZmFyIEkgaGF2ZW4ndCBzZWVuIGFueSByZXBvcnQgY29tcGFyZSBM
VFRuZyBhbmQgYXVkaXRkLDxicj4mZ3Q7IGFueW9uZSBrbm93cz88YnI+PGJyPkkgZG8gbm90
IHJlbWVtYmVyIGFueSBjb252ZXJzYXRpb24gb24gdGhpcyB0b3BpYy4gQWZ0ZXIgcmVhZGlu
ZyBhIGJpdCBvbiBhdWRpdGQsPGJyPmx0dG5nIG1pZ2h0IGJlIGEgZ29vZCByZXBsYWNlbWVu
dCBkZXBlbmRpbmcgb24geW91ciBjb25zdHJhaW50cyBhbmQgbmVlZHMuPGJyPjxicj5bMV0g
aHR0cHM6Ly9sdHRuZy5vcmcvZG9jcy92Mi4xMC88YnI+PGJyPkNoZWVyczxicj4tLSA8YnI+
Sm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW48YnI+RWZmaWNpT1M8YnI+PC9kaXY+PC9kaXY+PCEt
LTwhW2VuZGlmXS0tPjwvaW5jbHVkZXRhaWw+PC9kaXY+

------=_NextPart_60ACB1BC_1355A1E8_5C92F85A--




--===============5491394615516458715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5491394615516458715==--



