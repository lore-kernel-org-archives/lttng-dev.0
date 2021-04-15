Return-Path: <SRS0=1TmG=JM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A572C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 20:59:07 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F60A61153
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 20:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F60A61153
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FLsCF0bHNz1B7Y;
	Thu, 15 Apr 2021 16:59:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618520345;
	bh=0UVnBepkOtLK9FQvzFRwnmzHD1TGdaU4E1L9uZ0V0PY=;
	h=Date:References:Cc:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MkJV92R4dMPIoygnurdXksFEuJ6F87m0UpNSmIEA3oaOvj2PnWIecjjF9V9o+zPdv
	 VZ1359E5mgvfOidH07o/FFWa+zUPtHplajpJu+0LH/HCaBjh7S8cyrdGHMmhRe4Kku
	 v73VT6ZzZFiGGYflvuTjtHK0oTDshj1TwNiUqUdPP6oiz1RBxjhPiRpBoK5I5N+k4o
	 aLj6VQ9oniNPsUgqjXsVXkHLuWyKIR8TJr4eK7ibs1/b8v5IqsuMuy3SPc++CHrI0V
	 3y2ltAaHbTyq+5mZw2UyfcklkUdMgvtrrJyYxXIaYqHmlPmSDG4pyXr0l9jb2cRVYT
	 HPHvklvRqLO1Q==
