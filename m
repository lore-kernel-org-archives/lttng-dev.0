Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3045C77B7D
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684334708;
	bh=ZBRccVyO8aYw0WmVbdh3Vri0OzziOqLJrOIZTQe2T4w=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CNSZEKjnF3P3yCQaGbBJiufsL6rHvvVbpGZAIevxNp/Xl5UwL8EQAYsxmRybNkVWh
	 bDC3gf7tVT7ujy4wg1bFDswarinQXsSjpw4rRUo0BAftPwTMREI+nBZ31axJKIWG0M
	 tRNDQiwgclB7QV2H9zIKFecbqjhYYSrae2h/K/C+QM5e32kQhXClNmooqUYdeFK9QC
	 jP5I34cQY+pwZv8wy/Jebfr2CM9dW9bfW8iiinfkK1qAAHA17cuj8Om8Qg0EjhngMN
	 tQDZEWUGcgSRkcVpUgh+E17fu0YxMlqXShx5W+cE98PTkQWusrA+EMnVbt63bMgUkt
	 0dWpMhLzwVHMg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLwr45qZqz1Fhx;
	Wed, 17 May 2023 10:45:08 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLwr32ZHjz1FcV
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 10:45:07 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLwqT10kNz12c0;
 Wed, 17 May 2023 10:44:37 -0400 (EDT)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <CACT4Y+Z8c30QQ3KFTaMq1Zgm-5fFCXEpNN3Kc9KWC+xzRkTzRQ@mail.gmail.com>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
 <874jocl1lf.fsf@laura>
 <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
 <CACT4Y+Z8c30QQ3KFTaMq1Zgm-5fFCXEpNN3Kc9KWC+xzRkTzRQ@mail.gmail.com>
Date: Wed, 17 May 2023 10:44:36 -0400
Message-ID: <87ttwbj9uz.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, 17 May 2023, Dmitry Vyukov via lttng-dev <lttng-dev@lists.lttng.org> wrote:
> I've skimmed through the changes. They look sane. You know what you
> are doing. So unless you have any other open issues, I don't have much
> to add.

Thanks for taking the time!

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
