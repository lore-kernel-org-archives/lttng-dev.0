Return-Path: <SRS0=23sV=JL=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2685C433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 14 Apr 2021 03:19:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED92F6113B
	for <lttng-dev@archiver.kernel.org>; Wed, 14 Apr 2021 03:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED92F6113B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FKnlC5Yqqz18pQ;
	Tue, 13 Apr 2021 23:19:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618370376;
	bh=8GqhaWBeY/SIXE0Sd+v+Hv/ay4ds2hoICQzWAGiN1lE=;
	h=Date:References:In-Reply-To:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=FyRymwR/lDJQxBUHYwNLdzU+7hiSJto+ulqPv3HGb5En3CHCBIMNpMlYjpfBxeSQS
	 qMvCIWZ6ISMcFumU2RQLczJqWUH64ouHcYjj3DA16FaH7fh3p5BpV9TH4GSCcchZYk
	 yOfzIkdLh8LyZWqxBJbLYxK43VDGKApWSlik1qGyKQ2kVUysV8SRdz2z0GvlJc1iRl
	 f3myZuWnBSQPhe+WluOpGjULRyyjC0ah7dca4u0NIHRHqa9zXe+iBV92aWOxtYJF55
	 Qe7usKiJqRSubfgLh3LFkp5PRUn11J/K7bR6gWLkcSup5WZxup7qykDIFoESbfr0AP
	 yDEyx9jHNNECw==
