Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFFCC43334
	for <lttng-dev@archiver.kernel.org>; Mon, 27 Jun 2022 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1656352911;
	bh=+GQHlW+Ua80Y06u6DFHyPesAKDW89Myx3TLUdyueJx8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=QxpyJg3jjPxDP1GALAA2tRk//Sw/N8HYrpfZ85QUXXLyjLn08Ziz6FGPa0xz/JBza
	 rca9Hq2IUJldRh7h9JYZl5p4YovFG96xW/lDSnpy5e1fPrEhm9eAE8Yp0sQvkp4Uou
	 zr+i9+nqO98QyZrkC8SecSRZmbB79eOZ42ji22YUk4lIT3Z0OHjKEZ2mhKyZpupdtq
	 /68vnQ4F9TgtHCW8KAtCMUuaVS3IeZYugyxr+JFmw79C/nDenk6bmSkRS/jzAoibxX
	 ICHTVT2zEGFpEBMA8D3SQewHMNruXBZMETfW/AC+Ooz2JcrJQSY39hXCUCbdPO9IlS
	 vvMBtKZ2footA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LWwXZ4l9fzGZH;
	Mon, 27 Jun 2022 14:01:50 -0400 (EDT)
Received: from pmxout1.rz.tu-bs.de (pmxout1.rz.tu-bs.de [134.169.4.151])
 by lists.lttng.org (Postfix) with ESMTPS id 4LWvxb0G75zGfN
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2022 13:34:58 -0400 (EDT)
Received: from Hermes05.ad.tu-bs.de (hermes05.rz.tu-bs.de [134.169.4.133])
 by pmxout1.rz.tu-bs.de (Postfix) with ESMTPS id E60ED4E0D8D
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2022 19:26:37 +0200 (CEST)
Received: from Hermes11.ad.tu-bs.de (134.169.4.139) by Hermes05.ad.tu-bs.de
 (134.169.4.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 27 Jun
 2022 19:26:37 +0200
Received: from Hermes11.ad.tu-bs.de ([fe80::6082:86a9:d5b8:4309]) by
 Hermes11.ad.tu-bs.de ([fe80::6082:86a9:d5b8:4309%13]) with mapi id
 15.02.0986.026; Mon, 27 Jun 2022 19:26:37 +0200
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: No output on command line
Thread-Index: AQHYikpLNq+XFaa/wkS6h3zEDlvLtA==
Date: Mon, 27 Jun 2022 17:26:37 +0000
Message-ID: <e5fcc20c4d7148c9af6afe8db101fa1f@tu-braunschweig.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.169.9.110]
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 27 Jun 2022 14:01:49 -0400
Subject: [lttng-dev] No output on command line
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?J=C3=BCschke=2C_Lara_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsO8c2Noa2UsIExhcmE=?= <l.jueschke@tu-braunschweig.de>
Content-Type: multipart/mixed; boundary="===============1128772576324931328=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1128772576324931328==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_e5fcc20c4d7148c9af6afe8db101fa1ftubraunschweigde_"

--_000_e5fcc20c4d7148c9af6afe8db101fa1ftubraunschweigde_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gZGV2ZWxvcGVycywNCg0KDQpJIHN0cnVnZ2xlIHdpdGggYmFiZWx0cmFjZTIuIEkgc3Vj
Y2Vzc2Z1bGx5IGluc3RhbGxlZCBpdCAoSSB0cmllZCBidWlsZCBmcm9tIHNvdXJjZSBhbmQgd2l0
aCBkaXN0cmlidXRpb24gcGFja2FnZXMgZm9yIFVidW50dSkgYW5kIHRyYWNlZCBhbiBhcHBsaWNh
dGlvbiB3aXRoIGx0dG5nLiBIb3dldmVyLCB3aGVuIEkgZXhlY3V0ZSB0aGUgY29tbWFuZCAiYmFi
ZWx0cmFjZTIgPHBhdGgvdG8vbXkvdHJhY2UqPiIsIEkgZ2V0IG5vIGluZm9ybWF0aW9uLiBGb3Ig
YmFiZWx0cmFjZSAxLCBJIGdldCAibm8gdmVyc2lvbiBhdmFpbGFibGUiDQoNCkkgYW0gd29uZGVy
aW5nIGFib3V0IHRoZSByZWFzb24gYW5kIEkgd291bGQgYXBwcmVjaWF0ZSBhbnkgaGVscC4NCg0K
DQpLaW5kIHJlZ2FyZHMsDQoNCkxhcmENCg==

--_000_e5fcc20c4d7148c9af6afe8db101fa1ftubraunschweigde_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPjwhLS0gUCB7bWFyZ2luLXRvcDowO21hcmdpbi1ib3R0b206MDt9IC0t
Pjwvc3R5bGU+DQo8L2hlYWQ+DQo8Ym9keSBkaXI9Imx0ciI+DQo8ZGl2IGlkPSJkaXZ0YWdkZWZh
dWx0d3JhcHBlciIgc3R5bGU9ImZvbnQtc2l6ZToxMnB0O2NvbG9yOiMwMDAwMDA7Zm9udC1mYW1p
bHk6Q2FsaWJyaSxIZWx2ZXRpY2Esc2Fucy1zZXJpZjsiIGRpcj0ibHRyIj4NCjxwPkhlbGxvIGRl
dmVsb3BlcnMsPC9wPg0KPHA+PGJyPg0KPC9wPg0KPHA+SSBzdHJ1Z2dsZSB3aXRoIGJhYmVsdHJh
Y2UyLiBJIHN1Y2Nlc3NmdWxseSBpbnN0YWxsZWQgaXQgKEkgdHJpZWQgYnVpbGQgZnJvbSBzb3Vy
Y2UgYW5kIHdpdGggZGlzdHJpYnV0aW9uIHBhY2thZ2VzIGZvciBVYnVudHUpIGFuZCB0cmFjZWQg
YW4gYXBwbGljYXRpb24gd2l0aCBsdHRuZy4gSG93ZXZlciwgd2hlbiBJIGV4ZWN1dGUgdGhlIGNv
bW1hbmQgJnF1b3Q7YmFiZWx0cmFjZTIgJmx0O3BhdGgvdG8vbXkvdHJhY2UqJmd0OyZxdW90Oywg
SSBnZXQgbm8gaW5mb3JtYXRpb24uDQogRm9yIGJhYmVsdHJhY2UgMSwgSSBnZXQgJnF1b3Q7bm8g
dmVyc2lvbiBhdmFpbGFibGUmcXVvdDs8L3A+DQo8cD5JIGFtIHdvbmRlcmluZyBhYm91dCB0aGUg
cmVhc29uIGFuZCBJIHdvdWxkIGFwcHJlY2lhdGUgYW55IGhlbHAuPC9wPg0KPHA+PGJyPg0KPC9w
Pg0KPHA+S2luZCByZWdhcmRzLDwvcD4NCjxwPkxhcmE8YnI+DQo8L3A+DQo8L2Rpdj4NCjwvYm9k
eT4NCjwvaHRtbD4NCg==

--_000_e5fcc20c4d7148c9af6afe8db101fa1ftubraunschweigde_--

--===============1128772576324931328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1128772576324931328==--
