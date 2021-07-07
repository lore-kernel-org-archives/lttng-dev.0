Return-Path: <SRS0=qlDs=L7=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A03FC07E96
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jul 2021 02:43:44 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3109461CB2
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jul 2021 02:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3109461CB2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GKNyz1cVYzSj3;
	Tue,  6 Jul 2021 22:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1625625820;
	bh=1kY0xYQOYky02/sKdxAqeZGxRGBDe+oH7PTpKlrl+Uc=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=y6dw4l7kyR9Qb9sv2fBHfEtQMLwqFAJpW8iD1jmhiHLoMp2201uDPn/z3iDRClS35
	 lPA9LK7mZTh2q1bKYFCDZkt+87gLKsPHNRx5qUKGgok3mVnHKsvXfCRPGpbdABUSHS
	 IK1KKr7sS6s0ryRMDpPTtNApfTQx1BEjjYmIDc29EyPJyLNFKkNYL/8o2JIUVjGuxD
	 evU2t6vBa1PAc690ERQIekA1nd2hlQduXIAW0XB3Y6vatKTmv3VicN7qtxidG+AHza
	 6dmn2q0EhvkHvPPPL99Q8A/HZsb/zMsCIoNzspXmEN9KbFXyD624XQnMEUp8o4DlH4
	 6HofPq7y/ywdg==
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by lists.lttng.org (Postfix) with ESMTPS id 4GKNyx0h5tzSj2
 for <lttng-dev@lists.lttng.org>; Tue,  6 Jul 2021 22:43:36 -0400 (EDT)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09430134|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_social|0.128363-0.00754733-0.86409;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04400; MF=zhenyu.ren@aliyun.com; NM=1; PH=DW;
 RN=1; RT=1; SR=0; TI=W4_6173578_DEFAULT_0AC264D1_1625624195067_o7001c2363; 
Received: from WS-web
 (zhenyu.ren@aliyun.com[W4_6173578_DEFAULT_0AC264D1_1625624195067_o7001c2363])
 by e01e01406.eu6 at Wed, 07 Jul 2021 10:37:39 +0800
Date: Wed, 07 Jul 2021 10:37:39 +0800
To: "lttng-dev" <lttng-dev@lists.lttng.org>
Message-ID: <a286a436-454c-4aa1-b184-cccd0825370e.zhenyu.ren@aliyun.com>
X-Mailer: [Alimail-Mailagent revision 2546561][W4_6173578][DEFAULT][Chrome]
MIME-Version: 1.0
x-aliyun-mail-creator: W4_6173578_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNSkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzgxLjAuNDA0NC4xMzggU2FmYXJpLzUzNy4zNg==vN
Subject: [lttng-dev] =?utf-8?q?what_will_happen_during_tracing_if_getcpu?=
 =?utf-8?q?=28=29_doesn=27t_return_correct_cpu_number_occasionally=3F?=
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
From: "zhenyu.ren via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Content-Type: multipart/mixed; boundary="===============9061438588519042172=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============9061438588519042172==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_84299_7fb492dff940_60e51373_26f12b"

