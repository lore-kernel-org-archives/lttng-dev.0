Return-Path: <SRS0=Pen4=JC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF14C433B4
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Apr 2021 22:34:09 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0F361359
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Apr 2021 22:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0F361359
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FDlnW2TPJz12fk;
	Mon,  5 Apr 2021 18:34:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617662048;
	bh=0cViZse0E3A+LMOSyUiS0Wp4lAoxBkUeWDCEouDz2Cs=;
	h=Date:To:References:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=tdVdYjhmmHTKwgm8HcUOz7xp8hA9mSPpPDgsRkVNiY3hnCJSrmd2ZaZVbU2HjTEYX
	 H2/hpQaq9JGI8hXNEsTG9ixQalE+pBW5f/AIyfFPzHliywMDFWqvIe5nUjm7MWlp5z
	 U8yubbjqOb8QJAzd2nB4RLW3XM5GoLLFocY14MXtUa7CijV0rNvDSVVqjsbfj62Q95
	 QsFc1tkWBCQ2E1jnHjgJ3GsebYPyCLub+kIBjN6oR55mDWALgyQOk/Hk5Vn3yJJjvK
	 u9XgnfU3pTVOcJ8y+mx8oaabSw3YQjFBf6Oxp//lClKdcys4TAO+ONtfrUDbytI6p9
	 sSDV0oIuzy7gQ==
