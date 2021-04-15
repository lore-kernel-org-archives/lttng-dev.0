Return-Path: <SRS0=1TmG=JM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC3C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 12:41:21 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F8D61166
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 12:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F8D61166
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FLf8v0tXBz19wT;
	Thu, 15 Apr 2021 08:41:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618490479;
	bh=W/sN+9qajhoh6Y5XoZ+XKRRpcWlypUgvXB7ELjYunDE=;
	h=Date:References:Cc:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Fd/GMyZpAtvfHC68MmZS0LTVw+crlJxsg7NPA4cakyy6nj7p7BlBMrSN1mSMIrxTi
	 Wl9LFF4ijHKn8hmBhjp+CnRAbJgNhw3sTLXGVjgKPoVXD4jpn2LZAoKUtWRVVdA72V
	 xnnvTOWM5K1IVim+GtzMfkoQO2TGl5u/tj8X/8QahNS5LdV/yanpoj7YqTlCFcOgkM
	 tzUV1SeNOXwljaFqJjjKij+MpSUlR/KAu9UIwCQwCwTKE2pi8X3KtKoqNgmPKHxaef
	 wmIyHPGbf/bBPWGDVzBd8VB3zOIZWaLVAaMPDto9ZhQ1k2cOIlyFsDB64oEri4l3bj
	 +cC8jOS5WFgEg==