------=ALIBOUNDARY_84299_7fb492dff940_60e51373_26f12b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGksIAogICBJIGtub3cgbHR0bmctdXN0IHRyYWNlcG9pbnQgcHJvY2VzcyB1c2VzIHBlciBjcHUg
bG9ja2xlc3MgcmluZ2J1ZmZlciBhbGdvcml0aG0gZm9yIGhpZ2ggcGVyZm9ybWFuY2Ugc28gdGhh
dCBpdCByZWxpZXMgb24gZ2V0Y3B1KCkgdG8gcmV0dXJuIHRoZSBjcHUgbnVtYmVyIG9uIHdoaWNo
IHRoZSBhcHAgaXMgcnVubmluZy4KICAgVW5mb3J0dW5hdGVseSwgSSBhbSB3b3JraW5nIG9uIGFy
bSB0aGF0IGxpbnV4IGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IHZkc28gZ2V0Y3B1KCkgaW1wbGVt
ZW50aW9uIGFuZCBvbmUgZ2V0Y3B1KCkgd2lsbCB0YWtlIDIwMG5zISEhCiAgIE15IHF1ZXN0aW9u
IGlzIDoKICAgMS4gZG8geW91IGhhdmUgYW55IGFkdmljZSBmb3IgdGhhdD8KICAgMi4gSWYgSSBp
bXBsZW1lbnQgYSBjYWNoZS12ZXJzaW9uIGZvciBnZXRjcHUoKShqdXN0IGxpa2UgZ2V0Y3B1KCkg
aW1wbGVtZW50aW9uIGJlZm9yZSBrZXJuZWwgMi42LjIzICksIHdoYXQgd2lsbCBoYXBwZW4gZHVy
aW5nIHRyYWNpbmcgcHJvY2Vzcz8gIAogICAgICBTaW5jZSB1c2Ugb2YgdGhlIGNhY2hlIGNvdWxk
IHNwZWVkIGdldGNwdSgpIGNhbGxzLCBhdCB0aGUgY29zdCB0aGF0IHRoZXJlIHdhcyBhIHZlcnkg
c21hbGwgY2hhbmNlIHRoYXQgdGhlIHJldHVybmVkIGNwdSBudW1iZXIgd291bGQgYmUgb3V0IG9m
IGRhdGUsIEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGUgIndyb25nIiBjcHUgbnVtYmVyIHdpbGwg
cmVzdWx0IGluIHRoZSB0cmFjaW5nIGFwcCBjcmFzaGluZz8KClRoYW5rcwp6aGVueXUucmVu
------=ALIBOUNDARY_84299_7fb492dff940_60e51373_26f12b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iX19hbGl5dW5fZW1haWxfYm9keV9ibG9jayI+PGRpdiAgc3R5bGU9ImNsZWFy
OmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRhaG9tYSxBcmlhbCxTVEhlaXRpLFNp
bVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7Ij5IaSwmbmJzcDs8L3NwYW4+PC9k
aXY+PGRpdiAgc3R5bGU9ImNsZWFyOmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRh
aG9tYSxBcmlhbCxTVEhlaXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7
Ij4mbmJzcDsgJm5ic3A7SSBrbm93IGx0dG5nLXVzdCB0cmFjZXBvaW50IHByb2Nlc3MgdXNlcyBw
ZXIgY3B1IGxvY2tsZXNzIHJpbmdidWZmZXIgYWxnb3JpdGhtJm5ic3A7Zm9yIGhpZ2ggcGVyZm9y
bWFuY2Ugc28gdGhhdCBpdCByZWxpZXMgb24gZ2V0Y3B1KCkgdG8gcmV0dXJuIHRoZSBjcHUgbnVt
YmVyIG9uIHdoaWNoIHRoZSBhcHAgaXMgcnVubmluZy48L3NwYW4+PC9kaXY+PGRpdiAgc3R5bGU9
ImNsZWFyOmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRhaG9tYSxBcmlhbCxTVEhl
aXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7Ij4mbmJzcDsgJm5ic3A7
VW5mb3J0dW5hdGVseSwmbmJzcDtJJm5ic3A7YW0mbmJzcDt3b3JraW5nJm5ic3A7b24gYXJtIHRo
YXQgbGludXgga2VybmVsIGRvZXMmbmJzcDtub3QmbmJzcDtzdXBwb3J0Jm5ic3A7dmRzbyBnZXRj
cHUoKSBpbXBsZW1lbnRpb24gYW5kIG9uZSBnZXRjcHUoKSB3aWxsIHRha2UgMjAwbnMhISE8L3Nw
YW4+PC9kaXY+PGRpdiAgc3R5bGU9ImNsZWFyOmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFt
aWx5OlRhaG9tYSxBcmlhbCxTVEhlaXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMw
MDAwMDA7Ij4mbmJzcDsgJm5ic3A7TXkgcXVlc3Rpb24gaXMgOjwvc3Bhbj48L2Rpdj48ZGl2ICBz
dHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBzdHlsZT0iZm9udC1mYW1pbHk6VGFob21hLEFyaWFs
LFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZToxNC4wcHg7Y29sb3I6IzAwMDAwMDsiPiZuYnNwOyAm
bmJzcDsxLiBkbyB5b3UgaGF2ZSBhbnkgYWR2aWNlIGZvciB0aGF0Pzwvc3Bhbj48L2Rpdj48ZGl2
ICBzdHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBzdHlsZT0iZm9udC1mYW1pbHk6VGFob21hLEFy
aWFsLFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZToxNC4wcHg7Y29sb3I6IzAwMDAwMDsiPiZuYnNw
OyAmbmJzcDsyLiBJZiBJIGltcGxlbWVudCBhIGNhY2hlLXZlcnNpb24gZm9yIGdldGNwdSgpKGp1
c3QgbGlrZSBnZXRjcHUoKSBpbXBsZW1lbnRpb24gYmVmb3JlIGtlcm5lbCAyLjYuMjMgKSwgd2hh
dCB3aWxsIGhhcHBlbiBkdXJpbmcgdHJhY2luZyBwcm9jZXNzPyZuYnNwOyA8L3NwYW4+PC9kaXY+
PGRpdiAgc3R5bGU9ImNsZWFyOmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRhaG9t
YSxBcmlhbCxTVEhlaXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7Ij4m
bmJzcDsgJm5ic3A7ICZuYnNwOyBTaW5jZSB1c2UmbmJzcDtvZiZuYnNwO3RoZSZuYnNwO2NhY2hl
Jm5ic3A7Y291bGQmbmJzcDtzcGVlZCZuYnNwO2dldGNwdSgpJm5ic3A7Y2FsbHMsJm5ic3A7YXQm
bmJzcDt0aGUmbmJzcDtjb3N0Jm5ic3A7dGhhdCZuYnNwO3RoZXJlJm5ic3A7d2FzJm5ic3A7YSZu
YnNwO3ZlcnkmbmJzcDtzbWFsbCZuYnNwO2NoYW5jZSZuYnNwO3RoYXQmbmJzcDt0aGUmbmJzcDty
ZXR1cm5lZCBjcHUgbnVtYmVyIHdvdWxkJm5ic3A7YmUmbmJzcDtvdXQmbmJzcDtvZiZuYnNwO2Rh
dGUsIEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGUgIndyb25nIiBjcHUgbnVtYmVyIHdpbGwgcmVz
dWx0IGluIHRoZSB0cmFjaW5nIGFwcCBjcmFzaGluZz88L3NwYW4+PC9kaXY+PGRpdiAgc3R5bGU9
ImNsZWFyOmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRhaG9tYSxBcmlhbCxTVEhl
aXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7Ij48YnIgPjwvc3Bhbj48
L2Rpdj48ZGl2ICBzdHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBzdHlsZT0iZm9udC1mYW1pbHk6
VGFob21hLEFyaWFsLFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZToxNC4wcHg7Y29sb3I6IzAwMDAw
MDsiPlRoYW5rczwvc3Bhbj48L2Rpdj48ZGl2ICBzdHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBz
dHlsZT0iZm9udC1mYW1pbHk6VGFob21hLEFyaWFsLFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZTox
NC4wcHg7Y29sb3I6IzAwMDAwMDsiPnpoZW55dS5yZW48L3NwYW4+PC9kaXY+PC9kaXY+
------=ALIBOUNDARY_84299_7fb492dff940_60e51373_26f12b--


--===============9061438588519042172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9061438588519042172==--

