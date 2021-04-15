Return-Path: <SRS0=1TmG=JM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCD1C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 18:12:07 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167476105A
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 18:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167476105A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FLnVY32sZz1BB9;
	Thu, 15 Apr 2021 14:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618510326;
	bh=O/g9xw3mxgX7N4bFzSxk4ok68wV6rCA/RUoUuU+tNfo=;
	h=Date:References:Cc:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Q+aIVTAja9cNEwDCBluPcgsXgR9lWba4CVKbAg9oMTxOe5CgT4iAsUtiO7D2+HucZ
	 F+qlvwXdWX9njGq6ITUvSTsqaD7oiHgwOA26CyxfHfryBd6HQrpkTjzFaFKCQpG2BT
	 FakgPVqzuBAzeLGUuXPWO8JK7kqVBvqAD124VcC+yiYe/uWf2qFAqbBriGZA38Z6b6
	 Eke6K/NMn5PW4mXSQH9p6tpw9WOFZC+JeQ6icXMiYfKdEAZ/PytXWjTKNJTqGjO1Lz
	 GH1eAdpGnd41+l+oDFFEGCHtzQy69xctdpyTfG3DGwHmtrwfttUeErnPQP9L1oISDs
	 FBWtSCzgVMLMg==
Received: from sonic303-3.consmr.mail.bf2.yahoo.com
 (sonic303-3.consmr.mail.bf2.yahoo.com [74.6.131.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4FLnVX0Tnjz1BD5
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 14:12:03 -0400 (EDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1618510323; bh=2cWoQKE7LBVe6xoUx72z1GUcY8NVup9JWTFWcDiUhYD=;
 h=X-Sonic-MF:From:Subject:Date:To:From:Subject;
 b=T3T8C5MA8l+/+lD3vGf+E78cv2dKwcMLYkTqJ3pmBWs3vI14hcCVX2ok02NMyzOwWDwWWHb8xzfoA98M7UvSo8yzRJGfpSAHERECXBLJP7YsW0YThWAQVacgHlFLkofdG6im379WH21Pl28AZ76K9FvMc3dIz2+0p7t9tjrbdPPzBWgfHz92io6TVkNDlQLZTwmVF6K9NPq0YJIejoTC/3G8jIR2OIH75fcqu47L1SVZWQPz4iLKf0Hr9bcyy83USslIHWIRDKecVQpH5PPiZZzqiHNqnjiTaSlThReXnnV1Q+He3TW6yXxkwaKEtusdAtRfScquuTzCfpcawj2s4A==
X-YMail-OSG: zXzW8_cVM1mE0F4gKKV4NAiwfo2m46ORriMJPC_Yl5s_NWR40E4qIW3akX4ldrs
 jYaL1cl12C47JatCUf7xQ4clkUfLhvUxaMeduGnsCAJMO6Bkwh6hwxWhjdF7x.Z5lDTf8bIhnc6g
 ogkvSjnMGz.OjeXp_c0gLLZK4sLDDJYieSz5VtSsf85DT8vTnrTJHY5CUXqEPe8VEDNkv5SFB9ik
 Ta.2cs_Ne0ZkW7rEGO0Ave9mdZVdXG7stpRSnmNsowR4MP14fhnQ5YTNxQwZk__OrpkPRYjEiqnt
 MKV.jdmbJQX58V4if4shsbjYpt3Pfk5Ao3x4U2weXhTbgXFVhgtMeiUHWzRm63VK.ubfWQNVglA5
 sb3KmMVXH5Ur3sRY49t7f9vdkrCu92Pnla1Mw5gVuf3qGhCb5Pp73C.qpdoyfQKM.Cg87Uldt6nt
 wmGxL7B.ZfSMGTXNbYitO51rjpW3_sZeHDRNI7ikhEny3wna5rEMJcQVtiCrCLT5oQaNuXYhWsQr
 xF8x6InnCiZPigmXMLB9lBcjBpUU.wVW70KuzwsUrpkfmyzUXWZ26Kv7hOM7AiWpFj059sPEIcNS
 gD8_IhpYGQbBgJqjBH0WAWhznHv52ka9Ulxr1ksrFRTEeKidHxyOIdyIfMHNqrVsnZqTijkxjqJJ
 wRizC3RZgrdBt.uePRsOlPDaIhzMhl4Xgir8R132cQBObRsJcvRd72tO8O4QF2AnTbWivFA_fFLa
 PVKeR9pjIxwsoXMFJIM8YXIyJhixXF4yKOnfceFk6flA_Y8FOxW_9SdNH6pcgw4Iz55fZeBHqrps
 yQ_8m9TMI7Fr4yM3.3nXNjb0JQweHuPsiYw8krJUn7p4IqoyvIHN7WO4HDuXDac0i_A2BV7oNd0T
 ILTocVDSQUIkrOPJwvOwjPxdmkII61KHW.yn8_FyfYGbwtx8U8fIw79XxRq4Gw9NwXgVCl1Sy6SZ
 Dd22tkI2Tq8bo2x5Jh3DYoN4m.54m3TDErPyNeg5z6bbwQUblseMvbrogxZW1pkvpSuZMXN4WUxi
 WpqzhSs51rTf2iW1KlrMETxkyGao7UsNiz9aGGJOCHUl4cjoua_DVxvlZllT1p1qswoHWX11bvGS
 OOdGL80cHNVYrFgAgAt6dgZvcQy1T7SHKLOUBT7htJqCH2cZdx.QDVHDbyk7PLzPSVK_JCutsnLL
 tWPpu.fYouvRXIHK7nz_VA3NGnSLnSdCPiN4WCXtdfSvItFWUqZ232o6ZNuFhc0pEt1qKB3Ezerw
 AkI1U3cfkgHO.iiG4Spa79HNV5Z6cUb30Tbh0VKuY5qScBlhtL.5YoLHDm_D9EG8XbJjV_hp8.jw
 WdzC2UFTze95.KgcyYdgm4fU3QqaeexewyoAn6.eqjtBVsstOUFIpmoUrprv2q1cLvzKB534Vflo
 or5nBAAgENd4AjbvN2efNFzZYnU.95aoG8M1bjadrVWMY6OwB_kgdLPezrNMJcbL3DIS.30RaCXa
 QLolAK4ZUIJLbKr3jxHjYcy15BLFDpgjATVMA4w_ciNVZoP.581Of93epgfHTloSlfQCdTz7n4TI
 76YDqeneE7wOZpBYezZnpGlkP7LSEM1yvhAXVa.40GHQSPvnsqovo794M2nUd2REI3UQI_u1Xl6h
 X9dOO3dGjR.ZIKsSc6Wkvr_TUFkMEIBrR0GNmfJhw8NRmeCAg0tzY_Dv08VV6H75RpWbfZSGLuJB
 bM3uq5xc3V.PCTHk5A_5Qc1YCbxtqCEEU5puoPAWWmvZI7WYSzyqwn9MaW1CRcXoFG9y3JYnWFa6
 tqc27QIGrdLJ_NKrmVtarQuZtmNc57N19zZdfcp_CotjtbVxhAA9sp_SB3jqynmYzcBcuWXTEcgv
 cgaPXmRMGK3qpjtnQTcPLcWh8F4lJYZ5MInq6VAf3MpPIPsIl5T3LwsN2pL9R4mZaF0l2oC7ca1Y
 9_OOVwXBKN6xWZ_nopVY_Mzrcfx4E.T5Bgg_j1Rv9UJ65Y7TIcmaEJFyDSe.7TMzjeUQRdtJI8Jo
 OEOKpgya3vagYOy4l6oupZ19jHKR1XbLbBRc3j_Z9QQC69F4ABEDTNQhfqmbpbQAsocOTXNw5r2h
 iMvqIUCrSpcV67dLREET6BLccfdxMyRlabz619VcXdYA5S4EJSldtdAZ0vzscPM9gtJvPSlyqUx8
 GL.z7WlCh9AhjqOYDtyQBJdEq530FoWgbk9DN.tzdY5qM6W0Mg_Fc4qEPoFu0TohFURjM.ctHDGQ
 bjhx5u9Uj861qvuAQ.A6MC9pBRnzSdV2zxtxShoa8P3PsE1GzsPY6iZBjx_9y5QjddautncOT0WT
 l2AAJ9l2KhwWv8jKqoO.ZbtDm63SOP9b_24cPNYYtJ6lGre3_ichn.hfFL3mPVonurk0fXOVhaRE
 I9Xycpcgm8sKBv.Hqk00r.tZGyoKPf0uKDWMVjBYxacFUJabLl3QPGsZGPfTyji5uf9bQPMzhTVj
 9liuPsWPxKDfr2BgWpz8O_QuEVRlFsSv3HKR.SAX4G.OOTsEc..tGbOeVsd9eSZoCT.UihlxV5kQ
 PBFLXbkN42YnBOFug0Iu7S9M1K1G16NjgxW.flES3EdLsg1WxMdIGSQY.WKTJMSYdH_OyZLXr3m_
 LeSY4MS2svIu2..6A_BxgcnxNhp81O_92O73x.hYNFYUvmdHDoLeY6CICcARONdN3kJa7W6lQENw
 -
X-Sonic-MF: <lbj137@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.bf2.yahoo.com with HTTP; Thu, 15 Apr 2021 18:12:03 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 0e509e6b1572737807dffda4bcc8959e; 
 Thu, 15 Apr 2021 18:11:58 +0000 (UTC)
Mime-Version: 1.0 (1.0)
Date: Thu, 15 Apr 2021 14:11:57 -0400
Message-Id: <D6D81B40-920B-46C8-ABBB-9AD856F0D949@yahoo.com>
References: <219280299.78204.1618502428396.JavaMail.zimbra@efficios.com>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <219280299.78204.1618502428396.JavaMail.zimbra@efficios.com>
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

ClRoYW5rcyBNYXRoaWV1LiBJcyBpdCBzYWZlIHRvIGFzc3VtZSB0aGF0IGlmIGNhbGxfcmN1IGlz
IGNhbGxlZCB0d2ljZSB0aGVuIHRoZSBjYWxsYmFja3MgYXJlIGV4ZWN1dGVkIGluIHRoZSBvcmRl
ciB0aGF0IGNhbGxfcmN1IHdhcyBpbnZva2VkPyBJIHRoaW5rIHRoZXJlIGlzIGEgcXVldWUgYW5k
IG9ubHkgb25lIHRocmVhZCB0aGF0IFFTQlIgdXNlcyB0byBoYW5kbGUgY2FsbGJhY2tzLCBpIGp1
c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBxdWV1ZSB3YXMgYSBndWFyYW50ZWVkIGZp
Zm8uIAoKU2VudCBmcm9tIG15IGlQaG9uZQoKPiBPbiBBcHIgMTUsIDIwMjEsIGF0IDEyOjAwIFBN
LCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90
ZToKPiAKPiDvu78tLS0tLSBPbiBBcHIgMTUsIDIwMjEsIGF0IDEwOjU0IEFNLCBsYmogbGJqMTM3
QHlhaG9vLmNvbSB3cm90ZToKPiAKPj4gTWF0aGlldSwKPj4gVGhhbmtzIHNvIG11Y2ggZm9yIHlv
dXIgd2VhbHRoIGlmIGluZm9ybWF0aW9uIGFuZCB0aW1lbHkgcmVzcG9uc2VzLCB0aGV5IGFyZQo+
PiBncmVhdGx5IGFwcHJlY2lhdGVkLiBGaW5hbCBxdWVzdGlvbjogaXMgdGhlcmUgYW55IGhhcm0g
aW4gZXhwbGljaXRseSBjYWxsaW5nCj4+IHJjdV90aHJlYWRfb25saW5lL3JjdV90aHJlYWRfb2Zm
bGluZSBmcm9tIHdpdGhpbiBteSBjYWxsX3JjdSBjYWxsYmFjayBmdW5jdGlvbj8KPj4gRnJvbSB3
aGF0IHlvdSBkZXNjcmliZWQgaXQgc291bmRzIGxpa2UgaXQgd291bGQgYmUgcmVkdW5kYW50LCBi
dXQgcHJlc3VtYWJseQo+PiB3b3VsZCBiZSBoYXJtbGVzcy4gQ29ycmVjdD8gVGhhbmtzIGFnYWlu
Lgo+IAo+IFlvdSBjb3VsZCBpbmRlZWQgaW52b2tlIHBhaXJzIG9mOgo+IAo+ICByY3VfdGhyZWFk
X29mZmxpbmUoKTsgICA8LS0tIGVtcGhhc2lzIG9uIF9vZmZsaW5lXyBoZXJlLgo+ICBbIGxvbmcg
d2FpdCAuLi4gXQo+ICByY3VfdGhyZWFkX29ubGluZSgpOwo+IAo+IGluIHRoYXQgc3BlY2lmaWMg
b3JkZXIgd2l0aGluIHRoZSBjYWxsLXJjdSB3b3JrZXIgdGhyZWFkLiBOb3RlIHRoYXQgdGhlIHFz
YnIgc3RhdGUKPiBvZiB0aGUgY2FsbC1yY3Ugd29ya2VyIHRocmVhZCBpcyAib25saW5lIiB3aGVu
IGl0IGludm9rZXMgdGhlIGNhbGxiYWNrcywgc28gZWFjaCBjYWxsYmFjawo+IHNob3VsZCBtYWtl
IHN1cmUgdGhhdCBzdGF0ZSBpcyBiYWNrIHRvICJvbmxpbmUiIGJlZm9yZSBpdCByZXR1cm5zIGNv
bnRyb2wgYmFjawo+IHRvIGl0cyBjYWxsZXIuCj4gCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAK
PiAtLSAKPiBNYXRoaWV1IERlc25veWVycwo+IEVmZmljaU9TIEluYy4KPiBodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
