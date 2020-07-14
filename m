Return-Path: <SRS0=TO6l=AZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4620C433E2
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Jul 2020 02:56:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDCA208FE
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Jul 2020 02:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="hs4LqKTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDCA208FE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B5QC45MsVz1WKq;
	Mon, 13 Jul 2020 22:56:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594695393;
	bh=vAnvEQjqURo5SN1Bm2CFWPWJYOJadv7yXxsJrHSUbgk=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=hs4LqKTt9KOhNmcROeLJSVgBEpEPEc61IX0isgRuH5GmBBotfNwCmDpNCNyoyxEIT
	 ffeAYr5wZLqTCmUl/waG6oAWPwudFPkBSVAHuWYOklTtJC2IvJjlPehwXi8nvJ6DUr
	 4LdnxOgUSYck9UY1J43rfSkjgYNKq4YZKqtkyF6oXqnsyz64AIQFF7dsHRYkqkSxVk
	 1KorxrINDjjQAKrfQAvBJn1xLL2asSrpSUX5+MxyJMWBLSXjA/6ZZnu0Gi++DecRJE
	 ENYiS6W18gce4TFnLJWmfI/ABRRUI+dD0T6indlnN+IV++fJ5+Z+ecBuvgDyi0wbh7
	 eXBXvn0c6EE5Q==
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B5QC25TcTz1WKp
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 22:56:30 -0400 (EDT)
Received: from horde2019.polymtl.ca (horde2019.polymtl.ca [132.207.6.45])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 06E2uNUt009069
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 22:56:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 06E2uNUt009069
Received: from [67.216.56.114] ([67.216.56.114]) by www.imp.polymtl.ca
 (Horde Framework) with HTTPS; Tue, 14 Jul 2020 02:56:22 +0000
Date: Tue, 14 Jul 2020 02:56:22 +0000
Message-ID: <20200714025622.Horde.hxhRrc1ehcFdgXme3a70e7W@www.imp.polymtl.ca>
To: lttng-dev@lists.lttng.org
User-Agent: Horde Application Framework 5
MIME-Version: 1.0
Content-Disposition: inline
X-Poly-FromMTA: (horde2019.polymtl.ca [132.207.6.45]) at Tue,
 14 Jul 2020 02:56:23 +0000
Subject: [lttng-dev] custom field support in lttng-ust ?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Adel Belkhiri via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Adel Belkhiri <adel.belkhiri@polymtl.ca>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200714025622.IoiCu3PTGDf56LkP1UcE3KP8A5AEAYxXkUhMHkFmq5k@z>


Hi all,

Does anybody know if there is a custom field support in lttng-ust (to  
export atype_struct and atype_variant data fields) like in  
lttng-modules (ctf_custom_field)?


Thank you.
Adel

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
