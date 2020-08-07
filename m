Return-Path: <SRS0=EN62=BR=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6E2C433E0
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Aug 2020 16:36:39 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5418121744
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Aug 2020 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Da64u+Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5418121744
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BNWGF3jrkz1rpm;
	Fri,  7 Aug 2020 12:36:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596818198;
	bh=Q7nuLb+ksW2u+NzLQitS8hm+RpON87yaH6or2a6asmQ=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Da64u+XmUzaI5yrxs8wPniGVfZb/USR1ps3C8t53dlD3EdIDZM2hCKIh8ISXZSnwo
	 uBFNA6BSvxbF+7aTP42Fbbl6Iwd2Bfs8CRHMhPCsAxJxtXPLPEekjDFdC3EXcCGw8q
	 LGVJkJ8H9s4HnlXWWch9Jz+U4PtgrGyn9bHdZJ13qdxlFtlVSBXDKm2f/7X2F0HeKD
	 fsCJyMN6NgaAohWdS/35AoHZ5QIj2EHwn+4YoM9u2HsQ0oifDdqxfyDPZaXY8E4pnf
	 Uc/riFCllE5eeUuorsQGozMAWX0Z21aXI1/5yvtMoK19ZBqlBt34lZFSXwkq2HGRRD
	 8K6BDeDkiZV1A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BNWGD2jqMz1rDx
 for <lttng-dev@lists.lttng.org>; Fri,  7 Aug 2020 12:36:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 164612C44D0
 for <lttng-dev@lists.lttng.org>; Fri,  7 Aug 2020 12:36:28 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id glpxRIKflYib; Fri,  7 Aug 2020 12:36:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BF7362C468D;
 Fri,  7 Aug 2020 12:36:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BF7362C468D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id iLhYuxaIQygC; Fri,  7 Aug 2020 12:36:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id B285B2C4563;
 Fri,  7 Aug 2020 12:36:27 -0400 (EDT)
Date: Fri, 7 Aug 2020 12:36:27 -0400 (EDT)
To: Lego Lin <lego.lin@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1009482720.2512.1596818187667.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALR1Az+iE_0smhqj2saNsc0+KFPVSrH+ki59gKc4NjVvYdVkQA@mail.gmail.com>
References: <CALR1Az+iE_0smhqj2saNsc0+KFPVSrH+ki59gKc4NjVvYdVkQA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: Using rculist for dirty tracking
Thread-Index: agEzUP8K1qFexlyZxsvtnz6fZPwohA==
Subject: Re: [lttng-dev] Using rculist for dirty tracking
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="===============6648325505892357045=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6648325505892357045==
Content-Type: multipart/alternative; 
	boundary="=_5f7cba41-9923-4f95-bc33-c191139e8a1f"

--=_5f7cba41-9923-4f95-bc33-c191139e8a1f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Aug 7, 2020, at 3:24 AM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi,
> I am new for using rcu and I need some helps for integrating user space rcu into
> my project for solving performance issue.
> In my project, I create 2 link list - one for free pool, one for using pool.
> Free pool used to hold a segment of memory that no-one use.
> Using pool used to hold a segment of memory that someone use.
> Originally, I use a pthread_spin_lock to protect
> 1. alloc memory segment from free pool, and move memory segment from free pool
> to using pool
> 2. free memory segment from using pool, and move memory segment from free pool
> to using pool

I suspect we would need to know the entire intended design here in order to start 
a discussion. What operations are doing list traversals ? What operations are doing 
updates ? How frequently are each respective operation done ? Do you intend to 
keep your spin lock to protect concurrent list updates, and if not how do you plan on 
protecting concurrent updates ? 

What are the performance issues you are experiencing exactly ? 

Thanks, 

Mathieu 

> For RCU, I change the list_move_tail as following
> cds_list_for_each_entry_safe(cur, next, &(membk_pool->bk_free_pool), entry_pool)
> {
> cds_list_del_rcu(&cur->entry_pool);
> urcu_bp_synchronize_rcu();
> cds_list_add_tail_rcu(&ret->entry_pool, &(membk_pool->bk_using_pool));
> }

> Is it ok to use scenario like this?

> Meanwhile, that are some advance list operation API:
> 1. list_first_entry
> 2. list_first_entry_or_null
> Is it possible to integrate these into current urcu?

> Thanks

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_5f7cba41-9923-4f95-bc33-c191139e8a1f
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Aug 7, 2020, at 3:24 AM, l=
ttng-dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div data=
-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;"><div dir=3D"ltr">Hi,&nbsp;<div>I am new for using rcu and I nee=
d some helps for integrating user space rcu into my project for solving per=
formance issue.</div><div>In my project, I create 2 link list - one for fre=
e pool, one for using pool.</div><div>Free pool used to hold a segment of m=
emory that no-one use.</div><div>Using pool used to hold a segment of memor=
y that someone use.</div><div>Originally, I use a pthread_spin_lock to prot=
ect</div><div>1. alloc memory segment from free pool, and move memory segme=
nt from free pool to using pool</div><div>2. free memory segment from using=
 pool, and move memory segment from free pool to using pool

</div></div></blockquote><div><br></div><div>I suspect we would need to kno=
w the entire intended design here in order to start<br data-mce-bogus=3D"1"=
></div><div>a discussion. What operations are doing list traversals ? What =
operations are doing</div><div>updates ? How frequently are each respective=
 operation done ? Do you intend to</div><div>keep your spin lock to protect=
 concurrent list updates, and if not how do you plan on</div><div>protectin=
g concurrent updates ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogu=
s=3D"1"></div><div>What are the performance issues you are experiencing exa=
ctly ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>For RCU, I change the l=
ist_move_tail as following</div><div>cds_list_for_each_entry_safe(cur, next=
, &amp;(membk_pool-&gt;bk_free_pool), entry_pool) {<br></div><div>&nbsp; &n=
bsp; cds_list_del_rcu(&amp;cur-&gt;entry_pool);<br></div><div>&nbsp; &nbsp;=
 urcu_bp_synchronize_rcu();<br></div><div>&nbsp; &nbsp;&nbsp;cds_list_add_t=
ail_rcu(&amp;ret-&gt;entry_pool, &amp;(membk_pool-&gt;bk_using_pool));</div=
><div>}</div><br><div>Is it ok to use scenario like this?</div><br><div>Mea=
nwhile, that are some advance list operation API:</div><div>1. list_first_e=
ntry</div><div>2. list_first_entry_or_null</div><div>Is it possible to inte=
grate these into current urcu?</div><br><div>Thanks</div><br><br></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_5f7cba41-9923-4f95-bc33-c191139e8a1f--

--===============6648325505892357045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6648325505892357045==--