Received: from sonic308-3.consmr.mail.bf2.yahoo.com
 (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4FKnl96JzXz19Km
 for <lttng-dev@lists.lttng.org>; Tue, 13 Apr 2021 23:19:33 -0400 (EDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1618370373; bh=oBwix5F9htaCmTQWeRRu3hbGj5Z35fT1v62/+l+qEcb=;
 h=X-Sonic-MF:From:Subject:Date:To:From:Subject;
 b=rRkSuI3LgNSwtEUgy0/7dHAX1U04Khrt6lf6SGZwZVXlUc/6WidsAsoXZi9yiEEJA4oHu7ZZcWjHtSB67DZ8rGDHOXls+pyNgurkRxBltgqneCc6wc1fQixOjWNDiCwCvfvNIbFzc8kgpwvPMjW9K4EFCQ7YRFWy71wuuCKO/PTthbnRxtNUcJ6VAevBePx4jb2d41ZSrnKc4F+ShzQLY2SO02wNLDcAk2PpzhPHzZ3DkKAGLhi0j3ajVO4XDKPzZO06YloEYfmHLOQVtSlAVUJ2y/po82dNl6KSTwtP0GH/S/U0hqM/CHPCtCE9dsHhhK5M+V9tmmMrtZyDhLuhug==
X-YMail-OSG: Xij6vPkVM1lQqhgRP4dc5r7ykAGOHHlOwRW4f.Yvfi4mxiyzyTxp4WRDM2Vchci
 3w4iSqGylw2QtkXV4eUtjXfKaO8NoR_1.aykGKn8l4GUp5NZguuhjMsLpzOjJJcHTp1B2iC9PJ9r
 0ZnhjUZSQrZ6vbUGYIhR_fkWhLsWj5Per4gWPOw98EzqSWo.xvcR7lUYyRrZTT5VbOnxPAOAkTOh
 ycm5P7CJy7e1oKPsEmDfcEpichuvJsccky1j_rCemuen3F7jczUnLfze10ePj3S2I1U8fr9UvDhR
 HWF0DFIpBnLKIpu1yLTFT.fYirEDdN5VCnDYzoiKQc.bZpDSzpAdZWS56Yw3ZzJ5NRecSvx.Sktu
 _LMC5wNXfbn3M6GHoH9mCgAp9Os0NysCm42T0poC5Vj6CWXpjInClWc7y2TSV6qguLSQIumkVRX6
 agFivynumNlzBcF4vq.JMSqleeTQO8WreTVOODqCbUCWu3g75QTPC.MJVyJKIeB.u77puJuzsCzq
 Cbo1isOSwCmiCGIP4hEBmVcITXR9YT5BTWC0IyiayQyOsivKrWrIbIbVICqDqxkF9tpqZgUHBsRx
 _ymdRQFW5lb2UqONa.uC45UMeSe4Sxu5D.ksO0ISGnYB9GJyjp7J7grqiezazND10g.8OzUjAojp
 P7s_p8gcGFvok_xDiMHMs65imTfimBw.EQLvKnv0Z973A_LfvVxSZhLRXZkb8e_3BW5p9MUzpN_Y
 bM_HDCsQNd54UpjUGrbKpZLYoYAX663Wp_3Fxsu7BGKwIgZKXLztTDX43Fp6XlSxx1apJ3J7xrzH
 T4KohGVIjsPRM2iclQB4xAh9dCvUExkAIcoqd_j4malRFQWLhGws_CoIykZE9ygggR3YSqegPG.i
 V7AuRAcDdZ8KZPutNeNE5mdOx63ie2hxj2lR4G2Chi6FPrEb.sK3wnO09VMuoZFGLVUtxbLuGXVH
 0poX83_g7kZp31i2rGi2asBYf5TnG_RUD.GYX_d4lm78WGn1Ml0iN1lZ8qqu_1M94PL.cgpmj9Jm
 h8Wf.jbTYADCJ1DmzNoPrsVa_fgKD5QFdxjHxjlQyoh.8DXLwg.nTjsB_bVSOZM3Y1Xg3z1EOuPO
 A1oPrQS3KIRyaedhigNuM0VcV4gV9gzNdtwrOrYwTBxeokVT79M78WKZtlSA_oQTrV6e0RUSEKeW
 ff6FIR.190Tcu5krmdo..oyiqG1sOIB7KS1ltGA272Y9pqzvVohPZ611ekU4QTlJtNMPhxihqdTG
 Qz77vztb7A5sOwdeedOIA2z.0.z1UGvzG9n5HW.AdqeRMh63FNXBDP1PunU.63u2oXFLcxYGneVX
 EHsoiX.PQxLnoXn5yuwH2L4_nx3G_h0T0v3FToR7yRYCrto4WfJGHtETVNCbkrpnROLRsbyYwsLW
 ZIgC2N4pWKaMSroKuYK5JrWU2hVAeQuDUakB3vkUQkW0sKETT38FAm377.61rWC1bpbbc167sv4z
 rLPITJehozjZb6UpQgGCsm5HJYDXSVd8H2bNrFZmaIQd0kKcEFvGRLurgunX8M5ObCfU.rdQe4sW
 ucbGVC.GmO2ZOKa6_XJHCikCSB3j8o738IS.No6HtedgdQIQTmHoHKLZkb3MgEd7k6wq2YUr8Kgo
 Th44IK.olKLGqb3gnU91nNZgcOCGaOaA7uf4WnhlSxp2NI3k6lSxaW93OxSqzNTcVLvul3e_j5R0
 hFi7RI639vKmKpGHwZQN8j0cwzPE9Zb16OVAgXpRJ3hFZwEodAaWQPrsSflKqghBdio5cv80a26Z
 8pKIB2McIutf4dtQibM3l0qSMM1V96IrC3askNLNqt4S6HUVDe4BdjxF4k2nrYJeK6RjF75FMdy3
 SM35tSwDmdNy23F..H7KdX.6KltsD753O.hae6wmMYEJo_Hau2dCx8b9XRYmW3Zo.FXcxWu_mbPP
 nibY0Lg.SsvzFuz4Z16.cms.MehO0gArpMAafQXVXsAqV7eijRQYjz_mz1OkJMFDliGLKF2sx97y
 wkvEhJgf_XMm8SZeOBDGj6k6UGih2.87_0Fk2cE6zkxhZZ1wSwuw8eeLp0xw5tx2_3YbcbV._te6
 H.Y_UrMNsP0OumyCXXvx0u470jEM9YI0xmWoKpJQAZJPUa8TnfkMssLbIDJLK1Y0GCL8aIdwH4uC
 fddf07rhcGSjYqmzdScsqTEW4T9RVDS0kfmKoJq8Rz90C96kwjtUS6R2IDvBuKz5CnDSJIkY08S4
 5FUV6TgMFLhPfayKHXSWyJ1htXFta4d8.oEx1yLdwKeGGZDp.zOx2IT_z.nimS_vo_q2cAEmOQLf
 zu6HhvLqqfIv7PHw_EsDmjtfkkY1cxaeKED86HEeZMahUs5an8ZcBoLfA94sahh.qGp1WuIT5V2V
 ELEU4lgWruPiGgUnCvyQvaS26QGEcDKa3ZJiJ8IbBkpbqJOgPlWQkKSYEgIJMm7YEpRU7kQ2e3Qz
 lb0HC0oAuEzBfEgO319SjBf63
X-Sonic-MF: <lbj137@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.bf2.yahoo.com with HTTP; Wed, 14 Apr 2021 03:19:33 +0000
Received: by kubenode581.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 476528b9443c4385ec4d5578db476860; 
 Wed, 14 Apr 2021 03:19:30 +0000 (UTC)
Mime-Version: 1.0 (1.0)
Date: Tue, 13 Apr 2021 23:19:27 -0400
Message-Id: <793BB53F-CE1B-4A8A-8D6D-850C7A144DBB@yahoo.com>
References: <1546175211.59087.1617739554450.JavaMail.zimbra@efficios.com>
In-Reply-To: <1546175211.59087.1617739554450.JavaMail.zimbra@efficios.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailer: iPhone Mail (18D70)
Subject: [lttng-dev] QSBR urcu read lock question
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

I have two different entities that are both protected by QSBR rcu: a policy and a hashtable. In the reclamation thread for the policy I would like to take a read lock so that I can safely iterate through the hashtable. I dont see anything wrong with this, but I just wanted to make sure it was ok since taking an rcu read lock in an rcu reclamation thread seems like it may be a bit suspect. Thanks for any insights, let me know if clarification is needed!

Jeff
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
