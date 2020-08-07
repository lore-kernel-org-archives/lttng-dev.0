Return-Path: <SRS0=EN62=BR=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C347C433E0
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Aug 2020 13:08:01 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2368221E2
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Aug 2020 13:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="eFM8nOEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2368221E2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BNQdW0Nwrz1rGx;
	Fri,  7 Aug 2020 09:07:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596805679;
	bh=EFMixmlz47pPmO0cXbEilYNLXFF1gc/Vf+PwIYnzwk8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=eFM8nOEZ+IdIJGUGK0oM49UrStTJuL+95ppaYkeTz8G16oNzasyT5W3BtjvngdqY7
	 Is5vV4T8arLZrvsHyRGn5jHbVzfuIyD+6L+6lW7JzT7c+52b+JyMMdg9Q5BKhLgx9b
	 X7fGQhy+6BUjIr2vodz5SEVrEqDV8qD5xFTrzGOjjNP3yZxtAAZ9hO22KCilpcWgvO
	 /zcM8+9h/eMPpuDRWKaxefasJ4tIKEKWNvHG2BhCDKUaRd6lJLdC21/iAl6UEqWL+O
	 CgKmrw2B/uF4xu0nwMocbEXNeJW8gF0QwU15a/qdAQriYwLw90a/P4l3g2WWemdou0
	 on9xmMyrgThaA==
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 4BNH1G6Xvyz1r89
 for <lttng-dev@lists.lttng.org>; Fri,  7 Aug 2020 03:24:34 -0400 (EDT)
Received: by mail-oi1-x22e.google.com with SMTP id u63so1114884oie.5
 for <lttng-dev@lists.lttng.org>; Fri, 07 Aug 2020 00:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=tQqQXXKCKW0MmiLZ1NRO2Uk5/h2rkiS+2+WcYDV9dEk=;
 b=dknS1MNMk5t5jdtxeP7l1s0Sk4oVDRyM3LrvTX6bf0KO42GVeDs3C+I7zTTeQ7cT9C
 76Vhn92W/bi/Fsmn0Zh69uVDVXWyj03CzS9IGjqsEPHoWrTN8s9YmdUNFLS7JRFWc9TH
 F7oxJBrAKmdc1gm9JmqFIqN8hgV/NLeuqnen4uH+k6UUc1KYZCwgXtLIAHSFB9FRTdD6
 DjvWoXyX5DnjW1ACv/GHBRkgi+Q05PAsg6dBpFlCm6UThd6lK4KBOsAgIrsnyuHTmNfn
 r8nO7dLy60DQBuaXj5P1t2Gexghk7Z+Y7xvlQPxZzp3qZ6KhhL+cizCf3Oib8rHS/vZ5
 mM5Q==
X-Gm-Message-State: AOAM5315N3PTAIwowAqdf35FBV480JY6+eUHAMKwi/tV2LYMUeef1QPm
 1x04cviTVzUH8SGbi9xtPypI8W/Z67Qiin7srT+rCrU0Ruk=
X-Google-Smtp-Source: ABdhPJyJeRK1wv85zEHnZwPYloGNbYkZkQGLNz3tW7m6vtxP1UuAtf80ceKdixKQj2c3YIpdw8xbWgmk9/P42tIQ5tg=
X-Received: by 2002:aca:ba83:: with SMTP id k125mr10189654oif.49.1596785073849; 
 Fri, 07 Aug 2020 00:24:33 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 7 Aug 2020 15:24:22 +0800
Message-ID: <CALR1Az+iE_0smhqj2saNsc0+KFPVSrH+ki59gKc4NjVvYdVkQA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Fri, 07 Aug 2020 09:07:58 -0400
Subject: [lttng-dev] Using rculist for dirty tracking
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
From: Lego Lin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lego Lin <lego.lin@gmail.com>
Content-Type: multipart/mixed; boundary="===============7232797681709586358=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7232797681709586358==
Content-Type: multipart/alternative; boundary="0000000000001c0b1405ac447f48"

--0000000000001c0b1405ac447f48
Content-Type: text/plain; charset="UTF-8"

Hi,
I am new for using rcu and I need some helps for integrating user space rcu
into my project for solving performance issue.
In my project, I create 2 link list - one for free pool, one for using pool.
Free pool used to hold a segment of memory that no-one use.
Using pool used to hold a segment of memory that someone use.
Originally, I use a pthread_spin_lock to protect
1. alloc memory segment from free pool, and move memory segment from free
pool to using pool
2. free memory segment from using pool, and move memory segment from free
pool to using pool

For RCU, I change the list_move_tail as following
cds_list_for_each_entry_safe(cur, next, &(membk_pool->bk_free_pool),
entry_pool) {
    cds_list_del_rcu(&cur->entry_pool);
    urcu_bp_synchronize_rcu();
    cds_list_add_tail_rcu(&ret->entry_pool, &(membk_pool->bk_using_pool));
}

Is it ok to use scenario like this?

Meanwhile, that are some advance list operation API:
1. list_first_entry
2. list_first_entry_or_null
Is it possible to integrate these into current urcu?

Thanks

--0000000000001c0b1405ac447f48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div>I am new for using rcu and I need some helps=
 for integrating user space rcu into my project for solving performance iss=
ue.</div><div>In my project, I create 2 link list - one for free pool, one =
for using pool.</div><div>Free pool used to hold a segment of memory that n=
o-one use.</div><div>Using pool used to hold a segment of memory that someo=
ne use.</div><div>Originally, I use a pthread_spin_lock to protect</div><di=
v>1. alloc memory segment from free pool, and move memory segment from free=
 pool to using pool</div><div>2. free memory segment from using pool, and m=
ove memory segment from free pool to using pool

</div><div><br></div><div>For RCU, I change the list_move_tail as following=
</div><div>cds_list_for_each_entry_safe(cur, next, &amp;(membk_pool-&gt;bk_=
free_pool), entry_pool) {<br></div><div>=C2=A0 =C2=A0 cds_list_del_rcu(&amp=
;cur-&gt;entry_pool);<br></div><div>=C2=A0 =C2=A0 urcu_bp_synchronize_rcu()=
;<br></div><div>=C2=A0 =C2=A0=C2=A0cds_list_add_tail_rcu(&amp;ret-&gt;entry=
_pool, &amp;(membk_pool-&gt;bk_using_pool));</div><div>}</div><div><br></di=
v><div>Is it ok to use scenario like this?</div><div><br></div><div>Meanwhi=
le, that are some advance list operation API:</div><div>1. list_first_entry=
</div><div>2. list_first_entry_or_null</div><div>Is it possible to integrat=
e these into current urcu?</div><div><br></div><div>Thanks</div><div><br></=
div><div><br></div></div>

--0000000000001c0b1405ac447f48--

--===============7232797681709586358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7232797681709586358==--