Received: from sonic304-9.consmr.mail.bf2.yahoo.com
 (sonic304-9.consmr.mail.bf2.yahoo.com [74.6.128.32])
 by lists.lttng.org (Postfix) with ESMTPS id 4FLf8s0Ftxz1B2C
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 08:41:16 -0400 (EDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1618490476; bh=Evd4SoGrqNE+VjWEHBpmj+UWYQGI06QW4C5VHIzfj13=;
 h=X-Sonic-MF:From:Subject:Date:To:From:Subject;
 b=UN6lyo/hKQB8QwaHo/tM3HR9iBv1JrrUEwllSgFoLOHU7CgesTQrcUmkemrsjv1Z3YXr6QafNnxw4nY2baqhdxMP55WvUWH1JTP6YM0p+AG5crxRASzjIBQH3VCcYV2Fu4+iy+mdl9yZm3SPaeYn9yp/1H+LNLsUALgOqWgOT2l5ADqejUZw0RtNXNtGGTWaZQR6GSEXjqMF3M/AnefMEr7xDMPZJ4I5HgKojb8SpJcKkMS3VfPzvnRut6WPc2LVCeilanUFADktuN0cpi/0PdrhU4bJYZNQVIEZEETBv119yZyjM7t8g2Sc3FcgYwrtyvcIAdUpf1s5aGE87TsCmQ==
X-YMail-OSG: 1WAOJJEVM1kSQ10asu9yzinXVVdProHGCXUSVZ89Q2TbM3Pxh3Zmv_lOlSc7Hnz
 KDbqDGXdYWRO5772ASfhVzOv6pG6rMsGJKuEyi3tfMm4m.ZvFN2EVYn7m_p8DV_jf_89_YxB.8FP
 oowiK_c9H2Eq.3LBmmO_caKDACk7SMZOXXt.4fk9KlkkFex_niTZHuT9Yd4lTCt4CwwHW4yFtlNY
 284JTUoDniClQ9LpQl9e3.6CAKerFjb053pPsKIhZCgJBTVaaLaiSAbH7BGLXhS2YsDHkYkEBaBH
 bx4SfdxWui4kbjeZDSFdJrqO7GuUDdJBVVaDjgVl2ml_xAo1j0WTuC0napogqzrW4jkUnpTSPEbv
 spmTyM1GCl96fVClWpiRkIEVmaPeXSH8P8W0XBAdWGG.oBysDR6tRGgY3LgnPBhnM9WbtjDh1L9d
 zjv4GE2zgaQypGD7d_6qBABVB1vrtS3RDQw3JkRjeR9OLH_zqy6RbKfo1WolavRDnuCe6vilDsXi
 l.FHVgqDuXAy8PprZyw.zTsKt0E2GHLrXlX_05ZKqdI6u_agGdNwJM1NAT_mO7mc4lIm_vDPOrjB
 U2XLE_ZQmpgpM_jTpXjcpmLxbHU4ayovtCevR6Eu6pcKyAuYV7hRIKU.d92.S0c5hUKsl0gxuNSZ
 goq8LpymPvWMX9VbHjqJeBA_T35m6KAUJm65Z6CIrK2ghFrm7ExnGvIlUcseOQn01s_nTnwUlVAz
 F2sSN2Fuze1edt2r40jLaPUo4QUGZFeWbSYQQZIyIXmzIZ49FJ86IWzKCx6otDzkIYbeo02D5Jbc
 prgmoJyEgRE3.ATV_w9w3MOR6uAm_KY53Cng_nZ6aCvEELHiedoabcoZcQ8BTor9qX0WSlASkz8W
 4pAeimFtY3Ujq8Yk4N8TkTYaF4GHuZSTzBpsxMRvVIkEI3tG1bbj0JapVgCDA9IW2EtWf3o8PdmX
 vvL1MezOTTGGcFS1T5HP7PkorRY3C.NvMCljqCI6uRMFS2D35KL89FYYj0Y.oitZBXcqWeo1M3e8
 _N97p63hBAEUneI1eGVdX2rF3zcqIER_cEhVf1ZBo3wA3XoIboiIhpMToDEWfJA68rF8zuzImwoI
 Qdeq47lb8Q0xnxcoS6GDdHqe8l.NxTzUr1QX0Rb2cNoXwuTf6eIaltDiyRtT7P.kqsWIgQZGBYnC
 nxViPtP_J.g_WP_mUU3wjnDJS4QFm_bm0kDI2O.jq6qbEgD4S2WbRTjle5VXwwew99D1B3teRWk8
 VEfut.hoQ_msB7C3e4OwXhcgfiu_Vhexzuk.AD8Y62MidxW.kN3U.tuDio4LrORQQoIvpIiml69M
 AZkIR.uJzF_fnex0FHiePuu_0MD1R4Z1xTd5UX7ETmxp.xaW0RnEYVFaAg2YHGBxPNETBD.BsZEi
 eeQP89TxWrHKLdQU9idWNoeaFAT552sM0lGVvRZjotZBhFweQOPJGacnMB2ceiNlQoaMVGHjhL1g
 .k6vg9wXx8i56agL2YclofNAehi9DyxejkBQDGna0PYtdrqYxdD1fsEq1pvxGkJhHlsL6Om4vaAe
 yEKCCyxbcobf5I0bgn5RfmfQTtWPK06R8b6GjncSUu_IRoi_cODpjU9HXwlcg2CSd9laMVUjxNLn
 FVBdsG70_2Mln8RBWm5vT7zFIuXQQsmR5qBjOcabNS05lkULoyNpRYQ19GkkRM_bM2S92bMrylJN
 njFPahT53cEbYWfP2isL7KBt0Axs6YQ0LUt6lNAUFRw879_LRnlwbMKi2wxT4tCI0qs.iq1yReEg
 VUn6yNccpBAYTdMxjBeP4u2EcRIXCkd87APvn667esQ49z9bcKmT61.kfjG3nyJMaIn8NgpWv4xx
 GawOI3sagmcVpHSY9fbAlLQkHbnGxntVK.jz8oA1hj4YWAyhmnQPIppLb6ysScrjzF56EYIu9wgM
 .zLBz1Z930AF0P7fFKKciBIV1pmfjpyCjF3pDz84H.x.tepYxR92ggz.5bLNvuDfE8ImHoFWjZMb
 j9IwamAKTQ4.wzY53orHoD0dOk4_imRScHKJ4G_X2f5O2nJ8kFdDoRzo7HdbWRsiC2d7iXhPdF8r
 iLojMycLpM5of75tLGQZoaavAJTVBjjDsSN0hDdiJU.O3uLn6dLot2bl.fh63HgtyhL7EJwQIaS2
 IDJgzBKHHWyNYlJjrFJNk9HOdgN8i7wFWOgfJWN1g.JW5XwFJR5zW7htwI0QfhoUP6T2biQYyPhi
 tIM6BsQrKMkZNbvIZ.dAt6EvGSmaZ9R9zab1RPnq4.rQfJ5LOsCMbQMSR8.9Ob5MJmIqO..Mj0..
 rrZXCMU5y8oO9sVGwHw1fDHVEcugyMYbyTTKBHhBXk5Qsa4AgVeFtlFU_uJiuZA5TGUK10A5irtt
 sMJikfahz1MMUuKk2E.sYvefhc56ua0FnPm1HQeyh.eVQMT2UCsZ9ITDIHxC9O1GVipn7nLkV_3m
 ltEOxMhaXxoGAWuMDI1OGesFkR1kzKLyvp28fKStSzbfXntblTiPJdnKl9dUANxDC8qPV7.l58zd
 bbhnmnUkbHP0C9SidGKlsUrdSzVaVTthzw9IiqnDXZZAgeANjPVof_R.gbFLnSIq3MdYVishmqpw
 kMyeHLnrq_VftfZzifdt4AcioC2O5v66pa8dO3KekFJ5kisfY8b_NIcv1OFvs48ldeXQ-
X-Sonic-MF: <lbj137@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 15 Apr 2021 12:41:16 +0000
Received: by kubenode567.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 096608061b0d310361e7f800dc24cb7c; 
 Thu, 15 Apr 2021 12:41:11 +0000 (UTC)
Mime-Version: 1.0 (1.0)
Date: Thu, 15 Apr 2021 08:41:10 -0400
Message-Id: <EDFC028D-682A-433F-9FBD-59617058829D@yahoo.com>
References: <1791312961.77601.1618489242390.JavaMail.zimbra@efficios.com>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <1791312961.77601.1618489242390.JavaMail.zimbra@efficios.com>
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

SGkgTWF0aGlldSwKIFdoZW4gSSBzYXkg4oCccmVjbGFtYXRpb24gdGhyZWFk4oCdIEkgZG8gbWVh
biB0aGUgdGhyZWFkIGxhdW5jaGVkIGJ5IGNhbGxfcmN1IHRoYXQgaXMgdHlwaWNhbGx5IHJlc3Bv
bnNpYmxlIGZvciBtZW1vcnkgZGVhbGxvY2F0aW9ucy4gSXMgaXMgcG9zc2libGUvcmVjb21tZW5k
ZWQgdG8gcmVnaXN0ZXIgZm9yIHJjdSBhbmQgdGhlbiB0YWtlIGFuIHJjdS1yZWFkZXIgbG9jayBp
biBzdWNoIGEgdGhyZWFkPyBUaGF0IGlzIG15IG1haW4gcXVlc3Rpb24uCgpBcyBmb3IgcmVhZGVy
IGxvY2tzIGJlaW5nIG5vLW9wcyBpbiBRU0JSLCBJIHJlYWQgdGhhdCBidXQgZG9udCBxdWl0ZSB1
bmRlcnN0YW5kIGl0LiBTb21ldGhpbmcgbXVzdCBiZSBwcmV2ZW50aW5nIG1lbW9yeSByZWNsYW1h
dGlvbiBvZiByY3UgcHJvdGVjdGVkIGVsZW1lbnRzIHdoZW4gSSB0YWtlIHRoYXQgbG9jay4gCgpN
eSBzcGVjaWZpYyBzaXR1YXRpb24gaXM6IEkgaGF2ZSBhIFFTQlIgcmN1IHByb3RlY3RlZCDigJxw
b2xpY3nigJ0gb2JqZWN0IChqdXN0IGEgcmVndWxhciBvbGQgQysrIG9iamVjdCB0aGF0IHBlcmlv
ZGljYWxseSBnZXRzIHJlZnJlc2hlZCBhbmQgbXVzdCBiZSBhdG9taWNhbGx5IHVwZGF0ZWQgYmVj
YXVzZSB3b3JrZXIgY29yZXMgYXJlIHJlYWRpbmcgaXQgd2hpbGUgc3Bpbm5pbmcsIGFuZCB0aGV5
IGNhbnQgc2xvdyBkb3duKS4gV2hlbiBhIG5ldyBwb2xpY3kgaXMgcmVjZWl2ZWQgd2UgaW52b2tl
IGNhbGxfcmN1IG9uIHRoZSBvbGQgcG9saWN5LiBjYWxsX3JjdSB3aWxsIGV2ZW50dWFsbHkgbGF1
bmNoIGEgdGhyZWFkIGluIHdoaWNoIHRoZSBvbGQgcG9saWN54oCZcyByZXNvdXJjZXMgYXJlIHJl
Y2xhaW1lZC4gSW4gdGhpcyB0aHJlYWQgSSB3b3VsZCBsaWtlIHRvIGl0ZXJhdGUgdGhyb3VnaCBh
bm90aGVyLCBzZXBhcmF0ZSBzdHJ1Y3R1cmUsIHdoaWNoIGlzIGFsc28gUVNCUiByY3UgcHJvdGVj
dGVkIChhIHVyY3UgaGFzaHRhYmxlKS4gVG8gZG8gc28gc2FmZWx5LCBwcmVzdW1hYmx5IEkgbXVz
dCB1c2UgYW4gcmN1IHJlYWRsb2NrLiBJIGp1c3Qgd2FudCB0byBtYWtlIHN1cmUgc3VjaCBhIHNj
ZW5hcmlvIGlzIHJlYXNvbmFibGUgYW5kIGF0IHZlcnkgbGVhc3Qgbm90IGNvbnRyYS1pbmRpY2F0
ZWQuIFRoYW5rcyEKCkplZmYKCiAKClNlbnQgZnJvbSBteSBpUGhvbmUKCj4gT24gQXByIDE1LCAy
MDIxLCBhdCA4OjIwIEFNLCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZm
aWNpb3MuY29tPiB3cm90ZToKPiAKPiDvu78tLS0tLSBPbiBBcHIgMTMsIDIwMjEsIGF0IDExOjE5
IFBNLCBsdHRuZy1kZXYgbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyB3cm90ZToKPiAKPj4gSGVs
bG8gYWxsLAo+PiAKPj4gSSBoYXZlIHR3byBkaWZmZXJlbnQgZW50aXRpZXMgdGhhdCBhcmUgYm90
aCBwcm90ZWN0ZWQgYnkgUVNCUiByY3U6IGEgcG9saWN5IGFuZAo+PiBhIGhhc2h0YWJsZS4gSW4g
dGhlIHJlY2xhbWF0aW9uIHRocmVhZCBmb3IgdGhlIHBvbGljeSBJIHdvdWxkIGxpa2UgdG8gdGFr
ZSBhCj4+IHJlYWQgbG9jayBzbyB0aGF0IEkgY2FuIHNhZmVseSBpdGVyYXRlIHRocm91Z2ggdGhl
IGhhc2h0YWJsZS4gSSBkb250IHNlZQo+PiBhbnl0aGluZyB3cm9uZyB3aXRoIHRoaXMsIGJ1dCBJ
IGp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSBpdCB3YXMgb2sgc2luY2UgdGFraW5nCj4+IGFuIHJj
dSByZWFkIGxvY2sgaW4gYW4gcmN1IHJlY2xhbWF0aW9uIHRocmVhZCBzZWVtcyBsaWtlIGl0IG1h
eSBiZSBhIGJpdAo+PiBzdXNwZWN0LiBUaGFua3MgZm9yIGFueSBpbnNpZ2h0cywgbGV0IG1lIGtu
b3cgaWYgY2xhcmlmaWNhdGlvbiBpcyBuZWVkZWQhCj4gCj4gV2hlbiB5b3Ugc2F5ICJ0aGUgcmVj
bGFtYXRpb24gdGhyZWFkIGZvciB0aGUgcG9saWN5IiwgZG8geW91IHJlZmVyIHRvIGEgY2FsbC1y
Y3UKPiB3b3JrZXIgdGhyZWFkID8KPiAKPiBBbHNvLCB5b3UgYXJlIGF3YXJlIHRoYXQgUkNVIHJl
YWQtc2lkZSBsb2NrL3VubG9jayBhcmUgZWZmZWN0aXZlbHkgbm8tb3BzIGZvcgo+IFFTQlIgcmN1
LCByaWdodCA/Cj4gCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAKPiAtLSAKPiBNYXRoaWV1IERl
c25veWVycwo+IEVmZmljaU9TIEluYy4KPiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
