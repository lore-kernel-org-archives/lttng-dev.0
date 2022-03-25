Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6FCC433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Mar 2022 14:50:06 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KQ4kh5f8LzJhK;
	Fri, 25 Mar 2022 10:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648219805;
	bh=5UUgA+zVpHdFHEGX9iikylpMIuViKOcMRcjUDQ9N6bw=;
	h=Date:To:CC:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ISrFrH7B1QWLWUtjoZ/m3++27gDgt3w49qm7JvjvIqQAFO9bOLLmPH4x9Mf5Rp3O1
	 egSsEXNW/P83WvlQcVRZBXKnlSEkziZhDbGRRXuISQIz9A1TKOKRJK7ehbVWLP9LKS
	 qvnmH92qB1yxChic0gvE1UV+5rZJffoiCVEsu+26Jp5W6imp2L/MI/SUivUu/mVjwj
	 HIjHODmf4BwE2XH2DkkT1oe2au/bVVYril8wmhiliJ4UffJBaLGYXJHLvPf6+PtWaO
	 ycwgooZM82AYd3jI0eXAP/7qna99o08e7255k6p6OCY3aG3Fp0yhQB1AfKmpwipVTc
	 WtpCtWwiZ24Bg==
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by lists.lttng.org (Postfix) with ESMTPS id 4KPngC4hvBzJ77
 for <lttng-dev@lists.lttng.org>; Thu, 24 Mar 2022 23:31:03 -0400 (EDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KPnH61kHhzfZjk
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 11:13:38 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 11:15:12 +0800
Received: from [10.174.179.208] (10.174.179.208) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 11:15:12 +0800
Message-ID: <3d9a8965-c204-ee2b-b59a-e8092f90a71c@huawei.com>
Date: Fri, 25 Mar 2022 11:15:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To: <lttng-dev@lists.lttng.org>
CC: <wuxu.wu@huawei.com>, "hewenliang (C)" <hewenliang4@huawei.com>
X-Originating-IP: [10.174.179.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 25 Mar 2022 10:50:03 -0400
Subject: [lttng-dev] how to create a issue about userspace rcu
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
From: yaowenbin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: yaowenbin <yaowenbin1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello, I open the urcu webpage:
https://bugs.lttng.org/projects/urcu.
But I can not find where to create a issue. I just only can read the issues.
How to create one.
Thanks.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