Received: from sonic305-22.consmr.mail.ne1.yahoo.com
 (sonic305-22.consmr.mail.ne1.yahoo.com [66.163.185.148])
 by lists.lttng.org (Postfix) with ESMTPS id 4FLsCC38mFz1BHZ
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 16:59:03 -0400 (EDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1618520342; bh=4e8AYV29yJBIgJgYlkeJbHDmc8Q59Fczy7CEDbrVWBJ=;
 h=X-Sonic-MF:From:Subject:Date:To:From:Subject;
 b=EqBxO62J6+8g9a/GYzu5YTugg/M8oa5yEtmnbBHP/448QYMYCRpDmx5sMTxmmpA/hvwsju+SIDcnLsmdcBeSqPALHrqzMTI5AwXHERbGQQfMvweWKuHtkOACenxIs7AOlTvH+geBf5x/Xpm5pUteDpCg6LtYdLrdSig41De+Q02x/VFaA1pCeBvzqEqXx/qF3/C+mQYbiR7ysE62tOZWXpCdrtUnK1YDQh04elhao5iQyU24fZhMcTt4eL2fp07Kc6DWpqSji70m03pPE6Xh7Z+2s2k5iU6qavIy8REjtPTEjvhABThpKgGaJ5AoKByOeJpP5wC1yEqy/vjqEJZOGg==
X-YMail-OSG: dKVaBKYVM1k7sv_5YR6dPuZyNrGkXU_Y71BzTAEDOjOr.6EB6ZydTL8wnNoRudv
 cloO6mdNOOk695C8N5NZX5jV5o5RoSn5IBcebKwiFy5cBNFZAEnky3pZGRRRDVIhjN_CKRPXw3V5
 vxj3EnawXuqru2yS93PKIPdPcpZFEr.lIGNunkblqNu79WleAsbGRJUgdjj4jNgTLV0QwrN614NV
 ckPlBWJPLVPHmVorxOt5PRFD6AjNIXt_m7ynipnEoDQa9qa_v9F5V2G4FzewoY_iaBlwlhZ15LwD
 vu.ITenYIzWQNvLQqMKDVKm9CrWe1u_1dGu02bClfY2PVM.1vYJJUzAaCGhnliXudcmFdQiOP4AH
 CSqkgA91V2nclSuYjo1P6qUQT2zOYfcc2lEvKan8GGeQLDIlZ20LgaKPbeAlj8hCl01PbryYMnxI
 Rk_R8ll1f4VCFlnBWNdvWuVnhzMl.M_DoQawNNyaUqptJuCDb.fqgxCRpFwxwNoS6QxJ27NMS7iZ
 CCH01gvAtaCpf9Oe8f9Pnmhr4VQzlEn6hNoWMZKwni5.uu_4dVoXu_ZdjhGYLWhBaBa0DCN1Oeu.
 wzWvbolF2Cb.y6gn0HbgYCRIUecsVTs_hB0gzyC0koH7Eb82IyQB49L0L88uDtpKk7X5IlMG6AUB
 gIsva3aKi6ZHXWUn2zeAVi6HedEktWP48fwJDAzd05JGpP1NjkW2PO0ZWrfX9dfQsDUPbp7aoYZ2
 sGIUBl4fqXDuUFG6.vsQBcLbZk9BgYcjOH4.pxeeS7eqp9Xn0IwEC0W_dCn0.8z1pWTbnA0ON.ZA
 mILsAZ5aoroyIHmr5na1RK8mk8brVMCQwd0ypniuhaK2HYBSI41Q6on.g665A.lKJisWXZ_5I10p
 uPsU6XeR6NZQ4NmZgaPgXn5ixlrGKe4AQRCwR3AZH8d6.oWGLkXeKKtN0aPm9LIbBrulrJz4ePkt
 7nrfbVycHC0rDiUUwFFnTnI3ubvvvOhW2SbxAi1vvljoYE7RkHOoNdbZHdX1m9G40DPQOAiLwmt2
 BSNz71Zpob6pRyDEoRa5iyZrYoeK5QxteCabQx0Cmc0dhF_EFj.WGX__Al2pa9WJj0fh82K1IGUl
 hah2rLwCdR5WPpOA89BO2GjFiTjnaGFMVu0MTlFOlVuWPp6u3s5h0YDzfhFnXfcti39oNHg9FeyX
 VuXrHH2OxaTwseu1C6nFVcM79NXuJQ67bM5gZ3wJcDZUpJtd.3FIJUksbWO2SCjqT_J2rl_6CA0F
 jhLZtASWxN79Y4FeG.eVZrFYkqkt9NQKPDwRiMDOKX6GyKteqrrilktYznOg7VoaO94jotFE8ltu
 .QF5hZLHRTSg3lsTLEXe1SkJ43vHLqkhTzSViZmHsMonpAOu.4iEiVOmIZwPGoR1CA6Ld0EPmSeu
 RDAMpoxR8r_YLcjzgcAxcM5bEMZ0.AD831bq84LVyern1.mU5LbKRR3l1Ivqmccm_dh2__PssJI1
 EvNdH5zSUG1Qm3lO5fhRrTqaT6OPiQckapF3URocC5Knr.UDqpDS6IWfe3ol3iWV6t7B_gi4bWFL
 vMG6fYhv10bYrwBJRkdXVx8.dqVkdAtfsfUwoZEZbxK0BBveCFJZ64EPYraQ9FoarWgJcOJMVMMt
 SNpaKLxDHEw_akQFegolbdsrGfx3kqKvGdn7K7V_Cg5X1syIAF4ng7uGHUreOmT5Qrl_JrJveX44
 cIvVkoXAzs1b2pc2gbtFiUV6KmRhxK9CNaVVZQ26dpxcr.twb2EBzeV7dxGiZ8P3rQqvZ4qC5SZZ
 0.iCBA8XTH5o_M5TwYWFp2wGdjA7M.wRGlPl_WvfVP6pZdfRioOdZzQqnF1c4Vw_cQWjDRY.RMie
 J6Hn3MqmwfNhAtaNrLHzntwxUjIKRsyDIvZOeBl4QWX1xNIQwLadifcdkgCuPKEgwT0HJgdmMvEt
 iiMl5d8b3C_DIfbpp5UwDzDiqWoeNcHw_PyoRGCDvnGtJzxNu6No_n1laSyDnRt9nKC_uiLSsWyI
 mWLxSIB7dytQYiDzhc5fOR36emCQRAImh576sEVPyE_7G1G9zfxNip8rhJDMZVeDl9eP_0OVXHZ6
 J1WDmPxQqm13NPQajrvelqQE7O9O.fORARSULNXltTE7BsDpTwjvL8c1qzlrZqenewX748Dwfq1N
 CfKj_0rUxrSGNXFaNkNnRJyWCGDzr5Qb74UNJcqN2A33TOHfs.kKQ4DckAWOJ5A.rQEa7pCwW_YJ
 5baQ2DB6RAK8v6SR7ZCVpc0z9XDG07H_WUmyfZl6K9Y_8hvoHUJqGFhPBuCqj65C6GJT0Q0acNh0
 OjTKDC66V302rCeXb19LFe6.DNU_NaAjWHtRnLmhvKWhjzC7fC2vxea3vDdfgGUYEqhz4r1PSOK.
 jPJ8hGgy22pkJUdjVW_58FGZ6z_fef6NiGIHhqOBYWIKO8ywGCZfmC8ikc7_qoqK4oOAmblpnjp2
 Wf1p0FzFjaFvxsNYbg2dhNhYMW1AStqpeQFW8dV_3l6CSb5fZXWqoTzEDsH.1dB9ccLkZqNA5xhP
 6dTkGbMOtaRCqrU1CZ_gu7CPVG1tz9NuE_KVH.54QpqOCTekywFJkKoOUuJIjj9WwiyHknkMITzR
 pz793jbqAHlyj63Dog3CdBeK7O9kxFybf5gXrhREYIssU1Y1zgK2VM2jbSVT3DDn_CF7jtI56gLf
 W.w--
X-Sonic-MF: <lbj137@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 Apr 2021 20:59:02 +0000
Received: by kubenode518.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID fde5fbb76214693d09983a652a7d2adb; 
 Thu, 15 Apr 2021 20:58:56 +0000 (UTC)
Mime-Version: 1.0 (1.0)
Date: Thu, 15 Apr 2021 16:58:51 -0400
Message-Id: <1AAE8F6D-4896-4897-A548-56488B67E430@yahoo.com>
References: <981542164.79155.1618514760912.JavaMail.zimbra@efficios.com>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <981542164.79155.1618514760912.JavaMail.zimbra@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (18D70)
Subject: Re: [lttng-dev] QSBR urcu read lock question
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
From: lbj via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: lbj <lbj137@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

VGhhbmsgeW91IGFnYWluIGZvciBhbGwgeW91ciBoZWxwIE1hdGhpZXUhCgpTZW50IGZyb20gbXkg
aVBob25lCgo+IE9uIEFwciAxNSwgMjAyMSwgYXQgMzoyNiBQTSwgTWF0aGlldSBEZXNub3llcnMg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gCj4g77u/LS0tLS0gT24g
QXByIDE1LCAyMDIxLCBhdCAyOjExIFBNLCBsYmogbGJqMTM3QHlhaG9vLmNvbSB3cm90ZToKPiAK
Pj4gVGhhbmtzIE1hdGhpZXUuIElzIGl0IHNhZmUgdG8gYXNzdW1lIHRoYXQgaWYgY2FsbF9yY3Ug
aXMgY2FsbGVkIHR3aWNlIHRoZW4gdGhlCj4+IGNhbGxiYWNrcyBhcmUgZXhlY3V0ZWQgaW4gdGhl
IG9yZGVyIHRoYXQgY2FsbF9yY3Ugd2FzIGludm9rZWQ/IEkgdGhpbmsgdGhlcmUgaXMKPj4gYSBx
dWV1ZSBhbmQgb25seSBvbmUgdGhyZWFkIHRoYXQgUVNCUiB1c2VzIHRvIGhhbmRsZSBjYWxsYmFj
a3MsIGkganVzdCB3YW50ZWQKPj4gdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHF1ZXVlIHdhcyBhIGd1
YXJhbnRlZWQgZmlmby4KPiAKPiBJdCBtYXkgdmVyeSB3ZWxsIGRlcGVuZCBvbiB5b3VyIGNvbmZp
Z3VyYXRpb24uIEZvciBpbnN0YW5jZSwgaWYgYW4gYXBwbGljYXRpb24KPiBpbnZva2VzIGNyZWF0
ZV9hbGxfY3B1X2NhbGxfcmN1X2RhdGEoKSwgaXQgd2lsbCBjcmVhdGUgcGVyLWNwdSB3b3JrZXIg
dGhyZWFkcwo+IG9uIGVhY2ggcG9zc2libGUgQ1BVLiBJbiB0aGF0IGNvbmZpZ3VyYXRpb24sIGEg
Z2l2ZW4gdGhyZWFkIGludm9raW5nIGNhbGxfcmN1KCkKPiB0d2ljZSAoYmFjayB0byBiYWNrKSBt
YXkgYmUgbWlncmF0ZWQgZnJvbSBvbmUgQ1BVIHRvIGFub3RoZXIgaW4gYmV0d2VlbiwgaGVuY2UK
PiBkaWZmZXJlbnQgY2FsbC1yY3Ugd29ya2VyIHRocmVhZHMgd2lsbCBiZSByZXNwb25zaWJsZSBm
b3IgZXhlY3V0aW5nIHRoZSBjYWxsYmFja3MsCj4gYW5kIHRoZXkgY2FuIGJlIGV4ZWN1dGVkIGlu
IGFueSBvcmRlci4KPiAKPiBTbyBldmVuIHRob3VnaCBieSBjYXJlZnVsIGFuYWx5c2lzIG9mIHlv
dXIgc3BlY2lmaWMgYXBwbGljYXRpb24gY29uZmlndXJhdGlvbiB5b3UKPiBtYXkgcHJlc3VtZSB0
aGF0IHRoZSBjYWxsYmFja3Mgd2lsbCBiZSBleGVjdXRlZCBpbiB0aGUgc2FtZSBvcmRlciB0aGV5
IHdlcmUgaW52b2tlZCwKPiB0aGlzIGlzIG5vdCBndWFyYW50ZWVkIGJ5IHRoZSBBUEksIHNvIEkg
d291bGQgbm90IHJlY29tbWVuZCByZWx5aW5nIG9uIEZJRk8gb3JkZXIKPiBhc3N1bXB0aW9ucy4K
PiAKPiBBbmQgZ2l2ZW4gdGhhdCB0aGUgY2FsbF9yY3UgQVBJIGRvZXMgbm90IGd1YXJhbnRlZSBG
SUZPIG9yZGVyLCB3ZSBjb3VsZCBldmVudHVhbGx5Cj4gZGVjaWRlIHRvIGNoYW5nZSB0aGUgb3Jk
ZXIgb2YgY2FsbGJhY2sgZXhlY3V0aW9uIGZyb20gRklGTyB0byBMSUZPIGlmIGl0IGxlYWRzIHRv
Cj4gcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIGR1ZSB0byBiZXR0ZXIgY2FjaGUgbG9jYWxpdHku
Cj4gCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAKPiAtLSAKPiBNYXRoaWV1IERlc25veWVycwo+
IEVmZmljaU9TIEluYy4KPiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