Received: from sonic310-14.consmr.mail.bf2.yahoo.com
 (sonic310-14.consmr.mail.bf2.yahoo.com [74.6.135.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FDdLX418yz12KW
 for <lttng-dev@lists.lttng.org>; Mon,  5 Apr 2021 13:43:48 -0400 (EDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617644627; bh=7FYVQ0RzYimRToRRzPQnCaZWsLgAux7Us6IjKLWGjrS=;
 h=X-Sonic-MF:From:Date:Subject:To:From:Subject;
 b=nRUusI+6RQMJjvYFry1s5sFdjsFHFNqY9ao7QofD/x6uKTb1g7Dpi0vcmsoToHIB38QwfxPQMO9taKnza5g5v1w2F2reDNqfI6qZBWZei/9TghF8VnU2i8O6aqr2cjn1dQqpMHpmIfrPMJa3/9TYNIn5SCp1y38cB4ibKC4laMAMY2hVdGuRF0yVp6YWr41riuI4Whoow3pX1ktOuYhwjMRVo8SrURv5+hA8tuq6ovy/2t7nSNGfdcjWY6hpywCEmF6a4wuGKEu3MghaOZ0aT1oRm6DivRD/cE04d1jPFUMdNZCHFCm77QCxNYbuzCdL+4KfjbtYNCrmPz9wcztnuQ==
X-YMail-OSG: SENZ1uEVM1m.uN.3bpl.8IRw299CbIY_SFIYuMc3NsuyzZRWPlBIQ6rMQJ0A2sv
 dTbSzdMaOgqT8fHY4MNMewjmlE0GVv6krcBCtuhtEC60Klt_Ing_CkLzyXwfqRr86H.ERSG8FFTu
 ZJ_MCgqVfvCHuW1wiIjgKnDrVnFEXUl9X0pgRailBbD3jBLPc_tX.ZUA2L7YGafHPgUfiuMlXcH0
 0wO.DYmvaIqlNpASi4AhHqyiFZIIpJI15zOyCKeC9LitmOb5rDEa35T5DJeo_gZIwBxp98t8QATs
 2fINgHGKH5udoaR0SNUKLcXnbvCsc02chcoshyfD8_jJdfoSJZXDi45sdqRb_j_HLlQKISOGYi1u
 JwqgXiChowGDRfc35FltH3YUx9lK_UNcP2.n_cl7Fj4NjYKmsb7.NL0_ZPTgseO5sbzqJDywWd2W
 Bp5GILYZtnn70V8e_J9UZtmMDT16bbclOeMI6Nu75n4ipwJbulxZfcaTbdGpOn0L2k_mHhS1y0Rr
 GXFxlCktCIRzg601r_d5XVFxDcxN_zIj12xEYe9wylJvNOopFBYhE0qyVaeCtVz5lNBqQ_bsd77U
 pbziXE4U_VH0Z5xcaHiw0oInAtPhSvErV6mQvrPBjNqeSUDcj_hChjzgzmT51EhoF9wwkWsdBZXf
 bFF079ToqI1mKx48RJ1xJ0lkS5BqFzksx55fZ.WuNJCJTj2q.rf_Fq2gNWJEZx3HFxfbAOB3TnyX
 anBRjJN.YdZEeogVZhoX5bPYVs_5u7hZ5XnQtbQFcugjDeYK7kc6eKyKkerZVTvckjdpiZysAag8
 RHzq9aYdjfKEwyb1QBP4G.FzbijOV_1t7SGKeLXR9oAdapS3zsdn7NwwUFdNgu6ReCHoPFCearxp
 MBEFPw7.hHfxMa3L2iQLeyG0MtE_Ukt3NsxEkBS41LwKjyhPCxBIWXmN09v5xoWmoOPx1sFZ5x8r
 AlgQf_YpE_gUtj2cm0Z45jFoAP74d0xOa4FsRs9cJNTkv95KaYZRe0hXSnz6CITSyHn9WtwurEuS
 ns_4fRPnOWkiI46NL9BHhl8eUE7hMdC20LTgR2Dbx.R9qIf8bM6kAHB4mf2GLtm2W59lMtGZf0S7
 auJb.0prprhryCX9ovZUgl16i2zMKRX6f5eot7NCX0Q5V.LdI16n7BaMmKgjWP5uGAWCpejlegZ3
 ylSptKuTfhOub_wVOQ2WRYcRJDIkjs64C2r2UDOygh3fBxrObbAS9by0nkdtXl_Qzq6A.OVHFOP1
 iPefoqQgVNu.I0mf0GW5jO45vT9jRaAqe87lSbpkR34xKX_fuTwMupXQwmDSN.1Q7_ph_T1_8_20
 BtoV.vO013j5B7wqWq5ADDKcFLPIrxmanHtG1fCdZid9JL7AMzrtuXcUzq7v0Ycb4nE3oWYafpdi
 lV7VuI1YdflBD3h.yHmzD6zgVHrLVgnFJS0Nr58jLHgBCHddAaIWjdLJdG7rX071By.nzFBDINi9
 XBrcjsrS.BzHLRAEMEl6BMAaeS96fFv3L9rMTiDT6m6WB9o4CzwL9IwTJ.Vq7LevM3ZgG1v249Uy
 N1AGYkqACFFJFYhGTGV1aUX6cQD9g6XKChHhQrS1COAKMTklOLSdPWeVknaQlVdTp399eVCT3.YZ
 BL1IpxjeBdPj5qBv7JhyqePPNec3ltmiiemzx5sCMYunBP_JinkGhdcEvWOHNhfwXDZSv4eV00pc
 OReUbeV7nb7XntKWr118dml2Ezm_XDqkm9WMOaKggZpesOkkhV2hyoo4u53QnqYsw1BbASiMe35R
 n4bmNS4yrlMiVhjGFK9zkuYPVyyaCkY8tYMxbnUZwYPAO4Dm5YiWRxP4lRL0NMsPqhhPxPQ78B46
 LtV98pNjTayJslRk6A8d9AdCWfxTXq4LLy_QlqNy4XHCpRLTQ9PazA4wtfxJ9iuDpVP.O0gkoOvT
 WJ_VdgPaq.5a9Y4dSymU51AnhRcZRrj8DBwe2SUiyY0bV.LapLl7kOkmUUFk5q6TLBY6_6sit0PS
 pWVWjyvt7hOFDSU4MUqqSAbc_dmNT3vcmgod.GoCdM4ncs5vf04TWifiD1IAOEbR2PHBFTVlZVTx
 zyoe07zrM2wD9I9r01WMfzi3AWW44QOvPbzl2e_lqA6RoTdptmP_pu9wtdKJhSXQoqtmwXGt7GlT
 MMDyIMaNLKrd3j21CZB29LiEsYS9UNJu4RiCuHLAoDNDARXhhp8pH8_Ndx422g.TJXYWCB8hDLTQ
 L8UQlbNwua15dkSL3APq0LFPQRZu7yDwo3BQZchxl2DIOHUTsI450it_fNxrfuSOqWc.zFzgWN.v
 GIboki209vzbUGwLmpnhXSDLNliKCzd2MEjtuPv6.yEt.MKxOBScvcEceZzlJVt7.5gVpf8dmGH.
 MmpuYwl8_gZUsDme7o3Sf6MDxp5sXMSri7BEXiGoEpJBmso8cW7d1RJ5I1EUGAU7akITBsmigwa_
 psjw-
X-Sonic-MF: <lbj137@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 5 Apr 2021 17:43:47 +0000
Received: by kubenode507.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 64e38690bdd6ca285a4cc6084ad4b89c; 
 Mon, 05 Apr 2021 17:43:41 +0000 (UTC)
Mime-Version: 1.0 (1.0)
Date: Mon, 5 Apr 2021 13:43:40 -0400
Message-Id: <13D87E55-7D1B-49B0-9555-656A837ADEB3@yahoo.com>
To: lttng-dev@lists.lttng.org
X-Mailer: iPhone Mail (18D70)
References: <13D87E55-7D1B-49B0-9555-656A837ADEB3.ref@yahoo.com>
X-Mailman-Approved-At: Mon, 05 Apr 2021 18:34:05 -0400
Subject: [lttng-dev] QSBR urcu question
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


Hello all,

I am using the QSBR flavor of URCU and I have a question: is it ok to call rcu_register_thread more than once per thread? Similarly, is it ok to call rcu_unregister_thread more than once per thread? I am using a library that uses a threadpool I have no control over. A thread from its threadpool invokes a callback function of mine. Threads may be reused. I would like to call rcu_register_thread at the beginning of my callback and rcu_unregister_thread at the end. The thread in question may exit or may be reused at some later point, I have no control over that. So I want to make sure that periodically registering and unregistering the same thread is ok. Thanks for any information.

Jeff
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
